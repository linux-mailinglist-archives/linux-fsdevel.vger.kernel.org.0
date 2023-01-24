Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94913679793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjAXMSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjAXMST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE696442EB
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 453901FE4C;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzIT2ogqM6g985qdJPjq2SBXyIwASRSm+gjHhyco+Nc=;
        b=x/+onkdJP4myHMj6m2B4wmVSPvqTEPaQtNjVZv1wHzBdXNaEzIj8/9RW2YMfRvbVHMretZ
        4FMFgPyXhIJaiuBDPk2vQRL8I5A4tSQb+8aUrypmulEyWf5Z2nBr2LpOdY3wxPtfBQ2VIq
        3ejrAmU5u/EZk2E2kDnN+DQgv9FanlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzIT2ogqM6g985qdJPjq2SBXyIwASRSm+gjHhyco+Nc=;
        b=3e0nzqMYGGpr9cNd9AW1CduEAoMqMq+h+YQICsYrc1GLPYlqTUuem0d80dcIxrsydJ22yG
        qXOsThmosMC//JAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BDEE139FB;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nnGzCofMz2PyNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52C0AA06E3; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Subject: [PATCH 14/22] udf: Protect rename against modification of moved directory
Date:   Tue, 24 Jan 2023 13:18:00 +0100
Message-Id: <20230124121814.25951-14-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092; i=jack@suse.cz; h=from:subject; bh=Zu8Vih3EU1Cmz8d/II2LP6vgNBGzt1ICxuXfhJV63EU=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLPn6mI/zCpmOvx+yv9XXWL7xzf3qwhvq1y344m14qzT6TW HMuS72Q0ZmFg5GCQFVNkWR15UfvaPKOuraEaMjCDWJlApjBwcQrARF5Lsf/PvRY40fK7lp0ak/2aNU pHZ/onfDTc+mWf5Lva9slHS7rWzXj9auWJVS3tXfbrOuSnbhZ5LdbbmNKhuWJHaseqKMmvqZ84Tlkt vfMm4i+jeklBkktlZQeT/IM5t/87O+w+w91yfQPbncUGJ7n5H/9W2tyl0F1Vm7CfPVChlWF2YHrew9 Tl9xsLw3Y3Vf6J+XOy9Ipj5TI7sYrITaXaDya0uWz6djbBQYZxU2Y3C5ujq9givir9lGZf9+QfmQcu n57Xsq3u8Wmm9lQz/3bF64fsG2x5w1ZO+enSN8GtYF5GcZFWVn2STULqk5okERaJeSeEp7WKREdV9a jo3zCZWRv8gzfNJXNCl7bOvD5pAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are renaming a directory to a different directory, we need to
update '..' entry in the moved directory. However nothing prevents moved
directory from being modified and even converted from the in-ICB format
to the normal format which results in a crash. Fix the problem by
locking the moved directory.

Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 49fab30afff3..1b0f4c600b63 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -782,6 +782,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			if (!empty_dir(new_inode))
 				goto out_oiter;
 		}
+		/*
+		 * We need to protect against old_inode getting converted from
+		 * ICB to normal directory.
+		 */
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
 		if (retval == -ENOENT) {
@@ -790,8 +795,10 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 				old_inode->i_ino);
 			retval = -EFSCORRUPTED;
 		}
-		if (retval)
+		if (retval) {
+			inode_unlock(old_inode);
 			goto out_oiter;
+		}
 		has_diriter = true;
 		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
@@ -869,6 +876,7 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
+		inode_unlock(old_inode);
 
 		inode_dec_link_count(old_dir);
 		if (new_inode)
@@ -880,8 +888,10 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	}
 	return 0;
 out_oiter:
-	if (has_diriter)
+	if (has_diriter) {
 		udf_fiiter_release(&diriter);
+		inode_unlock(old_inode);
+	}
 	udf_fiiter_release(&oiter);
 
 	return retval;
-- 
2.35.3

