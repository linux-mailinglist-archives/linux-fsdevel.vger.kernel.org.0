Return-Path: <linux-fsdevel+bounces-35822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC49D8888
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE13B376CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B61D45E2;
	Mon, 25 Nov 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VneWMKgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A81B21BE;
	Mon, 25 Nov 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543880; cv=none; b=AjgLOe5aGo89YqNW2sNsAkJzRnFnPayniASzrUir20uf+mVip8F1ihj0geSUUURoizdlV/PgqtMSW78QHqVWFgUk9BO//Iqu05FyEb8xZMCDDAjOvDx/or7VpcqW2o0ij6AWWmrsamNSZgIiJ64lC6ZtDHNsAO+xWtkF2iI2TMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543880; c=relaxed/simple;
	bh=QGQPjZpNC0Q49sf3UKqx2fuEWAqlGVH9NBRq1O/QCGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7HJgI7r2R42YpWfb/udhG/cbLT9AmN5uqdtjUyqMm7sykhF6Znh7debRtcaU/szRUOxRyxROELk0zSrIJ4csxgoT26LAAZ2pN7uDa3lTJ8QYLgNZF44kR7YPtj9KHY6lnexvBHR9OOjJNJf/ARGztstg+UwOCnQ+4QE8GgaJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VneWMKgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354CAC4CED3;
	Mon, 25 Nov 2024 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543878;
	bh=QGQPjZpNC0Q49sf3UKqx2fuEWAqlGVH9NBRq1O/QCGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VneWMKgCVQOm9iMZ7pp2vK5gZ7X53NCekEzKK9a1Jr4GrEKH8k8ttYhzkT4563t7Q
	 7ZAAqd2aG86CAHfQUoL/ssFi0jHLqRditnHxIMRCNzDYfWR05ZyNfslICT3Is9WT8f
	 MTUEogEG1YSK//f2WMBclr79cCdoW/1q4RpwlNl+Uu/GOwaeY4jVtMjMnx5EfhWI3j
	 TIiGsOM7Q0MLnKrCoYzt/FUrSkS8Ppl0549+7BX/lx++5hg+dbuKKyFbXctAJpsbqe
	 VkcNayLsRqdK8K5W5DGGc2Ue4d4q1QRkppED8r2Yk9ZvHrtCiPDxX8gqg6yWNtbdJl
	 W5DoQvJoXi4dg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:21 +0100
Subject: [PATCH v2 25/29] trace: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-25-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QGQPjZpNC0Q49sf3UKqx2fuEWAqlGVH9NBRq1O/QCGw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHqJ33zocjrghVa0Rt4Nw6wA9xU383OOC5etbbtbM
 Xv/h9blHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp1WVkaLVcbnpx4c/f/6re
 f5i5wnmJyO2kC57TD7Arb9TbGu/5QYrhnyqzQbtb1HnOI1xhs+YHWiqtlNRLD9Quyzzy2X4Sq40
 IMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The creds are allocated via prepare_creds() which has already taken a
reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_events_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c54ae15f425c2c1dad3f8c776027beca2f00a0a5..17bcad8f79de70a29fb58f84ce12ffb929515794 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1469,14 +1469,14 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 */
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	if (visible)
 		ret = trace_add_event_call(&user->call);
 	else
 		ret = trace_remove_event_call(&user->call);
 
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 	put_cred(cred);
 
 	return ret;

-- 
2.45.2


