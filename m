Return-Path: <linux-fsdevel+bounces-59566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD01B3AE29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE93AC75D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750CC2F658F;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ijNvkQKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05012EBBB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422495; cv=none; b=IFq0o2YI9Zpjfxk8aCt1sPmV1Xs0N/ZQIXDvplHBfn/A2rxNrR1mjkhlGy5SSypvVhzDqZPgpKyO0h4tUretuCzeAM+kHnzmMWodi3mGx5Lg0RF6NxghlFaF4+4H76wKTCyvV6HUUSsD6H4zNObaDXitzebsyYCXPoYMSudy3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422495; c=relaxed/simple;
	bh=JZf3qDVyiRsEziTNVurg4i31o+T8+wkzN+wUDlrHy4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD6GWhv7xr8v1gQvaPFwAAw8yNiJ6XVTlFSuT7dDEqtxgJwKR/8DBYd/Q0DTgJktRQr1GpG34N6NJ9NUj5tqeuTmbOg0uKuauJrbSyfDtRMyK8u7kdY0wI18lFlRdAj/GYcv+ceqej9IwlbQ1Rl1lUmaCMA/h+LTMo/HLHK0C7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ijNvkQKW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JZdVpPaK23MieE10VGHz5AaqtRReqd/jmSbpsyiiXMo=; b=ijNvkQKWhWdWYyRmqpd/kub6xg
	eIeBS+caIJr6SJXsX7xoXFM5tqE9mCm71QrFyznbASQkq+oQKnFVU0ikTRiXNQV8vOz8cae3WZ9ry
	G6ZqVvgebwglXrAjqd0ODYOkXjt0hsXu4TjWmo+Rtpe9/Lpjs3qlVBPFjnXkRL/IxbLJEehnjoR8c
	r82je3ypBs/Wg2a+zNeUUSTP5u7sS1pmUOzAKilwz5WWUMnmLHT8q1XGdNSFEcDim4XxkZqEwplIW
	KP7/WWZFLiwxwRyg4CZQsmtQDMFBjbiArcNji7pA0D8utPmMYVcCEA4y4OGAzgb88Svk7EKM+u1EC
	SG3LZoCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F26x-43tT;
	Thu, 28 Aug 2025 23:08:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 38/63] do_set_group(): constify path arguments
Date: Fri, 29 Aug 2025 00:07:41 +0100
Message-ID: <20250828230806.3582485-38-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5766d6a3a279..e4ca76091bd7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3359,7 +3359,7 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
-static int do_set_group(struct path *from_path, struct path *to_path)
+static int do_set_group(const struct path *from_path, const struct path *to_path)
 {
 	struct mount *from = real_mount(from_path->mnt);
 	struct mount *to = real_mount(to_path->mnt);
-- 
2.47.2


