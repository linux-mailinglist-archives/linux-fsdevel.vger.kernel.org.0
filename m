Return-Path: <linux-fsdevel+bounces-52121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41FADF816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC93B0F09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9321CC57;
	Wed, 18 Jun 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSBSWLcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996B1B78F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280038; cv=none; b=dRxWfs3BDRS8mOG6jZnmxwASTWANdO79q+qMavtdFUxID08zJbrfTpCN2Q+H7QZt2nz9IEaNsul7HghhgCYhEIcBrX8qkEZVjkVfXNw3kWnQLhqDr4hwV6UreHjv1seT/u1e0hUJYCbq3pR+L+n8ly0u0fco5cfEG+AjMQWdw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280038; c=relaxed/simple;
	bh=SU8D1Jhz8AAI/kPfwm5WmN5INeSUVRddtDqEi3ZWC4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCfHXMEEUVLFWLEOdBg59t45ZtCzejOB7ZuDGAUusdDPk9NZTewMCQ/lVFZfu3HHevY2YnYdPVZ0N8TtG6SA1Dyc9z9MmWM++eKxyos7VHpT5j0B5o4m+Xxh7JDq7KwbUy2sG/SBUQYNkAgp3veVapEfStv6SgZtbtJ2dpJNZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSBSWLcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E2CC4CEE7;
	Wed, 18 Jun 2025 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280038;
	bh=SU8D1Jhz8AAI/kPfwm5WmN5INeSUVRddtDqEi3ZWC4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YSBSWLcSsXZHYJxIl1uwTVJW9UIwdb5QSlv52WNww+4nrhKUBKzHp6CtBiHDsjpq0
	 bA/vcqmCtHLOJGzRw1BkJWyp7K0FhX0G5B5oBjO6bD6ZjGcLm1p8eN+n7Ns78xcW8l
	 TBK/5ojOAY+o/tDjmWsnvAlGJ8l3XESdtKNkdpSsdS3qBH9hS67+uyVv15H+XQzMXO
	 OVQAjCAmrUQa40b0bDQ/++TPqYDPxs1cbIYIFYzRS5OxmHagcmGatTcMWjlw4VQcnO
	 v1WpqYUzX5UgV4x4w3BVWlCJX+2Fn58v5wrCLjRKp7hWdHhogzOsmDO62mFE20/fmX
	 LLgQ3/tI+IZzQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:38 +0200
Subject: [PATCH v2 04/16] pidfs: move to anonymous struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-4-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SU8D1Jhz8AAI/kPfwm5WmN5INeSUVRddtDqEi3ZWC4Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0ce4THbJXx1TXmMzc8Yv1P526RP2Pd5LVPKmenUs
 ODFX3XFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwCDIyPJ/Rw8zYz/359qIT
 3ll33+7d3nbu1RLeK/Oi3+/v/sHv9oLhn0Z3iv2CPw/j/Rgn9TguKs9yTG9VVt1/a8MqsxiJ+99
 7eQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the pidfs entries to an anonymous struct.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 453ae6d8a68d..00646a692dd4 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -52,14 +52,15 @@ struct upid {
 	struct pid_namespace *ns;
 };
 
-struct pid
-{
+struct pid {
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
-	struct dentry *stashed;
-	u64 ino;
-	struct rb_node pidfs_node;
+	struct {
+		u64 ino;
+		struct rb_node pidfs_node;
+		struct dentry *stashed;
+	};
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;

-- 
2.47.2


