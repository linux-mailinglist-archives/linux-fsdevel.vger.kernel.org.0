Return-Path: <linux-fsdevel+bounces-33476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D159B92B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B403A1C21DA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32571A2574;
	Fri,  1 Nov 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="LeA5WwjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajIH0dX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E261AA7BF;
	Fri,  1 Nov 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469329; cv=none; b=Ukf870L9D13uuReckUBM5oWxPNgm2M9lb/mkgo+Qb2yUFoxe39zeT6pu6Fz5eI3cIYmmLu0GWZyr0g5AO+P2ZlmocaU8FNlo4zNvcnlZp+mRnQpOEOkEt2Ju+dO3whCbXnurvd+a9n69+F8G+2K4Bp9vWLyFfxUTSD9L5GQGfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469329; c=relaxed/simple;
	bh=pFDhFHLBfdJwuTqHyN06kE8QojwExhKmomKGiOhi49U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPX2dG+ou/Nai/XdJN4PKILpc7o+admasyGrVFz9BgMcsAhRX0mWzrTSy4nF91f6m1QM0CA/p45DU+9rnq/dE01KpCkGvfC9rYKq0YkZzfgUx8zyNezOmqE9M8NegUr6hfGWuZpwHt6XRhnydclESyy4vqPEufUSgh6NloMJ+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=LeA5WwjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajIH0dX4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0963A2540115;
	Fri,  1 Nov 2024 09:55:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 09:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730469324; x=
	1730555724; bh=192szHnbj9c+YbJkI7hF7+bUn60M5dnEdOqJzMxTjAU=; b=L
	eA5WwjDCwvlDLjMxLIfH9dZ+fSRij5Nu9nUJlsRQyTz/KXJSTP16bRBUaTkh4+6U
	xSNu+EafJMCnAi4USPy34rYAZFQuPQH5H1PK9vU3oqlQRRfM9yS9EZrdS4fmI33f
	DrFSrsdseBBUJVZdNEF7EeK+d/K6f3y0551CjfTxYlkHXem18jxTdCC+5yqVxK3G
	C3gI6VMpyb1A3UJr6oeQOpNsxM0ukgXLaGQTYm/PwYA/dUf4Ba9vRZdqVNveyACA
	B92v/x35TFYiSbPKHFnJbRFCEK1dvQ753J2ADiDOD12Ui1EZOPSt2EpoSHDns/l/
	BLjy+i8eTUmtger1JFB8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730469324; x=1730555724; bh=1
	92szHnbj9c+YbJkI7hF7+bUn60M5dnEdOqJzMxTjAU=; b=ajIH0dX4GPtrgiqcT
	2lnWzwSV43zhKoN3MdVl4a7Gi9Lp2eEZvfH2AFRyWsZxKBHTv7csxIEzsaKHaNlg
	EZbBLqHqoK3WGfblZOP6aFaIrV/VHOCVtMYM9HYsCpjeudbvb5DlRwAuflbMaQyK
	4WWoSgXEfLUAJEcRwM0Gg0jQAwXsxjc6JqgnXYHSeo7hWGYJvIvRwM3SJSc+p2wt
	+2RICQArNsHFMmh1Y6Tqb6p0As79T36iSnoUHrPkE58jteswJoVw0l7agVrdXOvo
	U8xqHOazfm7NI1AgBA8Kg57twtdVXHNKJsdt67xFe5+wTZTqz0O+/YN6ESvhBJFG
	UbLxA==
X-ME-Sender: <xms:zN0kZ5xRoYOsrszSd0xSa1H3XCAqZ41QW7so028V8kpeVau5T8-9sA>
    <xme:zN0kZ5QDyMaKVIHn1xzqqXtT8wDT49k1dMZ5t3giz2GfYLAfygBSkzQmYUU3Yrf3C
    pi3PQ-daELoXlnkxgc>
X-ME-Received: <xmr:zN0kZzXWMPLyNxgM7obj5ABrquMttI83NYyCSODq6CkjkcPWnOkLDhWaXEI2g43Pd8WbsJ9oAhebDRssFpf1QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefgrhhinhcuufhhvghphhgvrhgu
    uceovghrihhnrdhshhgvphhhvghrugesvgegfedrvghuqeenucggtffrrghtthgvrhhnpe
    eggedvkedtuedvgfevvdehieevveejkeelieektdfggeevgfeiieejtdffledtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrsh
    hhvghphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnsegsrhgruhhnvghrrdhioh
    dprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohep
    sghluhgtrgesuggvsghirghnrdhorhhgpdhrtghpthhtohepvghrihhnrdhshhgvphhhvg
    hrugesvgegfedrvghu
X-ME-Proxy: <xmx:zN0kZ7g-_rK1tcm3YnV4Zk9qz8wmzDDsLX1gb3HBxgzNMSGdrdxzJg>
    <xmx:zN0kZ7DIfUAwlQGT0GMfvBje5PQC-3ivdFr0VNniOMEilFDWOAsMkA>
    <xmx:zN0kZ0IvA5uvPqlUzp71x_5KMMdn0kvimWFdMWXzRKLR1byCyiE_3Q>
    <xmx:zN0kZ6D8RRzLobZwAuaLFvu9hpX7Z148rMQTBENQFnFKDCJP0bkttw>
    <xmx:zN0kZ91VttTHp-Ph5O7_atnD5sTVjUVkpK_Z1-TIcZBV5a_FJYK8PvIf>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:55:24 -0400 (EDT)
From: Erin Shepherd <erin.shepherd@e43.eu>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com,
	bluca@debian.org,
	erin.shepherd@e43.eu
Subject: [PATCH 4/4] pidfs: implement fh_to_dentry
Date: Fri,  1 Nov 2024 13:54:52 +0000
Message-ID: <20241101135452.19359-5-erin.shepherd@e43.eu>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241101135452.19359-1-erin.shepherd@e43.eu>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables userspace to use name_to_handle_at to recover a pidfd
to a process.

We stash the process' PID in the root pid namespace inside the handle,
and use that to recover the pid (validating that pid->ino matches the
value in the handle, i.e. that the pid has not been reused).

We use the root namespace in order to ensure that file handles can be
moved across namespaces; however, we validate that the PID exists in
the current namespace before returning the inode.

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/pidfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c8e7e9011550..2d66610ef385 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -348,23 +348,59 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
-static int pidfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
+#define PIDFD_FID_LEN 3
+
+struct pidfd_fid {
+	u64 ino;
+	s32 pid;
+} __packed;
+
+static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 			   struct inode *parent)
 {
 	struct pid *pid = inode->i_private;
-	
-	if (*max_len < 2) {
-		*max_len = 2;
+	struct pidfd_fid *fid = (struct pidfd_fid *)fh;
+
+	if (*max_len < PIDFD_FID_LEN) {
+		*max_len = PIDFD_FID_LEN;
 		return FILEID_INVALID;
 	}
 
-	*max_len = 2;
-	*(u64 *)fh = pid->ino;
-	return FILEID_KERNFS;
+	fid->ino = pid->ino;
+	fid->pid = pid_nr(pid);
+	*max_len = PIDFD_FID_LEN;
+	return FILEID_INO64_GEN;
+}
+
+static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
+					 struct fid *gen_fid,
+					 int fh_len, int fh_type)
+{
+	int ret;
+	struct path path;
+	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
+	struct pid *pid;
+
+	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
+		return NULL;
+
+	pid = find_get_pid_ns(fid->pid, &init_pid_ns);
+	if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0) {
+		put_pid(pid);
+		return NULL;
+	}
+
+	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	mntput(path.mnt);
+	return path.dentry;
 }
 
 static const struct export_operations pidfs_export_operations = {
 	.encode_fh = pidfs_encode_fh,
+	.fh_to_dentry = pidfs_fh_to_dentry,
 };
 
 static int pidfs_init_inode(struct inode *inode, void *data)
-- 
2.46.1


