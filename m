Return-Path: <linux-fsdevel+bounces-61268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B9B56E36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A5E7AA1F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CEB1F37D3;
	Mon, 15 Sep 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X7gT4Exa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTYbBvmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5341FE44B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902572; cv=none; b=RhlT4l4vD0kWpbiKSuaAO7q1Wf1i4NTp+PDJVjpYXe7x2I2Wt8t5l7mjpv/P0whsiQXWtG9Ll1EdUOwvQEXTIMq4NWjBr7Gh37bWa8bwVU4RUhNl0F0aGevP3XrbthskhGLCbhdNIfqJxNPVMOu/M6AWCfKgVsSJf/ZT6wW66rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902572; c=relaxed/simple;
	bh=vBI6JbCL6XKIQCCvg56AJrKD4SC1IVfXyqKSD1y9al0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC+elKHfD9pJ6DYA/5gHiBrWQ1IxjVQbSvuB7Fn/RMBHBYTcNs1GImUC1+JvYa6lsoFbknuX58WOViJUAAjckByl0dzCw0ueJabgEr9B1lXF8p+3j89KYpqYYjkB4PH0HCxj9h7NurzzTXHHtfG37mYIxsnLhzuRb+7glClpsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X7gT4Exa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTYbBvmr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1E7F7A0082;
	Sun, 14 Sep 2025 22:16:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 14 Sep 2025 22:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757902569;
	 x=1757988969; bh=5oFNDVMpcas02lxj1pK7XLFrlruUGw0JYx5Vy6mcZtU=; b=
	X7gT4ExaL3hHrq3bKsqFvPHVqCa5JpHZVVKE5tYsr6+J5J7Pr+uTYEiT/WZCw4MO
	qvYTfsSkz68QquJuwsQZjVrziYMdMub9yV7MoD3zh+4k2tgEbmeD/OlPvlN+5HaJ
	sKsBbTp99pMjQhftJlmRbyL87dJpaeL38H6QRnIqsEZhEoLmBwf1L+81dKrivFEU
	iqfbvd7VMiKvllqjds3SnBg+uOhwftjXtlCwT9LQ3qSlv6Mcg6uQPOYfUdgAO4w2
	WX4CZ/pwpJ0wILVsd0xLNdN2tEgF3+IORkvSybJlwqz0YTmv/MWK36yqPknufxoS
	ClunfRMDNT+lC80JotUFvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757902569; x=1757988969; bh=5
	oFNDVMpcas02lxj1pK7XLFrlruUGw0JYx5Vy6mcZtU=; b=eTYbBvmrKNsLkfe9E
	9iABH8wWaAF/sTDV+9Hd+keXlCH7KBjB8BmOYyCa3LrOPYsnfZp8Gk6VM/rTbrVN
	IMkksKIsh/URBP93qS/cIjkdIOL3bgcSXkfrzW8KHia3K0XKHF+2OGERsc2se1rh
	0QoWG6USbyCYe+f+wjtTYeamQOUzRRvLS88TN9jxPx56WbgMLRz04zcjXqBXBwwx
	8iPrutd05Eiizf1Nk98GlLmrWd6okHq0qPWxfT/x2xVupBH9WmF8Tg7DE6JRGu6N
	peqLmeR4P2Jf/lLQlae2AnLj+gE2vw0LI3gRXC+Ba2udy8qlzisiMIdbv2Iw2alN
	TKHdA==
X-ME-Sender: <xms:6XbHaGVUf__Y-V9nhG82Sg-IExgbw0Zvu50O4XvGSfiupi3nouiR1A>
    <xme:6XbHaJ8jLqA_Mws418x0Hx2KCP-9ej2dS2TyngNckhgDWoR74QgDbvb5EkKXkws78
    pdQWQb4iRvoQA>
X-ME-Received: <xmr:6XbHaP8ICF-xK1A57cp26Z4jmVJs6IhXtTg1apdzKSX9W6aACxf4I8KTdNe50MW3miYm3x3VljUr_kRhgFXsOxIBkB7untFbhY5HL5SDKM1L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6XbHaJTK2AacJKIyWGWGGaWRXDukZ6uzzN65fFzuRc_ETQC68EE2kg>
    <xmx:6XbHaDenbleFPNGsIbsYqvzx5a5gSZGE-X3o_KMhBd08wZbkDQuP0g>
    <xmx:6XbHaNBwwcRXUdhgDeVeVQieloCdBbsCdPt9ZyNUD4Bp9bclo_tpKQ>
    <xmx:6XbHaFlIxUOCshq_A8wyqtKLwfaercCeMn6FGFDwl3ckqbgmhKECPA>
    <xmx:6XbHaJOOBeeQqKUk3DmY8ABAcahaHohom_IBz2TBYDwTFig80neb__I5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:16:07 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/6] VFS: discard err2 in filename_create()
Date: Mon, 15 Sep 2025 12:13:42 +1000
Message-ID: <20250915021504.2632889-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915021504.2632889-1-neilb@ownmail.net>
References: <20250915021504.2632889-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Since 204a575e91f3 "VFS: add common error checks to lookup_one_qstr_excl()"
filename_create() does not need to stash the error value from mnt_want_write()
into a separate variable - the logic that used to clobber 'error' after the
call of mnt_want_write() has migrated into lookup_one_qstr_excl().

So there is no need for two different err variables.
This patch discards "err2" and uses "error' throughout.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7c6b255db2c..e2c2ab286bc0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4169,7 +4169,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4184,7 +4183,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 		goto out;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
+	error = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
@@ -4197,17 +4196,16 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (IS_ERR(dentry))
 		goto unlock;
 
-	if (unlikely(err2)) {
-		error = err2;
+	if (unlikely(error))
 		goto fail;
-	}
+
 	return dentry;
 fail:
 	dput(dentry);
 	dentry = ERR_PTR(error);
 unlock:
 	inode_unlock(path->dentry->d_inode);
-	if (!err2)
+	if (!error)
 		mnt_drop_write(path->mnt);
 out:
 	path_put(path);
-- 
2.50.0.107.gf914562f5916.dirty


