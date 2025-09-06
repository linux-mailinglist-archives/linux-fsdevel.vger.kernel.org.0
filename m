Return-Path: <linux-fsdevel+bounces-60406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C84B46924
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DC91D2026E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784DB279DA8;
	Sat,  6 Sep 2025 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UWDoISlk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCo35G65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EF26CE0A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134857; cv=none; b=RgYkHqQv8dsIBVG53saug8fH9+MZiDax8/Rdz1ubXSdyWUI5HV7mC315eXX1vxdOa4GU4MaODB9wDRDEN0vgRESUBLOkeZmHRCb5CZxrDiO8Xwoy0zZsWc6oEIvq02T7H1QT8n72qvHUsSD1o7l1JV/I0YX91U+23S1QZxFEzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134857; c=relaxed/simple;
	bh=sO+35pMqjSFnGpWW1gsCDhePTv+JBH5XYjbnOCF9MT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSEHV/vvYIJ2I6A32xF41VczY0HtqD0uD0om1nngVnuuUfokZR6BN85pConw3UIlgSF3DpmJOcoVmgnB/aOdO1l5N97O5ibnqNSLkADSm6SXgIlh5y0tb5k1tAxHzUMwYOJXdEq88T8ibg1AJSHdZif3onM1r/pOB6eL28NwpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UWDoISlk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCo35G65; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCBAD7A0387;
	Sat,  6 Sep 2025 01:00:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 06 Sep 2025 01:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134854; x=
	1757221254; bh=AhC02sEb2ucQtugfskwv7HWM2K9DkR00fi3BVu64k8E=; b=U
	WDoISlkfcOjBEe87eUQDl7dInCQD2S4efwiK/2stigp9wmy2ynPatzijO2+8ZO8U
	KY3xErZk3kRFy3jQ1uZbExajDj6yKb4yckbA2EVVJuiaVRV/7scm7oj9GQFLYYuH
	9zN7tJoaunfudG+PUQVuzp2mhHPvszKeXJH+FEmfP5DEcqrnhR46ZtuifSaw7aRU
	1EX1yDpI1zKVquV+/fycC0mqbprwAwOOG4H3zLuOEIy3c2Ow6SKxmlrIUCfknBnb
	lHtc4cZqXZgkdTmWFri3O5C/Vg5QhdKYhRoIkgOYLAet96D3bh1RrnTSnqMTSaHZ
	/KMHMUJvzyzuqPWN9twwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134854; x=1757221254; bh=A
	hC02sEb2ucQtugfskwv7HWM2K9DkR00fi3BVu64k8E=; b=VCo35G65qjCRPDUhB
	2UwCm2kCUGS8jFS57zcDIV30tGYT6r80eGaD5UypGQxe0FjcTsXTnyC9OfzaKEhL
	A+JTJw05e277VFe5Cwpl/tgCieinfIIhkQVMRnlYjcoovxvBKavizWc3n65vUcGV
	5LL6GoalJJxo3zggI+x/0bczdPvG+np/RQJf76Bg+80MiQU9UcuWXZcYQwIPLlAN
	fCHG77m754I99ptFMd31ZoWP0p66QvtodKau3ik0L0veLu2XCbdcegYpn1iY9JJq
	fqI/ScvmWIYoMYHDDt0y7y/3cmJy0utC3rlk/GSiK5s14cC/oSuOh+AuR10DN/QW
	QeqdA==
X-ME-Sender: <xms:BsC7aPMrixWcH2dmRFAkYhU__Lu3RYNv9GpjzvfjVEsfEVjL1ypfew>
    <xme:BsC7aH5Q-8nmGXJxUcOAMJGbB7IHf2zi2ElZ1XRvmZWuUuld51EZGSUEATh12qfHq
    h_y4mwKcO4TpA>
X-ME-Received: <xmr:BsC7aAm76zkmhHcq2czxrUi9i5U46Dk-5XYEWq0Lmqm1sXfqiDwKf6pLejMpy2sXGb6qPcvSzCMc20O65d4h3owm3x53Mu_JuLbPw6m_PrmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
    ekvdehhfegtddufffhjeehfeeiueffgeeltdeuhefhtdffteejtdejtedvjeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BsC7aIQTePbT_b8sjE1YxdPNpBsg45wc9nWTQScbxTxUZfz_2hLe2A>
    <xmx:BsC7aPFWRizUX_yiItD8bZ_XFxp8uUCB8vyuc7JoO_oWWrxKhOM6Nw>
    <xmx:BsC7aNFZsZb6C3O8oYpHPPWlCXE0rEFBhxDCTYRVThff5R2wjxcrrA>
    <xmx:BsC7aNQiERqRfN2JOBNN1sxAwxvvcpF5Fg2SHwhQFflqZ0AGtLj5KA>
    <xmx:BsC7aKD2-yutTZ6qcCgGRa_PoT1eu7P8fcHdDL2TajIrgwvbS5Dy9Sp5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:00:52 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] fs/proc: Don't look root inode when creating "self" and "thread-self"
Date: Sat,  6 Sep 2025 14:57:05 +1000
Message-ID: <20250906050015.3158851-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250906050015.3158851-1-neilb@ownmail.net>
References: <20250906050015.3158851-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

proc_setup_self() and proc_setup_thread_self() are only called from
proc_fill_super() which is before the filesystem is "live".  So there is
no need to lock the root directory when adding "self" and "thread-self".

The locking rules are expected to change, so this locking will become
anachronistic if we don't remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/self.c        | 3 ---
 fs/proc/thread_self.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/fs/proc/self.c b/fs/proc/self.c
index b46fbfd22681..a2867b009269 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -35,12 +35,10 @@ static unsigned self_inum __ro_after_init;
 
 int proc_setup_self(struct super_block *s)
 {
-	struct inode *root_inode = d_inode(s->s_root);
 	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *self;
 	int ret = -ENOMEM;
 
-	inode_lock(root_inode);
 	self = d_alloc_name(s->s_root, "self");
 	if (self) {
 		struct inode *inode = new_inode(s);
@@ -57,7 +55,6 @@ int proc_setup_self(struct super_block *s)
 			dput(self);
 		}
 	}
-	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 0e5050d6ab64..9c4ff2131046 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -35,12 +35,10 @@ static unsigned thread_self_inum __ro_after_init;
 
 int proc_setup_thread_self(struct super_block *s)
 {
-	struct inode *root_inode = d_inode(s->s_root);
 	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
-	inode_lock(root_inode);
 	thread_self = d_alloc_name(s->s_root, "thread-self");
 	if (thread_self) {
 		struct inode *inode = new_inode(s);
@@ -57,7 +55,6 @@ int proc_setup_thread_self(struct super_block *s)
 			dput(thread_self);
 		}
 	}
-	inode_unlock(root_inode);
 
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
-- 
2.50.0.107.gf914562f5916.dirty


