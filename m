Return-Path: <linux-fsdevel+bounces-24533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4291F9406C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2291F21DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA381684A5;
	Tue, 30 Jul 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWIbF0Kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BA2114;
	Tue, 30 Jul 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316487; cv=none; b=KhRfTDU6DUnDtaQQfW5MGZHFWPgHgRBobAm7+AKL9XTeQevWGIp9VZO91dBr80fi+rKbSl00SGDKHRwB7lhlIE0j5+Ttvl2FWaGEgryqA/XqSKiaf/TWO5gtAyLP60hjCPJaxrwA/smPtbMZT+i+PIyC+1mlG6yBCHDeKAIqvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316487; c=relaxed/simple;
	bh=9+GUEXuBx9YsLhq/QX8kwA5yzV3pP+uMxTKcxPU/ZEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUK5H1xOYatCAKHFePaLmqlHawJ19DljFHIHeIzedtERIK/pReYq0ekdkwLRYpJeUyP73ci0DjNFrfpCNF0sSyJ/6AAeNbADjJx/CrAxOKG2vRmrj1kcZzBvzNJO6QRCIHcU/I/I20tOB/g53qZor3JleoSb+zxw+7uDkpEIqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWIbF0Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797EAC32782;
	Tue, 30 Jul 2024 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316487;
	bh=9+GUEXuBx9YsLhq/QX8kwA5yzV3pP+uMxTKcxPU/ZEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWIbF0KxXlh8S1V1TVLXnVofeyJl19QhXkLhUf3Nprmx89CCp69kbYXq8yjhLmqlF
	 //2hXU2TlRPNnsmDMEsWDFTNV6eYrytNiPWRVAmV7lBXcsagpXSZU6wu4qvsGdH57X
	 zkMIhH3mPFI7F2ZRqnD7oZnkjUp9Ig9Wi8N4y3pLf/QS8CATTYMy5FTeXaidnaeyfl
	 i8Q5bXEiLJYOtWSW71HyNpGkhYqKAvTzFdGvKNs3Xc4KNzGV19SLk7dsNmySbjhP5w
	 I0BWNsAmQyVmzOTWzibAxgKO6WYR964QQxvLNEJVHcs9CIUBft0ic9Q1blR+B6X7KK
	 I9QwqL2uE0iRw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 01/39] memcg_write_event_control(): fix a user-triggerable oops
Date: Tue, 30 Jul 2024 01:15:47 -0400
Message-Id: <20240730051625.14349-1-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730050927.GC5334@ZenIV>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

we are *not* guaranteed that anything past the terminating NUL
is mapped (let alone initialized with anything sane).

[the sucker got moved in mainline]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/memcontrol-v1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2aeea4d8bf8e..417c96f2da28 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1842,9 +1842,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	buf = endp + 1;
 
 	cfd = simple_strtoul(buf, &endp, 10);
-	if ((*endp != ' ') && (*endp != '\0'))
+	if (*endp == '\0')
+		buf = endp;
+	else if (*endp == ' ')
+		buf = endp + 1;
+	else
 		return -EINVAL;
-	buf = endp + 1;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event)
-- 
2.39.2


