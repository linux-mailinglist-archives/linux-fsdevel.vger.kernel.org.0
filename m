Return-Path: <linux-fsdevel+bounces-66745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B7C2B6FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 607D64F5FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62FD30BF59;
	Mon,  3 Nov 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbAi9WBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E630B524;
	Mon,  3 Nov 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169263; cv=none; b=iICZCztfF7Gyf7lEB3cn7pYdI1W/7j1D+1kPKI4YbS2vC1JF24s1Qn53z9xup8HAj3N1DVDuIjh/gjady2OksbE+YRnpbGuJgqRx8tAmFfUaGJtuoAfuGH9v90ObcH2H6mbFm+hAWI7LkFVuF89lGeZSgPfsbJ+YVJoBAx1HkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169263; c=relaxed/simple;
	bh=8jsM42EFf4c9yOO+A2KOodgf1ewjQpXoGxD8DKkZDoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct9luU7kniqpoegOqunqnExKK4aMBVqry0aK6yew6EFVXM12N2Kg6Jp853jL3+kQhhSOJntfI9Xoo0MFSeCkWK2pv81vCoYKS+bXOMscv3CBHxJrREWGa5AZJ0+92KfWfjFCBS7D06x3aPTc3Ps5Lony0sEZ0Qaqiual9GVUnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbAi9WBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A109C4CEE7;
	Mon,  3 Nov 2025 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169263;
	bh=8jsM42EFf4c9yOO+A2KOodgf1ewjQpXoGxD8DKkZDoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbAi9WBHffHsH+Y9i4zEwgXGAIiJkLuU4I+HseYDgpqTCTPTC4jOxJ/zZUZ5zwjIv
	 AJnUHU9QLT9QwwAEE5tloDBUIKvCHD3verXxV4hMa02aXBOKbWgHdlKty0QYCpdXpW
	 3Ifm6xh7AQdPJsNCk5uRCEygGiUxHY9DAPFacy9ki7uVzyHze8Sj+E+LXUbFxtAEHJ
	 GdsaJ3uUOHhyuAPkJ4dtaUpiXHG/SjvRIuRuQHulLMUTEibpTwF1bUXJxV8MqlR4pW
	 4o6yWUebx2bMZ9we+Y6QHTIvHodYlxQ1H7j2dd9PzCAqbHYax4rP9lp4aZkxy1S2Hs
	 54jUU1Y9ewvIA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:00 +0100
Subject: [PATCH 12/16] nfs: use credential guards in nfs_idmap_get_key()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-12-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8jsM42EFf4c9yOO+A2KOodgf1ewjQpXoGxD8DKkZDoc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz/8FlG9YDSAfX+gxrnPsoU75DNi/u4Js3hnvXDu
 fsfFKe96ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI4h1Ghofx+8P5r81wY7Tw
 Pqs/Yab/mnsf9pdx3eXulD8ZphDZLcfIsHdXoNyrEO2lryvXNolyp1mxdn4pSFe3vMPLe/TRy2w
 WNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/nfs4idmap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 00932500fce4..9e1c48c5c0b8 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -306,15 +306,12 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 				 const char *type, void *data,
 				 size_t data_size, struct idmap *idmap)
 {
-	const struct cred *saved_cred;
 	struct key *rkey;
 	const struct user_key_payload *payload;
 	ssize_t ret;
 
-	saved_cred = override_creds(id_resolver_cache);
-	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
-	revert_creds(saved_cred);
-
+	scoped_with_creds(id_resolver_cache)
+		rkey = nfs_idmap_request_key(name, namelen, type, idmap);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);
 		goto out;

-- 
2.47.3


