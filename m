Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1717B8D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbjJDS7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbjJDS5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8E1BFB;
        Wed,  4 Oct 2023 11:55:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A3C43140;
        Wed,  4 Oct 2023 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445709;
        bh=C2sMGCifwVKgPH9B5NULLuhjFDkV30Ac28vR9ZpArJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0dMSKQMuTar62s8aTrrgqnAAVo1fygmNDAZlzC7LIjlOAQTpW+bw2CXhsbT3f6l7
         FsCcQhgkXqjYwJScf7XhohFQ9wIyiolRZCpA+CsJAnkaZbnFYSE5i79qD1qMpmkpSS
         6kK5ehF2Ztll2jcw6nvCc5zSduIlbsdKB3Dorc4l0YDfTMCYTsaJVrCYN89BFMbBlD
         L0r4hJL6iXMAwOZ781Nkp0FfSMc0PzbN6J5jUpwx1ylyyD1b0jKeV8By6IcDAUQjQ/
         4rm6s5G4PseQwx+CA3FUwRnHHd3jvR/MpuDJ7CJVnkMMPHxnklXV2d0ONIpz5smNrY
         XX6nZuJvmJJKA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: [PATCH v2 69/89] server: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:54 -0400
Message-ID: <20231004185347.80880-67-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 544022dd6d20..581f1deb1a03 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4797,9 +4797,9 @@ static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 
 	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
-	time = ksmbd_UnixTimeToNT(inode->i_atime);
+	time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
 	file_info->LastAccessTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode->i_mtime);
+	time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
 	file_info->LastWriteTime = cpu_to_le64(time);
 	time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
 	file_info->ChangeTime = cpu_to_le64(time);
@@ -5406,9 +5406,9 @@ int smb2_close(struct ksmbd_work *work)
 		rsp->EndOfFile = cpu_to_le64(inode->i_size);
 		rsp->Attributes = fp->f_ci->m_fattr;
 		rsp->CreationTime = cpu_to_le64(fp->create_time);
-		time = ksmbd_UnixTimeToNT(inode->i_atime);
+		time = ksmbd_UnixTimeToNT(inode_get_atime(inode));
 		rsp->LastAccessTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode->i_mtime);
+		time = ksmbd_UnixTimeToNT(inode_get_mtime(inode));
 		rsp->LastWriteTime = cpu_to_le64(time);
 		time = ksmbd_UnixTimeToNT(inode_get_ctime(inode));
 		rsp->ChangeTime = cpu_to_le64(time);
-- 
2.41.0

