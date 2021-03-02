Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441CF32A52D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443465AbhCBLr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:56 -0500
Received: from z11.mailgun.us ([104.130.96.11]:49598 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349617AbhCBKn3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:43:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614681780; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bzphY5OQxbLN/iqNOX3XvX2YxbNYlBSIUk0+bXErBE4=;
 b=JTyI44CkR++pV6HvxSgNeLsOzQmBsy1qMZmi2YkKCL/aX/sQ/RRLgeNREekIezEJqVLIRaYf
 ws0eAGIafj8LLfh27OQydSt5tbkfs1tkssG9DqnSscRG7/ZUwe7b+KjIaNvoS3mJ0rfaYHud
 T9fkieyNB8vUggJuwtbB77GfT7k=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 603e13cd91ca526c583f54b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 10:30:37
 GMT
Sender: pintu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EFCEC4346B; Tue,  2 Mar 2021 10:30:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pintu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A934C433C6;
        Tue,  2 Mar 2021 10:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Mar 2021 16:00:34 +0530
From:   pintu@codeaurora.org
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, nigupta@nvidia.com, famzheng@amazon.com,
        andrew.a.klychkov@gmail.com, bigeasy@linutronix.de,
        ping.ping@gmail.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org, corbet@lwn.net,
        pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
In-Reply-To: <YD0EOyW3pZXDnuuJ@cmpxchg.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
 <YD0EOyW3pZXDnuuJ@cmpxchg.org>
Message-ID: <419bb403c33b7e48291972df938d0cae@codeaurora.org>
X-Sender: pintu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-01 20:41, Johannes Weiner wrote:
> On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
>> At times there is a need to regularly monitor vm counters while we
>> reproduce some issue, or it could be as simple as gathering some 
>> system
>> statistics when we run some scenario and every time we like to start 
>> from
>> beginning.
>> The current steps are:
>> Dump /proc/vmstat
>> Run some scenario
>> Dump /proc/vmstat again
>> Generate some data or graph
>> reboot and repeat again
> 
> You can subtract the first vmstat dump from the second to get the
> event delta for the scenario run. That's what I do, and I'd assume
> most people are doing. Am I missing something?

Thanks so much for your comments.
Yes in most cases it works.

But I guess there are sometimes where we need to compare with fresh data 
(just like reboot) at least for some of the counters.
Suppose we wanted to monitor pgalloc_normal and pgfree.
Or, suppose we want to monitor until the field becomes non-zero..
Or, how certain values are changing compared to fresh reboot.
Or, suppose we want to reset all counters after boot and start capturing 
fresh stats.

Some of the counters could be growing too large and too fast. Will there 
be chances of overflow ?
Then resetting using this could help without rebooting.

Suppose system came back from hibernation, and we want to reset all 
counters again (to capture fresh data) ?

Here I am sharing one output (from qemu-arm32 with 256MB RAM) just to 
indicate what could be changed:
Scenario: Generate OOM kill case and check oom_kill counter

BEFORE	AFTER	proc/vmstat
------  ------  -----------------------
49991	49916	nr_free_pages
4467	4481	nr_zone_inactive_anon
68	68	nr_zone_active_anon
3189	3067	nr_zone_inactive_file
223	444	nr_zone_active_file
0	0	nr_zone_unevictable
122	136	nr_zone_write_pending
0	0	nr_mlock
139	139	nr_page_table_pages
0	0	nr_bounce
0	0	nr_zspages
4032	4032	nr_free_cma
4467	4481	nr_inactive_anon
68	68	nr_active_anon
3189	3067	nr_inactive_file
223	444	nr_active_file
0	0	nr_unevictable
1177	1178	nr_slab_reclaimable
1889	1889	nr_slab_unreclaimable
0	0	nr_isolated_anon
0	0	nr_isolated_file
176	163	workingset_nodes
0	0	workingset_refault_anon
3295	3369	workingset_refault_file
0	0	workingset_activate_anon
4	4	workingset_activate_file
0	0	workingset_restore_anon
4	4	workingset_restore_file
0	0	workingset_nodereclaim
4436	4436	nr_anon_pages
2636	2678	nr_mapped
3559	3645	nr_file_pages
122	136	nr_dirty
0	0	nr_writeback
0	0	nr_writeback_temp
126	126	nr_shmem
0	0	nr_shmem_hugepages
0	0	nr_shmem_pmdmapped
0	0	nr_file_hugepages
0	0	nr_file_pmdmapped
0	0	nr_anon_transparent_hugepages
1	1	nr_vmscan_write
1	1	nr_vmscan_immediate_reclaim
1024	1038	nr_dirtied
902	902	nr_written
0	0	nr_kernel_misc_reclaimable
0	0	nr_foll_pin_acquired
0	0	nr_foll_pin_released
616	616	nr_kernel_stack
10529	10533	nr_dirty_threshold
5258	5260	nr_dirty_background_threshold
50714	256	pgpgin
3932	16	pgpgout
0	0	pswpin
0	0	pswpout
86828	122	pgalloc_normal
0	0	pgalloc_movable
0	0	allocstall_normal
22	0	allocstall_movable
0	0	pgskip_normal
0	0	pgskip_movable
139594	34	pgfree
4998	155	pgactivate
5738	0	pgdeactivate
0	0	pglazyfree
82113	122	pgfault
374	2	pgmajfault
0	0	pglazyfreed
7695	0	pgrefill
2718	20	pgreuse
9261	0	pgsteal_kswapd
173	0	pgsteal_direct
12627	0	pgscan_kswapd
283	0	pgscan_direct
2	0	pgscan_direct_throttle
0	0	pgscan_anon
12910	0	pgscan_file
0	0	pgsteal_anon
9434	0	pgsteal_file
0	0	pginodesteal
7008	0	slabs_scanned
109	0	kswapd_inodesteal
16	0	kswapd_low_wmark_hit_quickly
24	0	kswapd_high_wmark_hit_quickly
43	0	pageoutrun
1	0	pgrotated
0	0	drop_pagecache
0	0	drop_slab
1	0	oom_kill
1210	0	pgmigrate_success
0	0	pgmigrate_fail
0	0	thp_migration_success
0	0	thp_migration_fail
0	0	thp_migration_split
1509	0	compact_migrate_scanned
9015	0	compact_free_scanned
3911	0	compact_isolated
0	0	compact_stall
0	0	compact_fail
0	0	compact_success
3	0	compact_daemon_wake
1509	0	compact_daemon_migrate_scanned
9015	0	compact_daemon_free_scanned
0	0	unevictable_pgs_culled
0	0	unevictable_pgs_scanned
0	0	unevictable_pgs_rescued
0	0	unevictable_pgs_mlocked
0	0	unevictable_pgs_munlocked
0	0	unevictable_pgs_cleared
0	0	unevictable_pgs_stranded
0	0	balloon_inflate
0	0	balloon_deflate
0	0	balloon_migrate
0	0	swap_ra
0	0	swap_ra_hit
0	0	nr_unstable



Thanks,
Pintu
