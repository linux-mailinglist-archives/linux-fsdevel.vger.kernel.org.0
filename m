Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946AB577DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiGRIvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRIvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:51:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182631D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 01:51:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f11so9972827pgj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wgc+cGj98za4rUDWbU0RfsZuWkS1Vnin5ifV7MzA1M=;
        b=TrPCfkhp/kSXw35IfPMtNNuYNWrSQOrd06gh1nDMXmJwouhXsOL4aAEfBRFUIHetUk
         v41jDP2zss8d7C2H/+i8LI330YHHpI6zQwfwzN38+Xa75GkmqLj1TVg5MK6mnNa3CjDG
         LqBLxJ7JzlEqTT6Jmz6bm3v/ZNol+g5LeF6R7Qm04clQpaUEOBcwvqTbGOV66mpE6xR3
         y7vsg5FwSu+U5bAp/QhugNDV52Okcfpy/BAOGh9VJib18tZEK6aGwdsihh68Lqpc4w+l
         HHi+1e/UnlEsBcZ5t1XVqNULd9pocI4zgvlLbJ2W1+cxTMRt9LQPW0Ik34D/CX2SHpkC
         GnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wgc+cGj98za4rUDWbU0RfsZuWkS1Vnin5ifV7MzA1M=;
        b=hg3o1bOkGHVYkDg6t/NpqdrDfxo7Pc6CU+QbMzPFTDv3S3HYFqSZq42LCuc/YRbyEE
         bjzHLb2IBpSaqOz1/ix77BGdbPe8qWaK+qeh+sszzeSF2fdp8MkxqDKzGeeJWCVQXRfP
         l+dyu6EDDKDNqS6IeYUJzEBdWAbxrktyxUSIzcHs90w1pVmNt1S6o6h+QVXWBdaWuIqC
         tT3030opAa12jAGSl6kqcsbXInsdtCLB2hzz2WKRTlgHokevoS5jnDI/B3I1kTKLVfkJ
         KBjg4S886e3nFMcxrOXd5Ng7+OgLQbIvDDezqdLLZBWms8SxWEdj7E4XKSYQ/uhov6kp
         F0Fw==
X-Gm-Message-State: AJIora+JfLE5fc+r2tPIQHJUjpPA/gAQ0Tp56wdDTQM3j1EiO/YwioOz
        XYmL4V7j3z/vS2fa0igaRNnK
X-Google-Smtp-Source: AGRyM1uS+g0Gr+LWNxfbrarjcl/FqrHoX+IP7yzaRj11GgqaITssaTNUARVLNvD0vY089aq0qtGYpg==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr24285619pgu.30.1658134260282;
        Mon, 18 Jul 2022 01:51:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id f62-20020a623841000000b005252680aa30sm8678338pfa.3.2022.07.18.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:50:59 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: Remove the control interface for virtio-fs
Date:   Mon, 18 Jul 2022 16:50:12 +0800
Message-Id: <20220718085012.155-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit 15c8e72e88e0 ("fuse: allow skipping control
interface and forced unmount") tries to remove the control
interface for virtio-fs since it does not support aborting
requests which are being processed. But it doesn't work now.

This patch fixes it by skipping creating the control interface
if fuse_conn->no_control is set.

Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 7cede9a3bc96..247ef4f76761 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -258,7 +258,7 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 	struct dentry *parent;
 	char name[32];
 
-	if (!fuse_control_sb)
+	if (!fuse_control_sb || fc->no_control)
 		return 0;
 
 	parent = fuse_control_sb->s_root;
@@ -296,7 +296,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
 	int i;
 
-	if (!fuse_control_sb)
+	if (!fuse_control_sb || fc->no_control)
 		return;
 
 	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
-- 
2.20.1

