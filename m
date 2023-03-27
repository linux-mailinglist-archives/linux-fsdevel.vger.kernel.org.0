Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D96CACEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjC0SXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjC0SXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719613585;
        Mon, 27 Mar 2023 11:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3902AB818A9;
        Mon, 27 Mar 2023 18:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94982C433EF;
        Mon, 27 Mar 2023 18:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941383;
        bh=JEKlM+bqF/R1VFyTBMpRBCAf1N5vKq7gxUYcEFId+N0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lSV0tP4+v61vHHux+QcFowZFvdqJuXNaO0NRfRWwPXSE2tk2V/dEba8BGdLmrq+Sv
         3CDMY5JEyQjvPRnDKOpwZ+0egZSMOL/TEBgPvw31cNiV2EL4IWJVAjkIGyifXA1bb6
         gUECJyYvFgCDaWVLlatV/nRarSUe0l9WAfkFLW6f4vjPK1A06lYc5zgqji7QSK1liX
         mH4FcK2EEih3HkI7xufQoy3s0osbxcei59XxE44iiFmOMCWGiqIh6o4zN78dYSg6vp
         X5WqEYZxlF1VHXb5dEqBrQXdyR53OlJ48whrPXGLzG92Xf1i5228XqdfX25VQviPLY
         FT5OASAZtck6A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Mar 2023 20:22:52 +0200
Subject: [PATCH 2/3] fork: use pidfd_prepare()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-pidfd-file-api-v1-2-5c0e9a3158e4@kernel.org>
References: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
In-Reply-To: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JEKlM+bqF/R1VFyTBMpRBCAf1N5vKq7gxUYcEFId+N0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQo3mf0SZAs/5tQ151pd9fkgc+LhkS7TY/+rj7JwhizkMvD
 7t6sjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsWsTIsDnPKfanzNml95aniu4Pf8
 15pGtb258Ihv3GP39of1hfdI6R4eCSYmVlCUHbeW8f8E0uaws7Vi0buLto6ZWggE8LGi9cYQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop open-coding get_unused_fd_flags() and anon_inode_getfile(). That's
brittle just for keeping the flags between both calls in sync. Use the
dedicated helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c0257cbee093..1f5eb854ba3e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2291,21 +2291,11 @@ static __latent_entropy struct task_struct *copy_process(
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
-		retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+		retval = pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
-
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
-		if (IS_ERR(pidfile)) {
-			put_unused_fd(pidfd);
-			retval = PTR_ERR(pidfile);
-			goto bad_fork_free_pid;
-		}
-		get_pid(pid);	/* held by pidfile now */
-
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;

-- 
2.34.1

