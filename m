Return-Path: <linux-fsdevel+bounces-42228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC8A3F5A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC164189CD69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E320F09A;
	Fri, 21 Feb 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKxxjxj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723920F091
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143619; cv=none; b=HJW7jvr7lKYoV63+mX7ob7zSnQxGBIbKMUXh66D/6W9QjSIuv4GGneZ3ORk4QuU5kUVETaC4bIUGPZQpe0hpL0kN0Tm4rVnyRzmkLBkzMfJ+JBZwFyD5kBjvW1aXgeFFhfy+f8b2zwIPo6jmvC6cvnklVpn1dGKatmerg+kKQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143619; c=relaxed/simple;
	bh=+75OobclMsUAC78+z348QwpL7cPx5/qLrICWd2I9zJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9OkHTwmHmpFHbZtaCmubfXnEuZKhj1JLEkKvow7C9dEGJ0sT2DByGkYyPzDZ0i8FwxnRQvJanDK2dApv4LF8HuxBQM76VxdC5goGMxhH0TkgJTl7Ise9ypXKGC1Twrc8XblFqpaKdQDz/2cGl/hFHNVl4zQ19yPajsHSYcJ9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKxxjxj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB65C4CEE4;
	Fri, 21 Feb 2025 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143619;
	bh=+75OobclMsUAC78+z348QwpL7cPx5/qLrICWd2I9zJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKxxjxj/MHNDHGx2LEpyRuct32x9NPW3Hrl45irRRWEKG7X12TXn9Gx+nljM89d8w
	 ssr0hi+SKqgp1LpjhEPxyxQuc7DGjvzu5+9+z5G/oMW+fA0hIc6PH8FAW5BavjOtT+
	 sl6JUJVM95Dvumy5JsoljpGru7ajYRfYD2W8F656aDtaNNJHeZgJYxS5BbdX/2q1IE
	 JdvtUuU/+3EzEd90oKXLEmcf4AIuoWW/brSrkOcuTu+eiFq/K9yMQG9wHMlX4lvpDT
	 SyDrdeYrfch0Kej9AYQiLwuKcE0pEC/vrQMXwd6T2r0LCX5/UB3jCx8VEfNya0Fuss
	 VUQ0toZuXF3ow==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:02 +0100
Subject: [PATCH RFC 03/16] fs: add assert for move_mount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-3-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+75OobclMsUAC78+z348QwpL7cPx5/qLrICWd2I9zJo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP5luj/Nx6bkzl7fL6syTVyLNJIzFNUXcGn/nWUe4
 bNz9i/vjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlILmFk6E5LjTLPtS/w57KQ
 jXDw86xfdPKV8VL/aYzrIzpKT3WYMTKcKCr7LHVKY8fTu36Piz6zZs2L3fb13GWTmZ+vHFnhM72
 JEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

After we've attached a detached mount tree the anonymous mount namespace
must be empty. Add an assert and make this assumption explicit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1d3b524ef878..7d0fa8ef8674 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3421,10 +3421,13 @@ static int do_move_mount(struct path *old_path, struct path *new_path,
 out:
 	unlock_mount(mp);
 	if (!err) {
-		if (attached)
+		if (attached) {
 			mntput_no_expire(parent);
-		else
+		} else {
+			/* Make sure we notice when we leak mounts. */
+			VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
 			free_mnt_ns(ns);
+		}
 	}
 	return err;
 }

-- 
2.47.2


