Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0A7349E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFSCCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSCCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:02:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A65E49
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 19:02:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25e9e5f9e0cso1465285a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687140165; x=1689732165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXezs9Rch4qwU+sdxagt3dLdrAjbG0FwaZwoUeR58wM=;
        b=vfSLTGeOOV9bXM60MXaB/SN/BFKlMuMTB9eryikMaXPFS+OIVAClQjCasaf+Rr+eCN
         NxCB3Oj2fuDpNQ8bVdKk6l2woFpF1MtMo/2ShGqntdBegEsnRoBkT5kvooi7ga4b3huL
         DyJVqpB47fMhBffBLA8m/ctkisyEyQYK0hFEP42jZX6T+z3Tjz8gIdV2G8LDflkMle4W
         pS1nhHNxFKLM9S+ExOFgltU7NqQRcHWVqUsuAGKiru5ONS53jdO+QgahSgYx3vZbSoYZ
         92WjTJ58OsPEZMPgJEd1Dp5EPdfaOJykOkbTVpp+JOAQBCAGGoI4VqJxUb76aIzEGpzM
         SKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687140165; x=1689732165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXezs9Rch4qwU+sdxagt3dLdrAjbG0FwaZwoUeR58wM=;
        b=hFQVevFP+rF9lFZZJ2lhKRSWnGme6gSFlCl9iDyzD54sV6PkRbiI2WbIFMJBCu0106
         WzOjF1QagXxBrrTDL85XzvxQQHdeQzrMpBnOH49wAA8PsZEVoFihtDrDfIL2XVIMqprB
         HSp//HmeF9VRBrvi2RhXBEPaW6VRmJLJ3d7JBdYZSqYr2wyqV8TyDgbvjT3ICk/gZZLO
         YBs/aME/Lp3jQv23R4br+aINGIs8JuhTFQl1toUEt/wypfuK7MeBPrgBXBlZ6Pbs6vJI
         wIf2dywC/yA5YGG8TDxzkXhG1tLgbRJ0wMRZIyhLSe0ItyFLpEjL24A0mLqHquZmJN02
         MIBw==
X-Gm-Message-State: AC+VfDxIsslTXdEvAHjR/c5FOrhkOHeD80tJbrqRwNSoh3lEV8W7J/7K
        /mFObQq1gNBu6+hck+1pwa/EdzNwzqXOmU5J8kU=
X-Google-Smtp-Source: ACHHUZ7GzEI3+lUZKDJza2HOWhvjB2quX2IIULD5jSFg9g5vW9C4J2mlqnDOA/Xv+8gq8gRP8dQx3Q==
X-Received: by 2002:a17:90a:6e09:b0:259:c10:ea34 with SMTP id b9-20020a17090a6e0900b002590c10ea34mr6574076pjk.2.1687140165427;
        Sun, 18 Jun 2023 19:02:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a298200b002310ed024adsm4970670pjd.12.2023.06.18.19.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:02:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qB4E5-00DTx5-2I;
        Mon, 19 Jun 2023 12:02:41 +1000
Date:   Mon, 19 Jun 2023 12:02:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in
 xfs_attr3_leaf_add_work
Message-ID: <ZI+3QXDHiohgv/Pb@dread.disaster.area>
References: <0000000000001c8edb05fe518644@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001c8edb05fe518644@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:22:59AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1f6ce8392d6f Add linux-next specific files for 20230613
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e629dd280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
> dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139d8d2d280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b371f1280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2d9bf45aeae9/disk-1f6ce839.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e0b03ef83e17/vmlinux-1f6ce839.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b6c21a24174d/bzImage-1f6ce839.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/65eca6891c21/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com
> 
> XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
> XFS (loop0): Ending clean mount
> xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
> ================================================================================
> UBSAN: array-index-out-of-bounds in fs/xfs/libxfs/xfs_attr_leaf.c:1560:3
> index 14 is out of range for type '__u8 [1]'
> CPU: 1 PID: 5021 Comm: syz-executor198 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
>  xfs_attr3_leaf_add_work+0x1528/0x1730 fs/xfs/libxfs/xfs_attr_leaf.c:1560
>  xfs_attr3_leaf_add+0x750/0x880 fs/xfs/libxfs/xfs_attr_leaf.c:1438
>  xfs_attr_leaf_try_add+0x1b7/0x660 fs/xfs/libxfs/xfs_attr.c:1242
>  xfs_attr_leaf_addname fs/xfs/libxfs/xfs_attr.c:444 [inline]
>  xfs_attr_set_iter+0x16c4/0x2f90 fs/xfs/libxfs/xfs_attr.c:721
>  xfs_xattri_finish_update+0x3c/0x140 fs/xfs/xfs_attr_item.c:332

The on disk format for this field is defined as:

typedef struct xfs_attr_leaf_name_local {
        __be16  valuelen;               /* number of bytes in value */
        __u8    namelen;                /* length of name bytes */
        __u8    nameval[1];             /* name/value bytes */
} xfs_attr_leaf_name_local_t

If someone wants to do change the on-disk format definition to use
"kernel proper" flex arrays in both the kernel code and user space,
update all the documentation and do all the validation work that
on-disk format changes require for all XFS disk structures that are
defined this way, then we'll fix this.

But as it stands, these structures have been defined this way for 25
years and the code accessing them has been around for just as long.
The code is not broken and it does not need fixing. We have way more
important things to be doing that fiddling with on disk format
definitions and long standing, working code just to shut up UBSAN
and/or syzbot.

WONTFIX, NOTABUG.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
