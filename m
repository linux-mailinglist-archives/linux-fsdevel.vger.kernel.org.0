Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18416AF5BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjCGTeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjCGTdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:33:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0125BCBB0;
        Tue,  7 Mar 2023 11:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BED161520;
        Tue,  7 Mar 2023 19:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB88C433D2;
        Tue,  7 Mar 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678216843;
        bh=v+R8uNYyvl6BXMep+iIQa4rgGlsTJcYTdpVSEaeL+2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qssyoXV6oKqrID6jpSFU+zfGamVCT1S6yqdmKgV040D1m5WMln3CCvn9d4k8CGZvE
         ZHrJTJLKgffxwdC1rVzM8pQWXwxyDicrp0TZpg5ViZQ+G/EGbJgolTYixUCs48Bp5b
         OR+BuL3HWXOR+2+z67erIekRvHa1fRKj29W9qpwBn5bW13qucNtqJAYGVO3KLAl94/
         vgHj6DJt/h8tXdxyZCEGhe4/gHq/JiM6ue07J7dw/WGepmum0tg3/Cv82B4y1GrT2U
         s6Kg1DHCg648hLhcz4HGP5rpQtKTeXWeUS8rRBZsPCLpG6dJySDmXBGRuiFhAxUjIV
         J4YQPCt2dkNCg==
Date:   Tue, 7 Mar 2023 19:20:42 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+0c73d1d8b952c5f3d714@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename2
Message-ID: <ZAeOilzUDPQX7joj@gmail.com>
References: <000000000000435c6905f639ae8e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000435c6905f639ae8e@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:34:40AM -0800, syzbot wrote:
> =====================================
> WARNING: bad unlock balance detected!
> 6.2.0-syzkaller-13467-g0988a0ea7919 #0 Not tainted
> -------------------------------------
> syz-executor.3/8027 is trying to release lock (&type->i_mutex_dir_key) at:
> [<ffffffff82448753>] inode_unlock include/linux/fs.h:763 [inline]
> [<ffffffff82448753>] ext4_rename fs/ext4/namei.c:4017 [inline]
> [<ffffffff82448753>] ext4_rename2+0x3d03/0x4410 fs/ext4/namei.c:4193
> but there are no more locks to release!

I think this is the same as
"[bug report] ext4: Fix possible corruption when moving a directory"
(https://lore.kernel.org/linux-ext4/5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain).
See there for the root cause (double unlock).

- Eric
