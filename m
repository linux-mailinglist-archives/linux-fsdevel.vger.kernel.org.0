Return-Path: <linux-fsdevel+bounces-27965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600B96539A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD061C21E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1D18F2DF;
	Thu, 29 Aug 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gr8cjZsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F59187843;
	Thu, 29 Aug 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974918; cv=none; b=puAGi6bqNSWWJv0AjImKnLark2yA+Yn8avnWUA0FvACs5ZV+34iG+pWnrJk1uQBZfkJc77V5gTM4d1WhQMxzM8xysN00jW9sgtouYkCftyS8Mitp+Op7rLtoOfwesV98z3BcZMJRwgqrOHPFSX26EiSjFyq6yAcevkOht+cgyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974918; c=relaxed/simple;
	bh=J3YOD9SmiXvPuVJha+NIKySYKVlWlu10qdB6t3EKd7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2n77OPpATYFx5gmTZ3BiX93CDi19tXNdzwNbgnIqGnDDMfofARNud5Q+obKtqlQ2xsXYljbhJgM0oPJe+jIRZ2oTjfqOr8hG2JiA+dLywpiKxtoP8zxpibVHhMDWM3c/BXJLw8xr02zhwXmpOsA5SG5fJx5qYuhkCv1LiRHg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gr8cjZsD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ybJSaS8XOS7QsdfbQRICGW0IbfDKuXL+/iCoPAdx+KY=; b=Gr8cjZsDERIV8FeBImsAYONIfE
	Ik/7Ze1hHVdNPBXXLv1TvWeGIsiBY8jb6g9XsyHEPq3qXcBbP5rtGFjMhM3ZSALp3ErHqE5ATFH6b
	Y4QXmq0oioCRmpW+BnqhpSLuM2NoAy31dhv2n3U2qf2MnL9Ntc4bI+5SEFcuCKkVP8SlG3QWadWqc
	xVvDL467Sq/1Q0XioN6DrbmFpDWo131QwtfPG0Qlwxkiqm18oQx2Fu+h/yVPjpCR2mX6bxNE5LfkF
	TgZA9go07M6fgmvh0rQuOwJfoCSxgkbDbbCyJJza3RHBIMvnqaaFQXeJBjdspOLhejlRp/tW0o75q
	GcK9Qdqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjolw-000000043rD-23DS;
	Thu, 29 Aug 2024 23:41:48 +0000
Date: Thu, 29 Aug 2024 16:41:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	brauner@kernel.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
	linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com>
 <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Aug 29, 2024 at 06:12:26PM -0400, Zi Yan wrote:
> The issue is that the change to split_huge_page() makes split_huge_page_t=
o_list_to_order()
> unlocks the wrong subpage. split_huge_page() used to pass the =E2=80=9Cpa=
ge=E2=80=9D pointer
> to split_huge_page_to_list_to_order(), which keeps that =E2=80=9Cpage=E2=
=80=9D still locked.
> But this patch changes the =E2=80=9Cpage=E2=80=9D passed into split_huge_=
page_to_list_to_order()
> always to the head page.
>=20
> This fixes the crash on my x86 VM, but it can be improved:
>=20
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7c50aeed0522..eff5d2fb5d4e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -320,10 +320,7 @@ bool can_split_folio(struct folio *folio, int *pextr=
a_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head=
 *list,
>                 unsigned int new_order);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);
> -static inline int split_huge_page(struct page *page)
> -{
> -       return split_folio(page_folio(page));
> -}
> +int split_huge_page(struct page *page);
>  void deferred_split_folio(struct folio *folio);
>=20
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c29af9451d92..4d723dab4336 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3297,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct page *=
page, struct list_head *list,
>         return ret;
>  }
>=20
> +int split_huge_page(struct page *page)
> +{
> +       unsigned int min_order =3D 0;
> +       struct folio *folio =3D page_folio(page);
> +
> +       if (folio_test_anon(folio))
> +               goto out;
> +
> +       if (!folio->mapping) {
> +               if (folio_test_pmd_mappable(folio))
> +                       count_vm_event(THP_SPLIT_PAGE_FAILED);
> +               return -EBUSY;
> +       }
> +
> +       min_order =3D mapping_min_folio_order(folio->mapping);
> +out:
> +       return split_huge_page_to_list_to_order(page, NULL, min_order);
> +}
> +
>  int split_folio_to_list(struct folio *folio, struct list_head *list)
>  {
>         unsigned int min_order =3D 0;


Confirmed, and also although you suggest it can be improved, I thought
that we could do that by sharing more code and putting things in the
headers, the below also fixes this but tries to share more code, but
I think it is perhaps less easier to understand than your patch.

So I think your patch is cleaner and easier as a fix.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c275aa9cc105..99cd9c7bf55b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -97,6 +97,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
=20
 #define split_folio(f) split_folio_to_list(f, NULL)
+#define split_folio_to_list(f, list) split_page_folio_to_list(&f->page, f,=
 list)
=20
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
@@ -331,10 +332,11 @@ unsigned long thp_get_unmapped_area_vmflags(struct fi=
le *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pin=
s);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
 		unsigned int new_order);
-int split_folio_to_list(struct folio *folio, struct list_head *list);
+int split_page_folio_to_list(struct page *page, struct folio *folio,
+			     struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	return split_folio(page_folio(page));
+	return split_page_folio_to_list(page, page_folio(page), NULL);
 }
 void deferred_split_folio(struct folio *folio);
=20
@@ -511,7 +513,9 @@ static inline int split_huge_page(struct page *page)
 	return 0;
 }
=20
-static inline int split_folio_to_list(struct folio *folio, struct list_hea=
d *list)
+static inline int split_page_folio_to_list(struct page *page,
+					   struct folio *folio,
+					   struct list_head *list)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 169f1a71c95d..b115bfe63b52 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3529,7 +3529,8 @@ int split_huge_page_to_list_to_order(struct page *pag=
e, struct list_head *list,
 	return ret;
 }
=20
-int split_folio_to_list(struct folio *folio, struct list_head *list)
+int split_page_folio_to_list(struct page *page, struct folio *folio,
+			     struct list_head *list)
 {
 	unsigned int min_order =3D 0;
=20
@@ -3544,8 +3545,7 @@ int split_folio_to_list(struct folio *folio, struct l=
ist_head *list)
=20
 	min_order =3D mapping_min_folio_order(folio->mapping);
 out:
-	return split_huge_page_to_list_to_order(&folio->page, list,
-							min_order);
+	return split_huge_page_to_list_to_order(page, list, min_order);
 }
=20
 void __folio_undo_large_rmappable(struct folio *folio)

