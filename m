Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E054372A159
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 19:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjFIRgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjFIRgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:36:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC65E4E;
        Fri,  9 Jun 2023 10:36:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E44551FE10;
        Fri,  9 Jun 2023 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686332197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsENri2S9pvn1qva5u81VJpotBG57Jbvi1S1O6Xiv0Y=;
        b=FvNeMT2sAHqgex5YwtzgiL4bKlfJoNay15IlruWRKOQJvJBsFslyRdcwVa+o7uDnJP/1aI
        wX9zXMMrpH2MjP6PCbl84d4vP22vXorx9g1LYxWQ+94cqiB3p0DGGTum9cmboclRsE4yQD
        B1UBinfgFKvSVw9uZo9F5Dw4Keg4Jgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686332197;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsENri2S9pvn1qva5u81VJpotBG57Jbvi1S1O6Xiv0Y=;
        b=TziDihUDDOcgL9DY4Ncl70gVbdcQ2NItiJhfQjuD0ICNx/PPBR2p/IZ7J4/bFRYP0UNExU
        HzmxMv9z+eFb5RBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C38F2C141;
        Fri,  9 Jun 2023 17:36:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABCDBDA85A; Fri,  9 Jun 2023 19:30:21 +0200 (CEST)
Date:   Fri, 9 Jun 2023 19:30:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Sterba <dsterba@suse.cz>,
        syzbot <syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] INFO: task hung in btrfs_sync_file (2)
Message-ID: <20230609173021.GD12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000086021605fd1b484c@google.com>
 <20230606142405.GI25292@twin.jikos.cz>
 <ZH+3DJQC8CUSs+/x@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH+3DJQC8CUSs+/x@dread.disaster.area>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:45:32AM +1000, Dave Chinner wrote:
> On Tue, Jun 06, 2023 at 04:24:05PM +0200, David Sterba wrote:
> > On Thu, Jun 01, 2023 at 06:15:06PM -0700, syzbot wrote:
> > > RIP: 0010:rep_movs_alternative+0x33/0xb0 arch/x86/lib/copy_user_64.S:56
> > > Code: 46 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
> > > RSP: 0018:ffffc9000becf728 EFLAGS: 00050206
> > > RAX: 0000000000000000 RBX: 0000000000000038 RCX: 0000000000000038
> > > RDX: fffff520017d9efb RSI: ffffc9000becf7a0 RDI: 0000000020000120
> > > RBP: 0000000020000120 R08: 0000000000000000 R09: fffff520017d9efa
> > > R10: ffffc9000becf7d7 R11: 0000000000000001 R12: ffffc9000becf7a0
> > > R13: 0000000020000158 R14: 0000000000000000 R15: ffffc9000becf7a0
> > >  copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
> > >  raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
> > >  _copy_to_user lib/usercopy.c:41 [inline]
> > >  _copy_to_user+0xab/0xc0 lib/usercopy.c:34
> > >  copy_to_user include/linux/uaccess.h:191 [inline]
> > >  fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
> > >  emit_fiemap_extent+0x18e/0x380 fs/btrfs/extent_io.c:2616
> > >  fiemap_process_hole+0x516/0x610 fs/btrfs/extent_io.c:2874
> > 
> > and extent enumeration from FIEMAP, this would qualify as a stress on
> > the inode
> 
> FWIW, when I've seen this sort of hang on XFS in past times, it's
> been caused by a corrupt extent list or a circular reference in a
> btree that the fuzzing introduced. Hence FIEMAP just keeps going
> around in circles and never gets out of the loop to drop the inode
> lock....

Thanks for the info. The provided reproducer was able to get the VM
stuck in a few hours so there is some problem. The generated image does
not show any obvious problem so it's either lack of 'check' capability
or the problem happens at run time.
