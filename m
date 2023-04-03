Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A36D4A60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjDCOqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjDCOq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B7C1697D
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:09 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 241213F193
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533142;
        bh=sfvJPZXm6cJkfP1IztZnpclfjk/5sorCwMJVKfMiws4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=U9GExCUxVL4aqiP/iHc+BJRhTm8TrUB2KDBYxu1qdLCgoojWxKETBTue1x90eS1Kt
         /WMM8WepVmBX6Iii0OmUWBt2/QajqMpHy8Gk0Jj97Ti459I00xf10rV2b5+IJjLAV9
         +G+odC1NXPyo4/8btLds77u6naz22/nVHRi+x/UOcm5iDnw25LZv/WudfnDs2OKHzK
         mTKULpZc1+INR+z0z1Xl/C7mn/gKXu5/z1RjE/+q7f1emWio918ldj9TY6lxTk4UfZ
         rjqLqJctSSI4G9KHR74ZVg+bMbO2dQmkZ5Su6db+VCpkA9i+Uc/itK+Si+DiDF6z6Q
         xJTcNg9qemkzg==
Received: by mail-ed1-f71.google.com with SMTP id x35-20020a50baa6000000b005021d1b1e9eso41907740ede.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfvJPZXm6cJkfP1IztZnpclfjk/5sorCwMJVKfMiws4=;
        b=6LK2+1K1yOkeLTGpG1mknkwbtznayCRXJXMqUpf+OdFOeSfwF6/tiQWOXUsMjb0ypd
         z5vLn7SUTCQkJaC8ZdTnoC3Z+lDBAF5eBhRHc2M7psgcErH15Teb/9lHGfGhkLNDRxa9
         DY3O2g9onq91voX/iy+Q++SYN3m61XFAZ0MwUftFWlKjmdLV2CrBXru8dtrfaxUu+7rs
         1DqimtWMDpKY0xr7aMfAyy6BEeteh7JHhwmfU/+Qipb3OwhTChFbMe68qQ75sr286ygs
         8W8zXnSlQsghPRTL7lqC6XQ5M15Fbfr54hU3LA7H6Pt6EVbCJGRSySkO8VDCUhNKVZ8D
         /1Fw==
X-Gm-Message-State: AAQBX9fE63tBRVVRdrLXsd47Td+TxqFeqT36x1jzLwcUAwMQBB5DxPj4
        u4ixNpnR64hig0+evjqkmzHPvq1Vgrxr8SJRM8BjdNaAqKXUln9smZ8lCq+B4x9iW7gf7OFdspL
        n3Ryp1xJXFFkGC7h8Pj8j/71vZu3nwGVsmvUw2/6CNvw=
X-Received: by 2002:aa7:d7d3:0:b0:501:d542:4d0c with SMTP id e19-20020aa7d7d3000000b00501d5424d0cmr34895167eds.22.1680533142014;
        Mon, 03 Apr 2023 07:45:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWGwBvS+zemjywNUWSkjvaOtu2sVDQj8OVEVo6nanlpJoWa5G14nm9QBdMW9vWHb78BkoBAQ==
X-Received: by 2002:aa7:d7d3:0:b0:501:d542:4d0c with SMTP id e19-20020aa7d7d3000000b00501d5424d0cmr34895154eds.22.1680533141811;
        Mon, 03 Apr 2023 07:45:41 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:41 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 4/9] fuse: handle stale inode connection in fuse_queue_forget
Date:   Mon,  3 Apr 2023 16:45:12 +0200
Message-Id: <20230403144517.347517-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't want to send FUSE_FORGET request to the new
fuse daemon if inode was lookuped by the old fuse daemon
because it can confuse and break userspace (libfuse).

For now, just add a new argument to fuse_queue_forget and
handle it. Adjust all callers to match the old behaviour.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c    | 4 ++--
 fs/fuse/dir.c    | 8 ++++----
 fs/fuse/fuse_i.h | 2 +-
 fs/fuse/inode.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eb4f88e3dc97..2e7cd60b685e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -234,7 +234,7 @@ __releases(fiq->lock)
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup)
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
@@ -242,7 +242,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	forget->forget_one.nlookup = nlookup;
 
 	spin_lock(&fiq->lock);
-	if (fiq->connected) {
+	if (fiq->connected && likely(!stale_inode_conn)) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
 		fiq->ops->wake_forget_and_unlock(fiq);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5a4a7155cf1c..7e308a655191 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -250,7 +250,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			if (outarg.nodeid != get_node_id(inode) ||
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+						  outarg.nodeid, 1, false);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
@@ -403,7 +403,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 			   attr_version);
 	err = -ENOMEM;
 	if (!*inode) {
-		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1, false);
 		goto out;
 	}
 	err = 0;
@@ -690,7 +690,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1, false);
 		err = -ENOMEM;
 		goto out_err;
 	}
@@ -815,7 +815,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, entry_attr_timeout(&outarg), 0);
 	if (!inode) {
-		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1, false);
 		return -ENOMEM;
 	}
 	kfree(forget);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8d4276d7ab1e..be5d5d3fe6f5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1008,7 +1008,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
  * Send FORGET command
  */
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
-		       u64 nodeid, u64 nlookup);
+		       u64 nodeid, u64 nlookup, bool stale_inode_conn);
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 009fe5bbb855..e5ad5d4c215a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -124,7 +124,7 @@ static void fuse_evict_inode(struct inode *inode)
 			fuse_dax_inode_cleanup(inode);
 		if (fi->nlookup) {
 			fuse_queue_forget(fc, fi->forget, fi->nodeid,
-					  fi->nlookup);
+					  fi->nlookup, false);
 			fi->forget = NULL;
 		}
 	}
-- 
2.34.1

