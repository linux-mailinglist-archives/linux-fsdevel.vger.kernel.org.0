Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6B70F86D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjEXOQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEXOQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 10:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6E11D;
        Wed, 24 May 2023 07:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095326336E;
        Wed, 24 May 2023 14:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9EC433D2;
        Wed, 24 May 2023 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684937784;
        bh=3QN+9t6JJtH6fE/ajF8xfSfq7v/w6qAiLq/kcVdecT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erNS1OCdqIspA56gFKpdaFf+A6sG5B5UE/U/ri7nVQuB5Decx1IO/Hign2SWpeeM9
         MWFTEQsEN+XzO54OT3wxhkIAUL/9dfOEzN5ftsbD62aNcEqKuyNXeCdh2qwLP4JHDG
         07NKWkA0gNEqdrVxZ7HUtSFvNdFmHjHBUUqBzG/Kxw1Okr09FZl5YvMBtSo7JApUri
         eltVWoul+Yx0ssnaCnX4w1r2hVbS5j3AGOU3M6OeGeeDdZ7zY69ep6SIwqQ6HCzbAH
         osmXkqmLjIHdQ+H6UE6/RKBWri3pgItDuTGtZDFbTIpJWmNajNoC/5a2BZ1j/fxHcu
         upPrMuPa7YEog==
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: use UB-safe check for signed addition overflow in remap_verify_area
Date:   Wed, 24 May 2023 16:16:17 +0200
Message-Id: <20230524-umfahren-stift-d1c34fd1d0fa@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523162628.17071-1-dsterba@suse.com>
References: <20230523162628.17071-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=brauner@kernel.org; h=from:subject:message-id; bh=3QN+9t6JJtH6fE/ajF8xfSfq7v/w6qAiLq/kcVdecT0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTkyeh6HmmsOqjfeqDPkDOlbscftU5vdi1PscrfCR8yjKsX y/7vKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjSJ0aGE2v01T8dfdwj6nyBXWW2+9 dna5SlDzHd43EVs6i8nWj2nOF/uG+q8gKNr+cE+KR/2y1ePuVvSFxsxKa8+4t1m29JyKcwAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 May 2023 18:26:28 +0200, David Sterba wrote:
> The following warning pops up with enabled UBSAN in tests fstests/generic/303:
> 
>   [23127.529395] UBSAN: Undefined behaviour in fs/read_write.c:1725:7
>   [23127.529400] signed integer overflow:
>   [23127.529403] 4611686018427322368 + 9223372036854775807 cannot be represented in type 'long long int'
>   [23127.529412] CPU: 4 PID: 26180 Comm: xfs_io Not tainted 5.2.0-rc2-1.ge195904-vanilla+ #450
>   [23127.556999] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
>   [23127.557001] Call Trace:
>   [23127.557060]  dump_stack+0x67/0x9b
>   [23127.557070]  ubsan_epilogue+0x9/0x40
>   [23127.573496]  handle_overflow+0xb3/0xc0
>   [23127.573514]  do_clone_file_range+0x28f/0x2a0
>   [23127.573547]  vfs_clone_file_range+0x35/0xb0
>   [23127.573564]  ioctl_file_clone+0x8d/0xc0
>   [23127.590144]  do_vfs_ioctl+0x300/0x700
>   [23127.590160]  ksys_ioctl+0x70/0x80
>   [23127.590203]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>   [23127.590210]  __x64_sys_ioctl+0x16/0x20
>   [23127.590215]  do_syscall_64+0x5c/0x1d0
>   [23127.590224]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [23127.590231] RIP: 0033:0x7ff6d7250327
>   [23127.590241] RSP: 002b:00007ffe3a38f1d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>   [23127.590246] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ff6d7250327
>   [23127.590249] RDX: 00007ffe3a38f220 RSI: 000000004020940d RDI: 0000000000000003
>   [23127.590252] RBP: 0000000000000000 R08: 00007ffe3a3c80a0 R09: 00007ffe3a3c8080
>   [23127.590255] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 0000000000000000
>   [23127.590260] R13: 0000000000000000 R14: 3fffffffffff0000 R15: 00007ff6d750a20c
> 
> [...]

Independent of this fix it is a bit strange that we have this
discrepancy between struct file_clone_range using u64s and the internal
apis using loff_t. It's not a big deal but it's a bit ugly.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: use UB-safe check for signed addition overflow in remap_verify_area
      https://git.kernel.org/vfs/vfs/c/70a4d38461f8
