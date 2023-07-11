Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30274EB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGKJqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGKJqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B412E;
        Tue, 11 Jul 2023 02:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139E861445;
        Tue, 11 Jul 2023 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45957C433C7;
        Tue, 11 Jul 2023 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689068791;
        bh=khqqdSUgryNKoHyT/SRYlld1lc2OizTviNY0M8lLQkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kftvrLuu6q/hYtN4YVuWw9xk9CbOPKNopeoIxQ5XrEtQ8h7SFApymtIcmzISYVxR6
         THK9ieaBrfKM2yW3zcBdFYxN8L8hLJKiEjeXaw33cr+pHr8EBDWAxsYe0p5t8ko9qF
         DlP0HEoVfvNBE/05vnxbD5CjVDuAge/iLaN/UlrICVD5RO2r4zvxl6K3a5HVuw8OW7
         grCu9ak01/CiratkQMZ7f7oek0EL11gDeBmOJZrXsbycQrndo2acOp7ra/B34giOgQ
         ywOXzPjJerLbZ/CBbZ5rTA3KELAT8Y7Bj2sx1nmA0GiiYP7i7jP+q9wuEL7H1BIjkT
         +T3rfiN9ljCiw==
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is 0
Date:   Tue, 11 Jul 2023 11:46:20 +0200
Message-Id: <20230711-zumindest-anarchie-18d41e1893e3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=brauner@kernel.org; h=from:subject:message-id; bh=khqqdSUgryNKoHyT/SRYlld1lc2OizTviNY0M8lLQkU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSsVXnZ9/6t2s2106POmEt1s61Ra2R6f+1DBv+Tnxon9byv 3c6q6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIL2mGP9yWws/cYviXsgUdj+LiNz nhsu/EI9Hu6+f5ZR6zNyzZYc3wm1U+8U+pS0CXsUq0EW8M4/GlbU9nParcJspavtXhn9s0NgA=
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

On Sun, 09 Jul 2023 14:54:51 +0800, wenyang.linux@foxmail.com wrote:
> For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
> eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
> 
> 

I've tweaked the commit message to explain how an underflow can happen.
And for now I dropped that bit:

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 10a101df19cd..33a918f9566c 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -269,8 +269,6 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
                return -EFAULT;
        if (ucnt == ULLONG_MAX)
                return -EINVAL;
-       if ((ctx->flags & EFD_SEMAPHORE) && !ucnt)
-               return -EINVAL;
        spin_lock_irq(&ctx->wqh.lock);
        res = -EAGAIN;
        if (ULLONG_MAX - ctx->count > ucnt)

because I don't yet understand why that should be forbidden. Please
explain the reason for wanting that check in there and I can add it back.
I might just be missing the obvious.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] eventfd: prevent underflow for eventfd semaphores 
      https://git.kernel.org/vfs/vfs/c/7b2edd278691
