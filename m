Return-Path: <linux-fsdevel+bounces-60227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ABEB42DD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C102074C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6724B28;
	Thu,  4 Sep 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="QuN9gbNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lh0tQtx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568ED1C6B4;
	Thu,  4 Sep 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944330; cv=none; b=k9Yr4I1O7F4Dwkvirlh5zVniWzqbsKX7VPEIY62kyixSHSKA7Oxz29tLqp4UiWd7mkFyCixL2tBYHd4o3bLdqWcXjArCvrUDhpXT3wlMgBjtkj5PtQCp20RufGSBqLKYOejXiMaFVxtIFM4+n+fHtSeyqFHuNW4MoRNfG3yIWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944330; c=relaxed/simple;
	bh=oY6yTFcZxKrJcDEfrYyHyrRymAtAlL/Vs+QuHg3NhG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3CwTq3FHfMfferOm9/csD20PIoNnkieT/nOqVmYkX8r5XEwvzRbYuTb+/9nWK+5Wb/Ybe2w4RQ/wJiiFnyjqU1NqpwBOvRc6J4j9ECoZ21wVFlgiTutP5PkcW2i5O/0tWGaxXyMHq9agRlKskm5plagaFvHkG2wPOi3n86HLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=QuN9gbNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lh0tQtx0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ECEDEC009D;
	Wed,  3 Sep 2025 20:05:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 20:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756944328; x=
	1757030728; bh=Af6MBpxBFei1bd32K4CZVc6vvPIOtcDgTGTORtxh06A=; b=Q
	uN9gbNAJwUZ6DyDYuPgDM+4jyZZ4oK0x0acILTbiNEJbevN7YSmevsR7ksatLST6
	yNt9+7xAxQMn/cWOPklgeK9Guq+qoysK69cpMhU+STTwsy09c6mY3OBZ0EHWn/xv
	cpNyYAUnRlrMAROclVvY7UBWlCXVK4/zunQoGTcyMYpmH4nrR9q0v2X0r3Z09jVT
	6fhRs1yEZ9FQoxCjvrvLQbajJw/iluSZ8y6Jpo+DP+GWkY1YWj+F9tfBExFRJ46Y
	apMY85mtGIIWSM4XR6jsAntLE83HexF7wDTqzuZg6Hi0H8hxqq3C2y47LzjWXHC7
	PjUJB0vep5pswytnDlrOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756944328; x=1757030728; bh=A
	f6MBpxBFei1bd32K4CZVc6vvPIOtcDgTGTORtxh06A=; b=lh0tQtx0ySmcki6dM
	JEfQfBqPdUmhDPVH7Gbe6WooCwTKd4O6avo6TXeB4mEKamzHee1MMkXLT76IXaq3
	Q9nViRBB7BKi7cOPUdgsvR/WKTusSDDwKjCmTEGo68clAFKMsewkNwJILYtOBVQK
	XbC5isuOlLppd4GtQgMDwOMZOJl2UzVSGqVws69ZZPapI1x6GCq2Ucsf4+pOwwRQ
	S1KwUMgxkl8SFa0zweVImxddNguKXWsIZx3TM6mzm0VvXtlOSM6W96n0rKN9L/cG
	RNMYfsTidlzu3QAMsYgIbVzU7qt+SND0VmInSwijVOacP7wGFCUl+LG3+auRCM0o
	3zuvw==
X-ME-Sender: <xms:yNe4aArpb--EIpuDD2yk7H0cm63Q5YJApEWSMG9FTOhhyy4JehkyWQ>
    <xme:yNe4aCfVA6yP7VwkN5j9LStpE3DTbLS9kRwFOwXlbK_JY1jIkcg0mXwpubGQSNdNC
    13at-vB-KQ-tfc8sIY>
X-ME-Received: <xmr:yNe4aLrvfRx4VnY0o2fPyvSSZtRu_ttjqVa0iZJuDEHbmKfe7VDdaEr3yHGOst1Ew7MJM5OTCPIIF9tDImhcgCMy_7N_WhXd8s7ckH3lkHFFd0q_PwFnxrPlsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddthe
    fhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdroh
    hrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopegvrhhitg
    hvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhn
    vghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtghomhdprh
    gtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohif
    thhmrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yNe4aEkzoyYrD4v7V1WhI6Zu7D6HAEiR06QCt1pfZZL3bW3Bamp3CA>
    <xmx:yNe4aETfhtzIhN7uLJXtBQDyefy89nT8yHXkHcS_P2L6ltOkeMeCfw>
    <xmx:yNe4aCaYlz19SZLQVB_AgRnCdHey-RZYadM067yhwOnSY3U4sF_Zsg>
    <xmx:yNe4aM-71_lYHtRL35bMeFDq3-ScN53Y6pUAzyMumfDE64UMbMjxMQ>
    <xmx:yNe4aBb_KFELzEZNkh5wqA7jXClXl0EOG0_IYwbRZmNDC_UlLBy2GTRr>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:26 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/7] fs/9p: non-.L: Refresh stale inodes on reuse
Date: Thu,  4 Sep 2025 01:04:15 +0100
Message-ID: <8669a2c7cf096f2466a2a04dc75f7b3e924a2f99.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
References: <cover.1756935780.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replicates the previous .L commit for non-.L

Signed-off-by: Tingmao Wang <m@maowtm.org>

---
Changes since v1:
- Check cache bits instead of using `new` - uncached mode now also have
  new=0.

 fs/9p/vfs_inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 606760f966fd..4b4712eafe4d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -473,6 +473,7 @@ static struct inode *v9fs_qid_iget(struct super_block *sb, struct p9_qid *qid,
 		.dentry = dentry,
 		.need_double_check = false,
 	};
+	bool cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
 
 	if (new)
 		test = v9fs_test_new_inode;
@@ -512,8 +513,12 @@ static struct inode *v9fs_qid_iget(struct super_block *sb, struct p9_qid *qid,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		/* See explanation in v9fs_qid_iget_dotl */
+		if (!cached)
+			v9fs_stat2inode(st, inode, sb, 0);
 		return inode;
+	}
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
-- 
2.51.0

