Return-Path: <linux-fsdevel+bounces-37247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845ED9EFFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440EC28698B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B01D7E5F;
	Thu, 12 Dec 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXTJa+eN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37871DE88E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044651; cv=none; b=H/LwRJFyizC6bHI9NkKesaXsYrSFWHCWdgPm+VrNFCBwDeV6NWxsoBh5CEYLC4ysA5PomzeW2z9o8lPoRhXPtowRu3AjMHhraE1tbvVKIUollvl13kyuuuZEgSeuGRa4lWuZdghq0L3M2yJNruRUdsTnga0wGMM6cSZ3E6qNX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044651; c=relaxed/simple;
	bh=A0fa9RzXL1zVDpIQaB/+hbO+wEsCtHZ6TdzZepRZYiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Naa5oWYVkNfv2++8ReAKg0arsDMS2vTiN2ONO/cq+rf+Tbp7PCiEayaWXpuucq8OkgIqo1Iw8LUmDniPSmbQzorDEHZdWweqOkFLVCaLKPRGszycJ0VIsvi5ykiL3B9iD3B+WoGaeC6yOFXiWr4JJ+Mo4WxbsCviQ5+i7wKrg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXTJa+eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6E8C4CECE;
	Thu, 12 Dec 2024 23:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044650;
	bh=A0fa9RzXL1zVDpIQaB/+hbO+wEsCtHZ6TdzZepRZYiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FXTJa+eNETVK9dzSMJ0UqU2O24leWqj3S4JUa03I/BoN4kpyZEcIZTg42wCniXw5q
	 z2pZQThzWPvDd0Fp2UFkCllpd3IgldCYvFM4UPoeLNyLrb4frCH5LYpqOC00w1layH
	 hNL6Grz+Yui8ZISGhUDIoKw9fnQbiGJTeS4gkqrOmLPJ/R9Wt0DoI1xk0bzfr77CaF
	 VOOcxyHGZymEkghPgvong/a1D2ce5yt9iOmCy0OeYeopwNHgA0cH0ioZXHiXkFwO0/
	 REW75lUb2XB/ielFO/SsgIWJRi3sgbZUt92vAOjgDfpsVmpPgv/jw6RbEIhNpVEtPy
	 t6HCB+5O9bpJQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:46 +0100
Subject: [PATCH v3 07/10] seltests: move nsfs into filesystems subfolder
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-7-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A0fa9RzXL1zVDpIQaB/+hbO+wEsCtHZ6TdzZepRZYiY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ99q7n5/8ZPl4vP9AeZXpVWOvWW3XXx/rqB+znr9R
 WImm7e5dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE+A3D/+iQWE9j/0t/vl3I
 66u9O+Phg4NPN+/79Ga56fd370KUD6Uz/FPpNe0+ZukYdvbZ3tX+1gpsSaFSs2/l+11cxJr28nm
 7Ki8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I'm going to be adding new tests for it and it belongs under
filesystem selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/{ => filesystems}/nsfs/.gitignore | 0
 tools/testing/selftests/{ => filesystems}/nsfs/Makefile   | 2 +-
 tools/testing/selftests/{ => filesystems}/nsfs/config     | 0
 tools/testing/selftests/{ => filesystems}/nsfs/owner.c    | 0
 tools/testing/selftests/{ => filesystems}/nsfs/pidns.c    | 0
 5 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nsfs/.gitignore b/tools/testing/selftests/filesystems/nsfs/.gitignore
similarity index 100%
rename from tools/testing/selftests/nsfs/.gitignore
rename to tools/testing/selftests/filesystems/nsfs/.gitignore
diff --git a/tools/testing/selftests/nsfs/Makefile b/tools/testing/selftests/filesystems/nsfs/Makefile
similarity index 82%
rename from tools/testing/selftests/nsfs/Makefile
rename to tools/testing/selftests/filesystems/nsfs/Makefile
index dd9bd50b7b936e3ff16274260e149bc8d9cd23f3..c2f3ca6e488e9ddb49514e1b8e93909d5594259b 100644
--- a/tools/testing/selftests/nsfs/Makefile
+++ b/tools/testing/selftests/filesystems/nsfs/Makefile
@@ -3,4 +3,4 @@ TEST_GEN_PROGS := owner pidns
 
 CFLAGS := -Wall -Werror
 
-include ../lib.mk
+include ../../lib.mk
diff --git a/tools/testing/selftests/nsfs/config b/tools/testing/selftests/filesystems/nsfs/config
similarity index 100%
rename from tools/testing/selftests/nsfs/config
rename to tools/testing/selftests/filesystems/nsfs/config
diff --git a/tools/testing/selftests/nsfs/owner.c b/tools/testing/selftests/filesystems/nsfs/owner.c
similarity index 100%
rename from tools/testing/selftests/nsfs/owner.c
rename to tools/testing/selftests/filesystems/nsfs/owner.c
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/filesystems/nsfs/pidns.c
similarity index 100%
rename from tools/testing/selftests/nsfs/pidns.c
rename to tools/testing/selftests/filesystems/nsfs/pidns.c

-- 
2.45.2


