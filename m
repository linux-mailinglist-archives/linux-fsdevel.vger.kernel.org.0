Return-Path: <linux-fsdevel+bounces-45520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98FA790D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB00E3B2F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7D23BFBC;
	Wed,  2 Apr 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw4bV3Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DB23BD18;
	Wed,  2 Apr 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602906; cv=none; b=WWwwYhM5uiUd6ovuZhj3oRHf/qx1bSZYcobMJ2u8Ss+7aAj3GHWvOQPswJJiNsaQWmLe/ODE3XsWwLJfi3qhg5Eu0XoSnsPcpr42uncEFWMIzCm/T8GQd/J9uzfFzxGXoEUqCMqzPmN5iNo0D8dOZ2LWajjkCzuvJZxjy/0QUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602906; c=relaxed/simple;
	bh=zLuo91C8DjG6fvtrq/faF09Y89HMMWIPMTsbQdIE1Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN4tIPlFWCd9bP7tI7POCBdq03UIekNtJkx7o6ra2VyhNufS4zhAfaTCGp9JCiWEQdMqz9Vr6L+wSHueI8AyL3rFvfFxZaRCujYX8/8Kb3xfp02fxTpamlrENeOEZVLr5+iXLr1wTPpzwOan8zKxqL6/zxnNuj7DO/vsPEVozMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw4bV3Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9973DC4CEEC;
	Wed,  2 Apr 2025 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602905;
	bh=zLuo91C8DjG6fvtrq/faF09Y89HMMWIPMTsbQdIE1Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nw4bV3DvhfTPf0Mf2ryrVIl81+SK/sgYy0Ir8FN0iFCj91f69YELnvUB4F0mw2u0s
	 6ImRwCIToodpvr5uuRkDGHmrlVTQrh62ocz7TxD+30/GYZZ11iytPIDAkVNJNg9fPv
	 imaGODQN6CMysey6ndtl0gnTurm/RXcKEQtxhhFFjBCf7yyBurQ8tGWm/WvXPijRhL
	 zA4g1K5FObg8gxL9hN9sqcFt7GcpwUA29FwaTvh5Jti0ZAdjOjIK93tabIIVmHKUHR
	 rjr8Yd8K8xE/Ivtlhl7h3l9EDNcS93XHE43oAF3BCk3TOhr+d5HY55W7iW8H6fjg0b
	 w4E2okanIzisQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 2/4] fs: allow all writers to be frozen
Date: Wed,  2 Apr 2025 16:07:32 +0200
Message-ID: <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=brauner@kernel.org; h=from:subject:message-id; bh=zLuo91C8DjG6fvtrq/faF09Y89HMMWIPMTsbQdIE1Zw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/dVnlkFCRPmPT1WkXhVzbtZckhf3d+2+VQwqXav28n FfHb6TEdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdjzD/9jpJyafuHfFou9W hX2ZofiaU1UxjWdruM9cExF2m71bt4rhf33nryv1q1L44xns7rXOzLxiuEbL8lgGq1BItvLjfW6 VjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

During freeze/thaw we need to be able to freeze all writers during
suspend/hibernate. Otherwise tasks such as systemd-journald that mmap a
file and write to it will not be frozen after we've already frozen the
filesystem.

This has some risk of not being able to freeze processes in case a
process has acquired SB_FREEZE_PAGEFAULT under mmap_sem or
SB_FREEZE_INTERNAL under some other filesytem specific lock. If the
filesystem is frozen, a task can block on the frozen filesystem with
e.g., mmap_sem held. If some other task then blocks on grabbing that
mmap_sem, hibernation ill fail because it is unable to hibernate a task
holding mmap_sem. This could be fixed by making a range of filesystem
related locks use freezable sleeping. That's impractical and not
warranted just for suspend/hibernate. Assume that this is an infrequent
problem and we've given userspace a way to skip filesystem freezing
through a sysfs file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b379a46b5576..1edcba3cd68e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1781,8 +1781,7 @@ static inline void __sb_end_write(struct super_block *sb, int level)
 
 static inline void __sb_start_write(struct super_block *sb, int level)
 {
-	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
-				   level == SB_FREEZE_WRITE);
+	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);
 }
 
 static inline bool __sb_start_write_trylock(struct super_block *sb, int level)

-- 
2.47.2


