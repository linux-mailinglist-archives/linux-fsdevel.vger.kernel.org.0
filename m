Return-Path: <linux-fsdevel+bounces-60611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73649B4A0E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD9E3AEB2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157742EBB89;
	Tue,  9 Sep 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Riu0EYjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwUZsTd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A682E2851
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393316; cv=none; b=R3QAvF71FGGEorg4qUMybKDkrjJlw9iwSFdyCZWLhQ7f99u3seil7nsbtvbuPb0D+mucUe2ZCehJK7EuiggnYeeGlu5FJP2F8UHDPE1hJ/4iyQOpDmTAsfF1rW/cyrpU5DYyKXmdjoOl34bRMnSQBHsH3lfeJrDmck50uVgTAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393316; c=relaxed/simple;
	bh=BMy9d0IyApd+SnXJ/bLmtqVWl07fXaNYN9xQpQrpl3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAVmoTiglKSa/Zw16yZUemcHim89BrW7AQqSuz/WmJdGjqsC+USukkPzzUp5fez6fPeysHxg3j2Vdls3A208L8Xy6UPWiQ3jrtVUr8qWwZ7qctXpR1NQhiJPK/KkK98W2a57mrjO4ZRDJIZT0INnMi6eQGX/Xed7J3RNI1sfghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Riu0EYjt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwUZsTd8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7BF37A00BC;
	Tue,  9 Sep 2025 00:48:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 00:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757393313;
	 x=1757479713; bh=qEDo0hjkI/hqvktGfUp+aH0CTBV42DoqNmSS6QiM2do=; b=
	Riu0EYjtS9ZLFfo0CR1YrtbinHi16B0g2nmQAw/Bfx3Sug1Pb8zUOFS3byIH8C+1
	iCH2aNMfPRgoLAY1+iroVUe1ZViuEgcBswlNTIS5RTEKA8ZWO82y8pewJO3/QdnL
	LgCbfK/Ae+lHdxMeTIZEnaW6AnGGZYr3nBgzMVdYffAPbmC2y/GPaPFpH700Nt+S
	5z/mdKeubcGl0HGuuj0bPFn/GwYZjuyd0/SwWr1/VsZ9xc/n/bDIT6+18cmPzq2U
	GaplN56iZFB/b9BmgSdiO7iqMLDJ6kXIHmvBbeSMOH9c7SVNXbks+aVglcZd5zRp
	KKI3adG3mWmTWEId3MZv5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757393313; x=1757479713; bh=q
	EDo0hjkI/hqvktGfUp+aH0CTBV42DoqNmSS6QiM2do=; b=iwUZsTd8K+1HEp9t1
	8Pra7x5P/t2ba+G+OWb5G9bmJBEZqAOLx7nmNAStqtM3i12NP1olP2xHpXSmZaDI
	XQqNhf2TRMzo7mejweYJ4XJpIYW2N2MUAvPdiOy/H40JFkpSxSPIX3to1IVuMAIL
	ZK3QM5uyqCmRoWj4Z25kWbgqBJ1q83n7c54N9nBh6/ympGfOsoa2KxfpCE023k/6
	FW39gOmydU7dkuGxGHAu0A2/UyUKB5bN2/uZNG2zWkQ+4z2u1GP0PP7dbQlhuItE
	UktFOymIy/RwSPsn0AT7vf6vz0zZph27dDYMqCpdhOuSi2L3jBmKTL4PXSIDQ8VT
	MhfDQ==
X-ME-Sender: <xms:obG_aOpHZXuJhbr9zN2L-WvH1sB3Tf95IiUB5zmPQ25auUoHw-VzQQ>
    <xme:obG_aEBRfM4Lk-I0BJWKQqa67De6g7-pz1gkkagIwDaj0jGTXNHNp0S76V92kMnXT
    R76JuLUSarwNw>
X-ME-Received: <xmr:obG_aIwcvAHeaJi5SVFfCwmPu66Y5DTMra3AzZZL6ywnvyeKS0pF48RGDDirrpI5f8217lydpxJJcQ8xpXMWzn9wvqH_Jo-B9wGf2DSmDxCu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeglecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:obG_aJ3LEWPnq4Rd8RS7DU7SMnZSQTmEqoFH4FmYOlUhEFjsUVn4Ig>
    <xmx:obG_aAwu7pRFyWlkPu0NSa51629SSdxcrmFDydykBzotAL1n2lXxiA>
    <xmx:obG_aIE3jYm-FYdZre700CrgEqJs08Uh6AdY1MoQN8tTlNCTTmhrOw>
    <xmx:obG_aLbnN8wjK0lFSrWcKGC-JvZ7tDWIC3k80ncNx2qsbvFao77d2A>
    <xmx:obG_aBDk-BB_bA7MRGMyida64W5mdzKDipaVPrHCYkdl1ZQtt-hvgFax>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:31 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/7] VFS: discard err2 in filename_create()
Date: Tue,  9 Sep 2025 14:43:16 +1000
Message-ID: <20250909044637.705116-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250909044637.705116-1-neilb@ownmail.net>
References: <20250909044637.705116-1-neilb@ownmail.net>
Reply-To: neil@brown.name
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


