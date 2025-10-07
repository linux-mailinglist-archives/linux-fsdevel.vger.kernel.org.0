Return-Path: <linux-fsdevel+bounces-63535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471ACBC0DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003E93BEA34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414462D3EE0;
	Tue,  7 Oct 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ochj4aii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28C2571C3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829573; cv=none; b=TxMOaPyEH3TFvSvTgbFVcUPzr5TwbIY4zKr7a9LB2ZdINWGj8GQEiGalPUsEgEhXhJ/TcWShvGFlk55/0RPFwdaa+Qgk8mcHGHV6wmBqYlcvIzvjhsgsbxdpQfjDqhBZZk2pGgTUQlEoFWE33ExHqoeLBJD561dQpV2164dCZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829573; c=relaxed/simple;
	bh=5PX1/sZAFlc55gNiuOFqsFl1qACvmM8yk67ro4rHE88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEv971a28OTCR6VResNlroNz9eBw9slzX9FQxdhhwoVf7uIA+ayAa0izACAamCNP1xOlxmnt/ymlo/yU6HDedCqy3GZdHqUrnT6HeT3g+xI2yVi+POPiwBucfVj+sfVa+RBAnzq5mHegfRyn3+zFNpZDbRhfB3rR+epbSoNBsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ochj4aii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB0C4CEF1;
	Tue,  7 Oct 2025 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759829573;
	bh=5PX1/sZAFlc55gNiuOFqsFl1qACvmM8yk67ro4rHE88=;
	h=From:To:Cc:Subject:Date:From;
	b=Ochj4aii2IwA90zcoJLTlO6TNxEelPc997t6AJPkmAiAL91vYAKm7RSCdoSWA2Ovv
	 QG4HYjM97UlDhyMVZITChJnlQFE0RAqimFuh0nMlRTMx0fr+VLsm4TFWDRpaWLuTqU
	 Qx3ZVUYrtQCWpP++n2lxfodXGNK4VTi7OXm56UOdk5oGtcnOna2XWJLK5/a0mH9HjZ
	 CrI4NcEocEIioIEhiTPKrsq/7ix3gkm/8eHqwnRZr5OKoov++KWnqiDWVC7rdhKiz+
	 bk5bZTOC1JWr8v7KKU9A9ffcjOWBNIYZONWB7KsfVkItE8PJohMY8W7qLaCgARSJIk
	 FE43I1DXNsQnw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Watanabe <watanabe.yu@gmail.com>
Subject: [PATCH] coredump: fix core_pattern input validation
Date: Tue,  7 Oct 2025 11:32:42 +0200
Message-ID: <20251007-infizieren-zitat-f736f932b5c4@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=brauner@kernel.org; h=from:subject:message-id; bh=5PX1/sZAFlc55gNiuOFqsFl1qACvmM8yk67ro4rHE88=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8uWfLEJ77QtLP+IT3GkvbeM1IVpXFbD+9riTwrPwzr 2++yC/vjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQ3h4hSAibw7w8iwqMDl0a5leedEbd48 ez/LIOtDjsw5s+P6NkFfNmhyM7H0MTJc3i5eF2UqE5Wxo8Pj9ewvOU904jPvMDO63j+UsWKlaQU TAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

In be1e0283021e ("coredump: don't pointlessly check and spew warnings")
we tried to fix input validation so it only happens during a write to
core_pattern. This would avoid needlessly logging a lot of warnings
during a read operation. However the logic accidently got inverted in
this commit. Fix it so the input validation only happens on write and is
skipped on read.

Fixes: be1e0283021e ("coredump: don't pointlessly check and spew warnings")
Fixes: 16195d2c7dd2 ("coredump: validate socket name as it is written")
Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 2 +-
 fs/exec.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b5fc06a092a4..5c1c381ee380 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1468,7 +1468,7 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 	ssize_t retval;
 	char old_core_pattern[CORENAME_MAX_SIZE];
 
-	if (write)
+	if (!write)
 		return proc_dostring(table, write, buffer, lenp, ppos);
 
 	retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
diff --git a/fs/exec.c b/fs/exec.c
index 6b70c6726d31..4298e7e08d5d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2048,7 +2048,7 @@ static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int writ
 {
 	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!error && !write)
+	if (!error && write)
 		validate_coredump_safety();
 	return error;
 }
-- 
2.47.3


