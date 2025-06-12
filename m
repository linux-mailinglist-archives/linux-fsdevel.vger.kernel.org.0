Return-Path: <linux-fsdevel+bounces-51464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11501AD720F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472551C2487F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D66253B71;
	Thu, 12 Jun 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKvAncj1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C82472BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734736; cv=none; b=OypNria6rEizz+ck91ZTZzxJUOXhQzUd//oNVeAf7emkOIueB4aerBHf3Bhb6rsWZvb/9anuaumjScsdTfut25asmKZ4HTQJjjiXSZuUoEFY9U4+3/PQN6TFj/ff5QgNMCXSOzLBAJWKNxT+B3/HiCN4fFlhrBJNq+QrfLP3ImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734736; c=relaxed/simple;
	bh=oPysY2rpCsLrZga408PGqUtdvT3uxQbY3JROSuIAtSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrPSmrsUTyrSaGbQSnrogcBLBEPKNBOz8i+yINp0ZCmkD+uWoTVZKjHjQS7oh6Lz3N4NR09JsvVW1ciQJrP1QsAOP7Osct5j7Ex0bcymHXt6/hzrz4nEprFca76tcyQLjl/7ij8zJqlCuyD1Xx+z1WFZQFiFqvgHUjX2wqokd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKvAncj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8900BC4CEEB;
	Thu, 12 Jun 2025 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734736;
	bh=oPysY2rpCsLrZga408PGqUtdvT3uxQbY3JROSuIAtSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BKvAncj1w77FYaWREzZOSMbGnHYgsXv30dk7LotwOB3+D766wLshWmhLyA1aW8HUk
	 OHPSDgggN51JHvhKgf7IdLIqbgrICP/T1ngyYsnMqpvGsv8i7on/IY4/oG46aXqK/f
	 kWr6b1ZmJo8YRNBy/7twRxtITp9WKrkIYwfPGP2sBx8vq116OAD+SysQBb1RiajMPF
	 DQ5HkHqoYL7szPt0bivWvf4iPs4Huwo+weAv7Z+N2lkiDz5N+Rg6F2j8p1TQH1Che+
	 07XMmmtKtDhl+xtl2zh3Ot4+LmC6GGNx4apvkYMhtoquT04hehCtZA+kB+0U9W2u3y
	 hSbyF4yEQQFcw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:17 +0200
Subject: [PATCH 03/24] coredump: fix socket path validation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-3-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oPysY2rpCsLrZga408PGqUtdvT3uxQbY3JROSuIAtSc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVjM9v7x47NKY59yeRbOx/yLzlp48iuOPvhNJOu8
 7UvT7zd0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRw7EM/9PErvIue/Hg/B0L
 xQVCOozvqzpXdjLfkZ3UGhE62a44pYDhf8D5za8mpqbbzZIN10tUfqC1Ljrf0XmSuqeU5tbrZcW
 WjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that we keep it extensible and well-formed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 42ceb9db2a5a..70e37435eca9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1399,9 +1399,17 @@ static inline bool check_coredump_socket(void)
 	if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
 		return false;
 
-	/* Must be an absolute path or the socket request. */
-	if (*(core_pattern + 1) != '/' && *(core_pattern + 1) != '@')
+	/* Must be an absolute path... */
+	if (core_pattern[1] != '/') {
+		/* ... or the socket request protocol... */
+		if (core_pattern[1] != '@')
+			return false;
+		/* ... and if so must be an absolute path. */
+		if (core_pattern[2] != '/')
+			return false;
+		/* Anything else is unsupported. */
 		return false;
+	}
 
 	return true;
 }

-- 
2.47.2


