Return-Path: <linux-fsdevel+bounces-26400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B06958EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089C81F235E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0A15C13E;
	Tue, 20 Aug 2024 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqrix6aY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73814D70E;
	Tue, 20 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183317; cv=none; b=CvOPdf4sSJTJdq65L9LHNjWBtACALKycyBZ9dGjcndyzhqZpXj3iIIim5zTXH8P7u33G6NNnOIpIGovAHCnEoxcE5cPoeC4VtwNqUCBaT8M92+FOnqJ2efNi0nCOKMYoxEYGQmfil41uVcpq/jRVx0pLks1G9z05h0NdOh3XQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183317; c=relaxed/simple;
	bh=haCFzWzSqum3U7qR4Z0fyP3OGXJJFc69WSFXQNZLyg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LrjO3RVI3MvlJWMO2kJGNwKCfracYyyUvp0iYmM+W8+QeLxPRFXJbdyrouz/h2vS9gCUsOz5C+np++1CqaD+qo+yFItyMYpVM/OY56s+411JCudjg1K3H9BSTMJz4PyhIg2f4LWiNneh5YtzzXAAGlVnpshurvvKW7RlGJEos5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqrix6aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4AAC4AF09;
	Tue, 20 Aug 2024 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724183316;
	bh=haCFzWzSqum3U7qR4Z0fyP3OGXJJFc69WSFXQNZLyg4=;
	h=From:Date:Subject:To:Cc:From;
	b=pqrix6aYkGJ3/jeEphfoIHcqM0dldDpSuVe9eGxaAu2IRT0pOr6eGnrTyX+eQ2TGk
	 5+nPX+L2H5uwWLQ9ODitAOs3mOVZrg1ll3Qs3ABVEa9p41Hl7XTNb/gogJQN2M48YJ
	 jGgYpFfJj8j2cPYbkR19FWk/oD5pTXPh12TP5d7n757mSstfR9nrxRJ6k6VMpNgEFY
	 QFnxSAXd1SInGsiFJGJ3EEt/+JP9ipO5ATPlZvXmBvwjtNl5zZp5hCZP7mvoOt8hh5
	 Cd255KaTukBTzkq0IQUJSKXyvx5P3eQM8LgRRVeyCyRMXb7PasqbNugpCpa3K0FEC6
	 XFfKxU20Jnsow==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 20 Aug 2024 15:48:25 -0400
Subject: [PATCH fstests v2] generic/755: test that inode's ctime is updated
 on unlink
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-master-v2-1-41703dddcc32@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAjzxGYC/12NywrCMBBFf6XM2kgeJQZX/od00ce0HdRUZkJRS
 v7dkKXLwz2ce4AgEwpcmwMYdxLaYgF7amBc+7igoqkwWG1bHYxTr14SskI3tH5C7/QwQZHfjDN
 9augOc1EkCXRlWEnSxt96sJs6/7d2o4wK3vpLGMdWa317IEd8njdeoMs5/wC+YMQ7pgAAAA==
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=haCFzWzSqum3U7qR4Z0fyP3OGXJJFc69WSFXQNZLyg4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmxPMTxMLGjsgSin2uFddnggZa6FJwQe21wcQxN
 zrCuQFbaKGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsTzEwAKCRAADmhBGVaC
 FVs1D/9DVPEbwLZlJiDTQBLSH7izOC37tXBLhqoIwZskmzhEz7lhDzZe0CUWLxeQWgOdGmabzxf
 Lca0G+AMgDGy0LAD6eCGLW3pBHgeF3uDW2lQKk4QbHeW3+bLoNdMJ8id8Wmzy/0T/3Df+P379Jz
 7qtlhjU3pFnranENIQPQ1nXMarHBkHmO2ovN1CKWgvWwWeD7Vv6SESlbR2Qt1neAJ137vLVpAAP
 pN80HARp2C+TeiH+SP+gtru+N+FPMEg2z2IUbUKcP9aASs/bO0Qms/mpgG+kq8a3N1i9EvHKTSp
 9b4knWvD/SgMJKcqmMPSgHid1BIzpjPxIsGu3FkEAd135mR8zUN82fM5INa58VG1+rBZzmleRmf
 b5diTAa6TmQp6GWCuYH27zySffby14bbb2/SStauaWo1HVYYQQX6EDo8PWj1CQP8RzdSocG89d9
 es9/9AUKANqVRFp1MDFQvTepnOVpATdCoDKlksPQ6WLJPE/G9PTc+Z+gZcV1zirGL8RVtcdb3ke
 Ml0+f3Au+9VVpx7KxRwwxAncFLwiyA09rZgDSmGtiRxZ6nY7gGzYmqqT//pClPpa/lv9tGyQuGj
 tg3yoRumJdcFN5vaHYFizWjBAYaRLfHTNei92nnfhh7TigcnOqPma1c+EwiXVlG1vgC36hh/ywX
 613cU4hXOAtmQwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I recently found and fixed a bug in btrfs where it wasn't updating the
citme on the target inode when unlinking [1]. Add a fstest for this.

[1]: https://lore.kernel.org/linux-btrfs/20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
HCH suggested I roll a fstest for this problem that I found in btrfs the
other day. This just creates a file and a hardlink to it, statx's it and
then unlinks the hardlink and statx's it again. The ctimes are then
compared.
---
Changes in v2:
- Turn it into a shell script.
- Link to v1: https://lore.kernel.org/r/20240813-master-v1-1-862678cc4000@kernel.org
---
 tests/generic/755     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/generic/755.out |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/tests/generic/755 b/tests/generic/755
new file mode 100755
index 000000000000..68da3b20073f
--- /dev/null
+++ b/tests/generic/755
@@ -0,0 +1,38 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
+#
+# FS QA Test No. 755
+#
+# Create a file, stat it and then unlink it. Does the ctime of the
+# target inode change?
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_require_test
+_require_test_program unlink-ctime
+
+testfile="$TEST_DIR/unlink-ctime1.$$"
+testlink="$TEST_DIR/unlink-ctime2.$$"
+
+rm -f $testfile $testlink
+touch $testfile
+ln $testfile $testlink
+
+time1=$(stat -c "%Z" $testfile)
+
+sleep 2
+unlink $testlink
+
+time2=$(stat -c "%Z" $testfile)
+
+unlink $testfile
+
+if [ $time1 -eq $time2 ]; then
+	echo "Target's ctime did not change after unlink!"
+fi
+
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/755.out b/tests/generic/755.out
new file mode 100644
index 000000000000..7c9ea51cd298
--- /dev/null
+++ b/tests/generic/755.out
@@ -0,0 +1,2 @@
+QA output created by 755
+Silence is golden

---
base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
change-id: 20240813-master-e3b46de630bd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


