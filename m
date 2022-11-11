Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF06263F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiKKVzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 16:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKKVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:55:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9EC76F93;
        Fri, 11 Nov 2022 13:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B89DECE2A6D;
        Fri, 11 Nov 2022 21:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857F2C433D7;
        Fri, 11 Nov 2022 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203741;
        bh=iPU2ya7vrzgXAOb87/v2umBwtkGSZt9BZbUd7t73RfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOe2lnjcZrYovPeK5+0kQN6snOjL8nlJVF0U9m4qYudVgrdkMQ4NwGJDkRGL0e7/a
         +C50hxdcWfzB2GI5xxKICPGpIq2uxy1kbc/YrlpZZCeZU/xoDg0AiN9V31AMAvTNeA
         4eGPAgdnJmaFilYIYe37gHH/vOEWD3m6zlUiMleEy9rBXqcEZv0pWLUtWWd1Jgpobl
         eDTMmg1bKlAG9uTM2TfoAWeNxN6dM6kYseVnSqOxeX9OCXgFa7X9JtIQ+ZvrFGa0R0
         t2/WFr09wnHsTGbJRPTdETjRoxsJGMaS1iyUjnYYjmvSBoGNph2tMC60RI15UoGjnn
         tlpXi5BUxEHQw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] lockd: set missing fl_flags field when retrieving args
Date:   Fri, 11 Nov 2022 16:55:35 -0500
Message-Id: <20221111215538.356543-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111215538.356543-1-jlayton@kernel.org>
References: <20221111215538.356543-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc4proc.c | 1 +
 fs/lockd/svcproc.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 284b019cb652..b72023a6b4c1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -52,6 +52,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e35c05e27806..32784f508c81 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -77,6 +77,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 		/* Set up the missing parts of the file_lock structure */
 		mode = lock_to_openmode(&lock->fl);
+		lock->fl.fl_flags = FL_POSIX;
 		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
-- 
2.38.1

