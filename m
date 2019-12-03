Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D810F6DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLCFUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39529 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCFUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so1206938plk.6;
        Mon, 02 Dec 2019 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CmhQS/RvxHM1ZkF3nWKmxpQ+xBfLTIt05/c08FcGCIs=;
        b=tFIXbngRA4bGs0uS8LLLRx+A3m9DXCcFsNIgWW2kxkRU54hEbCfsAvgc/imoM22i5s
         lV87TdnsLHtXV0Zr5JeLF3A4+pXWRkHO3ZMtH8AzJWLSy4pH2jO5p/hB7ML+5bkylb3p
         tH87QBhRzlc4si01TiIqKov2fmZ4RbPHfu8M556gOBHMqjutm5SWQBcM4jT8pdbPNSs4
         SGSFWgks/LU+qsIAZZp12qHRq8Jj7zUPji6w9Pz3RMfo3SGIALpwicZ5972AnkKWLkwb
         56uisz8CWXbcuYmR4IHfs9xJ+1pwLaGFDQAPKKwmJAPDiBnRMRRRHso4CtBys8sSsWbq
         rGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CmhQS/RvxHM1ZkF3nWKmxpQ+xBfLTIt05/c08FcGCIs=;
        b=IttnAAQHOMIGMUOFwfKfOzdFjh01sP9FWiGKvIdaT8evMJxK/+O5Gwwtm5EqkE+IXZ
         JBUQfJhwqVALjV465OD0MYwgI5uzK8LAUs3C1lW+IHVTMo+LgwhGxgSfhocc9pmj8eyE
         Aq8SLSvpwB3mSbG8Ea1RauHutpnxAEyPOKxCHFizbBDTmoGNZ/qgflNO5ojPjQROiMjv
         K8mrHwVAQzO3LNmCDFOxgPzSdybC+eRcCGd9FamxuL5NQND440TI3QnpP3Pc7jgEGNUD
         ESlTh9r8XFCQIGKs9/fXOqylbOcf0MszYAiUZExTaAChCiG8+T9mXwgOEFnmcVeWx8q9
         FU0Q==
X-Gm-Message-State: APjAAAV452GRGTHIwRi8+SAUCErZPDLxuoPd2GfvGAaqeUgjvE1zOLov
        nOK4LHExzgF6wlDyT5vbiKk=
X-Google-Smtp-Source: APXvYqwgeQm9CquMiw2X8iXh0kvR4EbK2Pkb/9nW8nXpFjl2hMrC3Icouk50DpciJNUXFFPtA+ze9g==
X-Received: by 2002:a17:90a:9bc6:: with SMTP id b6mr3527181pjw.77.1575350411171;
        Mon, 02 Dec 2019 21:20:11 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:10 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        stfrench@microsoft.com, linux-cifs@vger.kernel.org
Subject: [PATCH v2 2/6] fs: cifs: Delete usage of timespec64_trunc
Date:   Mon,  2 Dec 2019 21:19:41 -0800
Message-Id: <20191203051945.9440-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timestamp_truncate() is the replacement api for
timespec64_trunc. timestamp_truncate() additionally clamps
timestamps to make sure the timestamps lie within the
permitted range for the filesystem.

Truncate the timestamps in the struct cifs_attr at the
site of assignment to inode times. This
helps us use the right fs api timestamp_trucate() to
perform the truncation.

Also update the ktime_get_* api to match the one used in
current_time(). This allows for timestamps to be updated
the same way always.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: stfrench@microsoft.com
Cc: linux-cifs@vger.kernel.org
---
 fs/cifs/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index ca76a9287456..026ed49e8aa4 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -113,6 +113,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	}
 
 	 /* revalidate if mtime or size have changed */
+	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
 	if (timespec64_equal(&inode->i_mtime, &fattr->cf_mtime) &&
 	    cifs_i->server_eof == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
@@ -162,6 +163,9 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_revalidate_cache(inode, fattr);
 
 	spin_lock(&inode->i_lock);
+	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
+	fattr->cf_atime = timestamp_truncate(fattr->cf_atime, inode);
+	fattr->cf_ctime = timestamp_truncate(fattr->cf_ctime, inode);
 	/* we do not want atime to be less than mtime, it broke some apps */
 	if (timespec64_compare(&fattr->cf_atime, &fattr->cf_mtime) < 0)
 		inode->i_atime = fattr->cf_mtime;
@@ -329,8 +333,7 @@ cifs_create_dfs_fattr(struct cifs_fattr *fattr, struct super_block *sb)
 	fattr->cf_mode = S_IFDIR | S_IXUGO | S_IRWXU;
 	fattr->cf_uid = cifs_sb->mnt_uid;
 	fattr->cf_gid = cifs_sb->mnt_gid;
-	ktime_get_real_ts64(&fattr->cf_mtime);
-	fattr->cf_mtime = timespec64_trunc(fattr->cf_mtime, sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&fattr->cf_mtime);
 	fattr->cf_atime = fattr->cf_ctime = fattr->cf_mtime;
 	fattr->cf_nlink = 2;
 	fattr->cf_flags = CIFS_FATTR_DFS_REFERRAL;
@@ -609,10 +612,8 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
 
 	if (info->LastAccessTime)
 		fattr->cf_atime = cifs_NTtimeToUnix(info->LastAccessTime);
-	else {
-		ktime_get_real_ts64(&fattr->cf_atime);
-		fattr->cf_atime = timespec64_trunc(fattr->cf_atime, sb->s_time_gran);
-	}
+	else
+		ktime_get_coarse_real_ts64(&fattr->cf_atime);
 
 	fattr->cf_ctime = cifs_NTtimeToUnix(info->ChangeTime);
 	fattr->cf_mtime = cifs_NTtimeToUnix(info->LastWriteTime);
-- 
2.17.1

