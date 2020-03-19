Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0D18BAA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgCSPKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38324 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSPKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so2703300wmi.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qUL5AUxiOJ5bWL9Ipf/Y87tgOUiq0x7sxDlFXUm/tco=;
        b=P5p1XcLDBdF1FZxIcfnRf6nbRdYvTPW9x8zfWpK8fLI45DkgR8BAlXblz6LYhZwFLI
         RZAJHoXTKlgP+XHsmbFVnyccTDezBv1EYKk/CdEZgfstSktEgmpbP3S1d9w6SNseFtN8
         Gl0EK7nn+CsmmEFIpI5zsQkp0vPR2IqxBoFI5wvRBpp8hjiMkX67oawG4tL2M8NA+11V
         c6Z83tCa6xvYGmO44k+Y8oNK1bpAjeRDgXH77dFKCQbte6EK2bDpH/rICDHcgrg1rU5g
         1kKdXRUkyJdlUA3bBZ3maTFHOiO7MU/4lbsQEuazgINmGTyFxmJp3QSRWjvaAyvsTnbR
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qUL5AUxiOJ5bWL9Ipf/Y87tgOUiq0x7sxDlFXUm/tco=;
        b=R/NtNPMPxzf4SXtc8cqUmFuShPxkyABdcDNEjxJPZ1kZhQoNfWQ9IXs7kjQqFgwBRI
         l5ZFmyTq+3lZ0U/53BQxGycS0TL+CvtVdBOoiqrpgHN5GgJsSqEAdwY2QbVXJmrzQNe8
         lg8PWyR2a5nq1pKWTMbewznf0GsXzYx1RV4cDCkGWs5ddwmmvXsOBZCqCxm/MRhYdVb+
         edSa++hSXQsFWey4D3cp9yh4OXA5YT9tHOFI6aE9PeG46fQjI7pFUStBPfS3jah6mXkX
         RBM2HQQFeq6FdWjVH0YKKPGl2Vp8uU8mSFZnGaSTsUpOK0Y79vVOMEI1o+ln6ruWVasD
         OlPg==
X-Gm-Message-State: ANhLgQ3sZNpQo6AezM1XTZ3H3okyjK8n3Iru7z+3fBQng6MtqC4UK2iB
        jyKkcyee0cKC8NgBfLRTcnJvcOtQ
X-Google-Smtp-Source: ADFU+vsNGPP1UgdLJ3XyPi4p24tjaTSfCa3Tv+aM1KDLqAay2zqt0OJVWJ/mJS53uG5qWk/bPjjuEQ==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr4232561wmd.101.1584630645791;
        Thu, 19 Mar 2020 08:10:45 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/14] fsnotify: pass dentry instead of inode for events possible on child
Date:   Thu, 19 Mar 2020 17:10:14 +0200
Message-Id: <20200319151022.31456-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most events that can be reported to watching parent pass
FSNOTIFY_EVENT_PATH as event data, except for FS_ARRTIB and FS_MODIFY
as a result of truncate.

Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY
and use it to pass the dentry instead of it's ->d_inode for those events.

Soon, we are going to use the dentry data type to report events
with name info in fanotify backend.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h         |  4 ++--
 include/linux/fsnotify_backend.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 860018f3e545..d286663fcef2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -49,8 +49,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
-	fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
-	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
+	fsnotify(inode, mask, dentry, FSNOTIFY_EVENT_DENTRY, NULL, 0);
 }
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 337c87cf34d6..ab0913619403 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,6 +217,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_DENTRY,
 };
 
 static inline const struct inode *fsnotify_data_inode(const void *data,
@@ -225,6 +226,8 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_INODE:
 		return data;
+	case FSNOTIFY_EVENT_DENTRY:
+		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
 	default:
@@ -232,6 +235,20 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
 	}
 }
 
+static inline struct dentry *fsnotify_data_dentry(const void *data,
+						  int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_DENTRY:
+		/* Non const is needed for dget() */
+		return (struct dentry *)data;
+	case FSNOTIFY_EVENT_PATH:
+		return ((const struct path *)data)->dentry;
+	default:
+		return NULL;
+	}
+}
+
 static inline const struct path *fsnotify_data_path(const void *data,
 						    int data_type)
 {
-- 
2.17.1

