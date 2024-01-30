Return-Path: <linux-fsdevel+bounces-9525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54084234F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B11288CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C846BB30;
	Tue, 30 Jan 2024 11:38:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005506A01E;
	Tue, 30 Jan 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614693; cv=none; b=DPPlGDJh0TjlAAwwHM06nLNXg+zeqL9sduAEhJTWFbEOiN2+qxEVqb+QsXfOTb0VC1Qgwx+cVTvGs9mZ2H86MUryW/CM7Lecq3Du+QJwfIn48UGmekXsX5GaMob08P8qOL0v2jdhA1o6NErNJ5tUHZ0H5k8Y3WXi/zl453I123o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614693; c=relaxed/simple;
	bh=/DsBAHX8HTlca+Vpy4zDg5DsZ5AAjetwE7nEWjeRix8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psG7XgZC/QZh+3TWfF6WlwUnle3O6N5nNOWS6ZaT5EgH7ZJi98iLDHnMqtOqLJXN9uTW5nxVUR53EgA/dhTpaP5REhbX7ZVvU4xPeKvIIWwzmGRIOKimtrI1312qj/p75kHv+83+8KM4MzIVD0RjK21dVsTE8ODeZqccmekg4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F6CEDA7;
	Tue, 30 Jan 2024 03:38:54 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070733F5A1;
	Tue, 30 Jan 2024 03:38:04 -0800 (PST)
Date: Tue, 30 Jan 2024 11:38:02 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 23/35] arm64: mte: Try to reserve tag storage in
 arch_alloc_page()
Message-ID: <ZbjfmqpYex4C8Uhm@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-24-alexandru.elisei@arm.com>
 <CAMn1gO5pGVRCErVF+Ca-4JgHRKEcq9sDGyEe--gEjj5ZLrB8sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO5pGVRCErVF+Ca-4JgHRKEcq9sDGyEe--gEjj5ZLrB8sA@mail.gmail.com>

Hi Peter,

On Mon, Jan 29, 2024 at 04:04:18PM -0800, Peter Collingbourne wrote:
> On Thu, Jan 25, 2024 at 8:45 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Reserve tag storage for a page that is being allocated as tagged. This
> > is a best effort approach, and failing to reserve tag storage is
> > allowed.
> >
> > When all the associated tagged pages have been freed, return the tag
> > storage pages back to the page allocator, where they can be used again for
> > data allocations.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >
> > Changes since rfc v2:
> >
> > * Based on rfc v2 patch #16 ("arm64: mte: Manage tag storage on page
> > allocation").
> > * Fixed calculation of the number of associated tag storage blocks (Hyesoo
> > Yu).
> > * Tag storage is reserved in arch_alloc_page() instead of
> > arch_prep_new_page().
> >
> >  arch/arm64/include/asm/mte.h             |  16 +-
> >  arch/arm64/include/asm/mte_tag_storage.h |  31 +++
> >  arch/arm64/include/asm/page.h            |   5 +
> >  arch/arm64/include/asm/pgtable.h         |  19 ++
> >  arch/arm64/kernel/mte_tag_storage.c      | 234 +++++++++++++++++++++++
> >  arch/arm64/mm/fault.c                    |   7 +
> >  fs/proc/page.c                           |   1 +
> >  include/linux/kernel-page-flags.h        |   1 +
> >  include/linux/page-flags.h               |   1 +
> >  include/trace/events/mmflags.h           |   3 +-
> >  mm/huge_memory.c                         |   1 +
> >  11 files changed, 316 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index 8034695b3dd7..6457b7899207 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -40,12 +40,24 @@ void mte_free_tag_buf(void *buf);
> >  #ifdef CONFIG_ARM64_MTE
> >
> >  /* track which pages have valid allocation tags */
> > -#define PG_mte_tagged  PG_arch_2
> > +#define PG_mte_tagged          PG_arch_2
> >  /* simple lock to avoid multiple threads tagging the same page */
> > -#define PG_mte_lock    PG_arch_3
> > +#define PG_mte_lock            PG_arch_3
> > +/* Track if a tagged page has tag storage reserved */
> > +#define PG_tag_storage_reserved        PG_arch_4
> > +
> > +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> > +extern bool page_tag_storage_reserved(struct page *page);
> > +#endif
> >
> >  static inline void set_page_mte_tagged(struct page *page)
> >  {
> > +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > +       /* Open code mte_tag_storage_enabled() */
> > +       WARN_ON_ONCE(static_branch_likely(&tag_storage_enabled_key) &&
> > +                    !page_tag_storage_reserved(page));
> > +#endif
> >         /*
> >          * Ensure that the tags written prior to this function are visible
> >          * before the page flags update.
> > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> > index 7b3f6bff8e6f..09f1318d924e 100644
> > --- a/arch/arm64/include/asm/mte_tag_storage.h
> > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > @@ -5,6 +5,12 @@
> >  #ifndef __ASM_MTE_TAG_STORAGE_H
> >  #define __ASM_MTE_TAG_STORAGE_H
> >
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/mm_types.h>
> > +
> > +#include <asm/mte.h>
> > +
> >  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> >
> >  DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> > @@ -15,6 +21,15 @@ static inline bool tag_storage_enabled(void)
> >  }
> >
> >  void mte_init_tag_storage(void);
> > +
> > +static inline bool alloc_requires_tag_storage(gfp_t gfp)
> > +{
> > +       return gfp & __GFP_TAGGED;
> > +}
> > +int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
> > +void free_tag_storage(struct page *page, int order);
> > +
> > +bool page_tag_storage_reserved(struct page *page);
> >  #else
> >  static inline bool tag_storage_enabled(void)
> >  {
> > @@ -23,6 +38,22 @@ static inline bool tag_storage_enabled(void)
> >  static inline void mte_init_tag_storage(void)
> >  {
> >  }
> > +static inline bool alloc_requires_tag_storage(struct page *page)
> 
> This function should take a gfp_t to match the
> CONFIG_ARM64_MTE_TAG_STORAGE case.

Ah, yes, it should, nice catch, the compiler didn't throw an error. Will
fix, thanks!

Alex

