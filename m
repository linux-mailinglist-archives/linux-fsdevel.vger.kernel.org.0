Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7517E166049
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBTPAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:00:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3956 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBTPAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:00:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e9ef00000>; Thu, 20 Feb 2020 07:00:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 07:00:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 07:00:33 -0800
Received: from [10.2.165.18] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 15:00:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 10/24] mm: Add readahead address space operation
Date:   Thu, 20 Feb 2020 10:00:30 -0500
X-Mailer: MailMate (1.13.1r5678)
Message-ID: <5D7CE6BD-FABD-4901-AEF0-E0F10FC00EB1@nvidia.com>
In-Reply-To: <20200219210103.32400-11-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-11-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_D3452F35-D86E-413E-A05C-9E5444344EF4_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582210800; bh=1ntWOoaWtNpHqLxJK1XQ1SdhWsITIFuo6dr1tEBt2WE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=YtTAS8bnX87BGK5w3lMdP9+458E9VtjDQ0fiiXkrkqS0mYcPltP6gqMHw4D0ZSzBM
         E1YhnSrzQvcKkF3Zto6UlqoOsOgpKE/NbXYGkimuFhR34xFm94uVexe3iOFwhSk6h2
         12/zcf497+YJzmP9TNrW43CQItw//lHNZ7BpxCqTnuYhxrdsvNbZfdHqeChfGPhfwR
         yyZBZ/QVbd2bSgyWP3NHl0VKcXZyFYJudagruOezn6PPp2ctR1x5hwjmiuRzW+Gg9w
         AJCl22QILCyz5lXp0TqvGllCCAiAw9ghV96heGAaDRve6pJTfWWtAC+iiu25BQOY4f
         N5DMQB97caaDA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_D3452F35-D86E-413E-A05C-9E5444344EF4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Feb 2020, at 16:00, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> This replaces ->readpages with a saner interface:
>  - Return void instead of an ignored error code.
>  - Page cache is already populated with locked pages when ->readahead
>    is called.
>  - New arguments can be passed to the implementation without changing
>    all the filesystems that use a common helper function like
>    mpage_readahead().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  6 +++++-
>  Documentation/filesystems/vfs.rst     | 15 +++++++++++++++
>  include/linux/fs.h                    |  2 ++
>  include/linux/pagemap.h               | 18 ++++++++++++++++++
>  mm/readahead.c                        | 12 ++++++++++--
>  5 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/file=
systems/locking.rst
> index 5057e4d9dcd1..0af2e0e11461 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -239,6 +239,7 @@ prototypes::
>  	int (*readpage)(struct file *, struct page *);
>  	int (*writepages)(struct address_space *, struct writeback_control *)=
;
>  	int (*set_page_dirty)(struct page *page);
> +	void (*readahead)(struct readahead_control *);
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
>  	int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -271,7 +272,8 @@ writepage:		yes, unlocks (see below)
>  readpage:		yes, unlocks
>  writepages:
>  set_page_dirty		no
> -readpages:
> +readahead:		yes, unlocks
> +readpages:		no
>  write_begin:		locks the page		 exclusive
>  write_end:		yes, unlocks		 exclusive
>  bmap:
> @@ -295,6 +297,8 @@ the request handler (/dev/loop).
>  ->readpage() unlocks the page, either synchronously or via I/O
>  completion.
>
> +->readahead() unlocks the pages that I/O is attempted on like ->readpa=
ge().
> +
>  ->readpages() populates the pagecache with the passed pages and starts=

>  I/O against them.  They come unlocked upon I/O completion.
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesyst=
ems/vfs.rst
> index 7d4d09dd5e6d..ed17771c212b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,7 @@ cache in your filesystem.  The following members ar=
e defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *=
);
>  		int (*set_page_dirty)(struct page *page);
> +		void (*readahead)(struct readahead_control *);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,12 +782,26 @@ cache in your filesystem.  The following members =
are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>
> +``readahead``
> +	Called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +	locked.  The implementation should decrement the page refcount
> +	after starting I/O on each page.  Usually the page will be
> +	unlocked by the I/O completion handler.  If the filesystem decides
> +	to stop attempting I/O before reaching the end of the readahead
> +	window, it can simply return.  The caller will decrement the page
> +	refcount and unlock the remaining pages for you.  Set PageUptodate
> +	if the I/O completes successfully.  Setting PageError on any page
> +	will be ignored; simply unlock the page if an I/O error occurs.
> +
>  ``readpages``
>  	called by the VM to read pages associated with the address_space
>  	object.  This is essentially just a vector version of readpage.
>  	Instead of just one page, several pages are requested.
>  	readpages is only used for read-ahead, so read errors are
>  	ignored.  If anything goes wrong, feel free to give up.
> +	This interface is deprecated and will be removed by the end of
> +	2020; implement readahead instead.
>
>  ``write_begin``
>  	Called by the generic buffered write code to ask the filesystem
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..d4e2d2964346 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -292,6 +292,7 @@ enum positive_aop_returns {
>  struct page;
>  struct address_space;
>  struct writeback_control;
> +struct readahead_control;
>
>  /*
>   * Write life time hint values.
> @@ -375,6 +376,7 @@ struct address_space_operations {
>  	 */
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
> +	void (*readahead)(struct readahead_control *);
>
>  	int (*write_begin)(struct file *, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned flags,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4989d330fada..b3008605fd1b 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -669,6 +669,24 @@ static inline struct page *readahead_page(struct r=
eadahead_control *rac)
>  	return page;
>  }
>
> +/* The byte offset into the file of this readahead block */
> +static inline loff_t readahead_pos(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_index * PAGE_SIZE;
> +}
> +
> +/* The number of bytes in this readahead block */
> +static inline loff_t readahead_length(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_nr_pages * PAGE_SIZE;
> +}
> +
> +/* The index of the first page in this readahead block */
> +static inline unsigned int readahead_index(struct readahead_control *r=
ac)
> +{
> +	return rac->_index;
> +}

rac->_index is pgoff_t, so readahead_index() should return the same type,=
 right?
BTW, pgoff_t is unsigned long.

> +
>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *r=
ac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index aaa209559ba2..07cdfbf00f4b 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -124,7 +124,14 @@ static void read_pages(struct readahead_control *r=
ac, struct list_head *pages)
>
>  	blk_start_plug(&plug);
>
> -	if (aops->readpages) {
> +	if (aops->readahead) {
> +		aops->readahead(rac);
> +		/* Clean up the remaining pages */
> +		while ((page =3D readahead_page(rac))) {
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +	} else if (aops->readpages) {
>  		aops->readpages(rac->file, rac->mapping, pages,
>  				readahead_count(rac));
>  		/* Clean up the remaining pages */
> @@ -234,7 +241,8 @@ void force_page_cache_readahead(struct address_spac=
e *mapping,
>  	struct file_ra_state *ra =3D &filp->f_ra;
>  	unsigned long max_pages;
>
> -	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages)=
)
> +	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages =
&&
> +			!mapping->a_ops->readahead))
>  		return;
>
>  	/*
> -- =

> 2.25.0


--
Best Regards,
Yan Zi

--=_MailMate_D3452F35-D86E-413E-A05C-9E5444344EF4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5Onw4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKP0AQAJ8rKk4f4gJQCLy1BEarhc0jqEJxv+LP4T93
thazkNgMM87L6fUgs2i0V2lUTkOQ9kN56mQH0wNc47I0tWm/5vVCPnDyS8MUFBeY
0sQiI3uTOVZcrz3GaZfrVJTUQHhIQ84wSAfUaRbaDKVlsGg4j1rZJocZrtKiXFoQ
afay88LB8I0MMBXGS6eM4Ep+ABD1Dp+awB7sOnuZOrvuWfNaULR4f8sGyyim/QjY
ZsJzs5rF5JIRkrCspYEnNbg7vx1orAAJBCxyVFgmAOIp2rNsnoDbHXhXE1LLCNgF
sIl6bfNbL/1hpJRWa6RegKxN9AiWCoDlKcqTOlHh5edI6ukk7oRSB7WJkcKgVSIA
ITkR/USPckkT4ZXP+5fYsfKMGgmPX00W9muaq6+/qWRFxjP1GY39zOlAgMoMMz82
AiBkYTLsp3L6SZ4f7GVLM8efNHFXk7cjjRDbN4GaGRzZhoz7yx3vGJaP/q9fssld
PXpx/80pWMoSQQQ1o3ouW1XdZdV6rh8slBFoXeYpFQXLs3Q/j7njrK4drJniuHz5
qySleNBceQp4y9l4FVC7G7t23VSRTHzcrff5wA+H+tVOjddzKC/L7rrZROsVk9uF
RBTotQ4VHR/fLoic/7IXBjQMD0nkS4UpaG71v9Rk4RwsusZU0f34h4zmuFQ4nfrU
hNoR35aP
=9x1/
-----END PGP SIGNATURE-----

--=_MailMate_D3452F35-D86E-413E-A05C-9E5444344EF4_=--
