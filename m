Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0339B20361
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEPK1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfEPK1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so1360582wrt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R3uh6IyNVfDGyHyrBptvQoODhPii0EVUznyG2VjUhjU=;
        b=N+FShchWGe+JKxtDpOy+uJQQjiykGm7/UR2PYJMWY6HoG1GUIr8VPHhgBSDsnX6DL7
         5gETlU1zmTy+wn4TXVBw3CpR9fytQYCMNB2H0o2NGl7R5KYls+pPw4uj5lhML5FVGB9R
         i6RsJwurPXK/qOKNvk1GKJBs89VpuJHgs4KKtEy+f097yGQ3YfGEsFSxh/IH05KM9vOn
         +QB2Ckx+FytOvIAV5FmtV9a0MK8aE6z6V3H7CXTGOqGrABnfKc9b/yzo+cvwHD+PMZL5
         KlSE6q6Btremh1ZhIgRDrA3ffC1x/adAn9MEGdqrO2P0L8muMt5JqTAAZrZ/4lUYKVSf
         +OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R3uh6IyNVfDGyHyrBptvQoODhPii0EVUznyG2VjUhjU=;
        b=Tc75LjI71UmqCtKWQ4fEHAMh+sMnLT76aiZuoXvJFy4jfA+f6kXmsfMIiyhZiV1e5q
         kT/NrtGr6GYuTnQDpZN5+Os4HfayFoICpDRuY//dz+VcQSwpjoZtRY6zuJRoKzVLAQfW
         EA9Vj+YmJuxfAQPBt16hQ4oVT0nASbaVfgXrg9sYdxPXBK+2IUOlgP3aV7LtZfbYAv2d
         9HjZs909rpYM0im23lk33XIdrBuuZjmaJVyggyYjgOU5XXEGoevJ+kMjpU/w9vq0BA/Z
         UTsVdsVIqdru1GDzA7iJxQdfCxJNkZEQL9qZEGM8vXPVop4ij+32kGKrqhOADmkrcTAx
         OFgw==
X-Gm-Message-State: APjAAAV3uAfXgIC/7M3yawjbbB2AX89+ZGzQ4XvFg8RGw+2Lr9Mnk72/
        4ntS8NV721pZdTFlkJFnxaCr24U1
X-Google-Smtp-Source: APXvYqyzPEa5b2XOcRqZ5EFiI4+koS8ZUp7NIgBYmossQxgfbRemHUxK3qfOhjpV+7TN0XgHafI8Ng==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr26080911wrm.150.1558002424202;
        Thu, 16 May 2019 03:27:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:03 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v2 08/14] fs: convert rpc_pipefs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:35 +0300
Message-Id: <20190516102641.6574-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 net/sunrpc/rpc_pipe.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 979d23646e33..5b1a59776b9a 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -593,24 +593,12 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 
 static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int ret;
-
-	dget(dentry);
-	ret = simple_rmdir(dir, dentry);
-	d_delete(dentry);
-	dput(dentry);
-	return ret;
+	return simple_remove(dir, dentry);
 }
 
 static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int ret;
-
-	dget(dentry);
-	ret = simple_unlink(dir, dentry);
-	d_delete(dentry);
-	dput(dentry);
-	return ret;
+	return simple_remove(dir, dentry);
 }
 
 static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
-- 
2.17.1

