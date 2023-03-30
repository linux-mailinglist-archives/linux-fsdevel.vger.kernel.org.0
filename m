Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FA6D1259
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjC3WnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjC3WnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:43:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBFE1A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 15:43:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c4so2657447pjs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680216186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UVKHLmtooHBiszVSX91jjnRbRPTxqeXvARSEkj4Iurw=;
        b=z2kFmVF12PB+1USjihOQ2IkAvXl0N1fq/jInPodKNEs7dZqnaLzec5W8AfN38+JYpR
         zAZJF0EXKNzxidG04g09ODyDuTNtunoJ0FckU7FOKtcFt1j3LCwGZr9V4+f5innvywQl
         KN1s7uojLkpkUpPUHG/coZJlgnwU3ZGHI8yOrZTEtYsj9EU2vvE6uTvnD1YOhtwmykWy
         mz72kBMnkJwwZaIwncskRsX8IlMweeoGrvHQyJ/zHu48rrND9RR3Y/2KoVFT68HicSHe
         CL1IFJYFro0peH/q4d2JVM7Svt1miqeM6Lg7OErh4t0hI5xTT9YvSpfiY9h1Ok9RXpJv
         MuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVKHLmtooHBiszVSX91jjnRbRPTxqeXvARSEkj4Iurw=;
        b=Fm/0BjvThYzuSFWSsMO2DC2u+lzBIclWy2L7HF67IPUOJJoi0RQBCu9RMCdQ2h7cyz
         FmSUzmjLBaJsgD1u9IfJ3u7gJkezKsUZJg4s+LtumEbVCb1bF3hvOQxkILfV4ccOj247
         HuVJBQ01sIlySKEMX5ErnGPiKZaALD2WQfUjLgQKvBrKtIhLU8GjfmJFh3vSiIim/w3w
         oLHllWBxEBkYruGQXJwQfNc+9Ao6q+xsSExQNcNJi4TVOhVZQNEJOT2IDZlXywIl1Wuf
         hNbrfCKXyM/Vdftq+fklsYjdEmzWeSjn36Jut0ObuyCyZugzYs4PhWe/zHr60rAxJqHk
         ISIQ==
X-Gm-Message-State: AAQBX9cN8BzCQ1pCqgNtkvanFY7rKG59QDwyUsPduS0ZaDNh9QgsyoAv
        30qJDNfAGoMnOzQo+XeciDTUeA==
X-Google-Smtp-Source: AKy350bIjtlVfVX80X38+5e4xoQbHy5skXE1pdFXCHYx5imS4ccdijWGeyPFFpsTSHYeojG22LghLQ==
X-Received: by 2002:a17:90a:190f:b0:233:c301:32b3 with SMTP id 15-20020a17090a190f00b00233c30132b3mr27210277pjg.3.1680216185974;
        Thu, 30 Mar 2023 15:43:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id mq6-20020a17090b380600b00233864f21a7sm3677742pjb.51.2023.03.30.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:43:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pi0z0-00F8FL-19; Fri, 31 Mar 2023 09:43:02 +1100
Date:   Fri, 31 Mar 2023 09:43:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
Message-ID: <20230330224302.GG3223426@dread.disaster.area>
References: <0000000000003da76805f8021fb5@google.com>
 <20230330012750.GF3223426@dread.disaster.area>
 <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:52:37AM +0200, Aleksandr Nogikh wrote:
> On Thu, Mar 30, 2023 at 3:27 AM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 09:08:01PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16f83651c80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1
> > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_extents_to_btree+0xe1b/0x1190
> >
> > Allocation got an unexpected ENOSPC when it was supposed to have a
> > valid reservation for the space. Likely because of an inconsistency
> > that had been induced into the filesystem where superblock space
> > accounting doesn't exactly match the AG space accounting and/or the
> > tracked free space.
> >
> > Given this is a maliciously corrupted filesystem image, this sort of
> > warning is expected and there's probably nothing we can do to avoid
> > it short of a full filesystem verification pass during mount.
> > That's not a viable solution, so I think we should just ignore
> > syzbot when it generates this sort of warning....
> 
> If it's not a warning about a kernel bug, then WARN_ON should probably
> be replaced by some more suitable reporting mechanism. Kernel coding
> style document explicitly says:
> 
> "WARN*() must not be used for a condition that is expected to trigger
> easily, for example, by user space actions.

That's exactly the case here. It should *never* happen in normal
production workloads, and it if does then we have the *potential*
for silent data loss occurring. That's *exactly* the sort of thing
we should be warning admins about in no uncertain terms.  Also, we
use WARN_ON_ONCE(), so it's not going to spam the logs.

syzbot is a malicious program - it is injecting broken stuff into
the kernel as root to try to trigger situations like this. That
doesn't make a warning it triggers bad or incorrect - syzbot is
pertubing tightly coupled structures in a way that makes the
information shared across those structures inconsistent and
eventually the code is going to trip over that inconsistency.

IOWs, once someone has used root permissions to mount a maliciously
crafted filesystem image, *all bets are off*. The machine is running
a potentially compromised kernel at this point. Hence it is almost
guaranteed that at some point the kernel is going to discover things
are *badly wrong* and start dumping "this should never happen!"
warnings into the logs. That's what the warnings are supposed to do,
and the fact that syzbot can trigger them doesn't make the warnings
wrong.

> pr_warn_once() is a
> possible alternative, if you need to notify the user of a problem."
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=1e760fa3596e8c7f08412712c168288b79670d78#n1223

It is worth remembering that those are guidelines, not enforcable
rules and any experienced kernel developer will tell you the same
thing.  We know the guidelines, we know when to apply them, we know
there are cases that the guidelines simply can't, don't or won't
cover.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
