Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404E2758353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjGRRRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjGRRRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:17:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4A10CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 10:17:47 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7659db6339eso267433885a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689700666; x=1692292666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aV119CUZzOJ+2nU7i7rciuokyHqqUtLofvwhyauU4aE=;
        b=pwbsr1h9n5c57JlTUKfYRkR3tkRz6+C5pAreh/uVqEdLCTLkt4AcNCuiIyjtJsp/G4
         Qkgdq/fsjPvyTf5hs7wKaiFe30IeO1bT5G7BfjcmyVHF7/QAzAXMchqoz9UEFinrpSfK
         T6NYQYDDbvked0eX/2cwnozLsB9uKgQT0zyVDgYULwhJaINeLMnjJO3UI1+iM/2r9bpt
         bHKVinmVHsaFXweOy3DgY+FDTLOHdo+uryF8YmiSbHSq+BLF5RLD0pWhUFRs6mXO30y4
         CNWqv6zK4Qr93h1/6q5Zx8ndi3SpgMiKDT3KhnjzAYpxYrn1qA6YdGmVU8QScYathHWe
         wL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700666; x=1692292666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV119CUZzOJ+2nU7i7rciuokyHqqUtLofvwhyauU4aE=;
        b=eRGHWh5BTZfAPZ9tDMih58mFCLdoyh6jDXhRtM5cX5TuzuA4iWJ3O0nzI5raN34a59
         o5eIrsitVeULfmHjTbih5EbRs0GAAXWepvGz67ydz23ayRohOhkvbC4Z4ea5yooMy5u5
         pROw5kU3SNF3v9/x7ffC+vD8dIlMbZOznVZ1zqj3YHE2SU7zO8ChQHn85hQv1G0GZWCI
         3xpbdMCFcnfMxAo3DxjOjJXDaF9YGU/Zdi9kKmK5MX9RV0G/9tGZvj94GqZsRKyrx340
         CqLYeLmdku0uNsvREEr0vL4yCkMLqB5pgjSxR5y+/nDgtuj0z7MbSwVEQceYEqIq26KH
         lMvQ==
X-Gm-Message-State: ABy/qLYQSevkhHmdd1uds6FW7H5NRLwFq8R78hsmOuEcXdjhgLVJeCIU
        /OjeFVgx7jXaolc7ylWvt1OnXw==
X-Google-Smtp-Source: APBJJlGDUuhVj/w8ybkHZroC36GxyeamEhSgFgNnIh7eTvU2ikI04uPpSE9SekbO0HBCPu+Mlf5+og==
X-Received: by 2002:a05:620a:d85:b0:765:6923:623e with SMTP id q5-20020a05620a0d8500b007656923623emr14824431qkl.29.1689700666088;
        Tue, 18 Jul 2023 10:17:46 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i3-20020a37c203000000b00767660afed5sm723261qkm.99.2023.07.18.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:17:45 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:17:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230718171744.GA843162@perftesting>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:04:22PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has various fixes for bugs found in inspect or only triggered
> with upcoming changes that are a fallout from my work on bound lifetimes
> for the ordered extent and better confirming to expectations from the
> common writeback code.
> 
> Note that this series builds on the "btrfs compressed writeback cleanups"
> series sent out previously.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-writeback-fixes
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-writeback-fixes
> 
> Diffatat:
>  extent_io.c |  182 ++++++++++++++++++++++++++++++++++++------------------------
>  inode.c     |   16 +----
>  2 files changed, 117 insertions(+), 81 deletions(-)

Just FYI I've been using these two series to see how the github CI stuff was
working, and I keep tripping over a hang in generic/475.  It appears to be in
the fixup worker, here's the sysrq w output

sysrq: Show Blocked State
task:kworker/u4:5    state:D stack:0     pid:1713600 ppid:2      flags:0x00004000
Workqueue: btrfs-fixup btrfs_work_helper
Call Trace:
 <TASK>
 __schedule+0x533/0x1910
 ? find_held_lock+0x2b/0x80
 schedule+0x5e/0xd0
 __reserve_bytes+0x4e2/0x830
 ? __pfx_autoremove_wake_function+0x10/0x10
 btrfs_reserve_data_bytes+0x54/0x170
 btrfs_check_data_free_space+0x6a/0xf0
 btrfs_delalloc_reserve_space+0x2b/0xe0
 btrfs_writepage_fixup_worker+0x7e/0x4c0
 btrfs_work_helper+0xff/0x410
 process_one_work+0x26b/0x550
 worker_thread+0x53/0x3a0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf5/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
task:kworker/u4:4    state:D stack:0     pid:2513631 ppid:2      flags:0x00004000
Workqueue: events_unbound btrfs_async_reclaim_data_space
Call Trace:
 <TASK>
 __schedule+0x533/0x1910
 ? lock_acquire+0xca/0x2b0
 schedule+0x5e/0xd0
 schedule_timeout+0x1ad/0x1c0
 __wait_for_common+0xbd/0x220
 ? __pfx_schedule_timeout+0x10/0x10
 btrfs_wait_ordered_extents+0x3e3/0x480
 btrfs_wait_ordered_roots+0x184/0x260
 flush_space+0x3de/0x6a0
 ? btrfs_async_reclaim_data_space+0x52/0x180
 ? lock_release+0xc9/0x270
 btrfs_async_reclaim_data_space+0xff/0x180
 process_one_work+0x26b/0x550
 worker_thread+0x1eb/0x3a0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf5/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
task:kworker/u4:6    state:D stack:0     pid:2513783 ppid:2      flags:0x00004000
Workqueue: btrfs-flush_delalloc btrfs_work_helper
Call Trace:
 <TASK>
 __schedule+0x533/0x1910
 schedule+0x5e/0xd0
 btrfs_start_ordered_extent+0x153/0x210
 ? __pfx_autoremove_wake_function+0x10/0x10
 btrfs_run_ordered_extent_work+0x19/0x30
 btrfs_work_helper+0xff/0x410
 process_one_work+0x26b/0x550
 worker_thread+0x53/0x3a0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf5/0x130
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

We appear to be getting hung up because the ENOSPC stuff is flushing and waiting
on ordered extents, and then the fixup worker is waiting on trying to reserve
space.  My hunch is the page that's in the fixup worker is attached to an
ordered extent.

I can pretty reliably reproduce this in the CI, so if you have trouble
reproducing it let me know.  I'll dig into it later today, but I may not get to
it before you do.  Thanks,

Josef
