Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E03561352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiF3Hf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiF3Hf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:35:57 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 00:35:56 PDT
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0CAD1A81B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 00:35:56 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 3E74320D70
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 16:29:19 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id ie11-20020a17090b400b00b001eccac2af53so1013706pjb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 00:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlpDtdwmWp2b5cqasTMpXtBnyv72jy1sATeseuyLyBc=;
        b=qVRG42rLPu/6Bs0W8rtN1xCiKd6nBP2LkY7RuNLXKNVh0eH6L4iaI2aTPvyFyzletL
         IN1n29N98+TJ1mB0vir1O+ypGuvtJ7/Zw5/p7ZXd93XM7qWFmlLWbo22sGUWpPglSZZO
         68LbKcA334SCvOc5EVGynthjmruDOzIO1aCJMZxE7diRHjvv8qqzab8I7HqHIWBtYq4/
         dxLj6eUogI3t1Oy7DQOG37Ck4S5HyxdSKxs8em1/eUZVn3IHFR4W6795YeM7RP6ALgC9
         mTdh6foqU5fWhWKoFkZQ+ntxQpcSH+dv6t9j6OwWKl9ESAfbckpPXDFAxujRju3efqy8
         EWag==
X-Gm-Message-State: AJIora+yEBrgaHp9KJ9DaRcvqwfqpk8f7QbSCWbzm3nFhf91AFDhQnCy
        0QeeB5cDy4e+1E1e0EqujcAxK4HmYtOZB+eMDPxObT/iwqhd0GX5Qh5Stwv0rA4Qs4P6sA4dBjj
        dFMoKcYTvin4h8rCExWSSvxRqNhA=
X-Received: by 2002:a17:902:e807:b0:16a:471b:a4cc with SMTP id u7-20020a170902e80700b0016a471ba4ccmr13385060plg.102.1656574158057;
        Thu, 30 Jun 2022 00:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unkGtBy8pj1LseJ12CPT9D2tB8s8CwrIAP721pTZJ67uSW54oYP5hdrssb9ch6i39KkfjNeg==
X-Received: by 2002:a17:902:e807:b0:16a:471b:a4cc with SMTP id u7-20020a170902e80700b0016a471ba4ccmr13385043plg.102.1656574157789;
        Thu, 30 Jun 2022 00:29:17 -0700 (PDT)
Received: from pc-zest.atmarktech (126.88.200.35.bc.googleusercontent.com. [35.200.88.126])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016bb24f5d19sm286102pln.209.2022.06.30.00.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:29:17 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o6obz-00BbWI-FR;
        Thu, 30 Jun 2022 16:29:15 +0900
Date:   Thu, 30 Jun 2022 16:29:05 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Major btrfs fiemap slowdown on file with many extents once in cache
 (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for marking
 a folio as accessed)
Message-ID: <Yr1QwVW+sHWlAqKj@atmark-techno.com>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220619151143.1054746-2-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy, linux-btrfs@vger,

Matthew Wilcox (Oracle) wrote on Sun, Jun 19, 2022 at 04:11:41PM +0100:
> We had an off-by-one error which meant that we never marked the first page
> in a read as accessed.  This was visible as a slowdown when re-reading
> a file as pages were being evicted from cache too soon.  In reviewing
> this code, we noticed a second bug where a multi-page folio would be
> marked as accessed multiple times when doing reads that were less than
> the size of the folio.

when debugging an unrelated issue (short reads on btrfs with io_uring
and O_DIRECT[1]), I noticed that my horrible big file copy speeds fell
down from ~2GB/s (there's compression and lots of zeroes) to ~100MB/s
the second time I was copying it with cp.

I've taken a moment to bisect this and came down to this patch.

[1] https://lore.kernel.org/all/YrrFGO4A1jS0GI0G@atmark-techno.com/T/#u



Dropping caches (echo 3 > /proc/sys/vm/drop_caches) restore the speed,
so there appears to be some bad effect to having the file in cache for
fiemap?
To be fair that file is pretty horrible:
---
# compsize bigfile
Processed 1 file, 194955 regular extents (199583 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced  
TOTAL       15%      3.7G          23G          23G       
none       100%      477M         477M         514M       
zstd        14%      3.2G          23G          23G       
---

Here's what perf has to say about it on top of this patch when running
`cp bigfile /dev/null` the first time:

98.97%     0.00%  cp       [kernel.kallsyms]    [k]
entry_SYSCALL_64_after_hwframe
 entry_SYSCALL_64_after_hwframe
 do_syscall_64
  - 93.40% ksys_read
     - 93.36% vfs_read
        - 93.25% new_sync_read
           - 93.20% filemap_read
              - 83.38% filemap_get_pages
                 - 82.76% page_cache_ra_unbounded
                    + 59.72% folio_alloc
                    + 13.43% read_pages
                    + 8.75% filemap_add_folio
                      0.64% xa_load
                   0.52% filemap_get_read_batch
              + 8.75% copy_page_to_iter
  - 4.73% __x64_sys_ioctl
     - 4.72% do_vfs_ioctl
        - btrfs_fiemap
           - 4.70% extent_fiemap
              + 3.95% btrfs_check_shared
              + 0.70% get_extent_skip_holes

and second time:
99.90%     0.00%  cp       [kernel.kallsyms]    [k]
entry_SYSCALL_64_after_hwfram
 entry_SYSCALL_64_after_hwframe
 do_syscall_64
  - 94.62% __x64_sys_ioctl
       do_vfs_ioctl
       btrfs_fiemap
     - extent_fiemap
        - 50.01% get_extent_skip_holes
           - 50.00% btrfs_get_extent_fiemap
              - 49.97% count_range_bits
                   rb_next
        + 28.72% lock_extent_bits
        + 15.55% __clear_extent_bit
  - 5.21% ksys_read
     + 5.21% vfs_read

(if this isn't readable, 95% of the time is spent on fiemap the second
time around)




I've also been observing RCU stalls on my laptop with the same workload
(cp to /dev/null), but unfortunately I could not reproduce in qemu so I
could not take traces to confirm they are caused by the same commit but
given the workload I'd say that is it?
I can rebuild a kernel for my laptop and confirm if you think it should
be something else.


I didn't look at the patch itself (yet) so have no suggestion at this
point - it's plausible the patch fixed something and just exposed slow
code that had been there all along so it might be better to look at the
btrfs side first, I don't know.
If you don't manage to reproduce I'll be happy to test anything thrown
at me at the very least.


Thanks,
-- 
Dominique Martinet | Asmadeus
