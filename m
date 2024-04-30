Return-Path: <linux-fsdevel+bounces-18274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB28B68EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776111C21B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147110A3F;
	Tue, 30 Apr 2024 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG5SGk1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3ADDA6;
	Tue, 30 Apr 2024 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448135; cv=none; b=IKzpz2ylDIEtN4Wg11efGkYxbtXPwQceie2vxTevmj41SsIthhMzZ40BIsrvnXgYIjYYsPYzdoPGbFo1OhkpgYqRQUAO2yoFmDMBUgkIYMe+qUG0VmhYaudDxqVzWr8n+crndNw0W2IOLQfngR4H2pYRN7GLufNLPye2sFfpFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448135; c=relaxed/simple;
	bh=gF/luiv8AIQ2sZ7JFnjtvfvXqCqlLavZ1Ynx0PcuKxQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eloc3bl+feJ7eipxeyuEpPJgnpbF/IQygDmfXB4KOn7eMHpqWm7nL9JSZgeNrCOUPMts5ZmZn89OMkuTDcAqTsf+SpCenhRw9BGZTG2wt0apeDeTpnDk2cBeyP3WWYuPPwOMXXhraEaWyKxvx2CSeYmFxNkuIEiWPHczmjKiZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG5SGk1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63199C116B1;
	Tue, 30 Apr 2024 03:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448135;
	bh=gF/luiv8AIQ2sZ7JFnjtvfvXqCqlLavZ1Ynx0PcuKxQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rG5SGk1erHiqwiOObiUaOgs0Mk34u8unIfCRte7TMyWKAm+cK91Iub6R6BmaXetVS
	 8oaHMQc0lg+ykAt+kTkxaVUhTT+XQfTaJKGUCuDj+rjJxUPq5pjqR5g+Ik9NVS4XKv
	 h0tqTX35k4Xd5jBS4h6iE/uHzac21dLkw0owaFbGVsnV+L1RQOT7vnG4vsY1iFmTds
	 W//KMjBzDXOhc+GwcPQXwNBSCNCvdsm3hiW5CExPHdfTbGM604AkY8Nff5F9Fe2ZwT
	 1iCO+17Vxuj3qn2+vUzCt1IHwWTldSCW54Hn9mInMuJlCBZ1Oim2sDvY5WUmN6pmZd
	 NYmiHgvzO0PPw==
Date: Mon, 29 Apr 2024 20:35:34 -0700
Subject: [PATCH 18/38] xfs_db: add ATTR_PARENT support to attr_modify command
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683388.960383.1844285181071756130.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add the parent namespace to the attr_modify command.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/attrset.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)


diff --git a/db/attrset.c b/db/attrset.c
index cfd6d9c1c954..915c20f8beb8 100644
--- a/db/attrset.c
+++ b/db/attrset.c
@@ -445,20 +445,23 @@ attr_modify_f(
 		return 0;
 	}
 
-	while ((c = getopt(argc, argv, "rusnv:o:m:")) != EOF) {
+	while ((c = getopt(argc, argv, "ruspnv:o:m:")) != EOF) {
 		switch (c) {
 		/* namespaces */
 		case 'r':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			args.attr_filter |= LIBXFS_ATTR_ROOT;
-			args.attr_filter &= ~LIBXFS_ATTR_SECURE;
 			break;
 		case 'u':
-			args.attr_filter &= ~(LIBXFS_ATTR_ROOT |
-					      LIBXFS_ATTR_SECURE);
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			break;
 		case 's':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
 			args.attr_filter |= LIBXFS_ATTR_SECURE;
-			args.attr_filter &= ~LIBXFS_ATTR_ROOT;
+			break;
+		case 'p':
+			args.attr_filter &= ~LIBXFS_ATTR_NS;
+			args.attr_filter |= XFS_ATTR_PARENT;
 			break;
 
 		case 'n':


