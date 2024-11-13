Return-Path: <linux-fsdevel+bounces-34682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF139C7A68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DF41F278AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12820651E;
	Wed, 13 Nov 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="PrumJXcy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWUdvWf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487842AE69;
	Wed, 13 Nov 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520534; cv=none; b=GJ9tbrimqw05Dr3ZB3sXHCbfFQ2Xs8e2Bcw8+y5lt7oKYsZiHQ+jeGkyr/O4kvynWWdYtCzrg7nmUicJqY5M4ige7+8XP447bZHN/tvHl5iqMzYEdyVCTMaAyXYFxtPyyO6yO5q5veTUw5jasdbqeINrP7jZQxYuc3H4xR/NalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520534; c=relaxed/simple;
	bh=MtJUEuROc9m9XnoE+OOWZZpv9KV2K7Zmu5eVLlF9w2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3zso3Eq3jNxIBuTNWH2ADJT3vEQ3YYouubAV6be4dQzPGgxaOiCf3vKaOq1xqeLF5IgBZXkLq+ATr1t11p3r1pgCpV+qk7KjuCxr3loX1uG63jtfER97yAcc69VN703HwT8efzW8T7ab7GiqTITDQE+GPA7JL9nl/bck9UCn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=PrumJXcy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dWUdvWf9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C66F25401EE;
	Wed, 13 Nov 2024 12:55:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 13 Nov 2024 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731520532;
	 x=1731606932; bh=H4mUvZK1UHDTuk+P/f3KKymsaUVeOckX9jzAr9bIhAE=; b=
	PrumJXcyV7sUnHgM/YV/iIdjGBkok+DMoHnpLnaUEKgcPqFP+egaAm+8PTSX+olW
	zY9Du9NIlzFrI/40zC2DXS2upMPSEN+WKGgzPseoazxwMv3gUeDfIUe6PbeRbGI+
	GpOZs9ZcuRVDa7FY1pbHhzpr84EqKs45P3+NOccyMAA4NcUMbSDrgmJUE44topUy
	lk7MFglKwq9X6zdqYDohM/b9qNAxD5sEjWzmWjGSDiGPSNIWvZiq35s0Mk8t+h8N
	kicNhkzL0q1cp/qZQIhyEKt2WIj/3cSjjUy6bRYDfnbVPAQ0McQf4AuOIH2JVFwm
	hb1IcXEFrRRKvWhN3Se1rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731520532; x=
	1731606932; bh=H4mUvZK1UHDTuk+P/f3KKymsaUVeOckX9jzAr9bIhAE=; b=d
	WUdvWf9o20g19ar97IpZdywHeKROEF0myEUR6JNlAdj38tQDCDkpvlTkWNM+BVkN
	LaD68MVqq/izCGWz4Uf8TxJYNhwEhwQfOpEug7OuozSG01XgIA68kNE5vIY93rUQ
	P3iU/mbJpcS1IkpowXTahMgfIz+nIZ6azVRd0DrZ2thvIe17jY0I8pqnEw4RNpiU
	YPOcC+bOo2CfME9iRCXDiDTRW1X8ycXGhaFwcWjPtdYcLkV/zB973oLWIBNKXG3O
	tRSEVGEYQAkfoCUq7HdVsvNxnAvJSyXCWJUimoTqa4PLZ8+gcRY8a2SRo7+dK+ak
	5+jsBoHty3A3fGZYW+5Mw==
X-ME-Sender: <xms:E-g0Zy4J1vPl_QYBbn1tOM6Kcv0OTvsR5tamwiEoE4wtt8O9Z5_oCQ>
    <xme:E-g0Z75Yv8BmVMJm-iv8te0qbYhTp4u3VgUX0RV49jmefNpKt-dZi_jTiv8nHqy8X
    7oTMgoXERliT6I6PNU>
X-ME-Received: <xmr:E-g0ZxfVu4XcAzfqZG7SJTScVZG8jO9AvXXKqbqnzBrF5L9evz9_5sWs-uQdJHrX7jkJo6dUcZRW2k-VKsoXtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceovghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghuqeenucggtffrrghtthgvrhhnpeegvdffgedugfeiveeifffggefhvddu
    uedvkefgvdduueeuheffgffftddtffeuveenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhu
    khdprhgtphhtthhopegvrhhinhdrshhhvghphhgvrhgusegvgeefrdgvuhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:E-g0Z_LQg1pfFn_tEErnO7co55t__976ZGlP1zw8YnNOH9CraU-dOQ>
    <xmx:E-g0Z2InNa8sZha_korIydivMTgcS0yvApjqo16CJdSTtE7Mgbsi4w>
    <xmx:E-g0ZwxtQiZbcAWwPK5ak5-yscW4qb9s0DQ4bL7YhfSHe8XFTW2rpQ>
    <xmx:E-g0Z6LH7lnWmHH0hvCaerbdnP_DkUr_URzzDdwn5OdL20vAx6HMcA>
    <xmx:FOg0ZzBWnA-hhMjsf81Zo1_swPX0KxY5tDVHTiCivhhu6XXN1cWkK_Cw>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 12:55:31 -0500 (EST)
From: Erin Shepherd <erin.shepherd@e43.eu>
Date: Wed, 13 Nov 2024 17:55:24 +0000
Subject: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 linux-nfs@vger.kernel.org, Erin Shepherd <erin.shepherd@e43.eu>
X-Mailer: b4 0.14.2

For pidfs, there is no reason to restrict file handle decoding by
CAP_DAC_READ_SEARCH. Introduce an export_ops flag that can indicate
this

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/fhandle.c             | 36 +++++++++++++++++++++---------------
 include/linux/exportfs.h |  3 +++
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 82df28d45cd70a7df525f50bbb398d646110cd99..056116e58f43983bc7bb86da170fb554c7a2fac7 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -235,26 +235,32 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	return 0;
 }
 
-/*
- * Allow relaxed permissions of file handles if the caller has the
- * ability to mount the filesystem or create a bind-mount of the
- * provided @mountdirfd.
- *
- * In both cases the caller may be able to get an unobstructed way to
- * the encoded file handle. If the caller is only able to create a
- * bind-mount we need to verify that there are no locked mounts on top
- * of it that could prevent us from getting to the encoded file.
- *
- * In principle, locked mounts can prevent the caller from mounting the
- * filesystem but that only applies to procfs and sysfs neither of which
- * support decoding file handles.
- */
 static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 				 unsigned int o_flags)
 {
 	struct path *root = &ctx->root;
+	struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
+
+	if (nop && nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
+		return true;
+
+	if (capable(CAP_DAC_READ_SEARCH))
+		return true;
 
 	/*
+	 * Allow relaxed permissions of file handles if the caller has the
+	 * ability to mount the filesystem or create a bind-mount of the
+	 * provided @mountdirfd.
+	 *
+	 * In both cases the caller may be able to get an unobstructed way to
+	 * the encoded file handle. If the caller is only able to create a
+	 * bind-mount we need to verify that there are no locked mounts on top
+	 * of it that could prevent us from getting to the encoded file.
+	 *
+	 * In principle, locked mounts can prevent the caller from mounting the
+	 * filesystem but that only applies to procfs and sysfs neither of which
+	 * support decoding file handles.
+	 *
 	 * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
 	 * confusing api in the face of disconnected non-dir dentries.
 	 *
@@ -293,7 +299,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	if (retval)
 		goto out_err;
 
-	if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags)) {
+	if (!may_decode_fh(&ctx, o_flags)) {
 		retval = -EPERM;
 		goto out_path;
 	}
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 893a1d21dc1c4abc7e52325d7a4cf0adb407f039..459508b53e77ed0597cee217ffe3d82cc7cc11a4 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -247,6 +247,9 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_UNRESTRICTED_OPEN	(0x80) /* FS allows open_by_handle_at
+						  without CAP_DAC_READ_SEARCH
+						*/
 	unsigned long	flags;
 };
 

-- 
2.46.1


