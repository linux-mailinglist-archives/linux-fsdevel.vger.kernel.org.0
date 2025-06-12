Return-Path: <linux-fsdevel+bounces-51468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B0AD71F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031EC3B0612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB61256C84;
	Thu, 12 Jun 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK69JQJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386324A04D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734745; cv=none; b=bYOF0TmpmnFGzmwHVeOR3kVI4IDlqq9fnjSF/gABg08zwRq1O6oJbaD5EHNMd0ntiGXqpMWTEZQJ9vvu6IMO0qGVIvbKPWeFgEViB+MKZscwvJRz7A5xmtXOwCSByrSrBixEVjggr+U/Jhw9Rj/SXuEzR8WDjJ2aLAWLXBrW5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734745; c=relaxed/simple;
	bh=dvJ09U0aL7f3WI68NDoSWXbJoEVBJBHHRpr/Qyxmv7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTw68hShxU/O26hx++omxWHAgoqEaZy5rNI0hrnavMg/Qd0YIo8qMpnn5Ltyd0WD3fDIoE9MtTUaquI3usiixpYy3jhKy/gSp0syiweDMrm708kU69uBSaQlSqPenIA42EqGDNZA0nUjKxx5SLCov7GohGZmkdTricV06vWku5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK69JQJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1DC4CEEB;
	Thu, 12 Jun 2025 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734744;
	bh=dvJ09U0aL7f3WI68NDoSWXbJoEVBJBHHRpr/Qyxmv7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gK69JQJo/wbTZBn1pKi1w/H552U/8T5fQlG7HJVI/YzVOpL8vRDjsXDNRNvhbHFdx
	 5zgxzPav5ajAH8y4kl1uUeLpelNMoX5O+066q/6rPG9xCzS/qAlboV9diA9cVyvzWn
	 jQs86Mgs2WxIa+MvAwcrba7MDRyv3bKvXXW3GsGSV2AI5s4exxqBySQEOdJm7oJWpk
	 4HQeHHKdYPJygsGUGlSiKwIiO4dgGRs2vHPR720zjSoZnovRuufRF3ASwKv3mFcXcP
	 9rgEA5UFYiLC1ND3f0huAQVFiAO3CIHBjaR1Zfh2j6VSEkvkxf5kQ4ibmOqofhcPkr
	 jevyDpPEzvlxw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:21 +0200
Subject: [PATCH 07/24] coredump: validate socket path in coredump_parse()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-7-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dvJ09U0aL7f3WI68NDoSWXbJoEVBJBHHRpr/Qyxmv7M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVbcfiy1/WFobs7nM4darnrGBe5z+id/e9Njhtcl
 SYHMxwT7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIUCbD/yKZM93am/wvBVzY
 cH/DZBEr1y9zW+KuflPT+8n8JCBVq4yRYUV1Ui3P1JkLOfbH3RKeZeJy9lasy4vFweqnwxbNT7l
 wgw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

properly again. Someone might have modified the buffer concurrently.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 8437bdc26d08..52efd1b34261 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -296,6 +296,17 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 			return false;
 		}
 
+		/* Must not contain ".." in the path. */
+		if (name_contains_dotdot(cn->corename)) {
+			coredump_report_failure("Coredump socket may not %s contain '..' spaces", cn->corename);
+			return false;
+		}
+
+		if (strlen(cn->corename) >= UNIX_PATH_MAX) {
+			coredump_report_failure("Coredump socket path %s too long", cn->corename);
+			return false;
+		}
+
 		/*
 		 * Currently no need to parse any other options.
 		 * Relevant information can be retrieved from the peer

-- 
2.47.2


