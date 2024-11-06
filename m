Return-Path: <linux-fsdevel+bounces-33825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE879BF79E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF662813A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1C20B1F7;
	Wed,  6 Nov 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLKcqf8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA020ADD2;
	Wed,  6 Nov 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922791; cv=none; b=lU+ltyQUetr6Reju2IwFuEMK9funCwvR0S1ECEwm+qteVlz08sJFDXdkFuexLpaGwD5ieDeGIFQL2xrevq8QgGX2Es1HIx1MN8WLBsBCR96NwlGrNiJHDVS4Q+yNuB00aXrAB39cicXLKC4llgNaPPoytpdLz5UNna1OWXaHtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922791; c=relaxed/simple;
	bh=DhBrdZZrF/qNnTsGkr+kWchoEMI385XmDrH+TXCiMTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYpQSJAXEywV+xE1e2WAbva6wfDoc5ue34nG1jIpam+8X5n12L4JWC96OSuwev1ZQ779f5PtHAF4T9dS2LbWlVyh0H3hzXzwlzVks6z7bRm5OoXZX/dC37doYATaCLYprePiz8u2nv7RAbwyZwYoU2bu2nM+dg6AuZwvDoSwdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLKcqf8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C732C4CED8;
	Wed,  6 Nov 2024 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730922790;
	bh=DhBrdZZrF/qNnTsGkr+kWchoEMI385XmDrH+TXCiMTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eLKcqf8sLB86bsnDq++J5aKyZP63ZAOxsP9Pq9uNXa+Yuv4jbwdNCMaG4JYgj+f/8
	 5hAl/QmGBW7o+5HRQNdgXInCK0LoZbZGhwoeVBdm4qFNM7uRafP5dffq2eBPkqByfI
	 82glJvG1CKf2XDcZGrr+d+bFJfC+nqlkN5bC8R8FL/q86Psq2Jco8H1K6xyJS68lJm
	 QrzujXz3UYjRUUrZorW9MjEjubdKCT+IpjPa7FcYPH6LEtkIFfusth6hpWqlb+xWLe
	 wOA4GBBeVMCTGqrpkBLKzf/Gnm2AHDg/ymramqojo3l794HL5HVyvubXoTrxsGTjto
	 kQC5fG97nimtw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 06 Nov 2024 14:53:06 -0500
Subject: [PATCH v2 2/2] fs: add the ability for statmount() to report the
 mount devicename
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
References: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
In-Reply-To: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3602; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DhBrdZZrF/qNnTsGkr+kWchoEMI385XmDrH+TXCiMTU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnK8kkpOcoW5ovJOr+8opJM4in1IzvKCz4331Bt
 463Gx728Q+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZyvJJAAKCRAADmhBGVaC
 FaPFEACfTeLSCABqw8VZmrzROAb1NTEgn1516lbHHa3uwOkIW1QYWPotSECmfgyN5jeKDbNjjAS
 eMxlPXGpa0udCTfeMNpZCMt411TEBxmrMBHo03jQqU3IldSCaHa5tBwRETiEeonBrogOOyhqei/
 vssYReM6nlFkYPU/7Dj6Rj2b0z2qSKhr8aeJWDjq6eaUdWZRVfPXf5yZclc5SJ0d2BpVbdaq6ES
 3jBv66a+0rpEiVg3uCE272rpVWzgtTrH0nYfegm6suSAmBEkjMcnH8y3AyCGuhdbAYTNmb2E9I8
 lfWF0DDdtgeA8/98JVE1p6DOi8qL/pf9Go4YeUpWoAFojXdt2I4AGCGObmOFEpB8DN567L6aTvF
 Y9bU8xH2Ry3McF0ZtWjSe+5LC4sL1QNkwPOpk6hd0iOb6auw5S5P7CXmAEOyKhxrUJVTsvCr7dk
 cngD9qwYPdFceOFXvKiXWBzOGI29zGxtr6EsIjam4SABQJGHkU0B75eiR6Rf8HMCSRVyxeoJCjh
 7oc4Is2VvxU3ZfzcOMaXjoHOUcDUAmnbhLdTV79WoGy4RKykHdLBNN+Zm1HSFsaWMIxyVv5fwIu
 n/RymKvp28qcCR+a57OI8kjJ1uHfYTlCRExf1wMq7j4awNB+Uarx0Jlb4PeDH3Ubpv1RdBw4YPI
 VaPJFHGhOyouGHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

/proc/self/mountinfo displays the devicename for the mount, but
statmount() doesn't yet have a way to return it. Add a new
STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
the return mask if there is a device string.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c             | 25 ++++++++++++++++++++++++-
 include/uapi/linux/mount.h |  3 ++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 52ab892088f08ad71647eff533dd6f3025bbae03..d4ed2cb5de12c86b4da58626441e072fc109b2ff 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5014,6 +5014,19 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
 		seq_puts(seq, sb->s_subtype);
 }
 
+static int statmount_mnt_devname(struct kstatmount *s, struct seq_file *seq)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+	struct mount *r = real_mount(s->mnt);
+
+	if (sb->s_op->show_devname)
+		return sb->s_op->show_devname(seq, s->mnt->mnt_root);
+
+	if (r->mnt_devname)
+		seq_puts(seq, r->mnt_devname);
+	return 0;
+}
+
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
@@ -5078,6 +5091,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		if (seq->count == sm->fs_subtype)
 			return 0;
 		break;
+	case STATMOUNT_MNT_DEVNAME:
+		sm->mnt_devname = seq->count;
+		ret = statmount_mnt_devname(s, seq);
+		if (seq->count == sm->mnt_devname)
+			return ret;
+		break;
 	default:
 		WARN_ON_ONCE(true);
 		return -EINVAL;
@@ -5220,6 +5239,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
+	if (!err && s->mask & STATMOUNT_MNT_DEVNAME)
+		err = statmount_string(s, STATMOUNT_MNT_DEVNAME);
+
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
@@ -5241,7 +5263,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 }
 
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
-			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE)
+			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
+			      STATMOUNT_FS_SUBTYPE | STATMOUNT_MNT_DEVNAME)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index fa206fb56b3b25cf80f7d430e1b6bab19c3220e4..0f9ea2748f6376b5e71ba969598fc5b641a2c77f 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -174,7 +174,7 @@ struct statmount {
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
 	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
-	__u32 __spare1[1];
+	__u32 mnt_devname;	/* [str] Device string for the mount */
 	__u64 __spare2[48];
 	char str[];		/* Variable size part containing strings */
 };
@@ -210,6 +210,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got subtype */
+#define STATMOUNT_MNT_DEVNAME		0x00000200U	/* Want/got devname */
 
 /*
  * Special @mnt_id values that can be passed to listmount

-- 
2.47.0


