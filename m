Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A771708037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjERLs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjERLsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECB6173D;
        Thu, 18 May 2023 04:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6396B64ED5;
        Thu, 18 May 2023 11:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77283C433A1;
        Thu, 18 May 2023 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410479;
        bh=wTAnemCjoVMdBCyfBm7Caga87wrGLLdiUMBAcBipLM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pv9NSU1eFgIMWnOukE0vFtlSJhvEzj0TZb3+gBxSbV4qnUliBKBhdy87cs9IAXHTQ
         1dMxyJ0MCSwcxOHa0adG7hzskt16qlLg6oamqDb76RXfskYjsZM5o0JxuTo/WFc897
         VcFtzIuIMOGA47SH7EdySeITog2TKUoLRdLffRTpA7WrjOcjjvIVsAT/189C9RgPwh
         YJ2blX4n6Pm7QyDIP3ewgeAI6b3YJEbz4lUXoiFKczZaUeQvD+QwwzqUFJd6f3EYkC
         +6ZEtMgGqziZq7hwGRaYwIsAUtBQD/dTP/9CtCnpQcrkIjmmiHoBVgsfu4UY3Vycc5
         mjFdNmAgburFQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 5/9] ksmbd: use ctime_peek to grab the ctime out of the inode
Date:   Thu, 18 May 2023 07:47:38 -0400
Message-Id: <20230518114742.128950-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
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

This ensures that the flag is masked off in the result.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d39ddb344417..c33128570448 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4745,7 +4745,7 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	file_info->LastAccessTime = cpu_to_le64(time);
 	time = ksmbd_UnixTimeToNT(inode->i_mtime);
 	file_info->LastWriteTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode->i_ctime);
+	time = ksmbd_UnixTimeToNT(ctime_peek(inode));
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->DosAttributes = fp->f_ci->m_fattr;
 	file_info->Inode = cpu_to_le64(inode->i_ino);
@@ -5386,7 +5386,7 @@ int smb2_close(struct ksmbd_work *work)
 		rsp->LastAccessTime = cpu_to_le64(time);
 		time = ksmbd_UnixTimeToNT(inode->i_mtime);
 		rsp->LastWriteTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode->i_ctime);
+		time = ksmbd_UnixTimeToNT(ctime_peek(inode));
 		rsp->ChangeTime = cpu_to_le64(time);
 		ksmbd_fd_put(work, fp);
 	} else {
@@ -5605,7 +5605,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	if (file_info->ChangeTime)
 		attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
 	else
-		attrs.ia_ctime = inode->i_ctime;
+		attrs.ia_ctime = ctime_peek(inode);
 
 	if (file_info->LastWriteTime) {
 		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
-- 
2.40.1

