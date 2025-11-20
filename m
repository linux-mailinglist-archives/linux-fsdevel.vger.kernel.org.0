Return-Path: <linux-fsdevel+bounces-69302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0971C76885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A63461A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298430FF27;
	Thu, 20 Nov 2025 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfPTTS2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D530DEDA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677983; cv=none; b=rmD4iv+bPAXTcmcNj8BGgIRiOBJRPJiUm1QMPHRoyEQrDvncIcjJwWytIkk0TdXxTkbwBYTLFieq5i/mCqouYbhmxAe3NSeORfq5EAztDzQJhADitPRtN9k6zlO4fyYVa38ndaji+IAIMdR+yLISks957fDUpX0rfdLMqVow7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677983; c=relaxed/simple;
	bh=O/p+DAU+z/mWVpqFFfQxRVPgofM5NHa7WINMjCwWtVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WvFCnn+fjEy49V5tRbjK+rzNWiXxtZZDBO9h0bNYWZTfiX7buP7zPfqBM84yvvnQrkCNy+b3Z4BY2a1Y376H2ulso2vN7zge/2B0e32kAbNYYEgnxL7MVM+MI9bbt33w1FaXV3U2smR+G9WWQixlHptVzSH4G5jgWNngAPJpqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfPTTS2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C70C4CEF1;
	Thu, 20 Nov 2025 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677982;
	bh=O/p+DAU+z/mWVpqFFfQxRVPgofM5NHa7WINMjCwWtVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AfPTTS2WbHy+PGZxFnI4RnPauRBcvJ4FlpnatNeHSb5Ps1UKhky48hHRUjxP6S+mC
	 HE17dmUwzdDdA3b4QyzEQZz1IjTGzWqmqIiJBJIVKMyryhIGO7JLC+g+8hqoPrw2vH
	 LH8C9+i9pPptZNSn2j25rvQkSJmVqsgZbtOiM6eATruWvuogcFezsgaTwY7cdKJKy4
	 f+tv9gxTCNMktZXv6C494jHlhgooYjMF0GUi3L/nB6nUhIXG6Wew8jg3M+bUJZ77R5
	 s1AnGqM0VVf1CyIKx1BKxA59LWDwPw2dQxht3lLmyBZbG9tKJoBzgd+ef+uCWA7ACd
	 sJNhtKTHt9viQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:19 +0100
Subject: [PATCH RFC v2 22/48] exec: convert begin_new_exec() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-22-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=842; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O/p+DAU+z/mWVpqFFfQxRVPgofM5NHa7WINMjCwWtVI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3trHXbmyZ9tTfyixeuuC/OmaCzfwVuaqHdW7P8Jt
 6XbGqq/dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkYiEjwynjSUn38os+3Oi4
 NM+lcUeNDW/jDrsPM+wSuA51Z0of+83IMGEFn9nefyGtbM9sNyksOst9aiJn89GYWZllQY2ZF4+
 qcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/exec.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e08d5d..137d4c74c73e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1280,12 +1280,14 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/* Pass the opened binary to the interpreter. */
 	if (bprm->have_execfd) {
-		retval = get_unused_fd_flags(0);
-		if (retval < 0)
-			goto out_unlock;
-		fd_install(retval, bprm->executable);
-		bprm->executable = NULL;
-		bprm->execfd = retval;
+		FD_PREPARE(fdf, 0, bprm->executable) {
+			if (fd_prepare_failed(fdf)) {
+				retval = fd_prepare_error(fdf);
+				goto out_unlock;
+			}
+			bprm->executable = NULL;
+			bprm->execfd = fd_publish(fdf);
+		}
 	}
 	return 0;
 

-- 
2.47.3


