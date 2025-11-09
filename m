Return-Path: <linux-fsdevel+bounces-67612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F40ECC44756
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3B1B4E5FF4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC4275B1A;
	Sun,  9 Nov 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px4uighz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB2262FED;
	Sun,  9 Nov 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722819; cv=none; b=kbo15esUrpLAqz0rWdwvHwYM7XryryrfzqVQwJRPOzcJPD3DeR38nTZF9pUYfdYcRZJJmMMsu4sQ8sstWl0cWWAIvR2ggASb2Xnfmtn5BhLd0sjz5hf1Il6olgRfwkvgKGqtj3FdQ6UdrhJE7Pp0BuG9hZcqsVmDy36xhEcc7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722819; c=relaxed/simple;
	bh=4u/o3PQG0aiPE+oADFsMi+pBX0ERWY6h/lrCzyzz43Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyyrD9cirsdsKhDljT8QroP542QAEjlrk4W0RfcdnxF0adez+gNlOWsUBIEHkFYCCw8HbZ2Qjp0MyOwT6FwGBxRKfbFX+rIbntHk2fzM1c7XPuzE31MxrcH2395gTv61Y+M4bVWmeoUtrTIUynbVYV27+XiEIT/sduncktSNbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px4uighz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A8C4CEFB;
	Sun,  9 Nov 2025 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722818;
	bh=4u/o3PQG0aiPE+oADFsMi+pBX0ERWY6h/lrCzyzz43Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Px4uighz2xmr5yERGOhFsa04jTkOju8yjAXi3j59loeVbRuXklnY6u2q8//WLboQ4
	 jjvnVdAowgU3Ijd7KgJAsBcwp3wfwv9Bj7oBi+qGKjz4cY1gUI3Twvyq/zNCz642nD
	 2I+JelNTdDwzp+MKZlcjaYnKYdigYlxqqia74RpLQ+AFm67nyfDbWG5mjqm5OKNzRA
	 sqZZ45dhn98ypjE2F2d4OIiiIsIYpbN/bGv+nHLB5FEE8aZeA4Gt/BAJTYfa/Yu2ra
	 PgivPGU23OMylZzclt1tpgwzUREuxmeEnXCJchpedGGtXlKfoaqwiKGzqbpN0WAhsB
	 v1gB0XIf2NijA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:25 +0100
Subject: [PATCH 4/8] ns: return EFAULT on put_user() error
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-4-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4u/o3PQG0aiPE+oADFsMi+pBX0ERWY6h/lrCzyzz43Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr9Inpw05dK3y/bZK94LFos2bfX67GSxNOSKO5/3H
 I2YS3KNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZUMHIcH6efS/vvwlhfrLG
 yc2q9i+zrl2UsL1/+r3otphtq3me9jP805qvonj7STjzPB+XePOd0Xacj3UWNAZ3KGZE1WmFvGn
 mBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't return EINVAL, return EFAULT just like we do in other system
calls.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 55b72d4f8de4..f27f772a6762 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -584,7 +584,7 @@ static ssize_t do_listns_userns(struct klistns *kls)
 
 		if (put_user(valid->ns_id, ns_ids + ret)) {
 			ns_put(prev);
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		nr_ns_ids--;
@@ -726,7 +726,7 @@ static ssize_t do_listns(struct klistns *kls)
 
 		if (put_user(valid->ns_id, ns_ids + ret)) {
 			ns_put(prev);
-			return -EINVAL;
+			return -EFAULT;
 		}
 
 		nr_ns_ids--;

-- 
2.47.3


