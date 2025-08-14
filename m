Return-Path: <linux-fsdevel+bounces-57870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB3B262F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282E61C27B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D9239E7E;
	Thu, 14 Aug 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2LXt2og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5BA318133
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167960; cv=none; b=tEB+ggkxV7w08339IqyY2+Vcr+pZNn3cOJa7PtKWcvd89vmD+sxjBCo01qpLVmkhAIEw5Khr9z8fgoKZpuRFNqn6qb2KGB7tATN9dMDAKmCEfC42uyCQgJSp8bVP89GMlq63pbZn4dxCrdXlzfNTYA1zdu+AUqm+1UMNKytPz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167960; c=relaxed/simple;
	bh=vy/kbyBLqEKNnDXX9JSY4JStM3dRhA0LlMTcKbNGUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtiNaICli6J0fi28OKZIshI3sl1lurAzPkeWCnrbTz1gMAIDjwzgk2Q6h7+K8s9CYE1MrXogYXQ2vzbFdWczGEfOgU3G42evmPVavs0Ht2fGxMcn8RIG3yUyNLVast1zJHaAMpuiY7EHp4slLmWPGudV5ybsIfFrTUYra0GEi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2LXt2og; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755167958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
	b=h2LXt2ogwT+r32Npyoy3tw4PnCCuX1EhkMpTpbgydS1cOw6kXyKnLLfHbuvny2WQbbvNvx
	fdKBG316TUiUoMGTfod/MjNCk7MuCaDh1hAmtKCPrd0hUwkrH0d7/dDzDsYy8IVpeqhV9x
	g0UEv+hXRLL9x7ifbigm+JGl4bNMAfs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-6EZTP8VxPaSuagkh5FzgHw-1; Thu, 14 Aug 2025 06:39:17 -0400
X-MC-Unique: 6EZTP8VxPaSuagkh5FzgHw-1
X-Mimecast-MFC-AGG-ID: 6EZTP8VxPaSuagkh5FzgHw_1755167956
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471737a7baso549689a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167956; x=1755772756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEmT42RQmaz79iSpEMVnY8SNb8kz15ad1uYq26SL5aw=;
        b=ACqRIWHZSr4xGZkDKqHCP/dP51cS3FoSRPv2edCx5n2gOz3O6RW8Uu32ROiOcXOOwM
         EFByDt7RpOpZDYke6jI8QXWDR+ZWkJvvNzMpQIQy4F9vAY1XRdmh7+jXVcC8FAQiskav
         G41yiYpkfN55rJEaA5I63EVew+sIICWP34cUWvF1nYipHdsXXDp7Cmlqlhx7QxNqI4Su
         +MLRb+q5gGCygaamL6gfgmo3TQisnN6pl9Cv3IXDVKXRM4mkSe2rm2tKRe3e/MQzb+9e
         NrnDnZoh31RY6rf0bU5DVsnWZy9oU3059osTAVtzuIDrSKRQk5Pm4AHqlYwEZ04LlupI
         37WA==
X-Gm-Message-State: AOJu0YxUOzuOVQtvGcT1wqwM2tTpU8hYGUpZ7MpUWIHsuwzlqt3BcDrI
	vjDsitbfWPWG2aAlewntu96FxLGvYAK16YBC23gZgUNqC6tOwX1/G08owVn5VudvQMUYjq6dmvd
	rBY8unAbTv0XRWd4EW5KSBnlOKJzQwH1AwQA/bmiTlWKif7hjbK/nfNYAdlCVxxNZMD8=
X-Gm-Gg: ASbGnct/iKTc/w+Izu8LWqfVBB6n0YfVS8xO/OyUQxDjmuCB7FSBtkgEI4V8gErsb+a
	qdtzo/6ukjSLxDiHCO63Ryt4GgHqoxKYrzb8CpuyZpRDX2VyEkV5ejRbOByUYnZxWY8zMyL89t6
	wMCJbjxcJeV9J4c96OAESS5MZxQb8Yv3y2Pd1lpd/sZcQODAxZtcXMwBCYUqwiMXnWb2wsekBp+
	6wc7x31HfAWYcOh8m/3/wykVQ4oVjFBBYfU4NXBWdV/5N9DQ5at//A0TtWsCF7UCaCF2fh0EhVZ
	OA8Ld9o5C23vAUD94oyVY3BU2EytR/CO0eszxhDtgZj9sbAUjQ==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875745637.17.1755167956028;
        Thu, 14 Aug 2025 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0qcRzLZjEIlriBSOpvCVTTIlZIky5VrZnbpwFkW4qbY9gLvkwJS1z02pXRiF8AX+jnTsQoQ==
X-Received: by 2002:a05:6a20:3943:b0:23f:fc18:77b0 with SMTP id adf61e73a8af0-240bcfcc4famr3875724637.17.1755167955635;
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:a40:5c04:f864:9735:818c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f6eesm34424189b3a.22.2025.08.14.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:39:15 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	safinaskar@zohomail.com,
	kexec@lists.infradead.org,
	rob@landley.net,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-api@vger.kernel.org,
	zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	initramfs@vger.kernel.org,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 14 Aug 2025 18:34:25 +0800
Message-ID: <20250814103424.3287358-2-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
By default, a tmpfs mount is limited to using 50% of the available RAM
for its content. This can be problematic in memory-constrained
environments, particularly during a kdump capture.

In a kdump scenario, the capture kernel boots with a limited amount of
memory specified by the 'crashkernel' parameter. If the initramfs is
large, it may fail to unpack into the tmpfs rootfs due to insufficient
space. This is because to get X MB of usable space in tmpfs, 2*X MB of
memory must be available for the mount. This leads to an OOM failure
during the early boot process, preventing a successful crash dump.

This patch introduces a new kernel command-line parameter, rootfsflags,
which allows passing specific mount options directly to the rootfs when
it is first mounted. This gives users control over the rootfs behavior.

For example, a user can now specify rootfsflags=size=75% to allow the
tmpfs to use up to 75% of the available memory. This can significantly
reduce the memory pressure for kdump.

Consider a practical example:

To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
the default 50% limit, this requires a memory pool of 96MB to be
available for the tmpfs mount. The total memory requirement is therefore
approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) ≈ 220MB.

By using rootfsflags=size=75%, the memory pool required for the 48MB
tmpfs is reduced to 48MB / 0.75 = 64MB. This reduces the total memory
requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
smaller crashkernel size, such as 192MB.

An alternative approach of reusing the existing rootflags parameter was
considered. However, a new, dedicated rootfsflags parameter was chosen
to avoid altering the current behavior of rootflags (which applies to
the final root filesystem) and to prevent any potential regressions.

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
Tested-by: Rob Landley <rob@landley.net>
---
Hi VFS maintainers,

Resending this patch as it did not get picked up.
This patch is intended for the VFS tree.

 fs/namespace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8f1000f9f3df..e484c26d5e3f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
 }
 __setup("mphash_entries=", set_mphash_entries);
 
+static char * __initdata rootfs_flags;
+static int __init rootfs_flags_setup(char *str)
+{
+	rootfs_flags = str;
+	return 1;
+}
+
+__setup("rootfsflags=", rootfs_flags_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-- 
2.47.0


