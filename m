Return-Path: <linux-fsdevel+bounces-45825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3118A7D07D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451B83AE479
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6211B0F19;
	Sun,  6 Apr 2025 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="bRgQ2tQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0tDGW2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94051B042E;
	Sun,  6 Apr 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972364; cv=none; b=afOFMurtx8sPV5oQJ3TzRz7gKqFIwtz5aaGXH9zPHH96oY25ccoN1UGbA5NfaWWy5LBI/5Oy8zPx7y+EWtdOJyGPJBExcKsEIqyXMJ+rU4LwXY2flezMEtBqpq+yIEiKVUC0w59Pg6kiPQV9Nza2yCxSzZspFPTmDIO5khJI8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972364; c=relaxed/simple;
	bh=hR94pmqglUX1HDCAhc0UZm/zg++tvdt+zW5ZJZPAMr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYxXKGQ0XHiRPNoKylObGb/NO8dN7Hgp0FIYqM1yOvVTM3RCVwZT40yEBgJjp1r1rDb7N0SVC9CwFXoHO+4fUHOq3dX5fCKMNdovqWCHbpy26PonK8KXBn9kh6JbL6ekz/pvjGtzibhgDOnwHhGw2u5b78opCa9IqPGd7UC3MyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=bRgQ2tQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0tDGW2z; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id D78F6202430;
	Sun,  6 Apr 2025 16:46:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 06 Apr 2025 16:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972361; x=
	1743975961; bh=90xMjucamVsewCSQDP8SkIIi9Yg3hTLJZtFtNjvjA/o=; b=b
	RgQ2tQpB5siKPyAeJ82ADpl/dRdmJ7HVy1HwuqWjUhWvxs8GqT6Onhv0Ho6F1v1g
	neyVSl7zpUmYTkvwPPGdrF5mWLgn3WvbJ0kuqBoXQfMjkMiP8TDFke+W4GEarfzW
	9cdM5uZ7qv+oZtE8niooffj4qn2Xsq5pvB5GDVrrSggjUxQGalSk/wqqbasFrSUr
	SOCjph6i2mYBev0OPe7UEMEkeZ2MS7BLP2b7z3wLaBCRwrKR/Ux5d2e5rdvoViKD
	7TL4a+iDcnEAYeiRk9PToSzAgb7FGEq/xj2io4+iKeOx7pjwPFOFnYQctFV6TYlo
	5hPCrjoDsdXFznLLa97lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972361; x=1743975961; bh=9
	0xMjucamVsewCSQDP8SkIIi9Yg3hTLJZtFtNjvjA/o=; b=T0tDGW2zHORFDFzbR
	hhmwqdaE9h6uaQqBiq6YVm8jHPsZlysXwp23GL5BEPrp+Ba7nq3DUZdyZKRvPeFe
	e1vvsBwOLUuCs5ml6u9bKBqaD9Iu/OS3u/KzIMsi9hdR4XOGEQdUUGBwrqT0Q5Ku
	Jq/5fk8x2hkkX2dDtOTSy27qHNH1N3QkytJVzdZovoc6dtdQ71Uc0p096tzVgEl0
	WzZ93O1ZfgdSHl04so/wcKl6cj+vAeAl/VX+vUX24bilEcO3QlA1O5PJiZNIozgQ
	Diq4Nylvy3A+yfsFxby/ERs8BCeIKqFih/J5SAnHD7yBgXvvq4a3/qMhB5CdLODY
	A34uQ==
X-ME-Sender: <xms:CejyZ7CZ7JQ5_7bbomT9L7GJIVjbzugmhKBso-WysYmcL5F_0H-Hdw>
    <xme:CejyZxisB5HbsyFPR3ylf9YzhIwercQJqrQ51220ZRUA3dEYlLQ6sEyXW5DH2xrn6
    WpCoXmlxKoRV6ZngzI>
X-ME-Received: <xmr:CejyZ2kuYhIMJuA8bwIRc1NfPbjhGh94Bue_c6j-rfkQXbpQDKthRMJq9Gn9Pl78ksgnvYLDkBmVDuVQkRSYxT9Sg7PxmDZsuXZpMRh9hzXX3MGj7Ymrc9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CejyZ9yELyWd9E2GBU5Awzyk-nZ6UrKYDd7kFkdSXK35hyNEd-ChWQ>
    <xmx:CejyZwT-rAWKxgvNbozX2r4m9oR081JuIUXd6eFpaXaquDjwUBDC3g>
    <xmx:CejyZwZcdvsfQBUoJMun9U6Dk69g5NRMLK7psvPLRZAcbpfd1V825w>
    <xmx:CejyZxQkOOQFBhdufQgGB9GGLz-vMTTeCPqh6quowxhjIe-mrDiHSQ>
    <xmx:CejyZ3Tix1weLh8UK0oviksdQC-Njpn_294nIHwMxlud5KqHsMDSyQO1>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:45:59 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 5/6] fs/9p: .L: Refresh stale inodes on reuse
Date: Sun,  6 Apr 2025 21:43:06 +0100
Message-ID: <c294acbe9cce13c87b732b7b5c9cef0d8e113b37.1743971855.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only for uncached mode for now.  We will need to revisit this for cached
mode once we sort out reusing an old inode with changed qid.version.

Note that v9fs_test(_new)?_inode_dotl already makes sure we don't reuse
inodes of the wrong type or different qid.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/vfs_inode_dotl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c1cc3553f2fb..20434a25cb22 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -187,8 +187,23 @@ static struct inode *v9fs_qid_iget_dotl(struct super_block *sb,
 
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
+		if (new) {
+			v9fs_stat2inode_dotl(st, inode,
+				(v9ses->cache & CACHE_LOOSE) ?  V9FS_STAT2INODE_KEEP_ISIZE : 0);
+		}
 		return inode;
+	}
 	/*
 	 * initialize the inode with the stat info
 	 * FIXME!! we may need support for stale inodes
-- 
2.39.5


