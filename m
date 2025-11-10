Return-Path: <linux-fsdevel+bounces-67711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DCC47793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B73B0F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF7328B41;
	Mon, 10 Nov 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlw7E5lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8430506A;
	Mon, 10 Nov 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787389; cv=none; b=aDiEPk4FbnS9FLnYmzKb0U6pNHM4qmnKkfmF6N7w6DI20d69upLflFJiNvCYHZe3Z8Rzpk8jb8U+xHaITinTvgZJ7STfRnTrlcQaIvbnKnC93Qzc7ghAXoUO2LjFbyySKjqGUqkdnOfiaIZTQ+EqoUX3x05HUHo9zga7dMa8LH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787389; c=relaxed/simple;
	bh=dZSc1guTC2/uM+g+SjXe2PvJ4m9+xTNeaSFMoTViLHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL5DAZUGESh3GR68g89d7BURdcjVxLUc+URA2/6tN4Z5YW52b/sWwlB7/3uj1F1xzaZsJLJh3expNytktPF3s7S/FbkNXzt5v9fIX3+bU5qHCYJapxy5NwAvQqbSkdIj2fS/M+D9eSJvwsqdXlkNccCanBVcZ+A0ZekdUgl0It8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlw7E5lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B99C4CEFB;
	Mon, 10 Nov 2025 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787389;
	bh=dZSc1guTC2/uM+g+SjXe2PvJ4m9+xTNeaSFMoTViLHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qlw7E5lblIEKi0aChIXt0k7Uk1U2yAxNDAp3eqNQjjWD9RWJF2tNQJGqhjCcFQp+z
	 ENgUjGqbbvgviGBZbJZptqhi4EIWRpNBwsOPKFPlX+SErgY8LDP4NUuJHR5v8m5CaE
	 eVOpQX3xWZUizKeTN0QWBXiPdB3nAyS2vj3MaQTMtheLkshcG7xtO/BkyAJtAUM0lm
	 eslqeZeez88/LxoWACbhAO4ZscXvhmakhliQB2bR/KAwwAMgXoH7OKXdvFT5dM9Saa
	 FWeFTBIYTiqbUm/6utoenkWiZGBmVeHlCTLoBr0wt3m9t032GcwnL9rhDJu20nZuPO
	 /dhdr3kdy/RpA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:25 +0100
Subject: [PATCH 13/17] ns: add asserts for initial namespace reference
 counts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-13-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dZSc1guTC2/uM+g+SjXe2PvJ4m9+xTNeaSFMoTViLHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+8PdR+0gFZr2ZZTqXa3T8rGnt8eFbU7wh5apiq6
 b3+2W/rjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImIGzIyfMg8f6RqmdYlz+7z
 CXEKaxT4nzXNlvp5bkplR1/5u/nxbxgZXr5+4fgyPFl+dpH3lvj7xtM1WM1MXPu2uKVd5fid6Hi
 BEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They always remain fixed at one. Notice when that assumptions is broken.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 5b8f2f0163d7..dfb6b798ba82 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -60,10 +60,17 @@ static __always_inline __must_check int __ns_ref_active_read(const struct ns_com
 	return atomic_read(&ns->__ns_ref_active);
 }
 
+static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns)
+{
+	return refcount_read(&ns->__ns_ref);
+}
+
 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
-	if (is_ns_init_id(ns))
+	if (is_ns_init_id(ns)) {
+		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
 		return false;
+	}
 	if (refcount_dec_and_test(&ns->__ns_ref)) {
 		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
 		return true;
@@ -73,31 +80,32 @@ static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 
 static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
-	if (is_ns_init_id(ns))
+	if (is_ns_init_id(ns)) {
+		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
 		return true;
+	}
 	if (refcount_inc_not_zero(&ns->__ns_ref))
 		return true;
 	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
 	return false;
 }
 
-static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns)
-{
-	return refcount_read(&ns->__ns_ref);
-}
-
 static __always_inline void __ns_ref_inc(struct ns_common *ns)
 {
-	if (is_ns_init_id(ns))
+	if (is_ns_init_id(ns)) {
+		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
 		return;
+	}
 	refcount_inc(&ns->__ns_ref);
 }
 
 static __always_inline __must_check bool __ns_ref_dec_and_lock(struct ns_common *ns,
 							       spinlock_t *ns_lock)
 {
-	if (is_ns_init_id(ns))
+	if (is_ns_init_id(ns)) {
+		VFS_WARN_ON_ONCE(__ns_ref_read(ns) != 1);
 		return false;
+	}
 	return refcount_dec_and_lock(&ns->__ns_ref, ns_lock);
 }
 

-- 
2.47.3


