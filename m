Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005FB9CFC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfHZMoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 08:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfHZMox (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:44:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 757327BDA0;
        Mon, 26 Aug 2019 12:44:53 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FF821F8;
        Mon, 26 Aug 2019 12:44:47 +0000 (UTC)
Subject: Re: [PATCH] fs/proc/page: Skip uninitialized page when iterating page
 structures
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20190825163805.3036-1-longman@redhat.com>
 <201908261216.iW5YJ6gY%lkp@intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <11f6841e-aba3-8d2c-ec24-7808cb57bd3c@redhat.com>
Date:   Mon, 26 Aug 2019 08:44:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201908261216.iW5YJ6gY%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 26 Aug 2019 12:44:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/19 12:08 AM, kbuild test robot wrote:
> Hi Waiman,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190823]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Waiman-Long/fs-proc-page-Skip-uninitialized-page-when-iterating-page-structures/20190826-105836
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    fs/proc/page.c: In function 'find_next_zone_range':
>>> fs/proc/page.c:58:2: error: expected ';' before 'for'
>      for (pgdat = first_online_pgdat(); pgdat;
>      ^~~
>    fs/proc/page.c:52:6: warning: unused variable 'i' [-Wunused-variable]
>      int i;
>          ^
>    fs/proc/page.c:51:15: warning: unused variable 'zone' [-Wunused-variable]
>      struct zone *zone;
>                   ^~~~
>    fs/proc/page.c:50:13: warning: unused variable 'pgdat' [-Wunused-variable]
>      pg_data_t *pgdat;
>                 ^~~~~
>    fs/proc/page.c: In function 'pfn_in_zone':
>>> fs/proc/page.c:79:23: error: 'struct zone_range' has no member named 'start'; did you mean 'pfn_start'?
>      return pfn >= range->start && pfn < range->end;
>                           ^~~~~
>                           pfn_start
>>> fs/proc/page.c:79:43: error: 'struct zone_range' has no member named 'end'
>      return pfn >= range->start && pfn < range->end;
>                                               ^~
>    fs/proc/page.c:80:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
>
> vim +58 fs/proc/page.c
>
>     46	
>     47	static void find_next_zone_range(struct zone_range *range)
>     48	{
>     49		unsigned long start, end;
>   > 50		pg_data_t *pgdat;
>   > 51		struct zone *zone;
>     52		int i;
>     53	
>     54		/*
>     55		 * Scan all the zone structures to find the next closest one.
>     56		 */
>     57		start = end = -1UL
>   > 58		for (pgdat = first_online_pgdat(); pgdat;
>     59		     pgdat = next_online_pgdat(pgdat)) {
>     60			for (zone = pgdat->node_zones, i = 0; i < MAX_NR_ZONES;
>     61			     zone++, i++) {
>     62				if (!zone->spanned_pages)
>     63					continue;
>     64				if ((zone->zone_start_pfn >= range->pfn_end) &&
>     65				    (zone->zone_start_pfn < start)) {
>     66					start = zone->zone_start_pfn;
>     67					end   = start + zone->spanned_pages;
>     68				}
>     69			}
>     70		}
>     71		range->pfn_start = start;
>     72		range->pfn_end   = end;
>     73	}
>     74	
>     75	static inline bool pfn_in_zone(unsigned long pfn, struct zone_range *range)
>     76	{
>     77		if (pfn >= range->pfn_end)
>     78			find_next_zone_range(range);
>   > 79		return pfn >= range->start && pfn < range->end;
>     80	}
>     81	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Sorry, I have accidentally sent the old version with syntax error out.
Has posted the right one in v2.

Cheers,
Longman

