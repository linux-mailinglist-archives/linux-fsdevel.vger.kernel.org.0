Return-Path: <linux-fsdevel+bounces-73402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1CD17A06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74F1830574C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239A38B7B5;
	Tue, 13 Jan 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKeGm3Z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E84389E01;
	Tue, 13 Jan 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296086; cv=none; b=dlm4w1/7hX77Bc5oF3Zh8j6ODcYTf02POU7NoTtGQYoaXQmzeUXU5sh3V/+09DbJhtQQNjDvTHj4ZBDKQ/ymfzYb0nMeK54GKN6gE64rft+LNR900Dz6AfXwoEd2tW+fgZNu8RGTWFumzKhGNIWLMp18JM6271BFpx8KL8FDwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296086; c=relaxed/simple;
	bh=ROVKdQmr+DawgPpCxGcE1IpjtvRSKTzHsnNOpgWpY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIHxEa9vPz8Ut6J10nRh/vBdMzWjZzTr94p9mCPnBW+5gGE1MvihdwqG+UhEk6DgBlAlWc230+xC3YfNluU2hsjrytAKyoU320uawx+1GBTofncIHYTx/jOZ8gbWmaZQi9kz/JDkI3BDe4HE91goP5grD1BV7tw2xCESpDY52FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKeGm3Z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39F7C19422;
	Tue, 13 Jan 2026 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296082;
	bh=ROVKdQmr+DawgPpCxGcE1IpjtvRSKTzHsnNOpgWpY9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKeGm3Z37swapz8yNgLzUItd/+DekYmVc63BE1ZBTbzbWTbnVUm2+nank76dYy72d
	 9XjcP5DCtOdb8LTREGlnqsQHy43V73VlZOQgD46419Su7zAXcs3w4mGdmVERkmh/Fk
	 AALmm4tTutZESfelEfh1dfiaQycBPZZDO49oOBCzaC2QvFvStEJgx7nLFjPNgzUN2O
	 pmz0AgmR2pYLY2KtulJZmqOQH8UVl6sbOn/AnjcsNwQp0rYZ5ijlHXy1fPsr4IQQuB
	 NbSfHt990gCQI0Q5PxDz/8hF/YTMHjomYx48zuI3XCwUrhEeX3FeIp6xWhS+KGdbOs
	 0v2I8CiG+l4DQ==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] docs: proc: add documentation about relaxing visibility restrictions
Date: Tue, 13 Jan 2026 10:20:37 +0100
Message-ID: <b20343931abd5d458b7f3de59cc35b9d52e8191a.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <20251213050639.735940-1-danilklishch@gmail.com> <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c8864fcbdec7..3acf178c1202 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2417,7 +2417,8 @@ so will give an `-EBUSY` error).
 If user namespaces are in use, the kernel additionally checks the instances of
 procfs available to the mounter and will not allow procfs to be mounted if:
 
-  1. This mount is not fully visible.
+  1. This mount is not fully visible unless the new procfs is going to be
+     mounted with subset=pid option.
 
      a. It's root directory is not the root directory of the filesystem.
      b. If any file or non-empty procfs directory is hidden by another mount.
-- 
2.52.0


