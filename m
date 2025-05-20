Return-Path: <linux-fsdevel+bounces-49511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CEABDAC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BD61BA52DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584824503E;
	Tue, 20 May 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+JxI97e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F2242D79;
	Tue, 20 May 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749654; cv=none; b=erGnmMKiXPaFGOAzqbVUblZwUtIC4s8G1gscRpjG8JxRAb68Ne0NBQ8CXkqVSVzLRoVSaiDnsXHX9Gp3tOGMZWu32VNSAc6b7uoBMPVKQL0G8B4C2crxo8M50aA5Vbh8yhisf1md9QigmSPg/3azRDpWJL6pKeMjUCCHPEYYxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749654; c=relaxed/simple;
	bh=ZiZU33Lo7kS1EPPVmImpLNvwguFnyj8P5M+5s/OJ5FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdIY2gZn2yRZF0Z4+FbH7LKr3PQr0AQy4GtUNOZhPreTnYN01KJUEJ3UEEJZZzulqiHfJb9QAEVk5tVxetWShf+WvhAcSK9Yfmn2ehGgJUdh6AHVdx6Ut+BQKCjpCrQdkvduNvJze4honr1kZVJ0vsd5MZHFZG7H5mvUlv9DAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+JxI97e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C16C4CEE9;
	Tue, 20 May 2025 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749653;
	bh=ZiZU33Lo7kS1EPPVmImpLNvwguFnyj8P5M+5s/OJ5FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+JxI97e69B40SgUGvsYJPp7AcOG8DLl8bQLtF+mnSmwR7OWmqw6CCg3WHszftch7
	 pSmtv8rCiaSajwyvexFftOLoezYglJfzv2oPEaE0qsDdESALRV1JVmMgqztgClONZP
	 vU6Xg3bb3Ubzjldao8/N9FTnKu61ap6J5LJg8Nvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Sebastian Ott <sebott@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/117] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Tue, 20 May 2025 15:49:28 +0200
Message-ID: <20250520125804.128281403@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 8ed2ef21ff564cf4a25c098ace510ee6513c9836 ]

With the BSS handled generically via the new filesz/memsz mismatch
handling logic in elf_load(), elf_bss no longer needs to be tracked.
Drop the variable.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 11854fe263eb ("binfmt_elf: Move brk for static PIE even if ASLR disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d59bca23c4bd9..02258b28e370e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -854,7 +854,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1046,7 +1046,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1209,8 +1208,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
@@ -1222,7 +1219,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
-- 
2.39.5




