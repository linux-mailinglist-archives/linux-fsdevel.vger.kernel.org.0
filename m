Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F27A4792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjIRKvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbjIRKu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16D188;
        Mon, 18 Sep 2023 03:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8666AC433C8;
        Mon, 18 Sep 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695034223;
        bh=xrXFiitV9cg7iNtsA2pDOZav9rtVTmsOfAZLd0oEB9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZsAy5ZMjVjc0xrbAbhRHXJ1nxSna2ldKcvq+v1lyoaFDxfqgU610q4ghN2XNNLMY
         hcYmU5z9f+/v2qpSkTVJHuwFBKOd4+uKePjbPFZhZ38prfruBw4Yo5P65IOphxiecm
         OTsas2wwkvfIk9Atujdyx1JSyaZ12BPVOI8l+hURw9AOa1D0lWLW10Gn+0P3Qt9GH0
         8OBL5w9iLIUx3r3a3tdehWgaT52QbuPHFkVyIfAKcRCihHINLOCzLq67AYoQdMj+zi
         BRUUUasfAX5R+zOVUQeE9Yozs/DmmerXrvr2fnTn+bRGhojBF7xIOGMP1+Js6cKoJ0
         sIWBIg6HzmyAw==
Date:   Mon, 18 Sep 2023 12:50:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] WARNING in setattr_copy
Message-ID: <20230918-adrenalin-extra-64562065d07b@brauner>
References: <00000000000033d44706057458b3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000033d44706057458b3@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:51:54PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3c13c772fc23 Add linux-next specific files for 20230912
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b02b0c680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7149cbda1664bc5
> dashboard link: https://syzkaller.appspot.com/bug?extid=450a6d7e0a2db0d8326a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b32b4680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cf6028680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb6fbc71f83a/disk-3c13c772.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d671ade67d9/vmlinux-3c13c772.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b2b7190a3a61/bzImage-3c13c772.xz
> 
> The issue was bisected to:
> 
> commit d6f106662147d78e9a439608e8deac7d046ca0fa
> Author: Jeff Layton <jlayton@kernel.org>
> Date:   Wed Aug 30 18:28:43 2023 +0000
> 
>     fs: have setattr_copy handle multigrain timestamps appropriately
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1419f8d8680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1619f8d8680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1219f8d8680000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+450a6d7e0a2db0d8326a@syzkaller.appspotmail.com
> Fixes: d6f106662147 ("fs: have setattr_copy handle multigrain timestamps appropriately")

#syz unset subsystems: ext4
#syz set subsystems: overlayfs
