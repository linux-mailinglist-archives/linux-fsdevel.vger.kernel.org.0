Return-Path: <linux-fsdevel+bounces-43500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABCA577A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4508F1890DE2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4C1494A3;
	Sat,  8 Mar 2025 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrQvCDOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551213C8F3
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741400904; cv=none; b=LJXT0zexf6mELBcrCjHSCH3FN1NBtLRGthf+otohSe0yjF0rYWOm20CJXgPMSGC9DUg6E3E4OCsQAp3zYP/a0SddIn99XeJnO4rdAJDbAYdOPbUmF7BCKLUsQLz4r7lvm+A2lNQpD1+KVJFhCgd7IcU8ZgmK/BEoiWUBbV2udDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741400904; c=relaxed/simple;
	bh=eV5ihY7K7FWN6AqJ6yB6eSDTxRsOSNGEcDCn6de3n/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIRyanJvpRwlSx4fUT5HO7RHEosaVLHODUxyuCBeb8D67JTpWl+e1iCAth+fYoSiLZjEAo3x0ocvQOuzmdRsd+QjQBHM/L0O6gR+dUu7YlHz+x6LdntZXwB+XjavvQAuAgoB/yzmzLgPfXTJuBjfHmROwHcuoX/An4dOsQk+Owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrQvCDOS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741400900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2MJaxTSbuivKRt/mwyd9lFXJjHZyzoNQYJijn/Im+p0=;
	b=BrQvCDOSDCliLRm2GbkyJoy2JTds3aVOo4i6YndpHSuyhh+E7ZAJ4/mhY1AsE5kiEm+xtz
	Z+/brjcVfoqMNotGcVMYqwuipno42D3uCmdU3r15QlrgvPduz/f+hR2UQFLiWtevoAjjsW
	nuMyIVUwAoA47d2vrzwbZZNz/6in9MY=
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
Subject: [PATCH V2] fs: binfmt_elf_efpic: fix variable set but not used warning
Date: Sat,  8 Mar 2025 10:27:54 +0800
Message-Id: <20250308022754.75013-1-sunliming@linux.dev>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/binfmt_elf_fdpic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e3cf2801cd64..a1ad3c94b2b7 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1024,7 +1024,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 	/* deal with each load segment separately */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
-		unsigned long maddr, disp, excess, excess1;
+		unsigned long maddr, disp, excess;
 		int prot = 0, flags;
 
 		if (phdr->p_type != PT_LOAD)
@@ -1120,9 +1120,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		 *   extant in the file
 		 */
 		excess = phdr->p_memsz - phdr->p_filesz;
-		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 
 #ifdef CONFIG_MMU
+		unsiged long excess1
+			= PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 		if (excess > excess1) {
 			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
 			unsigned long xmaddr;
-- 
2.25.1


