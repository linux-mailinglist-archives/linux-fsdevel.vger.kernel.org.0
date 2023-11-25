Return-Path: <linux-fsdevel+bounces-3797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8E7F89DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD912817A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA722D298;
	Sat, 25 Nov 2023 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJr6hJe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944CCA4A;
	Sat, 25 Nov 2023 10:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C7FC433C7;
	Sat, 25 Nov 2023 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700906622;
	bh=p2Y9N2XAI98q4rgvMYuaA64L0HRfC61PSCaNKkKNa08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJr6hJe4kA/IFAUVu+a8cU5PwRzwHnpFw+BVZV7Eazw1jADD5q48cknChA+YK0kN8
	 75wfNkXi0+hrIRRHvA55kPjFOdCjMIbK/Nkk6J8qugNc4KU2N3JpsizBoq9axvSDaa
	 Ama3nZ62v0b1HOPzmQ34RJS4uA7Q85Cej3G/DZRQQRdtHL0nUXTyRy8I5kixlxPqkN
	 A3S/bhP9BjywvJGFlYqE0IPpGyVfH/D+4vbA24fxy8h6mvVAKXzhtia7+p/TWtN8Xd
	 nbnTiXnGyzJuCC696fLSjtzVxsHlbJEVUtDxOz+tdxa2r8pLb7IFNRXfBAm33IfoOR
	 j2kX5KdSQknKw==
Date: Sat, 25 Nov 2023 12:03:22 +0200
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
Message-ID: <20231125100322.GH636165@kernel.org>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-5-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119165721.9849-5-alexandru.elisei@arm.com>

On Sun, Nov 19, 2023 at 04:56:58PM +0000, Alexandru Elisei wrote:
> It might be desirable for an architecture to modify the gfp flags used to
> allocate the destination page for migration based on the page that it is
> being replaced. For example, if an architectures has metadata associated
> with a page (like arm64, when the memory tagging extension is implemented),
> it can request that the destination page similarly has storage for tags
> already allocated.
> 
> No functional change.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  include/linux/migrate.h | 4 ++++
>  mm/mempolicy.c          | 2 ++
>  mm/migrate.c            | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 2ce13e8a309b..0acef592043c 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -60,6 +60,10 @@ struct movable_operations {
>  /* Defined in mm/debug.c: */
>  extern const char *migrate_reason_names[MR_TYPES];
>  
> +#ifndef arch_migration_target_gfp
> +#define arch_migration_target_gfp(src, gfp) 0
> +#endif
> +
>  #ifdef CONFIG_MIGRATION
>  
>  void putback_movable_pages(struct list_head *l);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..50bc43ab50d6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1182,6 +1182,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
>  
>  		h = folio_hstate(src);
>  		gfp = htlb_alloc_mask(h);
> +		gfp |= arch_migration_target_gfp(src, gfp);

I think it'll be more robust to have arch_migration_target_gfp() to modify
the flags and return the new mask with added (or potentially removed)
flags.

>  		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
>  		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
>  	}
> @@ -1190,6 +1191,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
>  		gfp = GFP_TRANSHUGE;
>  	else
>  		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
> +	gfp |= arch_migration_target_gfp(src, gfp);
>  
>  	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
>  	return page_rmappable_folio(page);

-- 
Sincerely yours,
Mike.

