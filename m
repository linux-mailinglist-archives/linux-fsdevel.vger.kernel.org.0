Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD772F716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjFNH5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFNH5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C27CD;
        Wed, 14 Jun 2023 00:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF5A263601;
        Wed, 14 Jun 2023 07:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9832C433C0;
        Wed, 14 Jun 2023 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686729453;
        bh=/rvXP8z8fSR2gCpuE2R7Dtsv1cxDxmCOVCGyTdZ/4gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPJY/RWyVN0jyebAGapylSQyRMsK/dVLte4Ovb1DR0WKTcNQEf0KMOwA8WdwdxvJx
         nBqELBvr7Tln8RhSKUM0BPYC2Qa2eQu6rwjyBEGECvVmTuqHXq+YuYMF748pvrY+Xm
         YzblKjHUFwa8ZoHBp7CdOwIZYbEjvvbGJPn1lhVGjgil2BLJcD1W5e0mDCrrhLJSGo
         Qhtqmhb97JUt6B3IEXkI15Je0WRsmHkuJwrCrnxufRfMuWUk0DpadQqmiWj2KrTFas
         RQfnV3aqvWYOKvY5O059fzOHDoaT2q9PMskMHxYnZwG9345ySrbHuo/Fat3wXFCzhR
         V8HEdodAgSD6g==
From:   Christian Brauner <brauner@kernel.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Suren Baghdasaryan <surenb@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] poll: Fix use-after-free in poll_freewait()
Date:   Wed, 14 Jun 2023 09:57:25 +0200
Message-Id: <20230614-tapir-zellkern-69406a55c08f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614070733.113068-1-lujialin4@huawei.com>
References: <20230614070733.113068-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=brauner@kernel.org; h=from:subject:message-id; bh=/rvXP8z8fSR2gCpuE2R7Dtsv1cxDxmCOVCGyTdZ/4gc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0Fj1szrHQOBC/2Z01d1rRWn3PeKnNt2yvzGmb+avZZ7Zw 1Q/NjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksUWX4K/x+4rpnMu+ZtrSsZIko+d vxR1TRU4xXX3/yveJt52et2MLwv1KxOF1J68GmOzFzLiuVefTuvHWXIe30mf+5hZm1uRMWMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Jun 2023 15:07:33 +0800, Lu Jialin wrote:
> We found a UAF bug in remove_wait_queue as follows:
> 
> ==================================================================
> BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
> Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
> Call Trace:
>  dump_stack+0x9c/0xd3
>  print_address_description.constprop.0+0x19/0x170
>  __kasan_report.cold+0x6c/0x84
>  kasan_report+0x3a/0x50
>  check_memory_region+0xfd/0x1f0
>  _raw_spin_lock_irqsave+0x71/0xe0
>  remove_wait_queue+0x26/0xc0
>  poll_freewait+0x6b/0x120
>  do_sys_poll+0x305/0x400
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] poll: Fix use-after-free in poll_freewait()
      https://git.kernel.org/vfs/vfs/c/e5f00a6f63bc
