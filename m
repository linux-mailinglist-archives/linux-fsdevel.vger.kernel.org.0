Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF975FA14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGXOoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGXOoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1CD2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42107611BC
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 14:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8DCC433C7;
        Mon, 24 Jul 2023 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690209838;
        bh=V80fCBO6tgYnB7Y4diByKwMKMbOCb33FIejFATg08B8=;
        h=Subject:From:To:Cc:Date:From;
        b=QNJOk2COoCIQPzMYykF9XgsX08VRDrdH8EU44jFw20RzAArf8azQe8/8g+HZLq3VN
         4IE+0rn/UW4CpdISFbcgE0U2cD4FPwCnZ1DlcsPa7llYhCtWxFghm2b2+WSbG2QbI9
         0wCrXpeb1afMfCL7iMUsJbDqwRIZIqqxRSTNwB/ukQFcynI7rqTgumTvXgJvHwkRfc
         r7ToSVzOD6IJNW/nY+LZv0j2vKLpRa7SNXVb5v+YcGSHN8S5QXv+69HRjNDExiTvjX
         2ldM5tgzdtI5mZTBUeOXIVMgxdLl/J4o20NVP8kE6ye/zc9xBkdio7MUT7tYCFzc/2
         UMy2onSWLgFLA==
Subject: [PATCH] libfs: Add a lock class for the offset map's xa_lock
From:   Chuck Lever <cel@kernel.org>
To:     brauner@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 24 Jul 2023 10:43:57 -0400
Message-ID: <169020933088.160441.9405180953116076087.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Tie the dynamically-allocated xarray locks into a single class so
contention on the directory offset xarrays can be observed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |    3 +++
 1 file changed, 3 insertions(+)

I've been looking into the recent kernel bot reports of performance
regressions on the will-it-scale benchmark.

https://lore.kernel.org/linux-mm/202307171640.e299f8d5-oliver.sang@intel.com/

I haven't been able to run the reproducer yet, but I have created a
small change to demonstrate that it is unlikely that it is the
xa_lock itself that is the issue. All tests I've run here show "0.0"
in the lock_stat contention metrics for the simple_offset_xa_lock
class.

It seems reasonable to include this small change in the patches
already applied to your tree.


diff --git a/fs/libfs.c b/fs/libfs.c
index 68b0000dc518..fcc0f1f3c2dc 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -249,6 +249,8 @@ static unsigned long dentry2offset(struct dentry *dentry)
 	return (unsigned long)dentry->d_fsdata;
 }
 
+static struct lock_class_key simple_offset_xa_lock;
+
 /**
  * simple_offset_init - initialize an offset_ctx
  * @octx: directory offset map to be initialized
@@ -257,6 +259,7 @@ static unsigned long dentry2offset(struct dentry *dentry)
 void simple_offset_init(struct offset_ctx *octx)
 {
 	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
+	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
 
 	/* 0 is '.', 1 is '..', so always start with offset 2 */
 	octx->next_offset = 2;


