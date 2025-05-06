Return-Path: <linux-fsdevel+bounces-48229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D934AAC329
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C804E7A06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECD27CB17;
	Tue,  6 May 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEP27UP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153A27CB0B;
	Tue,  6 May 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532563; cv=none; b=ruErTGMDE7BjX16NCnotWFKy6rCYKiW4uAUWq+TsTzha3O8sZXRQGgg36nMo+PSb1dQWBsCFa3Nt+OHSdYOHF/zUrtZmJMMh9PZwRtYpP2qrWJCPnnzLBpXOA5RxuW67KVa+RXLQs9CxUOpB6WEfUZ3/ORD/EQZU3LmY89/QPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532563; c=relaxed/simple;
	bh=wkLpQXzGAXHdGAr38No8C2VE5KifFLlLwwTCYQNol9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLboNMEYJVw5r9xcO+5pDPm5XU3gl9sZk8WaKUYpwlLOClPjXA0nay9f2/eghvoCbp3JSb6R2HBjXpykhMFFJ6SQpXKtgt6vo/bXizybjt5NrEQo4e8JIE7h3I9Dis9sVbJdqqBOiWo5tEtEQ4yfSZ70aD+HtZla9Jd9I0d0QkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEP27UP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EEDC4CEE4;
	Tue,  6 May 2025 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746532563;
	bh=wkLpQXzGAXHdGAr38No8C2VE5KifFLlLwwTCYQNol9c=;
	h=From:To:Cc:Subject:Date:From;
	b=mEP27UP/BmEkNHYglu7YbuBNHWL2kWeo8vvpmlKR0Z/fnee4BcMP76ULSI2xHQ1d5
	 muCKs/Jb/UtWoMzf273qi1fDnmgjNerKXIKvwftb0PpJ4pjDoy/bdbGGiLL/fcIm+n
	 YLkunHArPgJoOj4+iw8pZIVd2VQeNwvbRfS+WP6gcMHHBUr0rrxYzbMwJHHxKn6sZP
	 GlR4FtFYnWQEViG3RkGkczLtqVuCVZ9GWPyzGqAUnDi0fpy7GbvdL8zhdFyPtNLWKl
	 IXJk5ouAqjD3gBFd4gBoFNmhCrM5hfqz2uC8lQRUSver+gtROOQeSTW8XEjH7Wcdkw
	 kupm3KAKHmg1A==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfs: detect refcount bugs
Date: Tue,  6 May 2025 13:55:54 +0200
Message-ID: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=brauner@kernel.org; h=from:subject:message-id; bh=wkLpQXzGAXHdGAr38No8C2VE5KifFLlLwwTCYQNol9c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRI/jgtsMHb7dqvroSS49NnJCy9XnjtUyjLe7/YVJ3LK 4RfsYXFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkQI2R4X2vQV5c+44IiayN yx4w/V5zddpilUKFdRO2TpE5sHnpNkuGP/xm+/s01u9TqXsW0Vp0v9uC8cm7S2W/VbO01n87e0h jNTcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we have pidfs_{get,register}_pid() that needs to be paired with
pidfs_put_pid() it's possible that someone pairs them with put_pid().
Thus freeing struct pid while it's still used by pidfs. Notice when that
happens. I'll also add a scheme to detect invalid uses of
pidfs_get_pid() and pidfs_put_pid() later.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 26f1e136f017..8317bcbc7cf7 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -100,6 +100,7 @@ void put_pid(struct pid *pid)
 
 	ns = pid->numbers[pid->level].ns;
 	if (refcount_dec_and_test(&pid->count)) {
+		WARN_ON_ONCE(pid->stashed);
 		kmem_cache_free(ns->pid_cachep, pid);
 		put_pid_ns(ns);
 	}
-- 
2.47.2


