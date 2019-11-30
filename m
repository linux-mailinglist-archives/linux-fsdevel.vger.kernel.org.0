Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199C910DCA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfK3FbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:31:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36244 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3FbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so15503922pgh.3;
        Fri, 29 Nov 2019 21:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CmhQS/RvxHM1ZkF3nWKmxpQ+xBfLTIt05/c08FcGCIs=;
        b=hp4AIL/UwGtuzngGMTZYaxAlp9v/JGnzfyYa/plbFcAmNur5KkDnWK3HMa+z5yG+QZ
         Q5LxWgOtJXfAmlhcN0aFpuVfsa0evlcQxxe4lAzGeJWQmunAaZliLQ8kLX01VfmL+CnP
         pBre+WkAYg2CuUGA5ujfw9014QCVR96BCcPDEyeYyCB6OczBOee0gUs3jwC9Bp2hRBsO
         MaPBbWltKWMECRYznYlWa0xsAn0jKiSwY1F16Ksg8YxZQBDMN2VJA6dxFAwGoqayddJ8
         WKcM2vahApMvlhVohv0kXTPCmnT/nb73fP0CwGfWLgwDMCsq51/CGC69YtH39slcCM/2
         QSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CmhQS/RvxHM1ZkF3nWKmxpQ+xBfLTIt05/c08FcGCIs=;
        b=V/PEF6F68oSK0OmBCxjUEsfjEF1W1YjTc4HIHW+6NHdLlUtoAaXzDxsPYnwy7Pu0jA
         V8ZCIxspSuoJYfG3axIJ9Q2vh5bfHc5G0sulmldmmwKF/CdktxwPpaovt/TKLrLF7I3t
         IOivHfkrgwm6ccVkMCIMjW5gAXca6LWnGyDvm81NxxG4wsNRHfNElTfj2tshzOv+1Evh
         p8K9BNBnq7JxG6GJvqWy+VuyLzHuGwknT71vnhc8U6cBS/s5KO8Fi3q9zxLq0D0s/KF0
         Q2E6o3o0LYk+U3bMRkDuAXyGX89KGp5y1pWiO87SwSIn27VPq/Z/r/o/RG5xcoQq8Vsl
         Rekg==
X-Gm-Message-State: APjAAAXfXEu1x63Y02eRs8Pg5eLqNq5Fm0VgaR4BYP4rqhdariwpc03z
        KOANkrFSLnQl7zDifNeC3ogfP35R
X-Google-Smtp-Source: APXvYqzeGM2sPKH5IIE/oT9bZrPKO3zy52iiEg+grtcMiCeaPDDZKlj2ye7F1vCWVAMIZiWVhHR+aA==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr20132223pgl.394.1575091875879;
        Fri, 29 Nov 2019 21:31:15 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:15 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        stfrench@microsoft.com, linux-cifs@vger.kernel.org
Subject: [PATCH 3/7] fs: cifs: Delete usage of timespec64_trunc
Date:   Fri, 29 Nov 2019 21:30:26 -0800
Message-Id: <20191130053030.7868-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
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

