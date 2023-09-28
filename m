Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355127B1D48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjI1NEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjI1NEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915C1B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695906123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jtqyeIwabSbVK1kFbfunjeS3nfTCDCzse/xUKnJCfCQ=;
        b=L9s80K5KZYp7yhmn2hNmGf7eHw+b324mTRHBGvESsE2B+rYfKLNI42jw/3hMlm+MYkpi/N
        GQresz4CTb+BAmWcko7Ky1Heih1fwmF8Rufsf/vuhoNA413CUhjSYrzmMWbyyijUhuyNEh
        KrYkfVY+tT9fLgr7HkYeMheCBWrVwgc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-FUEoR2YSPAOh5cV5nKLYIw-1; Thu, 28 Sep 2023 09:02:01 -0400
X-MC-Unique: FUEoR2YSPAOh5cV5nKLYIw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5d86705e4so1131858566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 06:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695906118; x=1696510918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtqyeIwabSbVK1kFbfunjeS3nfTCDCzse/xUKnJCfCQ=;
        b=VsgnK0HcwBqes7IZTTveuQjxkxu6D9kAhqQ9Lpgjgup0HwLRF82evtVyHVSAppxwah
         fbddFu9EaLr/bOCd01aO0oHhGehJzp7Wub44hj5fk50jI6a6I0dcIlfdF6rRZSdjAuV8
         qN+VRvA4Mh4vR3ihGzsJp6BUhj8iGsO3REExQWeYwOF8irUJj3sFq0KZAqt9J8StB1id
         QXqy56NALOSF8jgUGbi21LEPkLg6miUlMxg1s1RckCSUjTt1mfqVtQnVXNi/Ns0JSRDd
         KSO9hikP4FrxXwmyPNruJOBmEhNOJD3E+no+wqy4te116GzyUIZCDbmwCz08piWcBccT
         r4Gw==
X-Gm-Message-State: AOJu0YyXgMVM4dWky9Q5iJ9ArE7//NLNPbpMSteTkmbgdtBqSoGbCart
        wdXlF2mzH0Yl3QVIyP8Q15JmrVhrxgzjVBoYMEWawQ3DTMaQ4G87B6Wf8o2ozM30wPWb1WCYnDG
        9F21xwnmkjonX1ZN5vxdTuxOGs6fP1CHGwsOJ6+2XKC1hQobBlOoZ255hsslSm25TBjJM46I62k
        L2JMvc843ZzA==
X-Received: by 2002:a17:906:108f:b0:9ae:5202:e611 with SMTP id u15-20020a170906108f00b009ae5202e611mr1106343eju.14.1695906118388;
        Thu, 28 Sep 2023 06:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL2k7VUiwqQ4h1L34lrXi/2ULqRDnR0xeWeBBIS648cMooHMQ+75ulk8bGyXx/u2Ycxg8vZw==
X-Received: by 2002:a17:906:108f:b0:9ae:5202:e611 with SMTP id u15-20020a170906108f00b009ae5202e611mr1106306eju.14.1695906118057;
        Thu, 28 Sep 2023 06:01:58 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-31.pool.digikabel.hu. [94.21.53.31])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906380600b0099c53c4407dsm10784863ejc.78.2023.09.28.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:01:56 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 4/4] add listmount(2) syscall
Date:   Thu, 28 Sep 2023 15:01:46 +0200
Message-ID: <20230928130147.564503-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928130147.564503-1-mszeredi@redhat.com>
References: <20230928130147.564503-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add way to query the children of a particular mount.  This is a more
flexible way to iterate the mount tree than having to parse the complete
/proc/self/mountinfo.

Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
based on path, then statx(2) can be used to first query the mount ID
belonging to the path.

Return an array of new (64bit) mount ID's.  Without privileges only mounts
are listed which are reachable from the task's root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/namespace.c                         | 69 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  3 ++
 include/uapi/asm-generic/unistd.h      |  5 +-
 include/uapi/linux/mount.h             |  3 ++
 6 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 317b1320ad18..65e0185b47a9 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -458,3 +458,4 @@
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
 454	i386	statmount		sys_statmount
+455	i386	listmount		sys_listmount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7312c440978f..a1b3ce7d22cc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -376,6 +376,7 @@
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	statmount		sys_statmount
+455	common	listmount		sys_listmount
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/namespace.c b/fs/namespace.c
index 3326ba2b2810..050e2d2af110 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4970,6 +4970,75 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
 	return ret;
 }
 
+static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+			 const struct path *root, unsigned int flags)
+{
+	struct mount *r, *m = real_mount(mnt);
+	struct path rootmnt = {
+		.mnt = root->mnt,
+		.dentry = root->mnt->mnt_root
+	};
+	long ctr = 0;
+	bool reachable_only = true;
+	int err;
+
+	err = security_sb_statfs(mnt->mnt_root);
+	if (err)
+		return err;
+
+	if (flags & LISTMOUNT_UNREACHABLE) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		reachable_only = false;
+	}
+
+	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+
+	list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
+		if (reachable_only &&
+		    !is_path_reachable(r, r->mnt.mnt_root, root))
+			continue;
+
+		if (ctr >= bufsize)
+			return -EOVERFLOW;
+		if (put_user(r->mnt_id_unique, buf + ctr))
+			return -EFAULT;
+		ctr++;
+		if (ctr < 0)
+			return -ERANGE;
+	}
+	return ctr;
+}
+
+SYSCALL_DEFINE4(listmount, const struct __mount_arg __user *, req,
+		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
+{
+	struct __mount_arg kreq;
+	struct vfsmount *mnt;
+	struct path root;
+	long err;
+
+	if (flags & ~LISTMOUNT_UNREACHABLE)
+		return -EINVAL;
+
+	if (copy_from_user(&kreq, req, sizeof(kreq)))
+		return -EFAULT;
+
+	down_read(&namespace_sem);
+	mnt = lookup_mnt_in_ns(kreq.mnt_id, current->nsproxy->mnt_ns);
+	err = -ENOENT;
+	if (mnt) {
+		get_fs_root(current->fs, &root);
+		err = do_listmount(mnt, buf, bufsize, &root, flags);
+		path_put(&root);
+	}
+	up_read(&namespace_sem);
+
+	return err;
+}
+
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index ba371024d902..38f3da7e04d1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -413,6 +413,9 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 asmlinkage long sys_statmount(const struct __mount_arg __user *req,
 			      struct statmnt __user *buf, size_t bufsize,
 			      unsigned int flags);
+asmlinkage long sys_listmount(const struct __mount_arg __user *req,
+			      u64 __user *buf, size_t bufsize,
+			      unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8f034e934a2e..8df6a747e21a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -826,8 +826,11 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_statmount   454
 __SYSCALL(__NR_statmount, sys_statmount)
 
+#define __NR_listmount   455
+__SYSCALL(__NR_listmount, sys_listmount)
+
 #undef __NR_syscalls
-#define __NR_syscalls 455
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index d2c988ab526b..7aa9916659d2 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -194,4 +194,7 @@ struct __mount_arg {
 #define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 
+/* listmount(2) flags */
+#define LISTMOUNT_UNREACHABLE	0x01	/* List unreachable mounts too */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.41.0

