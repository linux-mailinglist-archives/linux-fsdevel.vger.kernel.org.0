Return-Path: <linux-fsdevel+bounces-51465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3874AD720A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A29189B82F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD54253F1D;
	Thu, 12 Jun 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTGo+6nL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960225486E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734738; cv=none; b=NOcOfxVf4/Cyh0XcVj8iCvMudJ7kcUkRUIFylkH53N7jqAB7uiVmKJcJ6OYJ+50CLxI1PsRyC3YSwtzWrURETUcBLvY8qUIq/e1rDBCXzpcwIqx6Pjk8ZFHTlYZxfHKIivXOf/jodzb8h1I70G4nBna4AFAt9dtZz045s7wPdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734738; c=relaxed/simple;
	bh=vfy//LPspIVpo4kJbOT/U7SClFw2H/GGNcU+wFStgEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PW1aXqWK5F9iUNKxlewZS4S0wSlcKTtyV518ZruaX1r1LfJO5taN+9jXzsbe/50UoiNz93mHydBIIg5KkICGsCR9zzyhMAKOQsraN5XMtKusd9pOUj4Tryq3k7g85yhwm7e/bxvU9Fl8u1LeBd33urY5U1BSnWnMt78BqnFpMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTGo+6nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9372FC4CEEA;
	Thu, 12 Jun 2025 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734738;
	bh=vfy//LPspIVpo4kJbOT/U7SClFw2H/GGNcU+wFStgEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oTGo+6nLy2VVbEOe8c2bx1g+PXKj7SYLs2R3w3ivCjq8NOoboC9BcDGRySHbFUkz+
	 vFXRB11o5h9FsUv07gfIJ7/4PH+YlBSMGSXaHd+MWBnmihhQOMVo6EKTbbr4/fmNFe
	 HsittwS9qkpHXrYKcX4tEFlEI+xsPMzNVt+Vzs2+1lMpC84pd1G6f60j2eNFzy7whz
	 MHBBC30FkayMBYaiT14he9xIoCAbxURAgnvTFeZPF83CCOGRhQGivw97J2/QM0CuNv
	 NGZ3oWmPZ+TRlreiG8kp+I1boh381jk7V8wNT27QjFogLuR5KrEhwyf8PdnX1o8fe2
	 z9lTk0jvzUsUg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:18 +0200
Subject: [PATCH 04/24] coredump: validate that path doesn't exceed
 UNIX_PATH_MAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-4-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vfy//LPspIVpo4kJbOT/U7SClFw2H/GGNcU+wFStgEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXULTa7d1VW/smnDs5hP9St+rX/yZuMSzk0d8UyfF
 2fkfso+2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAnARUYZ/JoU32MriVk6X3hAu
 obReLJSPZ9qM3KdFB9xvZBUafPF5wMhw7/T661HLmJUlvny+eCB7/YNJz/8luy+y2vjXIMOnpfQ
 xEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

so we don't pointlessly accepts things that go over the limit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 70e37435eca9..a64b87878ab3 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1388,6 +1388,8 @@ void validate_coredump_safety(void)
 
 static inline bool check_coredump_socket(void)
 {
+	const char *p;
+
 	if (core_pattern[0] != '@')
 		return true;
 
@@ -1407,10 +1409,15 @@ static inline bool check_coredump_socket(void)
 		/* ... and if so must be an absolute path. */
 		if (core_pattern[2] != '/')
 			return false;
-		/* Anything else is unsupported. */
-		return false;
+		p = &core_pattern[2];
+	} else {
+		p = &core_pattern[1];
 	}
 
+	/* The path obviously cannot exceed UNIX_PATH_MAX. */
+	if (strlen(p) >= UNIX_PATH_MAX)
+		return false;
+
 	return true;
 }
 

-- 
2.47.2


