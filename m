Return-Path: <linux-fsdevel+bounces-60224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA0B42DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75AE74E135C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB0FBF0;
	Thu,  4 Sep 2025 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="XBKNjgUc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgFr4lpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96615A8;
	Thu,  4 Sep 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944324; cv=none; b=eJFBTK1mF0I7fAn1aa5uWEygE3ytAE75lr2LgJq/rhaHeS8Z5gkiBdOf/lN910/0Sr+wA+xIfysr8HkwwARnq8WBvwgyZvToy6g8H1yU2wuSobqmFDJmUIJL4lLgw+lY8Ux22zNvUefuQ8E1xKpkFscmqBz7bZR/vytyGRD7+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944324; c=relaxed/simple;
	bh=/avF7YlUmMomdKEmXB698jfqofsD2pIczusJMQR+BB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmbOm9o+ZGe/Ee14cd2GxW8MX8XEhdaccYT7q1gaVIexTJwAoDOZGTN7uNlnEDWPLaOcB90nDPgT0eWlL/LxPdpMRVV/wBDyyYbskbHA1tuHb4cMTqsY1UR6kfai+d/O6ewM28gv6uDnVzTFteQW3aISnip+CHKLeP+Yfgs7X18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=XBKNjgUc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgFr4lpj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D72331400182;
	Wed,  3 Sep 2025 20:05:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 20:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756944321;
	 x=1757030721; bh=W/JD31cTyLLZIxZlkHIOfcDif0a7gqR4Ga01YMWC4uM=; b=
	XBKNjgUcMdiBrlJpxYomji9bPpmToaaCavffnmiMMp6mjRKgxl+rCzCtJso00+ml
	Tg6NgWxvi/5ooiURaCvtQRJ1tGgH4I4uujF53qOYbJgVrdQcqAWp/xd1UgjhigJC
	mU4uuji5DD7FGHLalloHiaZt7pw+7Yahq3f2RGwh3f3GCYAhVDGlAUJZXNLiw08P
	raiRSAc0t3WjsnNYrUXvU6tWHtWGiROP/SJ6QD9id3/TarE9hAxJb5iLt7MFHT7Z
	07COYHPcd1jVKh0SYfhzyEqL7PGIRqcke/JT6ikzbD+9jgcp9pERX9XR1Y+WnlHa
	k7DsiKGAMHadGPKUKhZ3Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756944321; x=
	1757030721; bh=W/JD31cTyLLZIxZlkHIOfcDif0a7gqR4Ga01YMWC4uM=; b=W
	gFr4lpjKozvjQGYDxsXqkrF/ni4RNYMHxj9qwpxkuLIckApXGTDDln0TyZfzj1sG
	08D5rx02AvNokQvswktCh0nGUnz6PlsNEqDqGSXAvL63CObHf01ufBMIWGjHYW/V
	HBLv/jfwne2cUzbTE/PQmTPOs1yWR6fCjxlYuVc+3iOU401szSa0syw1z7veXEHR
	QsVps6DQXIIdNM24JCYKleWgTgSBA0b3ZWceWlzrh26a2KgWOtJs2/0GOb3g1DmF
	JxSZNTwdkZbnG+EdDW/fj+U0orqubeTHLuJ2YlR2NBo9H6Pt7735TbmJE1xcpc+8
	ajSlweqlswygOZxlrWnmA==
X-ME-Sender: <xms:wNe4aF0EP0NsdNZ2lfKwmpt7k1fJ8vCpnZvrrj9UOUJCmzyfmy5D_g>
    <xme:wNe4aH4JQ5hBzLsrXaMiIcZFiKTSY_1301BxCkTwhKZDZWMuVa74fUPw6axuX6haL
    24kJTN0WCJ6Ke6lPAA>
X-ME-Received: <xmr:wNe4aMVioS5-GoQcT3k5Xpv90wLvyHXDBU7X_3C7gbm2iwv5OZFb5M28RL50mL7ULr4TD4phIMhgtBQATTXryllM_0KV23n2bNEsWLctvWjEStIvciEFLaOCEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepieeige
    eghedtffeifffhkeeuffehhfevuefgvdekjeekhedvtedtgfdvgefhudejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepvghrih
    gtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdr
    nhgvthdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpd
    hrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrgho
    fihtmhdrohhrghdprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wNe4aPgQO1FYappPUJdXhk94eGuX_qORdzPulQ2UBaaHCVTFED-Y-g>
    <xmx:wNe4aMd8r4_IdU8EvHgGZyoWkh9lA19QwN5E2Y3QCA0HXpl0T9wjqw>
    <xmx:wNe4aO1aKtLbQf7n6KQsrfktRSeJkMnsA5y4WYumS_qHrM2lBN80DQ>
    <xmx:wNe4aIp0xziP0i-kElxD56fG_iCVBCFrnErrOMGdm49Er3vtVy5PoQ>
    <xmx:wde4aFEXttbNyNq9c3YirzAvQtPwOope_XD17OFA2nZIIK73PTpqsbVx>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:19 -0400 (EDT)
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
Subject: [PATCH v2 2/7] fs/9p: add option for path-based inodes
Date: Thu,  4 Sep 2025 01:04:12 +0100
Message-ID: <31a2c4c90681a52484411bd2a0314249e330f01e.1756935780.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756935780.git.m@maowtm.org>
References: <cover.1756935780.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By this point we have two ways to test for inode reuse - qid and qid+path.
By default, uncached mode uses qid+path and cached mode uses qid (and in
fact does not support qid+path).  This patch adds the option to control
the behaviour for uncached mode.

In a future version, if we can negotiate with the server and be sure that
it won't give us duplicate qid.path, the default for those cases can be
qid-based.

Signed-off-by: Tingmao Wang <m@maowtm.org>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: "Günther Noack" <gnoack@google.com>

---
Changes since v1:
- Removed inodeident=none and instead supports inodeident=qid.  This means
  that there is no longer an option to not re-use inodes at all.

- No longer supports inodeident=path on cached mode, checks added at
  option init time.

- Added explicit bits for both V9FS_INODE_IDENT_PATH and
  V9FS_INODE_IDENT_QID, in order to set a default based on cache bits when
  neither are set explicitly by the user.

 fs/9p/v9fs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/9p/v9fs.h |  3 +++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..f87d6680b85a 100644
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
 
@@ -149,6 +150,21 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->flags & V9FS_NO_XATTR)
 		seq_puts(m, ",noxattr");
 
+	switch (v9ses->flags & V9FS_INODE_IDENT_MASK) {
+	case V9FS_INODE_IDENT_QID:
+		seq_puts(m, ",inodeident=qid");
+		break;
+	case V9FS_INODE_IDENT_PATH:
+		seq_puts(m, ",inodeident=path");
+		break;
+	default:
+		/*
+		 * Unspecified, will be set later in v9fs_session_init depending on
+		 * cache setting
+		 */
+		break;
+	}
+
 	return p9_show_client_options(m, v9ses->clnt);
 }
 
@@ -369,6 +385,26 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
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
+			v9ses->flags &= ~V9FS_INODE_IDENT_MASK;
+			if (strcmp(s, "qid") == 0) {
+				v9ses->flags |= V9FS_INODE_IDENT_QID;
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
@@ -393,6 +429,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 {
 	struct p9_fid *fid;
 	int rc = -ENOMEM;
+	bool cached;
 
 	v9ses->uname = kstrdup(V9FS_DEFUSER, GFP_KERNEL);
 	if (!v9ses->uname)
@@ -427,6 +464,26 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 	if (rc < 0)
 		goto err_clnt;
 
+	cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
+
+	if (cached && v9ses->flags & V9FS_INODE_IDENT_PATH) {
+		rc = -EINVAL;
+		p9_debug(P9_DEBUG_ERROR,
+			 "inodeident=path not supported in cached mode\n");
+		goto err_clnt;
+	}
+
+	if (!(v9ses->flags & V9FS_INODE_IDENT_MASK)) {
+		/* Unspecified - use default */
+		if (cached) {
+			/* which is qid in cached mode (path not supported) */
+			v9ses->flags |= V9FS_INODE_IDENT_QID;
+		} else {
+			/* ...or path in uncached mode */
+			v9ses->flags |= V9FS_INODE_IDENT_PATH;
+		}
+	}
+
 	v9ses->maxdata = v9ses->clnt->msize - P9_IOHDRSZ;
 
 	if (!v9fs_proto_dotl(v9ses) &&
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 134b55a605be..b4e738c1bba5 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -43,8 +43,11 @@ enum p9_session_flags {
 	V9FS_DIRECT_IO        = 0x100,
 	V9FS_SYNC             = 0x200,
 	V9FS_INODE_IDENT_PATH = 0x400,
+	V9FS_INODE_IDENT_QID  = 0x800,
 };
 
+#define V9FS_INODE_IDENT_MASK (V9FS_INODE_IDENT_PATH | V9FS_INODE_IDENT_QID)
+
 /**
  * enum p9_cache_shortcuts - human readable cache preferences
  * @CACHE_SC_NONE: disable all caches
-- 
2.51.0

