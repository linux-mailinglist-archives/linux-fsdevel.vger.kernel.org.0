Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401A705812
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjEPT4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEPT4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8B7ABE;
        Tue, 16 May 2023 12:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 334E4633A0;
        Tue, 16 May 2023 19:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283ACC4339B;
        Tue, 16 May 2023 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266994;
        bh=ZU2Zyf0H03rXKE9YvXFofcikO93Ns0RFs8ZYRp3OsaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tf3mGJYbfXDUuKzpYVC5dBWll5p0S5N9WMNdtJ2iqua20Z0hH2+at4Hys1CA5/sxb
         7P4NZQIaQd3ePO75ufKBX/LinFDNMXdX8hgScHPgH6wtoglVscXDYpsLMUs2cO882L
         AK7P/lDH6t2IwAltA04Ffi/oUidP9yht9vqPFrwZ4/dSSqsrov48xn++4QuyMBWnHw
         jHVCAyLwdl0nFMEn5hWEMzeh4huCRcYId+bahUgj2UidiWqva7Db8/9DA3LxdjPpre
         2GsLHhTSqOIrwMQB21Ym2n8cFLla0kRyfAWrC2kJmTZGAZlsqFg+pRq8aAcmcfXXSf
         u/d0gVkvAGV4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: pipe: reveal missing function protoypes
Date:   Tue, 16 May 2023 21:56:12 +0200
Message-Id: <20230516195629.551602-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516195444.551461-1-arnd@kernel.org>
References: <20230516195444.551461-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

A couple of functions from fs/pipe.c are used both internally
and for the watch queue code, but the declaration is only
visible when the latter is enabled:

fs/pipe.c:1254:5: error: no previous prototype for 'pipe_resize_ring'
fs/pipe.c:758:15: error: no previous prototype for 'account_pipe_buffers'
fs/pipe.c:764:6: error: no previous prototype for 'too_many_pipe_buffers_soft'
fs/pipe.c:771:6: error: no previous prototype for 'too_many_pipe_buffers_hard'
fs/pipe.c:777:6: error: no previous prototype for 'pipe_is_unprivileged_user'

Make the visible unconditionally to avoid these warnings.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/pipe_fs_i.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d2c3f16cf6b1..02e0086b10f6 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -261,18 +261,14 @@ void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
-#ifdef CONFIG_WATCH_QUEUE
 unsigned long account_pipe_buffers(struct user_struct *user,
 				   unsigned long old, unsigned long new);
 bool too_many_pipe_buffers_soft(unsigned long user_bufs);
 bool too_many_pipe_buffers_hard(unsigned long user_bufs);
 bool pipe_is_unprivileged_user(void);
-#endif
 
 /* for F_SETPIPE_SZ and F_GETPIPE_SZ */
-#ifdef CONFIG_WATCH_QUEUE
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
-#endif
 long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 
-- 
2.39.2

