Return-Path: <linux-fsdevel+bounces-79344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBL4K7EcqGmYoAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 12:51:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC31FF4DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5378310F035
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E361D39B945;
	Wed,  4 Mar 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="h0dqcF6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EE39182A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624869; cv=none; b=nOEDEyLDTgsf2U3McG2toKkTBU50szMRz2NjNV5K/Q0zUUKpWYu6kdEu/Gz+0n+osPXdBCGSOPboTe4tbnuGBgYxhYbg07ld3lpVpOoJoAB26/7yalLS4k6HAy/nk/xevI+Aqj7KVn+88MrNXsWRhRsf89uFPbWrxDoow4c5L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624869; c=relaxed/simple;
	bh=Dcjy/fJCF/rN4gn0l0pE+hqWHG8jNAgHXv1CiahgN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gay+XW9bs5qaSHmysYgPOhv3LtsgoQIAgSamA5s+LGbXISZ7FutCkti1h+ENZQ0Ic7usUqfFldrioe5osJaTzH0eQjQnyOL8QQ7KRo6JlyjrSX9KZDiznbivR8Z/1BqBkQmYX1CDnSRcgGJCYY7eeYnaoxLBAGX0X4bQIweA490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=h0dqcF6L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8297c035d28so42142b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1772624867; x=1773229667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSmAArgo0j03YT7FseLxFhyf5NHLf28jrPvMl7zXPPo=;
        b=h0dqcF6LxBfOlEj7COrT2M3GPgiA7+PKqwwJgxHk8OlEDq0219Fn07wfrDidnKIIyl
         UtskNIIoCKeqVp85Yja0Ad3qjs3O9IO/CHmd0SNzr12r/OCeg9wlW2wvyfbQExeW9cky
         QVTBP2nzM58OXrAtMDT4ePobmxV2DnNrWlgP1BfoGBF8ANCfKDnzjNzx2t2UMKU3FGNm
         JlWF6H+6q4CdPGF8bTuZQGi60kkgFJG7dL2G6mU6mpsnag8FX7qBmHQzpCx9xR+IaoY1
         FA3bcbCoQCeswpJunMftYZWrW3wgbYcEQ0PRyehPtzYR1P+l89ErvO86AhkDrmP7wom/
         cX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624867; x=1773229667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSmAArgo0j03YT7FseLxFhyf5NHLf28jrPvMl7zXPPo=;
        b=UTo1Xbjnwt5OYUbgTraaeoPfR2N+X6nfXF8AbWEZRjYKTtJcVF56pYLC5C18g+5eIl
         mB5noIrt/I1IrjMMHjf17zRk4lX1cnZDxsT/+uMW9sItZ1nsg8nqia3rSIePAb3sQ9w9
         FsQqFwkxwGmrA6rhw7ZcysR+YQ4qBpicMTmNZLDnFwMtpfVbV6suSqZdo0AKj786zktJ
         DxjKpjLCPYHQu1SO0b4QS5FwB+WOCk48D3HijUU1HdIZmrHAAgKIGvqRMefqNeoMMrNC
         nL7TfFdteSdV6cAyWnrTDighG1GG+YgQfCtQXmQdhnnUO9oEld53ZtzekM1bSWtYCQYb
         bFeg==
X-Gm-Message-State: AOJu0YyO+vComevMQMqHjhhOGgiw6gQWfN1fhpFfBbOWMfDlJ2tIopWq
	P3JnTQXeY9VZSqeLOHisrRKenKYhOB79NlqI/aOOeysjYsmMBEzwCJFQ1XFoycieYAg=
X-Gm-Gg: ATEYQzxjxpRwEvWmM8RwX//IkmHasmZ5uyFjXVsBL6L6t0uOASk/zln3XZwV18qtMmW
	/szxTiBjFblLR/fSiHCYudPXZ3rCaLGVV78vqDYGWYIO3aE/9IoFsw5Q9xs4LMOwKTNUWl3j62K
	VV/WsdZSofh6I0tfpnttfxbC4KGn4tBgFLiuPSohYQVY//ZlP4Go7P+ZNLuM7OwyTVL9YC1q3pv
	P8NgbamR+rCI6RRjf3gTmbKBPPEeK+bJ3Q1Lae1J0mZJkWzp5hhQeJJdbhzeNpLh++bbJKpuvzr
	mVe4ffQlOBu8eXOIcs27IsWnXUJtrojRQYN20hYNvvDDxWEQvXC1Vj625jQNV1bwJVy10u7I9a6
	EP1b90u0S1U7VdyUm4jvrtDABAWK9KrQyugUicsvj93+gX5Zf/E95+mwymJEVid0ZZiX74ShXQW
	XYJs6stEji
X-Received: by 2002:a05:6a20:d527:b0:395:732:2c87 with SMTP id adf61e73a8af0-3982e2475fbmr1405418637.56.1772624867385;
        Wed, 04 Mar 2026 03:47:47 -0800 (PST)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7387271048sm182776a12.27.2026.03.04.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:47:47 -0800 (PST)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [PATCH v2] binfmt_elf: Align eligible read-only PT_LOAD segments to PMD_SIZE for THP
Date: Wed,  4 Mar 2026 19:47:27 +0800
Message-ID: <20260304114727.384416-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18BC31FF4DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[hev-cc.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79344-lists,linux-fsdevel=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[hev.cc];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hev-cc.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[r@hev.cc,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When Transparent Huge Pages (THP) are enabled in "always" mode,
file-backed read-only mappings can be backed by PMD-sized huge pages
if they meet the alignment and size requirements.

For ELF executables loaded by the kernel ELF binary loader, PT_LOAD
segments are normally aligned according to p_align, which is often
only page-sized. As a result, large read-only segments that are
otherwise eligible may fail to be mapped using PMD-sized THP.

A segment is considered eligible if:

* THP is in "always" mode,
* it is not writable,
* both p_vaddr and p_offset are PMD-aligned,
* its file size is at least PMD_SIZE, and
* its existing p_align is smaller than PMD_SIZE.

To avoid excessive address space padding on systems with very large
PMD_SIZE values, this optimization is applied only when PMD_SIZE <= 32MB,
since requiring larger alignments would be unreasonable, especially on
32-bit systems with a much more limited virtual address space.

This increases the likelihood that large text segments of ELF
executables are backed by PMD-sized THP, reducing TLB pressure and
improving performance for large binaries.

This only affects ELF executables loaded directly by the kernel
binary loader. Shared libraries loaded by user space (e.g. via the
dynamic linker) are not affected.

Signed-off-by: WANG Rui <r@hev.cc>
---
Changes since [v1]:
* Dropped the Kconfig option CONFIG_ELF_RO_LOAD_THP_ALIGNMENT.
* Moved the alignment logic into a helper align_to_pmd() for clarity.
* Improved the comment explaining why we skip the optimization
  when PMD_SIZE > 32MB.

[v1]: https://lore.kernel.org/linux-fsdevel/20260302155046.286650-1-r@hev.cc
---
 fs/binfmt_elf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb857faaf0d6..39bad27d8490 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -28,6 +28,7 @@
 #include <linux/highuid.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/huge_mm.h>
 #include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
@@ -489,6 +490,30 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static inline bool align_to_pmd(const struct elf_phdr *cmd)
+{
+	/*
+	 * Avoid excessive virtual address space padding when PMD_SIZE is very
+	 * large (e.g. some 64K base-page configurations).
+	 */
+	if (PMD_SIZE > SZ_32M)
+		return false;
+
+	if (!hugepage_global_always())
+		return false;
+
+	if (!IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, PMD_SIZE))
+		return false;
+
+	if (cmd->p_filesz < PMD_SIZE)
+		return false;
+
+	if (cmd->p_flags & PF_W)
+		return false;
+
+	return true;
+}
+
 static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 {
 	unsigned long alignment = 0;
@@ -501,6 +526,10 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
 			/* skip non-power of two alignments as invalid */
 			if (!is_power_of_2(p_align))
 				continue;
+
+			if (align_to_pmd(&cmds[i]) && p_align < PMD_SIZE)
+				p_align = PMD_SIZE;
+
 			alignment = max(alignment, p_align);
 		}
 	}
-- 
2.53.0


