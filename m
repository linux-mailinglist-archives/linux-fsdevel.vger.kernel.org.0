Return-Path: <linux-fsdevel+bounces-47232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68BA9AD5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AD3926B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705925E47D;
	Thu, 24 Apr 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI5ab5lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5025E46F;
	Thu, 24 Apr 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497530; cv=none; b=ZYmvhvVv4egXe88wElLYy6Ydy4jLNfXG4NV0eaig0N4zvnwwToypyhZApmWcQD4vrC/Fod5yUdVL8ISMCELw4txDiTBSg5Oo7+96Fxg1HTAa6daTiHSANszxgfqr7xTGJRGeEktsAL/Pz0AYGzsv8aAlXcDd9svbt60OrPA78Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497530; c=relaxed/simple;
	bh=HVAKMMSrEdpK2171Gtf4MhYESy3uUkDfAySuo0BZDy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gqe5eh83wdH4ruXKil0Hzby0Xd2rLztJ1nFiJM5eOPL3eCNcBHodjveq0xhn4LDC2aziUTaTGQN/oCtaEoUGiH5ta22Tlg+zVBQfkmrnTeyYpaohJ7m9rB+eQhZs0IdP8zgoJnGu1hNeA8sRrKFLE5wtcp3uDHe2BsiQKtbZL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI5ab5lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD24C4CEE3;
	Thu, 24 Apr 2025 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745497530;
	bh=HVAKMMSrEdpK2171Gtf4MhYESy3uUkDfAySuo0BZDy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LI5ab5lb/vb/jaIx1/MQ7TKpN1Bxbly6RRQy56ugtFdzutM1G6lJrXxQXACBlkugJ
	 +m5u7qsea3wKeLpps3Z8PI2qWsojwpskOINaUb0c/O2k+qw0jh4b4oKHzMQ5DONzKE
	 Il1Gpsh0RmB65iMMdkfDJMYqdRKXWnt1JMinlmumgNRE8KKBPvn8zNiglrDV5xmDux
	 y1WAdrnJQPM0OL9paRZ+3uwOInvsZTeweMtunt1/C8SDnzQxQ8sgtvPGUD4b7DJOMu
	 Lplr7vexD/XZClw11TLJ7aydHcCxye3vUhfrCZFhzG7/En4h8jZFaAfrhulOMe0QZa
	 HVqyDnoeokYxw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Apr 2025 14:24:37 +0200
Subject: [PATCH RFC 4/4] net, pidfs: enable handing out pidfds for reaped
 sk->sk_peer_pid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-work-pidfs-net-v1-4-0dc97227d854@kernel.org>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
In-Reply-To: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, David Rheinsberg <david@readahead.eu>, 
 Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Luca Boccassi <bluca@debian.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HVAKMMSrEdpK2171Gtf4MhYESy3uUkDfAySuo0BZDy8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw6S61OyXCk+U8V/oAy85P9/jTds39eWNSkPOL5IPf3
 u7/pHRMpqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiH1cx/NNtPfGexzFjp8CF
 H5c2JkidUPDuUivP/XW87l/LtnsF13sYGd6kbpmx/FyMeuVDm/dNQhdFVqUePitZl/w+fU34wl8
 LdnMAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that all preconditions are met, allow handing out pidfs for reaped
sk->sk_peer_pids.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b969d2210656..017b02b69e8b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -148,6 +148,8 @@
 
 #include <linux/ethtool.h>
 
+#include <uapi/linux/pidfd.h>
+
 #include "dev.h"
 
 static DEFINE_MUTEX(proto_list_mutex);
@@ -1891,7 +1893,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		if (!peer_pid)
 			return -ENODATA;
 
-		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
+		pidfd = pidfd_prepare(peer_pid, PIDFD_STALE, &pidfd_file);
 		put_pid(peer_pid);
 		if (pidfd < 0) {
 			/*

-- 
2.47.2


