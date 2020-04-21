Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132741B28A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgDUN5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:57:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728825AbgDUN5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wRD9FPTWKMzxCyWJGhqpm27rg8NjVNjjKx55UL7gOU=;
        b=Nu3trMDKQtUIanQbH665T2r5W69cir4BYnqL/P1xC+skrm/gffIT4BhTOS6jPkTl5objGj
        BHNhlR18NZV0trlNkBy9l6qhtEKxmvOFYCua/P+dXcGMiqOQ3PTfuhO0Has91F7QzXDDI+
        14pV7PDCkEi+3gT39hdQsaQLePqKXnc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-BAzj-0VbOpK8wj6mko_WPw-1; Tue, 21 Apr 2020 09:57:47 -0400
X-MC-Unique: BAzj-0VbOpK8wj6mko_WPw-1
Received: by mail-wr1-f71.google.com with SMTP id e5so7495786wrs.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wRD9FPTWKMzxCyWJGhqpm27rg8NjVNjjKx55UL7gOU=;
        b=G4KH3S9ovXJ+K1CR1jfzlyF7rFFdz4VV1qDJgfVC1iEmZVRPP1ykX5Ngqi/mEq1s9Q
         OJobs4dtElmhfhRgE1hDZ/jAVxg3hVPlRGr5IgOBImskIffXw2PAUoNHPFLDsMUyR/VK
         Q0c0XKtsh5Jz4gWiSQbNsOqzdpHsdV9V6L62xcPWKe+WWg8iVwPesXWN81zcePurTal9
         5oFBk4eG8LttCJlW/eGpdbhsZHJKK9X8WkOeHdOFBnT+N6perWIw6GpVutqIsEjuA01c
         E1u2Y+pYrOEtwnXbAH+DacZS4jXLKCEatpA6sz36aINLiLYdpj6dLnU2i9CnROnyVqtY
         6Y5g==
X-Gm-Message-State: AGi0Pua0rjBy0w6rT+BI10YLpoX5QTUknfjp767ihnWdzjsSfY+w7Jrk
        4qndYEwx+1VuQHrzo6+F+9Wod3WQio+w13uVtVTGlPqIRbHTXZkAQ+wCW89hfFT2exyChYadkdH
        lYZy1hrOJkzLb2fJCCb6uwqMrSw==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr4993969wmj.130.1587477466574;
        Tue, 21 Apr 2020 06:57:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdMbj9yLvuLA4LwwjCRX8ejEQ6n8RjZ/wI7HQOlXPSbSe/l8j+NErdfsIjBeaz5nCZl4whdg==
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr4993944wmj.130.1587477466378;
        Tue, 21 Apr 2020 06:57:46 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id f23sm3562989wml.4.2020.04.21.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:57:45 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 3/7] libfs: introduce new_inode_current_time
Date:   Tue, 21 Apr 2020 15:57:37 +0200
Message-Id: <20200421135741.30657-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
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

