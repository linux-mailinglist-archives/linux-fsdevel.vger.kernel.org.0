Return-Path: <linux-fsdevel+bounces-35700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF119D7304
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF6D1634B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD593210185;
	Sun, 24 Nov 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWLv1vUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8520FAA9;
	Sun, 24 Nov 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455908; cv=none; b=JZiR1QCGJauHexkxBun2mxRPdAsmpmw7TzMhV/lJYTPVTa0Ci+P88P9eq8R+XYjW/WetrFSY0AggGDEJ7Yab0SEYxM0uffAeUcWgCcpznr0oROXIdPSTyQqeBI0piZWqZPWHjfKGPl4OjcLgoeJHI8LFjVy+jal9LaFrKpPsj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455908; c=relaxed/simple;
	bh=C8K04Vp01127KZpkH0Pi2MRdy+GUfirK+wsgK6Ynj00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk02lL5dtjlpg33bS6iN+Mxsn1NdPpvUpsHnnUhKIgjpOMIehZDuRIUJFx+thciEdC1fBxAmYIvtTsFKMzZFKPv2iTIZycK6ZA7hE7WG19e28a38MGH2+Y/fn8nEBK68wr5SWO3uvQp2k5Y+lmsO71GCt1qi0SnYpxAcq2MeZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWLv1vUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D7C4CECC;
	Sun, 24 Nov 2024 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455907;
	bh=C8K04Vp01127KZpkH0Pi2MRdy+GUfirK+wsgK6Ynj00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWLv1vULgLXAeqWSKpTTGxkWezME6v58q/yB9NBbGKQw+BaFNWJa00R04hJI8hOo4
	 +8bqXEQJ66iyflKznMpvOFiu7t3BWKmz8rzdBEr8lh4cF7rD3XnCyhqgkkKlwRYWTT
	 /8Xn2HH0C8KE8f5RAmFxUgVKsk1Nt9WiS1TmhAlsUQGJCMLmBX+NOe/sFSZgGX9u0m
	 oDnx1fD6sj0tGsNSqZeys3RUUTSP7jdDUGsTSahaz2VcwuFixixCfpgX+TtO6iO4xj
	 zx4cvk2T9kwnzGRvfiVl8Z4PxF8astMfcXK/UwRzEMkcRQnqbtR0ZWOiU84/TzXkQf
	 8vZI/EDmyZe4w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/26] trace: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:11 +0100
Message-ID: <20241124-work-cred-v1-25-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=brauner@kernel.org; h=from:subject:message-id; bh=C8K04Vp01127KZpkH0Pi2MRdy+GUfirK+wsgK6Ynj00=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y5mWP3QvUdMRPtSwzOjfSbWUxf/Ozw5TfHap+sFd yr2xnOe6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE9gQLk4BmMgrVUaGVdxlb2O/LBVfbujk dJ3Bbu5Fntk3E/7ZVb2JZI6seLrSiOE3m1MvwyXO0Iiezu6Gtsn5M3p+n20O25rpdn7J1x9W1tu YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_events_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c54ae15f425c2c1dad3f8c776027beca2f00a0a5..1ec83a4f19ac038a8580391c291653ab822ce664 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1469,7 +1469,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 */
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	if (visible)
 		ret = trace_add_event_call(&user->call);
@@ -1477,7 +1477,6 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 		ret = trace_remove_event_call(&user->call);
 
 	put_cred(revert_creds(old_cred));
-	put_cred(cred);
 
 	return ret;
 }

-- 
2.45.2


