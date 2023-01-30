Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A56803B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 03:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjA3CFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 21:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjA3CFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:05:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960777A8B
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 18:05:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so10185905plg.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 18:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8Vxv8OwX133tUnuBdZdWAa7RTYGIr+O4AQ5K3l55Uo=;
        b=hL4YsroKWCH+QTT0BcGay1mkBwk8QVdd6Vvb9oDR84q0WNQMZMia0uIGGWuMlWhPYM
         lp2HxmxYgxwj3Aq53H9ZfhjpdxIYsfmQIDtjq+LCCqO4pH3xR5hJjQDs1dgmgqZMxPMC
         1Ls6tMXpMz2KAAarWRBUPd+KCWZLWd8GzZqmCgOf6z19kAZQiqdM2daJnYMmhxbWsZa9
         +xrYRBABNzbfCrCgNVrbsxLB5vyfHiOrcsfY64kGHMNgY335gHdhgqVJKelGCm2UUYJF
         py2w0LrLNczvkK2TZMgtqQFaTGGqAoYzO9n7fk3c0otDAWQDofAaAnqy5cFCy2jbK1st
         YDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Vxv8OwX133tUnuBdZdWAa7RTYGIr+O4AQ5K3l55Uo=;
        b=qCGpGZ1IZLF4V0UGObcSplGCMO8ZyJ9ObY4nV42bfi+GN7cAEuXhdqnRsCJzNff19d
         igPmj2cAB2LCPQAZvXolMrH8K+zHuLjWaFFymCP8Q1LpBwn22x20tTjNczTi6p9o01Yj
         GID65v7xzGV5c3LLMvrupqrS3LWY9k+lPc3aoJUc49oUDxVnLCZJmMZDu6HTYdg3XHQg
         MhwEHKC2r95ztW/n1ecJ8FzKfj7DHBt7W6ccmKSeuv/v1M2MLhcz9ndYcxT4C4rdv118
         Su0RVoonIRi3i1pi16b1MoAiGdjl/c8yDC5MoGxbm0ov1GH44hlrsN4bpuKDWs4ollW8
         QuQQ==
X-Gm-Message-State: AO0yUKW1RJx3mI53xmWF2MBZPMvEINQl7Tqw2kOEyKhnu6YUOZzgImSi
        OAYmj3fQ3T5dKDDYovGroCTeiw==
X-Google-Smtp-Source: AK7set+7nc+BfHsHoknZNPdu57MjuepFskScFxlhyNvQ21RAxAUsJVNqWT5MTSLtNpRpNNUMG5M3Ew==
X-Received: by 2002:a05:6a20:a015:b0:bc:57a3:e6e4 with SMTP id p21-20020a056a20a01500b000bc57a3e6e4mr10978611pzj.34.1675044330092;
        Sun, 29 Jan 2023 18:05:30 -0800 (PST)
Received: from dread.disaster.area (pa49-181-52-44.pa.nsw.optusnet.com.au. [49.181.52.44])
        by smtp.gmail.com with ESMTPSA id bs132-20020a63288a000000b004a3510effa5sm5587382pgb.65.2023.01.29.18.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:05:29 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pMJXx-009798-JH; Mon, 30 Jan 2023 13:05:25 +1100
Date:   Mon, 30 Jan 2023 13:05:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: replacement i_version counter for xfs
Message-ID: <20230130020525.GO360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
 <20230125000227.GM360264@dread.disaster.area>
 <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
 <Y9FZupBCyPGCMFBd@magnolia>
 <4d16f9f9eb678f893d4de695bd7cbff6409c3c5a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d16f9f9eb678f893d4de695bd7cbff6409c3c5a.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:58:08PM -0500, Jeff Layton wrote:
> On Wed, 2023-01-25 at 08:32 -0800, Darrick J. Wong wrote:
> > On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > > Note that there are two other lingering issues with i_version. Neither
> > > of these are xfs-specific, but they may inform the changes you want to
> > > make there:
> > > 
> > > 1/ the ctime and i_version can roll backward on a crash.
> > > 
> > > 2/ the ctime and i_version are both currently updated before write data
> > > is copied to the pagecache. It would be ideal if that were done
> > > afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> > > for this, but they need a lot more testing.)
> > 
> > You might also want some means for xfs to tell the vfs that it already
> > did the timestamp update (because, say, we had to allocate blocks).
> > I wonder what people will say when we have to run a transaction before
> > the write to peel off suid bits and another one after to update ctime.
> > 
> 
> That's a great question! There is a related one too once I started
> looking at this in more detail:
> 
> Most filesystems end up updating the timestamp via a the call to
> file_update_time in __generic_file_write_iter. Today, that's called very
> early in the function and if it fails, the write fails without changing
> anything.
> 
> What do we do now if the write succeeds, but update_time fails? We don't

On XFS, the timestamp update will either succeed or cause the
filesystem to shutdown as a failure with a dirty transaction is a
fatal, unrecoverable error.

> want to return an error on the write() since the data did get copied in.
> Ignoring it seems wrong too though. There could even be some way to
> exploit that by changing the contents while holding the timestamp and
> version constant.

If the filesystem has shut down, it doesn't matter that the data got
copied into the kernel - it's never going to make it to disk and
attempts to read it back will also fail. There's nothing that can be
exploited by such a failure on XFS - it's game over for everyone
once the fs has shut down....

> At this point I'm leaning toward leaving the ctime and i_version to be
> updated before the write, and just bumping the i_version a second time
> after. In most cases the second bump will end up being a no-op, unless
> an i_version query races in between.

Why not also bump ctime at write completion if a query races with
the write()? Wouldn't that put ns-granularity ctime based change
detection on a par with i_version?

Userspace isn't going to notice the difference - the ctime they
observe indicates that it was changed during the syscall. So
who/what is going to care if we bump ctime twice in the syscall
instead of just once in this rare corner case?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
