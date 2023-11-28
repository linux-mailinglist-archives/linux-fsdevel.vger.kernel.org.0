Return-Path: <linux-fsdevel+bounces-4012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEE7FB21B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 07:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7EE281B15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E9101DD;
	Tue, 28 Nov 2023 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if9fM89P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA0748B;
	Tue, 28 Nov 2023 06:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3030C433C7;
	Tue, 28 Nov 2023 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701154214;
	bh=BijUODoSlZIznO9rdGnXggiSdi32BpO3PHuXhYrN1B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if9fM89P+gYlCDnvkkF1Yr+BLEwcjrzHNVmL7eGBgP+mcsTCAA44Zo/jA2dVG0hka
	 h/LUzMc86Pns899eb+eBzUHUyopA70K0VId+L6bo9UvWEtksLRnYfQgsCIcyFXTmsA
	 StTDz/fcXiBOKdqidbSxUBOYr9dC1xwA/C8VFRnyTj6XuPag4Tu8h7UGU8HWcwBG9+
	 1fH3R1gOS/OEy8/WIfOf04Wk3ofHB909dr1lvVQRSa/GLjFVYWIitbmdb/iG2c0hqj
	 gI9GkHgvnjBOAPs5NT6aeOVlwPQnvsC/4BEjUwfK4dSUKeT8i6bctj0fIX1Dbg8u2L
	 G9GIlEM7e/Y1Q==
Date: Tue, 28 Nov 2023 08:49:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	hughd@google.com, pcc@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/27] mm: migrate/mempolicy: Add hook to modify
 migration target gfp
Message-ID: <20231128064957.GI636165@kernel.org>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-5-alexandru.elisei@arm.com>
 <20231125100322.GH636165@kernel.org>
 <ZWSDGGJDWDtY0G35@raptor>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWSDGGJDWDtY0G35@raptor>

On Mon, Nov 27, 2023 at 11:52:56AM +0000, Alexandru Elisei wrote:
> Hi Mike,
> 
> I really appreciate you having a look!
> 
> On Sat, Nov 25, 2023 at 12:03:22PM +0200, Mike Rapoport wrote:
> > On Sun, Nov 19, 2023 at 04:56:58PM +0000, Alexandru Elisei wrote:
> > > It might be desirable for an architecture to modify the gfp flags used to
> > > allocate the destination page for migration based on the page that it is
> > > being replaced. For example, if an architectures has metadata associated
> > > with a page (like arm64, when the memory tagging extension is implemented),
> > > it can request that the destination page similarly has storage for tags
> > > already allocated.
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > ---
> > >  include/linux/migrate.h | 4 ++++
> > >  mm/mempolicy.c          | 2 ++
> > >  mm/migrate.c            | 3 +++
> > >  3 files changed, 9 insertions(+)
> > > 
> > > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > > index 2ce13e8a309b..0acef592043c 100644
> > > --- a/include/linux/migrate.h
> > > +++ b/include/linux/migrate.h
> > > @@ -60,6 +60,10 @@ struct movable_operations {
> > >  /* Defined in mm/debug.c: */
> > >  extern const char *migrate_reason_names[MR_TYPES];
> > >  
> > > +#ifndef arch_migration_target_gfp
> > > +#define arch_migration_target_gfp(src, gfp) 0
> > > +#endif
> > > +
> > >  #ifdef CONFIG_MIGRATION
> > >  
> > >  void putback_movable_pages(struct list_head *l);
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 10a590ee1c89..50bc43ab50d6 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -1182,6 +1182,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
> > >  
> > >  		h = folio_hstate(src);
> > >  		gfp = htlb_alloc_mask(h);
> > > +		gfp |= arch_migration_target_gfp(src, gfp);
> > 
> > I think it'll be more robust to have arch_migration_target_gfp() to modify
> > the flags and return the new mask with added (or potentially removed)
> > flags.
> 
> I did it this way so an arch won't be able to remove flags set by the MM code.
> There's a similar pattern in do_mmap() -> calc_vm_flag_bits() ->
> arch_calc_vm_flag_bits().

Ok, just add a sentence about it to the commit message.
 
> Thanks,
> Alex
> 
> > 
> > >  		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
> > >  		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
> > >  	}
> > > @@ -1190,6 +1191,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
> > >  		gfp = GFP_TRANSHUGE;
> > >  	else
> > >  		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
> > > +	gfp |= arch_migration_target_gfp(src, gfp);
> > >  
> > >  	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
> > >  	return page_rmappable_folio(page);
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 

-- 
Sincerely yours,
Mike.

