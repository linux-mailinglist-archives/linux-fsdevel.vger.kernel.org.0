Return-Path: <linux-fsdevel+bounces-60226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A01B42DD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159E93BE61A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8C1BC3F;
	Thu,  4 Sep 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="2yz4JvwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EACHuVub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0715A8;
	Thu,  4 Sep 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944328; cv=none; b=t6C2+KHTMBijWbbEcvPe/8qdV7lUIa23g+6gaHwaGo61UQURMWoGtauKe0qarkYFlMPzpofrl691l7M9Gd9+T0QTJgAIn9LEEsCrabc/WnmS+pNmUxdUiv6p0PAEY5LUkEVkpcgVJMxVIXHWMTBvk+ruSZSBSpT33AxGVguVW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944328; c=relaxed/simple;
	bh=scZFTBZe7gJCYcNArW/RUUcEk9zABjvDgsI1g9xjiao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6BsGSU5zf/S3Hd1Q+QONaVfwb+H1lZKkBx9RWrJW9gi/CI9Fxz0SuZEbrp3En06a72hWcUXLhdGGOgo8Yy3UIuvHlNeB9IzviHkJ5re7RM1JIJdv4XmL+C696BBh/tguzE0E4JbpdcJi2NosRFsLQuVhp0dFCK+6C5UOyHE8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=2yz4JvwB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EACHuVub; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6911B1400182;
	Wed,  3 Sep 2025 20:05:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 20:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756944326; x=
	1757030726; bh=CsbRYtdoTrEOgTKUCcI1TPZdtkoXWLEquNG3Qonu8b4=; b=2
	yz4JvwBqWakE+ojmyqXssZL9Q/Fd0kzHBfyn/wyoFtcfiSbwRqvGdD9x3jIRi+OJ
	RNC8YyLn7FDhp0mg019ryoDyxEWs3HsPbv49cbgh1GGo9oMqAWLcQbYMYm+uTxxY
	g/qEyjvqfS+AZKYjHlfrrOdQFhwU9+xF2BBGoEgAQTzEjRdzoOlDYduN/hY7hrvd
	2oMpfOSfIFCj9G1uUfX5P6YmJHo9YEKWKDr8rMW3CvQ3wmzVGeBoiK2mjRU4NG9B
	t3fbprrYxfyTje/Npm4eb0BsoqDBjFfmkghxJIbErkdMlbDBrHyd6rfkkrQ2vbHF
	XDNAzXPl8iRnqfESPYdEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756944326; x=1757030726; bh=C
	sbRYtdoTrEOgTKUCcI1TPZdtkoXWLEquNG3Qonu8b4=; b=EACHuVubK01IPB6Rw
	VgMTwOv4AUxWMJSkv4UWUngzaYJsBFiHxcA4i7mShZpYdgyVIsjQYbbNOlQvsKM/
	0a1pcHn0whLzUaUUs8ESectl2H0hikgBHIn+kyqisJcB3RsR9SpTJyy1rsV7w8ls
	UzrUy4C5ae0cgA2mX4tFR8Hywiz/eMR4am/u7RaSlt+6L0uU0eugKh02nhpHUvxh
	i9kFOSGE0Jx4oWXwkNpFLvjTahNumutN9JUMJ+4L7CIeIWLinzyWoZVPzOEOr80Z
	YMv0seNmgKio+qfBe+Hfq0SphqwC4kvcS86lmVtRgzQQ6hmTDmBfIrtiM3WrDK0J
	omNOQ==
X-ME-Sender: <xms:xte4aPvP7Z5aLR1lkYHdtdj3zxTdoJdU_UlqKhN4anbP5edVDZoAwA>
    <xme:xte4aMSvR2Z39wh4clW7iH2Pk0JRf_Sg8FRQsDXlfAoeNdJgoCGIACeyOUJ1jCVl9
    kwG5fR0rLnBPr6F-Fw>
X-ME-Received: <xmr:xte4aJMShxDvlhif9WfGLFASZ4U1grplNzBix4nUGUGVB53vacVgigFaJb5HJrsRGqgxCwexKRfArBJmuGG3k8PEFnryqKGVtOAEGOO7GjQwscOy0NrP-ScTKg>
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
X-ME-Proxy: <xmx:xte4aK7_4ZGIWHDqbqXrCjbWJnPB_qlDLmmfEsf2a4HuF24LsTJKNw>
    <xmx:xte4aEWkAvUPhOXbmPuWCdVAUjW2vfMZfy5ILVHuGAdMvUr4lyROFg>
    <xmx:xte4aJNfNVhRHbzlwazBx0SgFqRGNE6Di4mZ6mnfLJOamV0k-YIWLQ>
    <xmx:xte4aDiTrW5G04rXCykPB4N2Q3PSW03rBnck2XewTlBZwLlcc3wXPA>
    <xmx:xte4aP_gNdzdWJNbjvQDNzq3iyhMIoaIin_CafvpZ9mnLRDAScoaBten>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:24 -0400 (EDT)
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
Subject: [PATCH v2 4/7] fs/9p: .L: Refresh stale inodes on reuse
Date: Thu,  4 Sep 2025 01:04:14 +0100
Message-ID: <717c1ede692e9d7fae9033cfbb59c68d7aecc9ba.1756935780.git.m@maowtm.org>
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

This uses the stat struct we already got as part of lookup process to
refresh the inode "for free".

Only for uncached mode for now.  We will need to revisit this for cached
mode once we sort out reusing an old inode with changed qid.version.
(Currently this is not done in this series, which would be fine unless
server side change happens, which is not supposed to happen in cached mode
anyway)

Note that v9fs_test_inode_dotl already makes sure we don't reuse
inodes of the wrong type or different qid.

Signed-off-by: Tingmao Wang <m@maowtm.org>

---
Changes since v1:
- Check cache bits instead of using `new` - uncached mode now also have
  new=0.

 fs/9p/vfs_inode_dotl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 86adaf5bcc0e..d008e82256ac 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -164,6 +164,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 		.dentry = dentry,
 		.need_double_check = false,
 	};
+	bool cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
 
 	if (new)
 		test = v9fs_test_new_inode_dotl;
@@ -203,8 +204,21 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		/*
+		 * If we're returning an existing inode, we might as well refresh
+		 * it with the metadata we just got.  Refreshing the i_size also
+		 * prevents read errors.
+		 *
+		 * We only do this for uncached mode, since in cached move, any
+		 * change on the inode will bump qid.version, which will result in
+		 * us getting a new inode in the first place.  If we got an old
+		 * inode, let's not touch it for now.
+		 */
+		if (!cached)
+			v9fs_stat2inode_dotl(st, inode, 0);
 		return inode;
+	}
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
-- 
2.51.0

