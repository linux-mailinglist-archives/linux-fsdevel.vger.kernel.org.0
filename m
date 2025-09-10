Return-Path: <linux-fsdevel+bounces-60776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11307B5199F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C2E5651AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6EC32F763;
	Wed, 10 Sep 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrNBqVHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C132A82D;
	Wed, 10 Sep 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515037; cv=none; b=T90s/wEw8TvIlvtODYFxqmZZZ9PvQz9LmiLaqD1+QQoaM0AzHuZmldhaVBXdNvscvAh35VyERGjIC1GXbB6JRmQ6nYZyupRnR+8PIUHITWD1ZOoEDRdkEshpd2FCfBb3wKAy/4naHhRZYm++yQGcauqWbriiK/jBlk+JTNVhR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515037; c=relaxed/simple;
	bh=4DSLJ0TDAmWPOipYbwhpaBlzGQi13TeCv46x7pWryak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oIdL15ZNw/vPdX0m4DX88RGM57xCJ10qOYz9A7ltFOan84JTgRnPajB3paijUGPxxV4Ize2pk1cOr0w+7XB3iaN89GL3W1zb46kovuu4HCUceQKNaRngmWGq21blUP6/w+GC1VgQyITAtb04WYb3X+TpnkWlRAkmJuxJf8TXZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrNBqVHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFC2C4CEF0;
	Wed, 10 Sep 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515037;
	bh=4DSLJ0TDAmWPOipYbwhpaBlzGQi13TeCv46x7pWryak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hrNBqVHEvwgF0wc0JzWFTb221izubC5GRAtDH4r7Ox9sdt++1A/9lpm+bTW6LY0NR
	 LnFpU9QqhJv92ZgNdk5rNUor4wk9DZO+Rr7It0GNC3UIYslfyIKztzEU9JkUFPi6Ww
	 Y9sV7OMaslefEkRtbbwyYwdQJ0tMIRSv8rG9GCGKj6up7o6ZNXxdaoMGFc+5k7vXDv
	 AF+8UZzUHsKdzxbluaKClfFOuY+YgSIpCVC8pbNWz9r8WkK9X0pQG6N1wOkSM/rl+8
	 1NTJG21lGjdWIzn06wb0EI1mnG+eYb1uSwCeY/dgrUiQh3H0jPJ9qn3kxop1YZVTXl
	 xTw8s6v5kprHw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:47 +0200
Subject: [PATCH 02/32] nsfs: validate extensible ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-2-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4DSLJ0TDAmWPOipYbwhpaBlzGQi13TeCv46x7pWryak=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7GW/UeDIlDPzOMtvgbpShYzMnu/7/FzOfKzsCW9Wq
 jCac25tRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETM1zIyrNzHoH+a+3Wzm1Fw
 D+esu0+YNVYxJW5//cz097S+1F1qXxn+meT9mKnxf/YpfYUZj9dH91uUJC7+NcFFZGnw/JmXl4R
 cYAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Validate extensible ioctls stricter than we do now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 59aa801347a7..34f0b35d3ead 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -169,9 +169,11 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	/* Extensible ioctls require some extra handling. */
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(NS_MNT_GET_INFO):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_INFO, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_NEXT):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_NEXT, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_PREV):
-		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_PREV, MNT_NS_INFO_SIZE_VER0);
 	}
 
 	return false;

-- 
2.47.3


