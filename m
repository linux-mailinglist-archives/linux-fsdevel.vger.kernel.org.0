Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22C01B2875
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgDUNvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:51:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728964AbgDUNvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=fImzjseo4IlSGtu+A2V4/MtSNJnATJsGan5yeQ1ZMVexqkz8ClwhMqdrA+LadAbD7ujFe4
        iPJDgDzFAMfvQGa9kFANVNNSsYjSPpKtd21JAa/4/NYr7ooiRT4zKdo/H0joybkDnw5mbG
        77FjDCBA360dM00M49kXGRofXSAG3n8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-9_heuotgMtah1JfwyRWC1g-1; Tue, 21 Apr 2020 09:51:43 -0400
X-MC-Unique: 9_heuotgMtah1JfwyRWC1g-1
Received: by mail-wm1-f69.google.com with SMTP id n127so1400407wme.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=gePfsboWW97N3JVbzn2TVyzvd1lSQp7J1WeCG2TZ4MRbwBShxBqDt1n+yy7q6ONi+I
         HLO5izSAgn91OhDrc1VY/a4H3j3g9rAtbMQ8MAunQj7JMDTTYI55yXqp2pCnx/VV8ETP
         +avgV2LR3ubvmxwMh+P+at0STwVhqO/Pp/aniFnKJDbs8691SWL0lmZBmvbPWiLgTG+v
         YIJphoBb6em5f/fqVGbhTfFon6LkeTwTfVea+SAT5raZ/cX5tlo+Iz7cMUCNArZttCFH
         lnE3SuIY+CYkbIl2zrJ0Smpwmdgu4OhT1wsrgx28ok5Ngu7sUZOtkYIo3NjYy6Jx13Bd
         9IJA==
X-Gm-Message-State: AGi0Pua/jlP6shxGEheSUDe9RMoU6h2LmfE8g7g9LV/sc7SCzfMzjXqZ
        FpZNZGQqYAZzQitQMk6/L3ozMecUBziJcSyMsyEQTcInuzDF2KR1h0dLCvK8LAVeZ+sfzrXa1zx
        A8yFIQoM5Fh076I3jscL8PFq5gg==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr23759642wrr.160.1587477102569;
        Tue, 21 Apr 2020 06:51:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYYb14rVpuN5IdJGjcztA4u7H/3dUDNtMGXdL7LsdIhh9n0qcoiv0NvYygrC3tIbBHwPH97A==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr23759618wrr.160.1587477102414;
        Tue, 21 Apr 2020 06:51:42 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id a187sm3565830wmh.40.2020.04.21.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:51:41 -0700 (PDT)
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
Subject: [PATCH v2 1/7] apparmor: just use vfs_kern_mount to make .null
Date:   Tue, 21 Apr 2020 15:51:13 +0200
Message-Id: <20200421135119.30007-2-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
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

