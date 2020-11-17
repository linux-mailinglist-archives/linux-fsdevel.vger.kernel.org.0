Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C22B693F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKQQAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 11:00:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1056 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQQAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:00:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb3f39e0005>; Tue, 17 Nov 2020 08:00:31 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 16:00:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <hch@lst.de>, <kent.overstreet@gmail.com>
Subject: Re: [PATCH v3 04/18] mm/filemap: Use THPs in
 generic_file_buffered_read
Date:   Tue, 17 Nov 2020 11:00:36 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <52328F4C-897D-4A56-9677-2B857661A487@nvidia.com>
In-Reply-To: <20201110033703.23261-5-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
 <20201110033703.23261-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_7D04A212-7550-437E-B89E-FE9F8F61D7E6_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605628831; bh=1iruRrNVQopuir9NbOv/AN90msY96jqPlMT6Ls6uI7M=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=kK2anQUHywl+eRTPigGnrCz/7ufoNkdFdWw3rdraaYgAnnDQXwRXZW2zFI/K/Wn6p
         JhbnqFB5+tv0CKFoeuWpMRIfPRqXJ/cbpdBCrCrM1GmFj3ZpcfF5Ic9VXc+BS0XPuQ
         9MUKq4F6Z3dMhu0IQDpDGWGJB397WNXJ7ubx2/wI6V6Aul719rpXyMe+umq+ZkIvCP
         uXM7yISAdAvKuh7EB2sS8odlSMM4xce6PJzj32VW0xquTQFvCdFu2lEiNFvEA5ARmm
         yUEkdVxJdnwjPD7Qgp7sa406ZYiuGPFoTv9DYdbtsddBo4dHQwbrcxhP+Dzm/A6oSR
         6VmQDjkVbCrpA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_7D04A212-7550-437E-B89E-FE9F8F61D7E6_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Nov 2020, at 22:36, Matthew Wilcox (Oracle) wrote:

> Add filemap_get_read_batch() which returns the THPs which represent a
> contiguous array of bytes in the file.  It also stops when encountering=

> a page marked as Readahead or !Uptodate (but does return that page)
> so it can be handled appropriately by filemap_get_pages().  That lets u=
s
> remove the loop in filemap_get_pages() and check only the last page.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/filemap.c | 122 +++++++++++++++++++++++++++++++++++----------------=

>  1 file changed, 85 insertions(+), 37 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bd02820601f8..1de586eb377e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2176,6 +2176,51 @@ static int lock_page_for_iocb(struct kiocb *iocb=
, struct page *page)
>  		return lock_page_killable(page);
>  }
>
> +/*
> + * filemap_get_read_batch - Get a batch of pages for read
> + *
> + * Get a batch of pages which represent a contiguous range of bytes
> + * in the file.  No tail pages will be returned.  If @index is in the
> + * middle of a THP, the entire THP will be returned.  The last page in=

> + * the batch may have Readahead set or be not Uptodate so that the
> + * caller can take the appropriate action.
> + */
> +static void filemap_get_read_batch(struct address_space *mapping,
> +		pgoff_t index, pgoff_t max, struct pagevec *pvec)
> +{
> +	XA_STATE(xas, &mapping->i_pages, index);
> +	struct page *head;
> +
> +	rcu_read_lock();
> +	for (head =3D xas_load(&xas); head; head =3D xas_next(&xas)) {
> +		if (xas_retry(&xas, head))
> +			continue;
> +		if (xas.xa_index > max || xa_is_value(head))
> +			break;
> +		if (!page_cache_get_speculative(head))
> +			goto retry;
> +
> +		/* Has the page moved or been split? */
> +		if (unlikely(head !=3D xas_reload(&xas)))
> +			goto put_page;
> +
> +		if (!pagevec_add(pvec, head))
> +			break;
> +		if (!PageUptodate(head))
> +			break;
> +		if (PageReadahead(head))
> +			break;
> +		xas.xa_index =3D head->index + thp_nr_pages(head) - 1;
> +		xas.xa_offset =3D (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
> +		continue;
> +put_page:
> +		put_page(head);
> +retry:
> +		xas_reset(&xas);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  static struct page *filemap_read_page(struct kiocb *iocb, struct file =
*filp,
>  		struct address_space *mapping, struct page *page)
>  {
> @@ -2329,15 +2374,15 @@ static int filemap_get_pages(struct kiocb *iocb=
, struct iov_iter *iter,
>  	struct address_space *mapping =3D filp->f_mapping;
>  	struct file_ra_state *ra =3D &filp->f_ra;
>  	pgoff_t index =3D iocb->ki_pos >> PAGE_SHIFT;
> -	pgoff_t last_index =3D (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> =
PAGE_SHIFT;
> -	unsigned int nr =3D min_t(unsigned long, last_index - index, PAGEVEC_=
SIZE);
> -	int i, j, err =3D 0;
> +	pgoff_t last_index;
> +	int err =3D 0;
>
> +	last_index =3D DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
>  find_page:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>
> -	pvec->nr =3D find_get_pages_contig(mapping, index, nr, pvec->pages);
> +	filemap_get_read_batch(mapping, index, last_index, pvec);
>  	if (pvec->nr)
>  		goto got_pages;
>
> @@ -2346,29 +2391,30 @@ static int filemap_get_pages(struct kiocb *iocb=
, struct iov_iter *iter,
>
>  	page_cache_sync_readahead(mapping, ra, filp, index, last_index - inde=
x);
>
> -	pvec->nr =3D find_get_pages_contig(mapping, index, nr, pvec->pages);
> +	filemap_get_read_batch(mapping, index, last_index, pvec);
>  	if (pvec->nr)
>  		goto got_pages;
>
>  	pvec->pages[0] =3D filemap_create_page(iocb, iter);
>  	err =3D PTR_ERR_OR_ZERO(pvec->pages[0]);
> -	if (!IS_ERR_OR_NULL(pvec->pages[0]))
> -		pvec->nr =3D 1;
> +	if (IS_ERR_OR_NULL(pvec->pages[0]))
> +		goto err;
> +	pvec->nr =3D 1;
> +	return 0;
>  got_pages:
> -	for (i =3D 0; i < pvec->nr; i++) {
> -		struct page *page =3D pvec->pages[i];
> -		pgoff_t pg_index =3D index + i;
> +	{
> +		struct page *page =3D pvec->pages[pvec->nr - 1];
> +		pgoff_t pg_index =3D page->index;
>  		loff_t pg_pos =3D max(iocb->ki_pos,
>  				    (loff_t) pg_index << PAGE_SHIFT);
>  		loff_t pg_count =3D iocb->ki_pos + iter->count - pg_pos;
>
>  		if (PageReadahead(page)) {
>  			if (iocb->ki_flags & IOCB_NOIO) {
> -				for (j =3D i; j < pvec->nr; j++)
> -					put_page(pvec->pages[j]);
> -				pvec->nr =3D i;
> +				put_page(page);
> +				pvec->nr--;
>  				err =3D -EAGAIN;
> -				break;
> +				goto err;
>  			}
>  			page_cache_async_readahead(mapping, ra, filp, page,
>  					pg_index, last_index - pg_index);
> @@ -2376,26 +2422,23 @@ static int filemap_get_pages(struct kiocb *iocb=
, struct iov_iter *iter,
>
>  		if (!PageUptodate(page)) {
>  			if ((iocb->ki_flags & IOCB_NOWAIT) ||
> -			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
> -				for (j =3D i; j < pvec->nr; j++)
> -					put_page(pvec->pages[j]);
> -				pvec->nr =3D i;
> +			    ((iocb->ki_flags & IOCB_WAITQ) && pvec->nr > 1)) {
> +				put_page(page);
> +				pvec->nr--;
>  				err =3D -EAGAIN;
> -				break;
> +				goto err;
>  			}
>
>  			page =3D filemap_update_page(iocb, filp, iter, page,
>  					pg_pos, pg_count);
>  			if (IS_ERR_OR_NULL(page)) {
> -				for (j =3D i + 1; j < pvec->nr; j++)
> -					put_page(pvec->pages[j]);
> -				pvec->nr =3D i;
> +				pvec->nr--;
>  				err =3D PTR_ERR_OR_ZERO(page);
> -				break;
>  			}
>  		}
>  	}
>
> +err:
>  	if (likely(pvec->nr))
>  		return 0;
>  	if (err)
> @@ -2437,6 +2480,7 @@ ssize_t generic_file_buffered_read(struct kiocb *=
iocb,
>  	if (unlikely(iocb->ki_pos >=3D inode->i_sb->s_maxbytes))
>  		return 0;
>  	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> +	pagevec_init(pvec);

This should be pagevec_init(&pvec);


>
>  	do {
>  		cond_resched();
> @@ -2464,13 +2508,8 @@ ssize_t generic_file_buffered_read(struct kiocb =
*iocb,
>  		isize =3D i_size_read(inode);
>  		if (unlikely(iocb->ki_pos >=3D isize))
>  			goto put_pages;
> -
>  		end_offset =3D min_t(loff_t, isize, iocb->ki_pos + iter->count);
>
> -		while ((iocb->ki_pos >> PAGE_SHIFT) + pvec.nr >
> -		       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
> -			put_page(pvec.pages[--pvec.nr]);
> -
>  		/*
>  		 * Once we start copying data, we don't want to be touching any
>  		 * cachelines that might be contended:
> @@ -2484,24 +2523,32 @@ ssize_t generic_file_buffered_read(struct kiocb=
 *iocb,
>  		if (iocb->ki_pos >> PAGE_SHIFT !=3D
>  		    ra->prev_pos >> PAGE_SHIFT)
>  			mark_page_accessed(pvec.pages[0]);
> -		for (i =3D 1; i < pagevec_count(&pvec); i++)
> -			mark_page_accessed(pvec.pages[i]);
>
>  		for (i =3D 0; i < pagevec_count(&pvec); i++) {
> -			unsigned int offset =3D iocb->ki_pos & ~PAGE_MASK;
> -			unsigned int bytes =3D min_t(loff_t, end_offset - iocb->ki_pos,
> -						   PAGE_SIZE - offset);
> -			unsigned int copied;
> +			struct page *page =3D pvec.pages[i];
> +			size_t page_size =3D thp_size(page);
> +			size_t offset =3D iocb->ki_pos & (page_size - 1);
> +			size_t bytes =3D min_t(loff_t, end_offset - iocb->ki_pos,
> +					     page_size - offset);
> +			size_t copied;
>
> +			if (end_offset < page_offset(page))
> +				break;
> +			if (i > 0)
> +				mark_page_accessed(page);
>  			/*
>  			 * If users can be writing to this page using arbitrary
>  			 * virtual addresses, take care about potential aliasing
>  			 * before reading the page on the kernel side.
>  			 */
> -			if (writably_mapped)
> -				flush_dcache_page(pvec.pages[i]);
> +			if (writably_mapped) {
> +				int j;
> +
> +				for (j =3D 0; j < thp_nr_pages(page); j++)
> +					flush_dcache_page(page + j);
> +			}
>
> -			copied =3D copy_page_to_iter(pvec.pages[i], offset, bytes, iter);
> +			copied =3D copy_page_to_iter(page, offset, bytes, iter);
>
>  			written +=3D copied;
>  			iocb->ki_pos +=3D copied;
> @@ -2515,6 +2562,7 @@ ssize_t generic_file_buffered_read(struct kiocb *=
iocb,
>  put_pages:
>  		for (i =3D 0; i < pagevec_count(&pvec); i++)
>  			put_page(pvec.pages[i]);
> +		pagevec_reinit(pvec);

It should be pagevec_reinit(&pvec);

Found the above two issues during compilation.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7D04A212-7550-437E-B89E-FE9F8F61D7E6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+z86QPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyyYP/A8pP+2SX8bVYt6OMyorFPzdWNqk1lDXm15d
Ej0TlXc6mOOwC4/Fgnb/1wKRx/Dxza2StlflG/CaT0LteVZG7CM1DU6JWBUJU+EH
6CX2FQxebOSCJ/KDw5xEoDk/rDm6CpqKWUHDy9fHolSkTY8ksBghtqZ3KSI/Npzi
aDVnbzdnAjwBGxwQK0v7BB1J1Jcmj+yYI3Op576u3/seQzYHtpH6gvAjHGlpP4pK
PgFz/qJW57fYO1ppNouqD9Y+gDeegQU6BMLskOLk5WdnqaYXLfxQkVHPVGmUuW4n
VwPh8Qgao8RYaKtaHK+zZh6wdpmS5UxOM+gZWvtwD8VVdVpIrGYO7x18tbONo60s
EV0kxGmelvWj7u4qUfggnoaCN1cnYhKb5pHq43zQWNweEBdcMsHCCZy4cXJwcGRq
xpcrqpXKkteiOMuJaL4JBCruJQ0tIOa2QWM4fn2KBE+1KPlGp032z8007Q1zdZ/S
LHo4YPIWluk7wg8b4xQLunkcRsW8Qq8zRZCUls9K1iKr3xyv6x8pEy0+s6Yefj/O
QZcxMU1MAAMci07vCusYABFVI3qjVECHetiX/ZnCYxEazHMyxLv9xdzTttPuU6En
GejEFWh5RqRIc6F6bN5zN3VpLIPOoVmXTSDFss0dBd45lgks2wYli6uFoHIWOnQz
120HJTse
=7J40
-----END PGP SIGNATURE-----

--=_MailMate_7D04A212-7550-437E-B89E-FE9F8F61D7E6_=--
