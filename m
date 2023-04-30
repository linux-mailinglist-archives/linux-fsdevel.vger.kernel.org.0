Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5066F27D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjD3Gkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjD3Gko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:40:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9B1993
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:40:42 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U6eNoc011311
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682836829; bh=iBfl+AI+TPXIjruYn9BTakCU2j/MI6yZMdHCd0wR+w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UwX75s5X9ohAWnGAWjLY809SChJuRowRZKwj3Iw1SuH+lgRoEhz65oefP4hGEWZop
         CoLfdbjQlerDCy3vn+gYbrNUfGSEiaLccdXlQ3gWeUmzTTAyxoRMLVI9Z4dQ8mSSR7
         GsiQ3Q/Jz8ASWZ5Y+ffCdB6OcWzKUaBauVze6rvqYK4HcXnaq/MG1lXCwCt9ThyJzY
         SE+ui5CErQDhhbL3EkOL+40rLiXUlDAqK2KdbMduYZiUKO5Jv/U/jWitAKfuhiS/Ry
         2ibVSrIRtAPKvrb1xasY7YaFRLA8nG9u1FxCiA3YLV8FW/HiQQYKRa6bDCniijz0dz
         LRoVhCld8IHww==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 158158C023E; Sun, 30 Apr 2023 02:40:22 -0400 (EDT)
Date:   Sun, 30 Apr 2023 02:40:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
Cc:     hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
Message-ID: <ZE4NVo6rTOeGQdK+@mit.edu>
References: <000000000000eccdc505f061d47f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000eccdc505f061d47f@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:57:38PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1560b830480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
> dashboard link: https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e320b3880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c0577880000

#syz set subsystems: sysv, udf

There are two reproducers, one that mounts a sysv file system, and the
other which mounts a udf file system.  There is no mention of ext4 in
the stack trace, and yet syzbot has assigned this to the ext4
subsystem for some unknown reason.

					- Ted
