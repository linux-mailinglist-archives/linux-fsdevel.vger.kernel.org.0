Return-Path: <linux-fsdevel+bounces-43228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC85A4FB49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E316B1888737
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB72063C3;
	Wed,  5 Mar 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcloonls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F451FC7FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169323; cv=none; b=WK8KmHYHd6LLdZRfq+N5S0XhOxUOKWA5jnFn20hk2UquVaHlqkTM+QF1rf9RJn8EHM5+uMs+SGJmfG9BnxmaSkdhMwbjZH5ifgkRpFJjyoY+/jkoa7KeEa889u1JvLmrTRy7ap4qMcvImfKd6GaeZcX3Gls9DSe5Rybxk1CaXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169323; c=relaxed/simple;
	bh=RH6+41naBJfLvwkOqLgEs+DeitLKhiNb5SVtjxokSvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h83Yik3FXOM3/N3DNR/9hT0rTecpYa8q/s8K9sv7nC9CCAfB1lLlTYVpDl09mXJ7yk6LHH8HeYBCl0vxFe7M0dfaPsnWzyr7GpEe6hGDznuSacHGd8qnIyUcaUisMdfZxoA2S1ysPBXWl8f9Rt65aMp3SItU6JgOsuvnqWGyaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcloonls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF0DC4CEE8;
	Wed,  5 Mar 2025 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169323;
	bh=RH6+41naBJfLvwkOqLgEs+DeitLKhiNb5SVtjxokSvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mcloonlsXDpKje2wQUH5UaBAi9FGZlPdwjR6/qMdvV8nS4UAYBe6kLGbjgCfhOcKP
	 mhIej62jrOmud2TbFsCcc/tClkOllX8D7pIB3wlFmtdE4DAENiZO6S5v+cMgBK5Suw
	 FOfGyPpgvGqKA/OPMp9Nzu6YJU/bOXX16iqrD/Mr+uy4A+02+v1LSyWZFl8QDUrSnI
	 qOkgDrNl+PV7fftfMSnaeXIlddVCg3EPFY3eJkTNk2Ewt+MadEhv2t+fQQey6dvSGu
	 aZumcBfkBflMCYJIFzxesyk+eHDYIq/9rZBhIEtcHc8U6qb24RWIlmR9Oc27Htm4WV
	 0y6jyxx9OVDPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:18 +0100
Subject: [PATCH v3 08/16] pidfs/selftests: ensure correct headers for ioctl
 handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-8-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RH6+41naBJfLvwkOqLgEs+DeitLKhiNb5SVtjxokSvk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqxftPUH/cL67l7Spg5Jirt2V75O5/NpU3k85oNz
 jmLjaXWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEqZzhv/cyOYP+TXmRclzT
 fWuEOyexF/TuLZ/hd8fOuu30THamt4wMD5m2HC1fsFf+lPKbsgCuOJ/pzJxHJRkmbNX35J96lkm
 GGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that necessary ioctl infrastructure is available.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-8-44fdacfaa7b7@kernel.org
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


