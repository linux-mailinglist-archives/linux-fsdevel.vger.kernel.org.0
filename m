Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029F7A7F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjITM1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjITM06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:26:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B46F7;
        Wed, 20 Sep 2023 05:26:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B244EC433C8;
        Wed, 20 Sep 2023 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212799;
        bh=7w3wXte0Q5vscTjKLQyyQ9Qi+pOJACkbgZE+Qx2WhvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK6KXZgbHlsUasqx1oAsJ5uphGPR+3k75a65VuYxbTVupA34BWG6lnBWADnMU2B5h
         6uuFEl8mtoQOFaVXwsgIrETfqq4tdAkxrhXxr2dB5rGlGqK1m396UyNaueN6J0K6ed
         bCj3AcauyiLJ0IS5tu2ucKXGHxU4XlOXHzqjr4ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Yang <wenyang.linux@foxmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/367] eventfd: prevent underflow for eventfd semaphores
Date:   Wed, 20 Sep 2023 13:27:07 +0200
Message-ID: <20230920112859.785849886@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Yang <wenyang.linux@foxmail.com>

[ Upstream commit 758b492047816a3158d027e9fca660bc5bcf20bf ]

For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.

An underflow can happen with EFD_SEMAPHORE eventfds in at least the
following three subsystems:

(1) virt/kvm/eventfd.c
(2) drivers/vfio/virqfd.c
(3) drivers/virt/acrn/irqfd.c

where (2) and (3) are just modeled after (1). An eventfd must be
specified for use with the KVM_IRQFD ioctl(). This can also be an
EFD_SEMAPHORE eventfd. When the eventfd count is zero or has been
decremented to zero an underflow can be triggered when the irqfd is shut
down by raising the KVM_IRQFD_FLAG_DEASSIGN flag in the KVM_IRQFD
ioctl():

        // ctx->count == 0
        kvm_vm_ioctl()
        -> kvm_irqfd()
           -> kvm_irqfd_deassign()
              -> irqfd_deactivate()
                 -> irqfd_shutdown()
                    -> eventfd_ctx_remove_wait_queue(&cnt)
                       -> eventfd_ctx_do_read(&cnt)

Userspace polling on the eventfd wouldn't notice the underflow because 1
is always returned as the value from eventfd_read() while ctx->count
would've underflowed. It's not a huge deal because this should only be
happening when the irqfd is shutdown but we should still fix it and
avoid the spurious wakeup.

Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
[brauner: rewrite commit message and add explanation how this underflow can happen]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 26b3d821e9168..e144094c831df 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -185,7 +185,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
 	lockdep_assert_held(&ctx->wqh.lock);
 
-	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
+	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
-- 
2.40.1



