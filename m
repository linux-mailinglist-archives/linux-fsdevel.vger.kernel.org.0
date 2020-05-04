Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9E1C352D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgEDJAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgEDJAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wRD9FPTWKMzxCyWJGhqpm27rg8NjVNjjKx55UL7gOU=;
        b=UUut1MreUc5Y/6c5C4iLxJYFVDAtKZn2G2AeY8f9yTPpexUX6U1DB6Nm91ngdQ/srPVnup
        ZF6nUbrrlMsw7oZcnJR43eu2CL18tbmAPmrhUwR9YIce19gZRq2EhDrbYjPh6H+Bvgp/kC
        bH9N4hYjRYJeltAks0p+NAHsefuLpPk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-_l0LRrbcO62TzT7D4txxEw-1; Mon, 04 May 2020 05:00:43 -0400
X-MC-Unique: _l0LRrbcO62TzT7D4txxEw-1
Received: by mail-wr1-f69.google.com with SMTP id a3so10432341wro.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wRD9FPTWKMzxCyWJGhqpm27rg8NjVNjjKx55UL7gOU=;
        b=gshoury4HBJhg+FxBEdiIRQWkEjHTBGbapEz2+SsD5IVDTV9IDunqdrD8zurZjZAIs
         fyz5K25pjX4KwgBT1kSXM2ocltH23uQQ7qfcQTOVONBS4Z1AKzGNdjY7p3cNNIaUfn4f
         m41QUg6EN+CrQO69HjIKmDyN0WK00xOGyVgfyCSPe87qaiJUD+4dqQGOEjVVC+qDtO/V
         6Owy5XqAu4uo1COqq+W8WcJlksl/nQY9kcePgIQF1CRlYeAgvGoFtuvn2qrqKaTREX/Y
         yvVAhU+Y68IGzoSZGWpFgWQyyP9qD4DE+wKXZ/Cb2kv3y+YQ4GZjVk02/VU7hBXIm+HP
         usQw==
X-Gm-Message-State: AGi0PuaLH5VWwr93mLFAgOzN3VI+VJt+gBGp9PCnvKEOPgo03fcRGx2P
        vrHajtGSEZ8pL/rQ3gv2FGsGcEAgfrycLZW0+UfVV5doX4GFA3RVFvA5FqkHi6OfrjG79DWehVX
        NkH3R9+7/jll4tE4djpNJeZYXPg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr13178007wmh.120.1588582841696;
        Mon, 04 May 2020 02:00:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypISx+znYaqJp02n1d/uugyBC8mxFpZgCaM7W1DIqIucjuH2loWZWImZ7IZ4TI2VeaUoQie1xg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr13177987wmh.120.1588582841501;
        Mon, 04 May 2020 02:00:41 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:41 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 3/7] libfs: introduce new_inode_current_time
Date:   Mon,  4 May 2020 11:00:28 +0200
Message-Id: <20200504090032.10367-4-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is a common special case for new_inode to initialize the
time to the current time and the inode to get_next_ino().
Introduce a core function that does it.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/libfs.c         | 20 ++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 54e07ae986ca..3fa0cd27ab06 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -594,6 +594,26 @@ int simple_write_end(struct file *file, struct address_space *mapping,
 }
 EXPORT_SYMBOL(simple_write_end);
 
+/**
+ * new_inode_current_time - create new inode by initializing the
+ * time to the current time and the inode to get_next_ino()
+ * @sb: pointer to super block of the file system
+ *
+ * Returns an inode pointer on success, NULL on failure.
+ */
+struct inode *new_inode_current_time(struct super_block *sb)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode->i_atime = inode->i_mtime =
+			inode->i_ctime = current_time(inode);
+	}
+	return inode;
+}
+EXPORT_SYMBOL(new_inode_current_time);
+
 /*
  * the inodes created here are not hashed. If you use iunique to generate
  * unique inode values later for this filesystem, then you must take care
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a3691c132b3a..de2577df30ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3088,6 +3088,7 @@ extern void clear_inode(struct inode *);
 extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
+extern struct inode *new_inode_current_time(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
-- 
2.25.2

