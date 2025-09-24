Return-Path: <linux-fsdevel+bounces-62678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04604B9C886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9924E3254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F32A29D26E;
	Wed, 24 Sep 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQgRLCDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DD25484D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756286; cv=none; b=SNSffr/KEvPEKzgS1kJz5RszTjhggjlfHWv6JebK29HfrOpa29S9i4wVCFVhqX/U2kQjuA11/JVHcqGq8Rt6AIfS+7EYpmNgMwhBhjlZ/L75yTcKfdBbfzUT1knx+Sw1XO9vfx9DW6VDb0MPwa4XiARWiJ/8rMd57+RgkKtrtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756286; c=relaxed/simple;
	bh=Hwj4ckhb5DTcc8UE9wkW8Nw57797AjnMiK+e62cBtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6hBGJf/f4xI3sirxFxSqNE4z4LVcWgExjQtQLOIVQp/5PAR7ixyh1jAwA+98P3JkoYP2eJ52XOHTFUsvcvL0sfzAfvTzceivkyMZUMmpVujYK9KbUOYWnjqcDj+9cCUoP4XONWXpt8JOikp/pW7PBfgkKxlvJadXD1i5ETZz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQgRLCDI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-84d8e2587d6so30443685a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756283; x=1759361083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y6EMmIcmPN+na3Sl1GzqFT2rkaqC+6JSJKayEapinw=;
        b=MQgRLCDI4Leblks5s5JdkhcruDNrM8we3xTxNnpGub0PwkDkcsc4vaXMh36qhU3pft
         cKbCBEKp0svuACUodaj1tvZCXzxBCvNkqArJeumK8ZEauNSeLZZcvjqTT8Ybjzr+hCbs
         pIMyed3aaleVX9HMePpgw4xAxai9fRgTXRH21ToqANI3ZveKvGBsXos1QhmrofPaSXa7
         m05OyzSedRL8upGCaiPKxwl2q9oNz7OyBzfHtw0ne0QmUI7COk9Ut9vUpNDmZ9HkhTV9
         +7kUj1V1ajX6Xw6TFMsDOtXDppOwG+AUFN/gnIraqKh9KFWGsPGZQAzyKH0ZU24/eYE2
         j9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756283; x=1759361083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y6EMmIcmPN+na3Sl1GzqFT2rkaqC+6JSJKayEapinw=;
        b=sxzUhT0mdsmG4viKjNfqdktTLWNM+a4O/X8rYx3otVwMHs8SwL9DLl7KlVm3AO2V21
         DSuZ/6v4Oaf08uf+1G2S5Dv9rGPD+/zhkWKgWMoQNqGHoSowPLPGIEb8BKK2NUVIaHXw
         GDQPU5fexbG+d1mkMFpSD3J0RDobVGAWOzPudfy3xi3DBTUvlpfB3G5dk+W0NDLA0M03
         Q9ZeoxeHhYZHc1vxPyuwmzbjueWwm6N6QvlI2zHdfcB6ncKWAqkyUJEPrlzyN/ZuYvUU
         tBkXKHhCodbgdMaAjeUFAdQybVDVq/JxrlJV7E7OL/MpRb+lVN+W7FsWLA9JQCC4dKw9
         E4kg==
X-Forwarded-Encrypted: i=1; AJvYcCV6C0YmK7vN8LRt22+csdjFqA5Wqq9IIY//0h0AoKgxwccJkFXEjoOhNvCJX+zaHfqQr2Vwnh9oKIPZRZlz@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTMOW2K6A2sRIcILhVFqkq/h+Xrtq+spDM4DKv8ZScLuSG3S1
	MYyIb3xnPO9QGUQ1KdmGZH7l0aHaL/M1URgG6iR8GD+nWggtFy/IMfdA
X-Gm-Gg: ASbGncvoSTC512pUH5bv/clerHJAxYr2cNNY6Sg6xNHd35+XrYYF1l0om0NIg8V4M0U
	ShO/V5tuPV8oHyxQcPjec4X7HKlbDpb9UTJ/NljCSM0n1U8w1m5no3dj86Y6K+zYlwul5C82GmD
	Fg6Miw8mUzonLAqDwnfD1YlwfVVpYelw5T4xC7FKaL58HGxuSu9HUFygOmKMGFE2iPLWSvhgoTy
	tu+vEGQuNrOpqz5vVOZHJvV1Gd70Pl8utP2wmIyA5oaVyACRh7EcE+vRt1Rnv2BCGyQOeE3rGKh
	3D6PvK9sMWexdY6wHADdOW6YVMvaIgjI4ktb+VGCCzMSFb9agwcPX3Uq0CWgG1kQ/6A2hMlwurG
	jcEzUdO3jGlihOyg9reXFakcfvuhY89PlAHh8t/oE24LiNduKLADbn8re1okIP9Ou5mn5F5EvrT
	QAY0Wm1yaoeRMB0V6AwC87mjBCjnA=
X-Google-Smtp-Source: AGHT+IHDUMqGg8lGvUVV3/0K130ob6QpaUMxuL0wG0YcMB+sfiZMR0SDmArQInyj/I2Nfd9qxcCPug==
X-Received: by 2002:a05:620a:4051:b0:84b:3c5a:e449 with SMTP id af79cd13be357-85ae7cd4d89mr171227285a.60.1758756283424;
        Wed, 24 Sep 2025 16:24:43 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c336ad64bsm14213285a.59.2025.09.24.16.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dwindsor@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Date: Wed, 24 Sep 2025 19:24:33 -0400
Message-ID: <20250924232434.74761-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924232434.74761-1-dwindsor@gmail.com>
References: <20250924232434.74761-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add six new BPF kfuncs that enable BPF LSM programs to safely interact
with dentry objects:

- bpf_dget(): Acquire reference on dentry
- bpf_dput(): Release reference on dentry
- bpf_dget_parent(): Get referenced parent dentry
- bpf_d_find_alias(): Find referenced alias dentry for inode
- bpf_file_dentry(): Get dentry from file
- bpf_file_vfsmount(): Get vfsmount from file

All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 1e36a12b88f7..988e408fe7b3 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -169,6 +169,104 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_dget - get a reference on a dentry
+ * @dentry: dentry to get a reference on
+ *
+ * Get a reference on the supplied *dentry*. The referenced dentry pointer
+ * acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_dget(struct dentry *dentry)
+{
+	return dget(dentry);
+}
+
+/**
+ * bpf_dput - put a reference on a dentry
+ * @dentry: dentry to put a reference on
+ *
+ * Put a reference on the supplied *dentry*.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ */
+__bpf_kfunc void bpf_dput(struct dentry *dentry)
+{
+	dput(dentry);
+}
+
+/**
+ * bpf_dget_parent - get a reference on the parent dentry
+ * @dentry: dentry to get the parent of
+ *
+ * Get a reference on the parent of the supplied *dentry*. The referenced
+ * dentry pointer acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced parent dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_dget_parent(struct dentry *dentry)
+{
+	return dget_parent(dentry);
+}
+
+/**
+ * bpf_d_find_alias - find an alias dentry for an inode
+ * @inode: inode to find an alias for
+ *
+ * Find an alias dentry for the supplied *inode*. The referenced dentry pointer
+ * acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced alias dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_d_find_alias(struct inode *inode)
+{
+	return d_find_alias(inode);
+}
+
+/**
+ * bpf_file_dentry - get the dentry associated with a file
+ * @file: file to get the dentry from
+ *
+ * Get the dentry associated with the supplied *file*. This is a trusted
+ * accessor that allows BPF programs to safely obtain a dentry pointer
+ * from a file structure. The returned pointer is borrowed and does not
+ * require bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_file_dentry(struct file *file)
+{
+	return file_dentry(file);
+}
+
+/**
+ * bpf_file_vfsmount - get the vfsmount associated with a file
+ * @file: file to get the vfsmount from
+ *
+ * Get the vfsmount associated with the supplied *file*. This is a trusted
+ * accessor that allows BPF programs to safely obtain a vfsmount pointer
+ * from a file structure. The returned pointer is borrowed and does not
+ * require any release function.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A vfsmount pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct vfsmount *bpf_file_vfsmount(struct file *file)
+{
+	return file->f_path.mnt;
+}
+
+
 __bpf_kfunc_end_defs();
 
 static int bpf_xattr_write_permission(const char *name, struct inode *inode)
@@ -367,6 +465,12 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dget, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_dput, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dget_parent, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_d_find_alias, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_file_dentry, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_file_vfsmount, KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.43.0


