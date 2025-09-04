Return-Path: <linux-fsdevel+bounces-60229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F152B42DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C77A5E74D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0BEAF9;
	Thu,  4 Sep 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LnDVFotn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFUUTY19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983D125A9;
	Thu,  4 Sep 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944334; cv=none; b=GvE0Ey02pxzerftLk8mQVgdnFxUrpY5ohp1yeym0cMHGiQO0f7j62AcwjAgyZbKTsO23dHrcWZEfC1+KbDpsN2QVSRttrk/pxkuY3WBgS+697nsU0btAWBoRrDdH12k4Xnw4bwn2anb3gYzlC98kN84mNAgko83MaTSAnRoFjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944334; c=relaxed/simple;
	bh=HeyVWVmdu2Gnz28ip5qk5OaQRBY3QWrBK9+gCmnExwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddrn+nlkwyr3UybSA+dHYSwmXFdfJqulwmu+eTblk6i693Jf2TT3Jaabj9dzJ++Y6qgOxIYaUYO4TS+R+tRy+emEnq6h4RmPVfCZUeOSynTpW7xS1qwP1u47bwuiWTEKxuiBGj+GifVpKGJdFcdbRX2wfacy0KyWOPehx9fa5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LnDVFotn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFUUTY19; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8470D14005D3;
	Wed,  3 Sep 2025 20:05:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 20:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756944332; x=
	1757030732; bh=bi6KFMXLXw2rU6KRbsDWud5jypdQj8humwHJMDHqoIU=; b=L
	nDVFotn7xZCCJxewHV7u64KbU7AxedsycyXaqfwZ6V54JeCfNozjEQ8GaBVVlOtB
	WhFKZ+svsR1/YRwDTOsQknV6vDTwVjREsOEzXDGhin9X356caFOk4alNzlFzbUfu
	40rFssnUErCGZiZ4h7n0mFvaY8ak3FU078m1Xs0SNb/iiKa//XR5msN/4xrtSchU
	cw04Jez6qkSm0/RiABWdwASrg+Ci2ZWrmIKQdoX/MHLFWoJa7116B/LQOtWEhMIx
	0stG/PqSBv8s1lo8Ub29GSJKmVMp1JyOrRq8KT19EjqV0a83v6vLhJe4aeBl24bH
	8kWD9QF6ZRQJT8qIr0P4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756944332; x=1757030732; bh=b
	i6KFMXLXw2rU6KRbsDWud5jypdQj8humwHJMDHqoIU=; b=EFUUTY19BIdcHV/y6
	dDG6T5NYEuFRD/InW560C9yoS6XcCTaKMLZMMlA8tbAGqX2pa6a3qlIc18Y8lypL
	/oyIVA9X8MkplviDfTYWRrySTnOfbu+ZXwsHPiBgd5ROzVpoetwjNPWT8yk2EId1
	jL9/iiwzmel8WWtymXJGzC1FofJaVSWwoKsUo3E3hT2ahAJvq4MpjGMwb2GDviU0
	wUVk8bSKajgLJGIn0BXXjeTRtdnqwAEEXD4V9TSU+N5tYNktw0p95C8r86Eme2O1
	eKYIsccYr2EqJjCL3ZICw/5GboeTXLr05yKHPhsWOIl8wxPrMi1JcmxGM5j/KoJu
	cIZog==
X-ME-Sender: <xms:zNe4aG3u1VsE7asFuWb3bZuew181SuGR9B-FQt9t0oBh6L2y3_DjWQ>
    <xme:zNe4aE4Sj02eR5tIUVkAd4DEVsBrASPA4YuAVliMSG92m2FHuI55q0YRkXOiLMeYp
    3c3JSMSAlrrQb-_00E>
X-ME-Received: <xmr:zNe4aFUDrC_XiBlgiJfU6jlsnjwFEHE4ESiYPtiVMtsDNHejihdSQ7fPGW-yFbnz75CZGeqwdpli8ZmVcJzPOUZaQGGU66acqNmNe9kdPgju3fEU4ngeMk1o8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:zNe4aEjOwjM_OdO6Od803c7lCu4mfWwjM9l-r8KeP6wqdEGKI5YSSA>
    <xmx:zNe4aNf3UN14ECoUPqtCXIDZyqbvfmujUi0itjqbNXfvO2WPRlkBzQ>
    <xmx:zNe4aL0gPEeuIogDJER2gqPpWemEXZpJP_BpTadq_AzVAuIu7P1kiQ>
    <xmx:zNe4aBqO0cQ3S4W5nXWBEVnYtPXtfoDagTbyKV-hVjWERmhiuZ3NIQ>
    <xmx:zNe4aOFY9PcwPVB4KEdZWryeKqB7XqV7uyktFJN3w_yrJlMXF6MgyOB9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 20:05:30 -0400 (EDT)
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
Subject: [PATCH v2 7/7] docs: fs/9p: Document the "inodeident" option
Date: Thu,  4 Sep 2025 01:04:17 +0100
Message-ID: <7ef55d4b0541108e367e547cf3b87825f05a68c9.1756935780.git.m@maowtm.org>
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

Add a row for this option in the Options table.

Signed-off-by: Tingmao Wang <m@maowtm.org>

---
New patch in v2

 Documentation/filesystems/9p.rst | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index be3504ca034a..8b570a7ae698 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -238,6 +238,48 @@ Options
   cachetag	cache tag to use the specified persistent cache.
 		cache tags for existing cache sessions can be listed at
 		/sys/fs/9p/caches. (applies only to cache=fscache)
+
+  inodeident	this setting controls how inodes work on this filesystem.
+		More specifically, how they are "reused".  This is most
+		relevant when used with features like Landlock and
+		fanotify (in inode mark mode).  These features rely on
+		holding a specific inode and identifying further access to
+		the same file (as identified by that inode).
+
+		There are 2 possible values:
+			qid
+				This is the default and the only possible
+				option if loose or metadata cache is
+				enabled.  In this mode, 9pfs assumes that
+				the server will not present different
+				files with the same inode number, and will
+				use the presented inode number to lookup
+				inodes.  For QEMU users, this can be
+				ensured by setting multidevs=remap.  If
+				the server does present inode number
+				collisions, this may lead to unpredictable
+				behaviour when both files are accessed.
+			path
+				This is the default if neither loose nor
+				metadata cache bits are enabled.  This
+				option causes 9pfs to internally track the
+				file path that an inode originated from,
+				and will only use an existing inode
+				(instead of allocating a new one) if the
+				path matches, even if the file's inode
+				number matches that of an existing inode.
+
+		.. note::
+			For inodeident=path, when a directory is renamed
+			or moved, inodeident=path mode currently does not
+			update its children's inodes to point to the new
+			path, and thus further access to them via the new
+			location will use newly allocated inodes, and
+			existing inode marks placed by Landlock and
+			fanotify on them will no longer work.
+
+			The inode path for the target being renamed itself
+			(not its children) *is* updated, however.
   ============= ===============================================================
 
 Behavior
-- 
2.51.0

