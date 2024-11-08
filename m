Return-Path: <linux-fsdevel+bounces-34033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65569C231B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962DD2839CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29321F9414;
	Fri,  8 Nov 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAAEV9jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9121C19B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087192; cv=none; b=OljEIjPkc9duHkGNF9efk/vwT7fW9Z1qYW/d3XU5Lf2xzPS+l+NEm1xcqy5RDGNxbSwXnhhODggWqG717NRawKa6BKdvZijpzuPxcSyRFqLEenHpBowxzU79NFqYnbtxaXPi9o9Y53BBvUMMdnnY7MbLEnMWDJCwdg61FKCOSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087192; c=relaxed/simple;
	bh=DKAomHDMSV3ChJFG0xijXuKMqsNJv7vwnmfJy9ep5Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsIX+eyAKpCQuDbbATIW3vOpskFngLygpkBW011qqiUfWQKSvvbGXNhX6Js68mbaahJUyVdlbM5WgQX5ONHsNnG1PlqvsnGAAb5tqPYWPCZn17xJslwtvK7H6sNfQmOgdC2Aj6Ot4G+sDyL1EK9Ss32sixtT4gPMaWTjrbKm/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAAEV9jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931FFC4CECD;
	Fri,  8 Nov 2024 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087191;
	bh=DKAomHDMSV3ChJFG0xijXuKMqsNJv7vwnmfJy9ep5Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAAEV9jv0Ztb4YUnjOOXZgd6yMg8nk/mzDlTItNojR/Qd/wUpmwQNSnDEOHzpMQoU
	 kQiC8qOt/Fb/vqqQfcYH0WOQ+9UvshWnDH9z8Wy6tjPs9LOfWv+imazG/lFE5bRPwJ
	 CRhugCfGYEA6ReHmWYBajBt6ggEbuPXjIqtI5dBJLDd8b8Yboo1VdxLlKEVtOCnoNE
	 hXxraskFWgXJvjtQdsdNIKrwIt7p5SV21soT/6OgTrLQ5/zeCtQWow8zrYvpZhGq6d
	 r6HdQ1GQ+UaoQGpCw+t30T1Rup3XqS2CtfcLZDSga/BXKYqQMARR8hlPqzyxySRz9+
	 w8OLwepgJs4lA==
From: SeongJae Park <sj@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in offline_pages() if migration fails
Date: Fri,  8 Nov 2024 09:33:09 -0800
Message-Id: <20241108173309.71619-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107235614.3637221-5-joannelkoong@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ David Hildenbrand

On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:

> In offline_pages(), do_migrate_range() may potentially retry forever if
> the migration fails. Add a return value for do_migrate_range(), and
> allow offline_page() to try migrating pages 5 times before erroring
> out, similar to how migration failures in __alloc_contig_migrate_range()
> is handled.

I'm curious if this could cause unexpected behavioral differences to memory
hotplugging users, and how '5' is chosen.  Could you please enlighten me?

> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  mm/memory_hotplug.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 621ae1015106..49402442ea3b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1770,13 +1770,14 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  	return 0;
>  }
>  
> -static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> +static int do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)

Seems the return value is used for only knowing if it is failed or not.  If
there is no plan to use the error code in future, what about using bool return
type?

>  {
>  	struct folio *folio;
>  	unsigned long pfn;
>  	LIST_HEAD(source);
>  	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
> +	int ret = 0;
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>  		struct page *page;
> @@ -1833,7 +1834,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>  			.reason = MR_MEMORY_HOTPLUG,
>  		};
> -		int ret;
>  
>  		/*
>  		 * We have checked that migration range is on a single zone so
> @@ -1863,6 +1863,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			putback_movable_pages(&source);
>  		}
>  	}
> +	return ret;
>  }
>  
>  static int __init cmdline_parse_movable_node(char *p)
> @@ -1940,6 +1941,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	const int node = zone_to_nid(zone);
>  	unsigned long flags;
>  	struct memory_notify arg;
> +	unsigned int tries = 0;
>  	char *reason;
>  	int ret;
>  
> @@ -2028,11 +2030,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  			ret = scan_movable_pages(pfn, end_pfn, &pfn);
>  			if (!ret) {
> -				/*
> -				 * TODO: fatal migration failures should bail
> -				 * out
> -				 */
> -				do_migrate_range(pfn, end_pfn);
> +				if (do_migrate_range(pfn, end_pfn) && ++tries == 5)
> +					ret = -EBUSY;
>  			}

In the '++tries == 5' case, users will show the failure reason as "unmovable
page" from the debug log.  What about setting 'reason' here to be more
specific, e.g., "multiple migration failures"?

Also, my humble understanding of the intention of this change is as follow.  If
there are 'AS_WRITEBACK_MAY_BLOCK' pages in the migration target range,
do_migrate_range() will continuously fail.  And hence this could become
infinite loop.  Pleae let me know if I'm misunderstanding.

But if I'm not wrong...  There is a check for expected failures above
(scan_movable_pages()).  What about adding 'AS_WRITEBACK_MAY_BLOCK' pages
existence check there?

>  		} while (!ret);
>  
> -- 
> 2.43.5


Thanks,
SJ

