Return-Path: <linux-fsdevel+bounces-43409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE12A560A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 07:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B49160CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8660419D8BC;
	Fri,  7 Mar 2025 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORH6dbqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9C19CD17
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327955; cv=none; b=rbQF8rRCQvh0DtciQUyEZh3tI53dAq9oJCU22jKP0ColAsm6XXjV64ZFL3ve0S4qHWAPrEsURYPX7tlyG8FjsGnns3YlAGO34Fi1F9+KY4nQ3g0IYajoYytKXTJ1cQf0Uv4ngqRD3+c+mUoEw3OeU/3u+q2nD1o89jGK/apdXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327955; c=relaxed/simple;
	bh=xO8ZI9a0KZOG1OBVqu6pteabFCxnjmcR2BLrYKbuEV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dq3S+zN3SV7W63nehUfqBiNd8WkXaBiGogZo1hjEn7p9MPQZdv9ZjI1CtBCj+wjiq9urYbMQCo6gIEHhDiaRcUsKEVuww1W5TEmwcBKfxg1jSADuD0MyK2Mvv3W/4C500T5GSbQcnjRJRc3lLEs6/pNoUdjQRuW089Q6VL9pHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORH6dbqI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741327941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bioy24DUV/2OG8cBBKOG2c94GvtSiwsNOhqhjVfSmEE=;
	b=ORH6dbqIDicSzrn6+UeGXamopLDg39lSxzptTnJsQxJfiA5kMm/NUWgDnTfvnkiZYFlV3X
	OjKt7+L+UKAy02k4mInJ51JsEF1SbPtUzSlJz4J8CnjasSqIimvBy5yQrcIkG2ZBrfewRG
	On2m9r5QHhVQcMAPHCsAlrJijF/xS8w=
From: sunliming@linux.dev
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	ebiederm@xmission.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used warning
Date: Fri,  7 Mar 2025 14:11:28 +0800
Message-Id: <20250307061128.2999222-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below kernel warning:
fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 fs/binfmt_elf_fdpic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e3cf2801cd64..bed13ee8bfec 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 	/* deal with each load segment separately */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
-		unsigned long maddr, disp, excess, excess1;
+		unsigned long maddr, disp, excess;
 		int prot = 0, flags;
+#ifdef CONFIG_MMU
+		unsigned long excess1;
+#endif
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		 *   extant in the file
 		 */
 		excess = phdr->p_memsz - phdr->p_filesz;
-		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 
 #ifdef CONFIG_MMU
+		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 		if (excess > excess1) {
 			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
 			unsigned long xmaddr;
-- 
2.25.1


