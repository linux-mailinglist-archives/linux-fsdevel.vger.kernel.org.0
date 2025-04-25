Return-Path: <linux-fsdevel+bounces-47328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78892A9C08E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8405D1BA3913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74629236A79;
	Fri, 25 Apr 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZNmf8pI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92262367BB;
	Fri, 25 Apr 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568715; cv=none; b=ZhImhkAUKhgKfokgxLNfzJMIl/jqyxoYZ2A2NJ4kuw9pfSLGbh+iOJUdTuG2n8tfziK6jaAKAmYdd2Txtm4BIw6VuZn1Gls2SJjs1Qii9U9/6h0KVX+DSxMnwPAPd3Ptn4gWqYegrPOdJdDTwKAQ5iFWgyzmfW2fGsrNHEHRcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568715; c=relaxed/simple;
	bh=lKHgXD3YJcZUCX/EWbivAcuAmix3WP6EI2DGGplB02U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTXoGuwCeEvhnvw/JQlh1b2serCjVCFnd+pUX/7Q0jRM54651x8PHPyaJIYKy/Q34esrCiceSrHOdW9lBnVtH71TxBbtQkv6uJaHZ6oDDKRd3hlq/T0E5uUnVDJdW4Da5An/zD8k5jgcEMcPYHeHenmhqavSjZ+Y+5CFBTLR7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZNmf8pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCC7C4CEE4;
	Fri, 25 Apr 2025 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568715;
	bh=lKHgXD3YJcZUCX/EWbivAcuAmix3WP6EI2DGGplB02U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tZNmf8pIDsN9Gw7AU9oWrmMNIF4r8dR8ubLLapWz9qXJ00/fnXawAS5l66BqV07si
	 8g5r/5OncQJ4roZi82KZ3hZ3gWYyLY4RXI8xapdpfmhyGGv0Co5aTRqKe5VU3lzGL8
	 R39DxSY6J6LpyB/MpbpRq/kkNhQ4Bv5hQlZXQrk0pyXVzAtA3S09On2qxuMY2VN6ru
	 v7OJA9X+SWYRqra4WPxUEDRJp/6PKTqkqlC7KsysrlEWro/CqJGQCnDh8NebjkvpMd
	 /hzV2PP2iYDb8KkBTGu5awpnxNCgI/vARV1lW2pfXMxpQNH0l1FMh3oNI8QaiYxnr3
	 9cYd5wg/MpHNw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Apr 2025 10:11:33 +0200
Subject: [PATCH v2 4/4] net, pidfs: enable handing out pidfds for reaped
 sk->sk_peer_pid
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-work-pidfs-net-v2-4-450a19461e75@kernel.org>
References: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
In-Reply-To: <20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lKHgXD3YJcZUCX/EWbivAcuAmix3WP6EI2DGGplB02U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwO2+NV1euXjCjVvrErqdhu7cErzp6Z9E7xTV5k5tn1
 B3STJ1b01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRH5KMDNOTy0+rOjNydDCs
 SH5/MkHIfsP+qWkPjE78f/XJq+qZwBJGhsO5vA4HBThkHdMMu7a0/zu1OHt6Dcf293uulPA/MGd
 dyAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that all preconditions are met, allow handing out pidfs for reaped
sk->sk_peer_pids.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/sock.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b969d2210656..5ad0b53d0fb0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -148,6 +148,8 @@
 
 #include <linux/ethtool.h>
 
+#include <uapi/linux/pidfd.h>
+
 #include "dev.h"
 
 static DEFINE_MUTEX(proto_list_mutex);
@@ -1891,18 +1893,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		if (!peer_pid)
 			return -ENODATA;
 
-		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
+		pidfd = pidfd_prepare(peer_pid, PIDFD_STALE, &pidfd_file);
 		put_pid(peer_pid);
-		if (pidfd < 0) {
-			/*
-			 * dbus-broker relies on -EINVAL being returned
-			 * to indicate ESRCH. Paper over it until this
-			 * is fixed in userspace.
-			 */
-			if (pidfd == -ESRCH)
-				pidfd = -EINVAL;
+		if (pidfd < 0)
 			return pidfd;
-		}
 
 		if (copy_to_sockptr(optval, &pidfd, len) ||
 		    copy_to_sockptr(optlen, &len, sizeof(int))) {

-- 
2.47.2


