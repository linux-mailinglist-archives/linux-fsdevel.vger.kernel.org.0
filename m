Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62476FFD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 13:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjHDL7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHDL7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F4B1;
        Fri,  4 Aug 2023 04:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D4A61F69;
        Fri,  4 Aug 2023 11:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E47C433C9;
        Fri,  4 Aug 2023 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691150353;
        bh=TlxRuxshp1+YEtrdMg8rVE0v+c8+0ZCqcnwFTAXxjpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcD49VFzi/A6qiHCW/un5jA9r576MNjHpV0OwWK0UaQcwSCkmN5BEV3W29E4+xuHs
         +l/Eyr9uUBYwKinhoYq4H6p1kyCSIErdj/WWKRf9z+U5OKpm1FRpedp6ASfOJG7VYx
         5CvyFiRFLLSgIh+lPwDwmCcRtu1Q9/WhqeKSGFCIQhB6h5ICdTpyAop9gZKjGeSoq6
         DPNNRGHJkhAX+XTiUoS2s3qNPoSPOPa58XejfwlavvTDLLXlyLIpIkP2netue/HOof
         bFL71jXAPnkHWHpKVXXgXYfZX7zhxEB2FkEbeiZoQFSw2mJIV67JCJZCC9YxzNuZgD
         qmihkgzqDqyqw==
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrey Vagin <avagin@openvz.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/2] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
Date:   Fri,  4 Aug 2023 13:59:05 +0200
Message-Id: <20230804-testverfahren-bison-351d431d4491@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
References: <169112719161.7590.6700123246297365841.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=brauner@kernel.org; h=from:subject:message-id; bh=TlxRuxshp1+YEtrdMg8rVE0v+c8+0ZCqcnwFTAXxjpw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScecGa53mD0SqYv1/Ubvvbb5c0DZWPR4Uo8y0zWqH+RPOV 4SzJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUhjH8z1pqUfxFxHlTgt6ljy9LLn +flcTgaXx60/vpZet2TLhtr8/I8KrOPGdyQbdXb+XK7vMX2W50zbvf9eTiSy+eb6cuFs98xw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 04 Aug 2023 13:33:12 +0800, Ian Kent wrote:
> Syzkaller reports a memory leak:
> 
> BUG: memory leak
> unreferenced object 0xffff88810b279e00 (size 96):
>   comm "syz-executor399", pid 3631, jiffies 4294964921 (age 23.870s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 9e 27 0b 81 88 ff ff  ..........'.....
>     08 9e 27 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ..'.............
>   backtrace:
>     [<ffffffff814cfc90>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
>     [<ffffffff81bb75ca>] kmalloc include/linux/slab.h:576 [inline]
>     [<ffffffff81bb75ca>] autofs_wait+0x3fa/0x9a0 fs/autofs/waitq.c:378
>     [<ffffffff81bb88a7>] autofs_do_expire_multi+0xa7/0x3e0 fs/autofs/expire.c:593
>     [<ffffffff81bb8c33>] autofs_expire_multi+0x53/0x80 fs/autofs/expire.c:619
>     [<ffffffff81bb6972>] autofs_root_ioctl_unlocked+0x322/0x3b0 fs/autofs/root.c:897
>     [<ffffffff81bb6a95>] autofs_root_ioctl+0x25/0x30 fs/autofs/root.c:910
>     [<ffffffff81602a9c>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81602a9c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
>     [<ffffffff81602a9c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
>     [<ffffffff81602a9c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
>     [<ffffffff84608225>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84608225>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied to the vfs.autofs branch of the vfs/vfs.git tree.
Patches in the vfs.autofs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.autofs

[1/2] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
      https://git.kernel.org/vfs/vfs/c/ccbe77f7e45d
[2/2] autofs: use wake_up() instead of wake_up_interruptible(()
      https://git.kernel.org/vfs/vfs/c/17fce12e7c0a
