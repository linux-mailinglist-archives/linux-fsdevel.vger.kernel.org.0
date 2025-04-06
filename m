Return-Path: <linux-fsdevel+bounces-45822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8106CA7D077
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496F67A287E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFE41AA1EC;
	Sun,  6 Apr 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="vmMCpyh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYiPJhxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6E157A48;
	Sun,  6 Apr 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972358; cv=none; b=PZQu2LfXf109oZNCviwa4HZ8d+EnCRRF4JhFAW0/vCc6b+fETVFNOcB1wMzG5yJShLRjuH8BMmHQDiIeUHbiNraVkRtkX+vl1YYa9PfFFxiu2P9P6ALLwFWVCidkzswj1wcNWPAEaGZRYhSTowepND1I168zdy3xCO/MI+v7O7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972358; c=relaxed/simple;
	bh=3uJ5EzHzUXFc4cgnh3jo3P1fzJjtE38PfIqi7/I4yy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNZOggFYAk3ZDKKoU0eDh++KQEZ+M+AH/13gRIakCS7c1Fnmq5NqDmq+/E03931I7zXdGbY6yBLVyUjYk2re3QK85SioAFZ+ZOdEYzHtGvO/5lPfQJnGsfhZu+X7qPBO4EexTU78DXaNTnskP617ToeIs43kJtT7fPFmPvY3xcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=vmMCpyh9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uYiPJhxo; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id B3640202428;
	Sun,  6 Apr 2025 16:45:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 06 Apr 2025 16:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972354; x=
	1743975954; bh=7NkZxrLaz0tdouf7OofZ+jWLjRfRdYXGiNFcjQujXBs=; b=v
	mMCpyh95t0+6wtiLKuPDjpIWj61Yw5bOsrQ9RCh5997xnHjdtYBWZwA0ppDwpAMj
	crT6LptjN9pPJ1yaufvOSj71Yp8yCF067q9whifbCzYoSXdfOJZYFbaaP9Ar0hK4
	xfXW7BHcNmv5mJ6rr+3MkUWtL+091nosTpZjV4XALddojLbLv3iudJu/WUzXva/P
	RNXZSmjZeJEEdC4fw3Ohn8Nhld07zg+Kqf7iDO4P6oIp9zQxKkESsIVrLosiDAV0
	6m49wVWVF7Yh9RtkAdKbZ1m7mNeDnjg6k7Jxk9KK17LwDfCOHC29dUBlJ38n4gLt
	9Eb47eY2HMy559bg2jOJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972354; x=1743975954; bh=7
	NkZxrLaz0tdouf7OofZ+jWLjRfRdYXGiNFcjQujXBs=; b=uYiPJhxoWeZ4n8rRA
	VmuGTrz7zbr76pAimneNW3Zub2OQILGcpcyP/PSpfcwswhFgI3a+HguKVrU2Wq+q
	mtIoNa/sJk+6qouWKLOUDxyEHXJqrFe7oFHYveNFHNMkw8mdP8krN4yqaC5p80ih
	tTZf2MtQkmeM28CbnL1pKG65+8yrjUfp+/1+47u6mEEbtyFQIwxqFVEEgBNAkZsn
	ztN+NcE+4LkxiQLKu0L8bj39AU/k2GInb6FI/p33t+bYvVyOTT0CV8kcYofRy8PA
	jNEbs4+dfNflz4KowIP+MPBnuHOxzcjUE+6UJDzRVWgYQMtjW62uBTiH0bHytTb1
	dBqIw==
X-ME-Sender: <xms:_ufyZyrOx6jnHrUYBdxYfMsJEQy-jjUHFFcSNzeam6hwyYQglXj_3w>
    <xme:_ufyZwqg-iL5SxAWTpftJK2P41V_0nEYqnu_4480TtMo4MTW9GoLQawLVXq9VQYem
    t0b302n-uBGG1tGKYU>
X-ME-Received: <xmr:_ufyZ3N4Fz1R-qKOYzptJoPHnUFnFWHIL6FKjF1lUdiqC1zeQARVkx9xqNWfgvUjs2B_5135-krFIRcUhaszyEHgpxxq1JnLf465nFEssG7Fxj-i4KQYpvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_ufyZx4HHSJe3IsR8TNDwUyC_1STHQ5RXa7Atj4ACqIwiqtGA4yFVg>
    <xmx:_ufyZx7ArGo7nuYzlQWI_Qkr3rvs_90-EEUWcNEb2aBKtjlL9neH-w>
    <xmx:_ufyZxhdt0CA-0RUrRu4XdFSngQVz6CwNbyXkAG97ibGDIfdfyYvIQ>
    <xmx:_ufyZ77Ec2DS01_PBLirvL5Bi8TIYECUvpU7I2HK_JxbhZ6Jhr32TQ>
    <xmx:_ufyZ05seLlajMSwxePNGHIJ4cYcwqHdjxJwiU8OtuJ0tqC3Z0O7KVAc>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:45:48 -0400 (EDT)
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
Subject: [RFC PATCH 2/6] fs/9p: add default option for path-based inodes
Date: Sun,  6 Apr 2025 21:43:03 +0100
Message-ID: <cafa370071ac34fcfcbe31b52dd4344ce61570f5.1743971855.git.m@maowtm.org>
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

Add an extra option to control the inode identification behaviour, and
make path-based default.  The reasoning for this default is that the
current 9pfs already does not re-use inodes even for same qid.path, but
because of the dcache, a file kept open by a process (by e.g. open, or
having the directory as CWD) means that other processes will re-use that
inode.  If we identify inode by path by default, this behaviour is
consistent regardless of whether files are kept open or not.

In a future version, if we can negotiate with the server and be sure that
it won't give us duplicate qid.path, the default for those cases can be
qid-based (possibly re-merging commit 724a08450f74 ("fs/9p: simplify iget
to remove unnecessary paths")...?)

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/v9fs.c | 33 ++++++++++++++++++++++++++++++++-
 fs/9p/v9fs.h |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..487532295a98 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -36,7 +36,7 @@ enum {
 	/* Options that take integer arguments */
 	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
 	/* String options */
-	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
+	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag, Opt_inodeident,
 	/* Options that take no arguments */
 	Opt_nodevmap, Opt_noxattr, Opt_directio, Opt_ignoreqv,
 	/* Access options */
@@ -63,6 +63,7 @@ static const match_table_t tokens = {
 	{Opt_access, "access=%s"},
 	{Opt_posixacl, "posixacl"},
 	{Opt_locktimeout, "locktimeout=%u"},
+	{Opt_inodeident, "inodeident=%s"},
 	{Opt_err, NULL}
 };
 
@@ -149,6 +150,15 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->flags & V9FS_NO_XATTR)
 		seq_puts(m, ",noxattr");
 
+	switch (v9ses->flags & V9FS_INODE_IDENT_MASK) {
+	case 0:
+		seq_puts(m, ",inodeident=none");
+		break;
+	case V9FS_INODE_IDENT_PATH:
+		seq_puts(m, ",inodeident=path");
+		break;
+	}
+
 	return p9_show_client_options(m, v9ses->clnt);
 }
 
@@ -369,6 +379,25 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 			v9ses->session_lock_timeout = (long)option * HZ;
 			break;
 
+		case Opt_inodeident:
+			s = match_strdup(&args[0]);
+			if (!s) {
+				ret = -ENOMEM;
+				p9_debug(P9_DEBUG_ERROR,
+					 "problem allocating copy of inodeident arg\n");
+				goto free_and_return;
+			}
+			if (strcmp(s, "none") == 0) {
+				v9ses->flags &= ~V9FS_INODE_IDENT_MASK;
+			} else if (strcmp(s, "path") == 0) {
+				v9ses->flags |= V9FS_INODE_IDENT_PATH;
+			} else {
+				ret = -EINVAL;
+				p9_debug(P9_DEBUG_ERROR, "Unknown inodeident argument %s\n", s);
+			}
+			kfree(s);
+			break;
+
 		default:
 			continue;
 		}
@@ -423,6 +452,8 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 		v9ses->flags |= V9FS_PROTO_2000U;
 	}
 
+	v9ses->flags |= V9FS_INODE_IDENT_PATH;
+
 	rc = v9fs_parse_options(v9ses, data);
 	if (rc < 0)
 		goto err_clnt;
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 5c85923aa2dd..b4874fdd925e 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -31,6 +31,8 @@
 #define V9FS_ACCESS_MASK V9FS_ACCESS_ANY
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
+#define V9FS_INODE_IDENT_MASK (V9FS_INODE_IDENT_PATH)
+
 enum p9_session_flags {
 	V9FS_PROTO_2000U      = 0x01,
 	V9FS_PROTO_2000L      = 0x02,
-- 
2.39.5


