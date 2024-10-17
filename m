Return-Path: <linux-fsdevel+bounces-32248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA089A2B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B31C21DA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247361DFE1A;
	Thu, 17 Oct 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul9Gm+sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF611DFDA4;
	Thu, 17 Oct 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187240; cv=none; b=VkYCw2dtU6vlC00hQM7BDqCajlcVZ+0Gozt/Wc9DWrzTZyZ3R5BOA+KJaxhBU30AlPUWGTGioAGq4b6CRFXiwPUQNijRZ1bENUSs7e9fcKxT0Qub4d4FuZ2wKEIhQqw1Ge3F+FmjIO8wUDDfWMpV2OfiWrGcKTyemeIvcsPe1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187240; c=relaxed/simple;
	bh=Cn02DK1/ZKdE3wGTEZWm4ta7PBaonJHJ5BZuMYejZuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhHN2lmtpCjCX29YIYa98cyXcsroGjw5ai4SBqx35hF0/pdPTYCrAYG0kL7CYAc4darOOJYRAzmz6lKpFF03LAdarIjUh4KjYz5ha8vWiUIixiikclMCTZ+TZYcFDiyNsnja4/xVBm5mBT7OewvKqtMAfM2sOJ+GXl9L+Zrz9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul9Gm+sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7866C4CECD;
	Thu, 17 Oct 2024 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187240;
	bh=Cn02DK1/ZKdE3wGTEZWm4ta7PBaonJHJ5BZuMYejZuw=;
	h=From:To:Cc:Subject:Date:From;
	b=ul9Gm+swfBq9t+bm2ovTgBpErgP2OVJ/5GGOqe6Qnpzbyc1jWUPTanfu6Bl9I55xV
	 yEvLuLFo6X1fh6xHTapCWNNTaRiUmEKIgvECXK/mK98legWTEtTWNyvFX2jTXzYhj6
	 aSpa8TRyctmNZXopFXwozbZ5KQRHZK40y5H9cfAoAQCTUzPoXHj14RLh7qav9U/CQp
	 M+pNbaxesW8A5rXFsc64yqfmYq/MtKnJDIkLkSiLxi5IgdgCy+kjfBJpK8ZFoKqHKp
	 +R8+/yPp509MdssDi6mmKN+aTRqZ0EIErXSXuuGPIa3Kk0bEMfDFqr9w6X3MDxCX7P
	 HSFU+N3gkCrwA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rppt@kernel.org,
	david@redhat.com,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Subject: [PATCH v3 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
Date: Thu, 17 Oct 2024 10:47:13 -0700
Message-ID: <20241017174713.2157873-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From memfd_secret(2) manpage:

  The memory areas backing the file created with memfd_secret(2) are
  visible only to the processes that have access to the file descriptor.
  The memory region is removed from the kernel page tables and only the
  page tables of the processes holding the file descriptor map the
  corresponding physical memory. (Thus, the pages in the region can't be
  accessed by the kernel itself, so that, for example, pointers to the
  region can't be passed to system calls.)

We need to handle this special case gracefully in build ID fetching
code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
family of APIs. Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Yi Lai <yi1.lai@intel.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 290641d92ac1..c4b0f376fb34 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -64,6 +65,10 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping))
+		return -EFAULT;
+
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
 
 	/* if sleeping is allowed, wait for the page, if necessary */
-- 
2.43.5


