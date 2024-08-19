Return-Path: <linux-fsdevel+bounces-26306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0B9572F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803DDB24519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652A18A95A;
	Mon, 19 Aug 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5gdrmNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695E18A926;
	Mon, 19 Aug 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091499; cv=none; b=U3DTec2rVNywJ1+P672a8bw2IxxvfNaeW9w+4fC5s33e7UyX8NYY0U4cPV6h6EanT/XBgJOeOxurFg7gNcYwKYamTXwzgQd7I2hXs0qNLvWFB84zgLjTMv5LmxpcmBkoweAnULcxy7PiEp6aJDKySctWpCSvf7oIcbiimNur/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091499; c=relaxed/simple;
	bh=4Id9vBjAEGLNLirVxTLvWyzW2NSnZzaTE5XtB31TylM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRk2Tn2O6R9cp2jYl0pbCJ+X0/WXfvCH6cG6XbgKmUoyysmLusVx83xCyEBDFBy5nxp7c57VycA/9eVWZtuTIfJ5mPgfXjGJ2yMQkiJjklSyKEFISTWaxOkr1iWnfcVAF5zyQbGfxkiq4bJ/ZuYqjlP3GYORQzjINvgg5COEcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5gdrmNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23307C4AF0C;
	Mon, 19 Aug 2024 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091499;
	bh=4Id9vBjAEGLNLirVxTLvWyzW2NSnZzaTE5XtB31TylM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5gdrmNCvQV8weoBr6BEb2zUTY1Q7FFIH7XtTwbW1ZGQGXnjYZfv+zaHYbBb0hLYw
	 foCKKS92qTIfNcvlYTDvoVz9J+HVG00GM0TP/JDSgT8WtVCPgHqMsR2hDGar2q4wrP
	 0ax1LQ37saH/VKB8fPpBsmE+DZac+1eo6o9Kw4LdM6+kGwkogAeqycVLMf2lRGFvvA
	 lVWGypkUaH8EaAEPutgKPAOA5IDu114dDwvbgD8SCy5r0SZz4C5Zz6Q0w/Oa03feON
	 eDYD96QUbEKFNPz0xCCQGVqJNJ75OwgVv48O+zwyPfT6lTjOsbUON3817e/rN33+ZN
	 be+xNkVzej/Ww==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 20/24] nfsd: use GC for nfsd_file returned by nfsd_file_acquire_local
Date: Mon, 19 Aug 2024 14:17:25 -0400
Message-ID: <20240819181750.70570-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offers performance improvements if/when a file is reopened before
launderette cleans it from the filecache's LRU.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 56be99a3667a..447faa194166 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1197,9 +1197,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * a file.  The security implications of this should be carefully
  * considered before use.
  *
- * The nfsd_file_object returned by this API is reference-counted
- * but not garbage-collected. The object is unhashed after the
- * final nfsd_file_put().
+ * The nfsd_file object returned by this API is reference-counted
+ * and garbage-collected. The object is retained for a few
+ * seconds after the final nfsd_file_put() in case the caller
+ * wants to re-use it.
  *
  * Return values:
  *   %nfs_ok - @pnf points to an nfsd_file with its reference
@@ -1214,7 +1215,7 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 			unsigned int may_flags, struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(NULL, net, cred, nfs_vers, client,
-				    fhp, may_flags, NULL, pnf, false);
+				    fhp, may_flags, NULL, pnf, true);
 }
 
 /**
-- 
2.44.0


