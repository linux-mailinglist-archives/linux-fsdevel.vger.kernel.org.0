Return-Path: <linux-fsdevel+bounces-36707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC989E862B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E488164A01
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4015B12A;
	Sun,  8 Dec 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MqQAE0bG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335F13B2B6;
	Sun,  8 Dec 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674216; cv=none; b=UNuLQq3kdjyMtApOcGy2TnALMk+vNWT9PCxIvyeDeQLCH22x3nTM4oSwuXp+PxZ/DN0bKz1iT6Mj/ko999YhsP3RXJdXvcLiPahXwv2goE/Fzew1OULk/C//SNT8N7J81mkcXI8oxHb8Oze3XYCW+Hbcrlzf1emzv51zTQF2jxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674216; c=relaxed/simple;
	bh=OONF1R+W5xUWSoNKpJYhV+NJhM7xqTM0MK5ZqndlSN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmhxN9ku2HyMUakZHcMCdCluLck6vT5v4HIqWINOIwe1KeqFp0LoafycScYE8HbJwp+dTWZ4aqpdCtTI9H1rpEzhnclj+els7OyYwc/HTZGvSubNDykwoblu6/hxENQFPsruUXk/IPzioo/t7cRH6Up+9g3HsGSO8n4l7H07WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MqQAE0bG; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nxI5r
	KZ08BnCDhR50j1kRXJkXSlItgYZ6GxJQvaVuSo=; b=MqQAE0bG/H98s7Yv5oOgo
	25eCQfw9GOKpsKnu3ludkuEpHDqeZP7a1cQks00ezTpL5Qszmrd3ICU++I78LraT
	onrw7q6O3uIOlT6ac+/FchZgdWRPSeqiBj9zHFJweGzcl/rEn3K8ynjStm5fUVLL
	x8dfSH8ufmV9ep4bpD8YDg=
Received: from nilq-virtual-machine.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn9z+NwFVnfXBxAA--.54791S2;
	Sun, 08 Dec 2024 23:51:44 +0800 (CST)
From: niliqiang <ni_liqiang@126.com>
To: debug@rivosinc.com
Cc: Liam.Howlett@oracle.com,
	ajones@ventanamicro.com,
	akpm@linux-foundation.org,
	alexghiti@rivosinc.com,
	alistair.francis@wdc.com,
	andy.chiu@sifive.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	atishp@rivosinc.com,
	bp@alien8.de,
	brauner@kernel.org,
	broonie@kernel.org,
	carlos.bilbao.osdev@gmail.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	devicetree@vger.kernel.org,
	ebiederm@xmission.com,
	evan@rivosinc.com,
	hpa@zytor.com,
	jim.shu@sifive.com,
	kees@kernel.org,
	kito.cheng@sifive.com,
	krzk+dt@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	mingo@redhat.com,
	ni.liqiang@zte.com.cn
Subject: Re: [PATCH v7 00/32] riscv control-flow integrity for usermode
Date: Sun,  8 Dec 2024 23:51:41 +0800
Message-Id: <20241208155141.21611-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9z+NwFVnfXBxAA--.54791S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWruw4kGr1fJrWUuw48Zwb_yoW8WFWfpF
	ZI9as3Jws5AF98Cr97ta18AFWSvws5trsxGr95Jr1S93y5Wry0vF4UtFWrGFy5CryYvF10
	vw4j9348ua4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkgAwUUUUU=
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbiJB2v5WdVlodlmwACss

> How to test this series
> =======================

I recently built a test environment for RISCV control-flow integrity for
usermode using QEMU, referring to the test instructions in the patch.
I found several problems during the test, and I hope you can answer them.
Thank you.

Q1:
The CFI-related macro definition values in
QEMU(branch: qemu-zicfilp_zicfiss_ratified_master_july11) and
Linux(branch: linux-riscv-cfi-vdso_user_cfi_v6.12-rc1) are inconsistent.
For example, the definition value of PR_GET_SHADOW_STACK_STATUS in QEMU
is 71, but the definition value in Linux is 74.

In order to continue the test, I modified the relevant definitions
in the QEMU and GUN source codes with reference to the Linux source code,
so that the cfi-related macro definitions in the QEMU and GUN source codes
are consistent with Linux.

Q2:
When zicfilp=true is added to the QEMU command to enable landing pad,
after cfitests command is executed, a segmentation fault is prompted,
software check exception is raised, and the value of xtval is 2.

According to the comments in the code, when xtval is 2, there are the
following exceptions. 
 * An indirect branch doesn't land on 4 byte aligned PC or `lpad`
 * instruction or `label` value programmed in `lpad` instr doesn't
 * match with value setup in `x7`.

Why do these software check exceptions exist? What should I do to further
troubleshoot or resolve these issues?
The software versions I am using are all the versions mentioned in the
test instructions, and the zicfiss test is in line with expectations. 
Can you help me with the above two questions, especially the second one?
thank you very much.


