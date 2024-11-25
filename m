Return-Path: <linux-fsdevel+bounces-35813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A831F9D8837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BCBB47004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F241C4A07;
	Mon, 25 Nov 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElVqWXj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF21C303E;
	Mon, 25 Nov 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543858; cv=none; b=FuXbAS3G+tJYMhGEjGHPxUt79Lp/rvY1ErrfJf1OZ/8IK8wax/iCREbuH3Vu/eqvyAp+uLPgRW1tQIDQIDZIiz7d9KuvOk1cYvsjl+uAmZjE9kaCWBdoQPvtZB0GuYz19Wh4pmGdOsJuizFT95Ex8RzK8eXzPtyUSUYp++oXr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543858; c=relaxed/simple;
	bh=E/xuZiaaXUS1dUjJCcyg4g+UNuKLiuXMKNRl4YbEaOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMqQ5NmfuiETg7Le4xNc561sg5yVBW+vz36d2vYlfCl50qV0OOjzuwuVNQEk4MLEf3wDm7+lPvCJWwan4/RMKmKN9N/RQd7hqrdgcG38qWAK7RjxrqQAIv0wIeJn4o5GWhdUmoZbqY7FbznkSrnbyQnBdgLHd5BtDvYILZuBTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElVqWXj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24420C4CED2;
	Mon, 25 Nov 2024 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543857;
	bh=E/xuZiaaXUS1dUjJCcyg4g+UNuKLiuXMKNRl4YbEaOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ElVqWXj6qyF8vO59t7q5N8a9Tzd1B4KnsVDU2TDzOZ9A5Yft98+hWNPwMTRINW/h3
	 wDe09MqwT4OGrMF90NAulb01ayXRrzfvdd+ZT18/taXZiC19ZiKTD/4B1e03p+Gr5H
	 qKdP1FSVWtKoqJi1t4iCtLiwLbpQe4b9QVSq+HrAhAWYBtuihEV9exVrhr8j2qGnKY
	 YoEhazeQfS5Uuaz0ZXH8bzQesKaPZmMBq51VjmyOXO7pUrkJZN+/5MXwQyN1XLDe0H
	 6Ftsv7VJB1gDy6maKOvsYPvtCwzTHexOdZ5HoQwmGIfM3ud0v/WxwunL63SqdQJ1y+
	 nTDw2MHhHMDEw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:12 +0100
Subject: [PATCH v2 16/29] nfsfh: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-16-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E/xuZiaaXUS1dUjJCcyg4g+UNuKLiuXMKNRl4YbEaOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrOfSSyj68hk6nAe579Ph+lxdpfX9c/CdJMY5O0b
 Da9sOh5RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER08hgZenZ8+X+pj7F7y+T5
 fs3MC1d1q5m+zn0mXnr1v8QV5s9ZzxgZ7j96JLl4zjav15ddnz5929UVyTG54MpLsS11mRqzODK
 cWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The code already got rid of the extra reference count from the old
version of override_creds().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/nfsfh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 60b0275d5529d49ac87e8b89e4eb650ecd624f71..ef925d96078397a5bc0d0842dbafa44a5a49f358 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -221,8 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds(get_new_cred(new)));
-		put_cred(new);
+		put_cred(override_creds(new));
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)

-- 
2.45.2


