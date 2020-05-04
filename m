Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C91C352C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEDJAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgEDJAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=gqJIYZJtk21ZEBjz2wn0eGGqTYdZXWRt52erYkePk/HEJiQJYq+wVv/xEnoLjFH7ZbcbCi
        CuK8VsiEyASaFugHZwG5nr9GDwzD8TerUztnCfxyGdlhk9NK+aUyNXKSVO5xumHaCrgl9G
        IUXMsXqjxjh5uADyddp9/At5qVvh8D0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-ljBJ4gZ0Nl2oL59L21rTzw-1; Mon, 04 May 2020 05:00:40 -0400
X-MC-Unique: ljBJ4gZ0Nl2oL59L21rTzw-1
Received: by mail-wr1-f70.google.com with SMTP id f15so10477387wrj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=UVw3zFd5Qat7V44KWJ7cW8PZLRsDRUyVC+kndGnC1gZO4Zj2j/BZOtblDNLbb1gLZs
         s1//95G2c/dlLw+pYPEU9dYpUXFuxtsqDdj4SB59BKkZW7G91Iy2NXdGb0sjDwOx0oid
         TTp5SRBmSaYMj9dHahF8pZhQ26+Gro3bNOx1JxLeLvo/9VDUtynZleahLC4vywtcdKLB
         2ODt+JuZt3XIqWBAfPEF+uZp/92Q166tHcnrKW7JObn20ETIAp1bnxGmpnXdf/IwN+D9
         5Fz6PwdTBE1SN8wVpN87NJHr839yxaFCaKLSlz4gmDPZnYjWC6NBMyXq9szPPs8ONOxX
         d6pA==
X-Gm-Message-State: AGi0Puay9/HkzY/YV7LXQvp/nxGSV6M0uZtHq+iO9uFbHdat2buvTRqx
        0PtGZFbePx3qUfoCjYctWlcBOwGm0VduqZWYXgr9yxIlp9vPYpz8ofZpQ4S3yGVzveuVG4o+Uvs
        hhyIBY9A1sgpEAReqnk7ADwiAFw==
X-Received: by 2002:adf:d088:: with SMTP id y8mr17044936wrh.23.1588582839429;
        Mon, 04 May 2020 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJfg5Fwy2CBxDFsYu6WnMkOBOE4DxhFssLcCGLYtWOfjXSolVzo99GxYSiGmSdVs99rkYbaxQ==
X-Received: by 2002:adf:d088:: with SMTP id y8mr17044918wrh.23.1588582839274;
        Mon, 04 May 2020 02:00:39 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:38 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 1/7] apparmor: just use vfs_kern_mount to make .null
Date:   Mon,  4 May 2020 11:00:26 +0200
Message-Id: <20200504090032.10367-2-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

aa_mk_null_file is using simple_pin_fs/simple_release_fs with local
variables as arguments, for what would amount to a simple
vfs_kern_mount/mntput pair if everything was inlined.  Just use
the normal filesystem API since the reference counting is not needed
here (it is a local variable and always 0 on entry and on exit).

There is no functional change intended.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 security/apparmor/apparmorfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 280741fc0f5f..36f848734902 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2525,14 +2525,15 @@ struct path aa_null;
 
 static int aa_mk_null_file(struct dentry *parent)
 {
-	struct vfsmount *mount = NULL;
+	struct file_system_type *type = parent->d_sb->s_type;
+	struct vfsmount *mount;
 	struct dentry *dentry;
 	struct inode *inode;
-	int count = 0;
-	int error = simple_pin_fs(parent->d_sb->s_type, &mount, &count);
+	int error;
 
-	if (error)
-		return error;
+	mount = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
+	if (IS_ERR(mount))
+		return PTR_ERR(mount);
 
 	inode_lock(d_inode(parent));
 	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
@@ -2561,7 +2562,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	dput(dentry);
 out:
 	inode_unlock(d_inode(parent));
-	simple_release_fs(&mount, &count);
+	mntput(mount);
 	return error;
 }
 
-- 
2.25.2

