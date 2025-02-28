Return-Path: <linux-fsdevel+bounces-42851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59EA499B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7F1172FFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E526D5AB;
	Fri, 28 Feb 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5OEh3K/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5E26B2C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746677; cv=none; b=U+M3gVX6wV75zJhVNHcfaQdM/Z9yYridWgxEQX5deOyCsFv2O6VIVTIa1SnX+G1FLJONsLNEd372+Caat0f9XHwOn/uGCIsz3orXqThradYlt0dZ6QBdv+r1PG7KXVDgK6IApQzxS4TqK0MP/Y5SjUFT2Rjsy4Jvg9RNWMkuTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746677; c=relaxed/simple;
	bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9Y7Dwr86ucJ1Wa3rZmHQUObAtffFpM4gcscE/5oaP9ZjIKRbHYdJskfkZtrof/tLE1oYn2OxfD0Nsiw5aUu+hU1rqyzqVX5szkbnxVOQfykTuaDiUQnYUYPtxxHnbhNryNhs9Yb2eVpLCAHQ/6ai3aQjvxoEVWUddE1ZFvZ0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5OEh3K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58E6C4CEE5;
	Fri, 28 Feb 2025 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746676;
	bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S5OEh3K/SHp+/HSH01NclT6vSknGnRQYu0x3gcehi2G3PjE942RZDMQqutONZgK3A
	 0upbcFCIOjSImsAHnwcP8lXVc10aN8T270nH5T/Rt83JNgy83fkrxW4YqkwAOpPfpk
	 c3vw7BeMVyjfjj5hTXGQN2nYeaNXZ+jik8LG1d5TgNZAUfz4Bc5Jv8ZxxyaqLPFEJw
	 6j14Aae5aNy3QtpDrLpSx4+iK3GUspI0OBaapu3O5sHjE5hSkdoZ3xeLKgn1BFG+qt
	 nmy3B41JdPuRUf2Q9dv+slrhjPfxG07eTLS/AMFTeomkR4fECjda7nCSuHv9UL3IvJ
	 9cLZlmyXpyB7A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:08 +0100
Subject: [PATCH RFC 08/10] pidfs/selftests: ensure correct headers for
 ioctl handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-8-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=653; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/DPEsZvaOBJV0BlsE7mEEfJBsCIwh9zyCd6k4r1+RVU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/oeMiFnQzmWuwXNpumT3MJ3jCbV0f19dEUk3XLT
 9ldvS8n2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRXnlGhob1EasWCcRmcXU8
 +PWsv5n1EYeOyqxHlz/+8v3lW27AJ8LI8KgyOZn93KICue6fles4nq1bavfI/Fz5Kh7xDfeX7+Z
 YzgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 222f8131283b..d9e715de68b3 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,7 +16,7 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <linux/ioctl.h>
+#include <sys/ioctl.h>
 
 #include "pidfd.h"
 #include "../kselftest_harness.h"

-- 
2.47.2


