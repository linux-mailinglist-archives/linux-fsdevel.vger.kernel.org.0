Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2129F66C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJ2Uto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 16:49:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19480 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2Utm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:49:42 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9b2af10000>; Thu, 29 Oct 2020 13:49:53 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 20:49:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/19] mm: Use multi-index entries in the page cache
Date:   Thu, 29 Oct 2020 16:49:39 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <4D931CDD-2CB1-4129-974C-12255156154E@nvidia.com>
In-Reply-To: <20201029193405.29125-3-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_D9B87038-46DC-4CF4-A92E-D48924BAC681_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604004593; bh=H73uYo6ZVFteoqVVbGe7E15b3YH6FJGU5ApHCByDFvw=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=ATGHh69R9TBfGd63CcF/oa5dUhgZsPqaRzSnvx9pOcMWGTaxExQFU37alVcF3dtMW
         4zPf7Tf6uUBJkRnSgCRLi6NBaCgNpPwDc45nySBky2ARJf09NJ2tMcGhhImciPJZ8/
         GDw0Y1tcPmn3YN9UE/89QK7AzQvu1nvzJaYl+QYEbSId0Xy1cWE4kH6Q69AE5mfuyS
         b9lkXuRtrRjHoKVgElWdjOS5vv6sdY7YnpwCuv1eQqUeDxaS6qmdMHx7nCldqyBpqj
         vECQL65vgbj4Ed0efv6DVynoGlji+8cOIV7qveBCZXiu8l1P5W7cMBmgR+BiubOAr2
         S7st8oygqhAVw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_D9B87038-46DC-4CF4-A92E-D48924BAC681_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29 Oct 2020, at 15:33, Matthew Wilcox (Oracle) wrote:

> We currently store order-N THPs as 2^N consecutive entries.  While this=

> consumes rather more memory than necessary, it also turns out to be bug=
gy.
> A writeback operation which starts in the middle of a dirty THP will no=
t
> notice as the dirty bit is only set on the head index.  With multi-inde=
x
> entries, the dirty bit will be found no matter where in the THP the
> iteration starts.

A multi-index entry can point to a THP with any size and the code relies
on thp_last_tail() to check whether it has finished processing the page
pointed by the entry. Is it how this change works?

>
> This does end up simplifying the page cache slightly, although not as
> much as I had hoped.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 10 -------
>  mm/filemap.c            | 62 ++++++++++++++++++++++++-----------------=

>  mm/huge_memory.c        | 19 ++++++++++---
>  mm/khugepaged.c         | 12 +++++++-
>  mm/migrate.c            |  8 ------
>  mm/shmem.c              | 11 ++------
>  6 files changed, 65 insertions(+), 57 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 62b759f92e36..00288ed24698 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -912,16 +912,6 @@ static inline unsigned int __readahead_batch(struc=
t readahead_control *rac,
>  		VM_BUG_ON_PAGE(PageTail(page), page);
>  		array[i++] =3D page;
>  		rac->_batch_count +=3D thp_nr_pages(page);
> -
> -		/*
> -		 * The page cache isn't using multi-index entries yet,
> -		 * so the xas cursor needs to be manually moved to the
> -		 * next index.  This can be removed once the page cache
> -		 * is converted.
> -		 */
> -		if (PageHead(page))
> -			xas_set(&xas, rac->_index + rac->_batch_count);
> -
>  		if (i =3D=3D array_sz)
>  			break;
>  	}
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5c4db536fff4..8537ee86f99f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -127,13 +127,12 @@ static void page_cache_delete(struct address_spac=
e *mapping,
>
>  	/* hugetlb pages are represented by a single entry in the xarray */
>  	if (!PageHuge(page)) {
> -		xas_set_order(&xas, page->index, compound_order(page));
> -		nr =3D compound_nr(page);
> +		xas_set_order(&xas, page->index, thp_order(page));
> +		nr =3D thp_nr_pages(page);
>  	}
>
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(PageTail(page), page);
> -	VM_BUG_ON_PAGE(nr !=3D 1 && shadow, page);
>
>  	xas_store(&xas, shadow);
>  	xas_init_marks(&xas);
> @@ -311,19 +310,12 @@ static void page_cache_delete_batch(struct addres=
s_space *mapping,
>
>  		WARN_ON_ONCE(!PageLocked(page));
>
> -		if (page->index =3D=3D xas.xa_index)
> -			page->mapping =3D NULL;
> +		page->mapping =3D NULL;
>  		/* Leave page->index set: truncation lookup relies on it */
>
> -		/*
> -		 * Move to the next page in the vector if this is a regular
> -		 * page or the index is of the last sub-page of this compound
> -		 * page.
> -		 */
> -		if (page->index + compound_nr(page) - 1 =3D=3D xas.xa_index)
> -			i++;
> +		i++;
>  		xas_store(&xas, NULL);
> -		total_pages++;
> +		total_pages +=3D thp_nr_pages(page);
>  	}
>  	mapping->nrpages -=3D total_pages;
>  }
> @@ -1956,20 +1948,24 @@ unsigned find_lock_entries(struct address_space=
 *mapping, pgoff_t start,
>  		indices[pvec->nr] =3D xas.xa_index;
>  		if (!pagevec_add(pvec, page))
>  			break;
> -		goto next;
> +		continue;
>  unlock:
>  		unlock_page(page);
>  put:
>  		put_page(page);
> -next:
> -		if (!xa_is_value(page) && PageTransHuge(page))
> -			xas_set(&xas, page->index + thp_nr_pages(page));
>  	}
>  	rcu_read_unlock();
>
>  	return pagevec_count(pvec);
>  }
>
> +static inline bool thp_last_tail(struct page *head, pgoff_t index)
> +{
> +	if (!PageTransCompound(head) || PageHuge(head))
> +		return true;
> +	return index =3D=3D head->index + thp_nr_pages(head) - 1;
> +}
> +
>  /**
>   * find_get_pages_range - gang pagecache lookup
>   * @mapping:	The address_space to search
> @@ -2008,11 +2004,17 @@ unsigned find_get_pages_range(struct address_sp=
ace *mapping, pgoff_t *start,
>  		if (xa_is_value(page))
>  			continue;
>
> +again:
>  		pages[ret] =3D find_subpage(page, xas.xa_index);
>  		if (++ret =3D=3D nr_pages) {
>  			*start =3D xas.xa_index + 1;
>  			goto out;
>  		}
> +		if (!thp_last_tail(page, xas.xa_index)) {
> +			xas.xa_index++;
> +			page_ref_inc(page);
> +			goto again;
> +		}
>  	}
>
>  	/*
> @@ -3018,6 +3020,12 @@ void filemap_map_pages(struct vm_fault *vmf,
>  	struct page *head, *page;
>  	unsigned int mmap_miss =3D READ_ONCE(file->f_ra.mmap_miss);
>
> +	max_idx =3D DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
> +	if (max_idx =3D=3D 0)
> +		return;
> +	if (end_pgoff >=3D max_idx)
> +		end_pgoff =3D max_idx - 1;
> +
>  	rcu_read_lock();
>  	xas_for_each(&xas, head, end_pgoff) {
>  		if (xas_retry(&xas, head))
> @@ -3037,20 +3045,16 @@ void filemap_map_pages(struct vm_fault *vmf,
>  		/* Has the page moved or been split? */
>  		if (unlikely(head !=3D xas_reload(&xas)))
>  			goto skip;
> -		page =3D find_subpage(head, xas.xa_index);
> -
> -		if (!PageUptodate(head) ||
> -				PageReadahead(page) ||
> -				PageHWPoison(page))
> +		if (!PageUptodate(head) || PageReadahead(head))
>  			goto skip;
>  		if (!trylock_page(head))
>  			goto skip;
> -
>  		if (head->mapping !=3D mapping || !PageUptodate(head))
>  			goto unlock;
>
> -		max_idx =3D DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
> -		if (xas.xa_index >=3D max_idx)
> +		page =3D find_subpage(head, xas.xa_index);
> +again:
> +		if (PageHWPoison(page))
>  			goto unlock;
>
>  		if (mmap_miss > 0)
> @@ -3062,6 +3066,14 @@ void filemap_map_pages(struct vm_fault *vmf,
>  		last_pgoff =3D xas.xa_index;
>  		if (alloc_set_pte(vmf, page))
>  			goto unlock;
> +		if (!thp_last_tail(head, xas.xa_index)) {
> +			xas.xa_index++;
> +			page++;
> +			page_ref_inc(head);
> +			if (xas.xa_index >=3D end_pgoff)
> +				goto unlock;
> +			goto again;
> +		}
>  		unlock_page(head);
>  		goto next;
>  unlock:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f99167d74cbc..0e900e594e77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2626,6 +2626,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  	struct page *head =3D compound_head(page);
>  	struct pglist_data *pgdata =3D NODE_DATA(page_to_nid(head));
>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
> +	XA_STATE(xas, &head->mapping->i_pages, head->index);
>  	struct anon_vma *anon_vma =3D NULL;
>  	struct address_space *mapping =3D NULL;
>  	int count, mapcount, extra_pins, ret;
> @@ -2690,19 +2691,28 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
>  	unmap_page(head);
>  	VM_BUG_ON_PAGE(compound_mapcount(head), head);
>
> +	if (mapping) {
> +		xas_split_alloc(&xas, head, thp_order(head),
> +				mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);
> +		if (xas_error(&xas)) {
> +			ret =3D xas_error(&xas);
> +			goto out_unlock;
> +		}
> +	}
> +
>  	/* prevent PageLRU to go away from under us, and freeze lru stats */
>  	spin_lock_irqsave(&pgdata->lru_lock, flags);
>
>  	if (mapping) {
> -		XA_STATE(xas, &mapping->i_pages, page_index(head));
> -
>  		/*
>  		 * Check if the head page is present in page cache.
>  		 * We assume all tail are present too, if head is there.
>  		 */
> -		xa_lock(&mapping->i_pages);
> +		xas_lock(&xas);
> +		xas_reset(&xas);
>  		if (xas_load(&xas) !=3D head)
>  			goto fail;
> +		xas_split(&xas, head, thp_order(head));
>  	}
>
>  	/* Prevent deferred_split_scan() touching ->_refcount */
> @@ -2735,7 +2745,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  		}
>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:		if (mapping)
> -			xa_unlock(&mapping->i_pages);
> +			xas_unlock(&xas);
>  		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
>  		remap_page(head, thp_nr_pages(head));
>  		ret =3D -EBUSY;
> @@ -2749,6 +2759,7 @@ fail:		if (mapping)
>  	if (mapping)
>  		i_mmap_unlock_read(mapping);
>  out:
> +	xas_destroy(&xas);
>  	count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>  	return ret;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2cb93aa8bf84..230e62a92ae7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1645,7 +1645,10 @@ static void collapse_file(struct mm_struct *mm,
>  	}
>  	count_memcg_page_event(new_page, THP_COLLAPSE_ALLOC);
>
> -	/* This will be less messy when we use multi-index entries */
> +	/*
> +	 * Ensure we have slots for all the pages in the range.  This is
> +	 * almost certainly a no-op because most of the pages must be present=

> +	 */
>  	do {
>  		xas_lock_irq(&xas);
>  		xas_create_range(&xas);
> @@ -1851,6 +1854,9 @@ static void collapse_file(struct mm_struct *mm,
>  			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
>  	}
>
> +	/* Join all the small entries into a single multi-index entry */
> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);

Would thp_order(new_page) be better than HPAGE_PMD_ORDER?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D9B87038-46DC-4CF4-A92E-D48924BAC681_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+bKuMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK+3kP/iwWR1hgvfpwwgrl7UE8JKdjRpsh4pRAxNyU
ixpV8KLLn/ioCckkxYTMyJKMS9Nabl+gbNHgZMxmTxSOeLvTsJj4OfrtLlPl0bos
J0NMn9UD+trxcsPeqh2XYaEe2BdEHkFxnOV4aVQETGoxczFHDIriUEXpRn5nM3IV
+SJ2ZhB+7HDBNYRHetMHpeMXnrnaEpUjroSNTNsbjTYyc5giwYn2eEJN0zqt4IfV
B2RNAkdTXFibTuuJ8kxb+0CifeDbNdSgix54WFFEPiM3pUVH2n9pinQTnv0IgTWQ
yxgzbN2nBmze9UpkV7C7l6jW7RIzcALrWE61TBhS4f2sHDsyPVPy1qhSznaqDbLL
KDF5Uy+HS25HWHkbTkYoghIcv5WdHmIcZLs0emVIXhmZX7bmRwNl276Z+AcZ8YU/
E8N6oA1Pa/kJMvVRYV4EOS5xQy13rukyn2X92RjmuwPxNDNe5VVwI3A8ZuOBxDhJ
3UI8PU70unDS4KZ/T0GbUMIQyWKmshmc3VPk6b2dSzgCdOb5nLX//DF/e3VRlL+8
pAbhZDSv3ndOpER+UjHoBjZ/0FkAyRLs5f94qZN7YZNLCUDhOaVwzeJh3GkCWtN5
GxkfHzki87thX4zvtjoAwp2muAZXjUr2LZ/9HyOMkqRqC7OIqFKxzcYn0YcXjIbX
tBK9LZuY
=3Nr9
-----END PGP SIGNATURE-----

--=_MailMate_D9B87038-46DC-4CF4-A92E-D48924BAC681_=--
