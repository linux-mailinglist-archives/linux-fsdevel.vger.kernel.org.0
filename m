Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF47B1A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjI1LKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjI1LJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:09:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72419C;
        Thu, 28 Sep 2023 04:05:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20470C433C9;
        Thu, 28 Sep 2023 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899134;
        bh=14gzqF/vqBJ7lLHQtJVC0eAe1MKwKnBy8jzKUgJf0XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfyaUQBG7VWCB64WApXpej0ehV8q05W0VBDKrxKlzrmtE8TiiUjHze62R5XqwD4Bu
         rnSNSrE/lEM9ddmWodzJNVE+tNYlHRegbdFOPTlXT+4U4ziFdZQTbm2TF/2d58w0Mc
         GLb3HeY9DGUAEEcQOmam3WG4/eYp0KVxn98+xpcvS/D0VoG1ukg0y/eUn7LdMRKkhS
         8eZo2lq3V/A3AxvpbGtboFU/89PRMOMKs2kmB9RKGrvglQh7o5gJbTZbwumZ6sxvBP
         qVmA6e9U2PqQzPLYESrFSd1FPQWuFoZLpNp3iwgIVg3LVDpxQthOEsxQGczZmiX9YN
         xupDVTfN4xF7w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: [PATCH 68/87] fs/smb/server: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:17 -0400
Message-ID: <20230928110413.33032-67-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

