Return-Path: <linux-fsdevel+bounces-60408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60052B46926
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 07:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746E61D203BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ADD2773F2;
	Sat,  6 Sep 2025 05:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pj+rSIFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJTT2eEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BB1A0711
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134866; cv=none; b=AfT0nWXP3vH+BWMvCBmEP6LhS4fqmcWiQDdYl2rMaf96U72i5PfAPL70Ma8bVz/ntE631UBjGzDANSm0LyG0FtpkG4mNKnO0Cwilh+NWVIUsdcFXYQ5W0iL/+xcKNDAxdqZ6VVX7xUPXEquSOczKp/cXoLzDiXAJrh09UhT3D4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134866; c=relaxed/simple;
	bh=tE/pHx+D4sUTzzvmFKp8+fVFGNODePqsYPQvDgmsbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpd/j0ZGxuSK+ow5TS96fB4Sl+9oHsNern6uLHsrnIL3B4P8BK3g8fx0V55DbuyZmuHS+b3oDjclSruLrQ9SR0kTtnRBxDiy9MIb/BTgD0IAI3F11Wrot/vy4PWge3uNIXSQ0ywSq+yy0/rhI+pddFuHx/tzKfW/UFLT0GXDKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pj+rSIFy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJTT2eEj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DBDA1D003A0;
	Sat,  6 Sep 2025 01:01:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 06 Sep 2025 01:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757134863; x=
	1757221263; bh=ln0LbiOH5iiG+2fODlhKNyOm4fk8chv+D6AkIb7wlY0=; b=p
	j+rSIFyQAvBY4TzvCOmX3DiCeis8rWEcoJzAoCjsYM2tBKLxkyZYsb/ItM771HBk
	OR9oRfcKlLajDlsFl7wlhvZkuJh/UMUdW50HO2DuBe1KdhG2qzTrBTTyGfADBODH
	phrfshCIXtaYctdGiacMU0YLnSA/mYxaDAJB1JzyMiGRNSuxSWTKyl4b4ot2qoC+
	2ztrRh8JPz/7Y8FK+7aDNaj9RDH1ju1wBMVwLNmWTwZPkZrr5kIF0BvL1BAra9MO
	v+EN81gSU4dLSwz4k27/JIKiU3V1b5aS9LxWCzwqCHcEpdD0L4blWzgxbiT6LsyE
	UOxyYBK7sRdDJRKF+ls+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757134863; x=1757221263; bh=l
	n0LbiOH5iiG+2fODlhKNyOm4fk8chv+D6AkIb7wlY0=; b=jJTT2eEjS6kypwTUY
	KiQzh3P7DDAvmDc7MAJgIDQuXbapeRzSkXdxNBh8IZgMjbQD3bc7SIKXxd8WTREK
	dSSHk3APLsZTfJoVgSGzTbGvbsBsNXGS69jLssZWgi49lvBwS2WpmgyJTg8h1bwJ
	C5f3I3QNDdFxS2Gyu0A1N2QColZVfrSvdyn7cxPD0nPKNfq6l0dL1omAkDOCNPcd
	LYg9lxgsPmgNZ6MF2/21kxBIOejl3uo42cSbxXgXfu8tPqJX37sCRx86ebExDhK7
	jIZHXLuTQkE33z0YsTVFiMQqmjSJzU4SODLGpiW9Gr0ufDzAfGmcefgtKAYzJs6D
	Papjg==
X-ME-Sender: <xms:D8C7aMLg8IekqbCla1ncrxV3lzm3qlj7xMVJ6LZmciZ9TKGp7ONLKg>
    <xme:D8C7aKFGjxCQHU2H0MNUvwCnY_RCBHZloUcAGVBdOdjVKtl2VhzPGdlFOLt6KImHJ
    LYkzNlsbmaIjw>
X-ME-Received: <xmr:D8C7aPD5UnjKgLyOnkhQwzSchGD6pJEde9781y5ZxZuDhYLUZuafZduf_vJxY81Aaiq62wxDrUfLVfzO3X7LzfmV3fmCA_dyYTdGnNLDOYCx>
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
X-ME-Proxy: <xmx:D8C7aN9l5Zl3wVLiO0BeBuyWY3SQPGwC0dQZBGmTusTkW-kzKwd11A>
    <xmx:D8C7aLAptM8h8FnbmmwxsTkMc9ClmCvsst-u45OY58a-Ggs6sCaeYg>
    <xmx:D8C7aCSv38GJsfq1SZmKQhPQRoGcidiItHRl_R9hTJjIsxIg8B0ngg>
    <xmx:D8C7aCsJ-L_5Z5pYFkiy2-vKrB73tLc8ZBH4hIIVEnYzuD4oyqO5fA>
    <xmx:D8C7aNPDzpIF1J3VWA1YiEgOWdkweXDFi1We9-jsD3xyFaY13FNq64OB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 01:01:01 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] VFS: discard err2 in filename_create()
Date: Sat,  6 Sep 2025 14:57:07 +1000
Message-ID: <20250906050015.3158851-4-neilb@ownmail.net>
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

Since 204a575e91f3 "VFS: add common error checks to lookup_one_qstr_excl()"
filename_create() does not need to stash the error value from mnt_want_write()
into a separate variable - the logic that used to clobber 'error' after the
call of mnt_want_write() has migrated into lookup_one_qstr_excl().

So there is no need for two different err variables.
This patch discards "err2" and uses "error' throughout.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b1bc298b9d7c..a8d9fa44f2bf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4168,7 +4168,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
 	int type;
-	int err2;
 	int error;
 
 	error = filename_parentat(dfd, name, reval_flag, path, &last, &type);
@@ -4183,7 +4182,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 		goto out;
 
 	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
+	error = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
@@ -4196,17 +4195,16 @@ static struct dentry *filename_create(int dfd, struct filename *name,
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


