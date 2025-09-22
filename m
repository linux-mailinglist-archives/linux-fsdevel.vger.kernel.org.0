Return-Path: <linux-fsdevel+bounces-62359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA6B8EF0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2EB173F24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5D1F4E4F;
	Mon, 22 Sep 2025 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cYDVP2zI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P401ZiKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C501E0B86
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515611; cv=none; b=pAJ4bXyt1uS63O4qK1IcjqBqZT/JR6dVsNoDOu2MTSrKWTYrBD04gjmoAKKNbXRZaA2KNWkUo2TJzKjcvwDXdle7WFacXjNn47+Ehv1TctCwNSLZkC58kwT9G5DBU5oU8IHeHDO7EwpVHlVuKRKq77GNfL6QUZmFil8meNXlaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515611; c=relaxed/simple;
	bh=vBI6JbCL6XKIQCCvg56AJrKD4SC1IVfXyqKSD1y9al0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjTHJlAdtJia/Hg4xOoFcZp1PGoO8wpa+XDDtQ2CLwzXHSbQSj+EImAA5fgcoeV9HiwOa5Rvx18LgkObO6feh41U/jPlRMXvjZas9K4TAdCWII93Vrn9tMMId5I3j42ImqZGHd57u1EXVmmktxPjBCQXYzffiqLAHfm1czp2AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cYDVP2zI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P401ZiKn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 354D81400065;
	Mon, 22 Sep 2025 00:33:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 00:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515608;
	 x=1758602008; bh=5oFNDVMpcas02lxj1pK7XLFrlruUGw0JYx5Vy6mcZtU=; b=
	cYDVP2zIt/cyiXRL88+4wg3hX1IdiZL9B0MkyIz18Fyp9cRL7h4aNv3y/7mFUcGh
	2nVIG+OqXUtcmVnfolEphvJTxCC3L1vs8EgeeXSJAyA6wS8th53i6cRD21Zq7ZeL
	I5n9B1pUf41O3hgV3uxfhUtQM5upUIYqZmdXMJCHexZs1z2LT4HLETeqlfsKaLxB
	EuOA4YV+Tvr7S7K0UAeKJlckqQ+y7gUjLL4S/jAIeiAGlWelQ94BobL2DS2bxvfm
	Q4YwYehh80zH0ebBDDNhM6x6t7vIpPWsVJ2eyQlrifd2k/IXOGQQPB+yg3EH+5Wd
	ZM80GBxPCZxqQA754FbC3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515608; x=1758602008; bh=5
	oFNDVMpcas02lxj1pK7XLFrlruUGw0JYx5Vy6mcZtU=; b=P401ZiKnrMSAWULqe
	J3k1SoOwkMGYiN4H2IwtGMi1Z5iqJ/vsAbW+xvHwNn1kQvRi0uZVHleMiy4/6NyN
	UH6J6xNS+qhKXyBDAUcydM+ICAoB//7O8oS+SBblzeHaH7C+q3+H41qLeopQWyiz
	XQdp315NwiJ1qJIVoyDbIZP3RFW9xKQOde3rcrEy8DTO/BATm9Rnp4/jlv4djkaI
	R9k3ieqfzehku20HE9jpZFIb0ynUlo1MjO6aZebieTlQZ4CsEyXzioWRvUOwkfjF
	D+7HZ6F4F/MtgCCjIL2ALBHGFuKkiXnH/51Ax8jWNqsYHu3aeT2BM7xyAZ1ftJNQ
	7zcFA==
X-ME-Sender: <xms:mNHQaIAn0aSFei3pIYbNImdzE_8PBbU1xzOPSEIRdQtt1hGpy3vCIQ>
    <xme:mNHQaB5Ik46GslOIaoSSa-BzCNqoT_A4c1SbC4sUYH5Jv_-EEjD_vqJ2pSHFb0Fx8
    ugoJzIeHWsilw>
X-ME-Received: <xmr:mNHQaBKt9oXXQJV1wlLNsOY7ueGlUcfMtjStyqfHbIvcAKqqp_EdIvmRtWo4K2iUO1YZtT_4pA12F8wfZS-h7aQ11XJ9_bQhEHzsUwXgCLfr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:mNHQaKu4Yb3bhx5S8WSmEDHtin0ds6BKz0sLhxkGzkuHxkjhtkPGoA>
    <xmx:mNHQaAKx2ISufbR42wVVphZahOnFle2Orst_bwCizdW9PYJzq1NJJQ>
    <xmx:mNHQaD_-13CpviLKDtn1E9uXdKJ8JGfGgNMc4j2m7M74syQHx0rJmg>
    <xmx:mNHQaJw6xXD2EhIRu4Ei92Eq49uIjweXJUnGosjGh8GT7Bl7kdc0RA>
    <xmx:mNHQaLZOC-RY7kValSJ-yWX3nF2S0JRBMlazMt9Hoib5YPdRE9JI2zBP>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 2/6] VFS: discard err2 in filename_create()
Date: Mon, 22 Sep 2025 14:29:49 +1000
Message-ID: <20250922043121.193821-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
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


