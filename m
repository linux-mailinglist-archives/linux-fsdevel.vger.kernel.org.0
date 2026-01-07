Return-Path: <linux-fsdevel+bounces-72657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97961CFEDC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638CA316D694
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58639901E;
	Wed,  7 Jan 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlyzrF/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBB39871A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800100; cv=none; b=Eb2UB2ldiWy1djpbHmKkJj8qyE/GwunH/meA3NEXdsW8OGbkXwmEl2JJJOrkdJQripEtiKECOl5wol1BPXAdPN2q+/mc1ErvvUAd2F16vIyLe8U9rYuwM1AnC3Ilsq8RbyTFNfAvXKwIXdM79Ju/OaUFpnx0OO3jKStAuHDXrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800100; c=relaxed/simple;
	bh=3CO44iNrPAkdfYLxe1mcSvtJfmua9dBTiPyw/Zw6zgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owCozRwleAHt5FxNwqXl7V372aYTrumf640x/LZEISRoQURLZ571KTZJMw40Vy1AQ+BaTVKZzB3Pzr23Q8fzZ233IRJtPG6Hwy8NOzyR3krbOy636wnWmPZYzBSro2j1GRz++Lm3it7i0cetzT2hUSk0P7AtvSTTrqdWDkrr+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlyzrF/X; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44fe903c1d6so620037b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800097; x=1768404897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n8Kb47Rl130Byxu0ad+8SvRWtkqSvh8ZeidUsu8Q2I=;
        b=UlyzrF/XmN05HA8PEjpbuqMKIxx6O8wSt2fCFJoABez6wlizZ79QjgpsYRx/PagwSv
         aFSZzo0XW7wjrLvKNUbPNWYGGdtU0/YPxOJbWREdy1/XecdFZNmiL85RnhW+HvdjT4uI
         WGo8FT0h1ziCxDr0ibrUqSNq9TnHnncITTFvgYI3O3d9nZhM9BB/0KvupT6d5TlNYykt
         5auxcqE3iDkoH2Btc7JA9ecrgsh/VNTLoNfp3hFq1IQb70zhvXL2ixaTfkQr+/DMuhVj
         yl981S+hkIE3mf2MImnTIMl8GzQ0akcPzC+l5xu8jUWWIXH9OYGdiSLi8l8JOVvbY+cE
         P3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800097; x=1768404897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n8Kb47Rl130Byxu0ad+8SvRWtkqSvh8ZeidUsu8Q2I=;
        b=AYtyT5/k1/1WJ385QC1f4zEpRNHCi2qGFDuHA5c7te28EUuyEUbdqSYnZiO2qd20zP
         pxULSfVkOXJ6qVtT9Ykq9S//PKuWKH2qagMnb819rEpx3DjJTHByuyzexehOr6TQx3Dl
         fMutNfPbLBDUj1vUEDKYOcA2cOdOsmCKD2fHw9dUFDc2GGiKJH6TDmdWAxnoecsvkDfQ
         zlME4+eb7iHMSmhPKJiRmX9dCEKrgCpRcaFP/bcbyHBMWs7gEhGKHVWtlRE1AAsb7bJt
         cXz9Vm79/sUkbpMT79ql1o+P6QAfvMmtFbeke8wX83uY+2mXrVrA5ze2a95bWE8ng1lo
         K73Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIXClYMzczEaELBjfgqcd2UqxkFXoLxm6F0SZnGgHAlvKxDR0rnq0mJUWYSCo4WQRGKaQvMBzoc5+N0B2c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZLy1zdW2R0gTl9eWFgMGODSZSxzymiuzutqIQx3WB6M6VEIy
	sM+YUuiXcLdgPJ6TdXIruJ4Kk/vOdjxzLkiKGRlvRulXLWojYYbwOJFb
X-Gm-Gg: AY/fxX5Eip60q02O8+34yY9p9TnOVws4EGq/Lh+3ogYtsfvt1w+lVUibDBF201Ps4uu
	/bdqBRYbIi6HJwkgkGtVILHCHmQDXqvkccZVBSRwF7hrRFVYEkrRKhV1GpHgT/iDYDhvtk/KXng
	tAcQ2VCOeyyQYSCrxLZ82VzYiwdcjlCzIhXIXgdrlDiWGeRzUMZIUnmw4rAqr+HKggGhws7tAPV
	9PoDNHYiUeiijja6ZPCRoI1xdeKq9uIpaTBWdEjm88Yeef6mK7OwaUGVGOyYGeNLAWJ17pf8O2F
	w3G9o/+Tx8fGF6Ta/R3PjgOHBSM1lS7t2JLc0yfCALsiDpYLjmwrnvcPlJ9BisEo6cxBP3SkKgd
	m1G4fILftk7e2T6sdEJGcNOtij3YJ6JJaPJbdXvEj/RFy/SE463W09WgPrwI0LmaU/KvSpqatKs
	9JycP753jXDHkeXK2qG8hQn7T9TPMAZkLuSr25/mNEAs4Y
X-Google-Smtp-Source: AGHT+IEkv++nP1XZgFGglQlyqUlGW3kCUi7rPnay9ZMhKErbt4qPcz86yrkR1ubRTqfHLlOPMJj8bg==
X-Received: by 2002:a05:6808:16a8:b0:45a:55e6:f5d6 with SMTP id 5614622812f47-45a6bd87897mr1217540b6e.12.1767800096765;
        Wed, 07 Jan 2026 07:34:56 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:56 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 3/4] fuse: add API to set kernel mount options
Date: Wed,  7 Jan 2026 09:34:42 -0600
Message-ID: <20260107153443.64794-4-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153443.64794-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fuse_add_kernel_mount_opt() to allow libfuse callers to pass
additional mount options directly to the kernel. This enables
filesystem-specific kernel mount options that aren't exposed through
the standard libfuse mount option parsing.

For example, famfs uses this to set the "shadow=" mount option
for shadow file system mounts.

API addition:
  int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_lowlevel.h | 10 ++++++++++
 lib/fuse_i.h            |  1 +
 lib/fuse_lowlevel.c     |  5 +++++
 lib/fuse_versionscript  |  1 +
 lib/mount.c             |  8 ++++++++
 5 files changed, 25 insertions(+)

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 016f831..d2bbcca 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2195,6 +2195,16 @@ static inline int fuse_session_custom_io(struct fuse_session *se,
 }
 #endif
 
+/**
+ * Allow a libfuse caller to directly add kernel mount opts
+ *
+ * @param se session object
+ * @param mount_opt the option to add
+ *
+ * @return 0 on success, -1 on failure
+ */
+int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt);
+
 /**
  * Mount a FUSE file system.
  *
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 65d2f68..41285d2 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -220,6 +220,7 @@ void destroy_mount_opts(struct mount_opts *mo);
 void fuse_mount_version(void);
 unsigned get_max_read(struct mount_opts *o);
 void fuse_kern_unmount(const char *mountpoint, int fd);
+int __fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
 
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0cde3d4..413e7c3 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4349,6 +4349,11 @@ int fuse_session_custom_io_30(struct fuse_session *se,
 			offsetof(struct fuse_custom_io, clone_fd), fd);
 }
 
+int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)
+{
+	return __fuse_add_kernel_mount_opt(se, mount_opt);
+}
+
 int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f9562b6..536569a 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -220,6 +220,7 @@ FUSE_3.18 {
 
 		fuse_reply_statx;
 		fuse_fs_statx;
+		fuse_add_kernel_mount_opt;
 } FUSE_3.17;
 
 FUSE_3.19 {
diff --git a/lib/mount.c b/lib/mount.c
index 7a856c1..e6c2305 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -674,6 +674,14 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
+int __fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)
+{
+	if (!se->mo)
+		return -1;
+	if (!mount_opt)
+		return -1;
+	return fuse_opt_add_opt(&se->mo->kernel_opts, mount_opt);
+}
 
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 {
-- 
2.49.0


