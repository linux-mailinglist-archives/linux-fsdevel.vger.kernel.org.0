Return-Path: <linux-fsdevel+bounces-77324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qaCiGAaqk2lE7gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:36:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C91148184
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B67253014640
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BC27A92D;
	Mon, 16 Feb 2026 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="1OJVMxx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446CC1EB5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771284990; cv=none; b=pqfP/NcDs3qFXWBBhTtI5r5Jhy1zA3FdmPJJ8K2E7/qSULuJWDBa6wCqN0tFDXWkXp/ksML44OAiSuFDAd8ANTcWr4+YEw9qwpl3PaOx/qiIeBvQQ9cUmEkyZP4eVm8Q2G+lYCosK41grhnvku9IuiE6A1aKLpWeKS4dwvZ+uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771284990; c=relaxed/simple;
	bh=esLF+A0YukoamlXsOOHiBkurDo4uiQ0esRy5nEZf+DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njWQnsfFkRpEJtrHioeRoGGw9ZgNNMH38qiJqqpfNBg7VB2NXBj1gKDK8EBX26OpfDhsraezrSzJn91RI+FIwS7F0ehrDbzhL7S1kqNGWSjHUU4uszn8RZQ4Iu4E9M2E0O+1aSWO1aqWjyl2UfrgP0irpq1J6Zy9DNRdcxRaATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=1OJVMxx0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797d36fdb96so12911697b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1771284988; x=1771889788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0wuf53ccE9AgrxzbRCa+8Dv2jf/73k7y6/hF9TjBaA=;
        b=1OJVMxx0P52m8TMop3ztGxxwKgnO/v5n41g/B20xLh74lGq4e/2ZJzEryv22FigHeC
         rRVc9KTDtzG+S/EmCEjJoaNjzwK/W72eQqUjF+4W1aXMSUO387oHJsSRfwWyqKxf2RCH
         q0ZMuZ3KRG7V5c7bxkX0oXZmPpNR+o1sexzQ4LZmVD3c/vnTGFtFXJcxwLTuLMPesTM2
         yHNGSp429iCJc/fCTZFaC9OWVyMkU0fv7B4wyoGMjnm/Bh8Zfy0tIU9K8WuuO9BrAh9b
         rTYtbxQu4X7G6ld4msLqr1rwbX44NzDieGINL1yJbgiLMCcGv9yutbFge9h+m2nOeqQ6
         mP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771284988; x=1771889788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0wuf53ccE9AgrxzbRCa+8Dv2jf/73k7y6/hF9TjBaA=;
        b=NnhOvPr0JV5BtV5JwHaNv/oJm+tC/HwxtZz/wh6+NAvM18HHEyafnjyZkrljHz/0nv
         Vd1jaLvKNlgmKDSG5vLq1vn+YN3eKk9MpSIh3LIr/G9+nSDm3OQqNR/YfcCyfypqAVTS
         p9TKPM9Zh9GOz+ucdNahaAeWGbKndHoeqr4sMaLYRDDib+DE5uC1IKIZDiUtbdZJ/yYp
         SKovbVzM0tp8rhu2yvldZq2vNKnPxEwAcJOtHVKsp6FvxP6flXsUihrSCqHJLsFxd6A8
         LoXIjYnI+F74fBeA3nJ/Qv7X0soK2mg2pj1FQHwuEYLlMRI6/VwPl7rxF7vKSni2dTAQ
         ZJfg==
X-Forwarded-Encrypted: i=1; AJvYcCXMgLRSD2Ln0XiG2MBp0eX3eOQV3aOSxgwb8UHN7U8es9qMZMCgxH2fUUdenb9vtadv9HHl8N5EbEk3bdJE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSj+sU2rUO+5lUl8BZhiZ0Vd0z1mgdM03rhiYEZy7sUzOmm6i
	5zBf/lxgQ5Jl/vuiovtKyZVe6KY661sw01a+jsg9RN5gIkzG7PmrKNGPEaP7TMUG7IPiMl7/II8
	HXLFEktc=
X-Gm-Gg: AZuq6aLaZiAYkP4J0CJqPgE3kJhpIPPA/Dh4Nac5dYQbvU4BVKqNdz357CCgJRXQhtj
	1WVKz9r/kq6/zfMFC7o7Qmm1d+WxdL4ry/QxCEuS0fQFLw9Gh+lJGwyFvajAnV6rWt0xVNeGXrr
	WAVjWYFG/rWzZ7uq7rGlNSgi5J9C6BEBYWcm92umFhX91/cmEU7Z9y93OG1i3jqoXuvNbIJiKv3
	zcNaJKgDqx3Y/moUEj1JuxxwYtoL+AUw8ot/746OP71iuIjcbE+KbtBr9B6MNF7TXkf0SiVAM7v
	OhtOwv4Ys41tOh0LxtqeuitZX0IlTGw4wowG7PJHHEC2u6p5QzeK4qvBuDH4PM7wX24hV/jPdFJ
	S0yYd1VSVC9+nVNJpnQptLXlVqAZ+EMoUi0jvIRts84Be+O8OpfZQwiil+OsQFYoEu77BjEDW3e
	1eLGVhUn+2VBzTYN/RdHcPeDPMJX9EbdrbKtcRw4hh0tDz3vHcNYxR1BF2dEafFSCxJ3NMq8zOo
	usSStvavtnLdO6reO4ReZlAHHpBL6qykuI=
X-Received: by 2002:a05:690c:c513:b0:796:4154:9f7f with SMTP id 00721157ae682-797aa80856fmr86372427b3.6.1771284988181;
        Mon, 16 Feb 2026 15:36:28 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:3027:3f43:225f:bc5c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16f201sm104642127b3.10.2026.02.16.15.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 15:36:27 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
Date: Mon, 16 Feb 2026 15:35:57 -0800
Message-Id: <20260216233556.4005400-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77324-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dubeyko.com];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email,dubeyko.com:mid,dubeyko.com:email,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A4C91148184
X-Rspamd-Action: no action

The xfstests' test-case generic/258 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/258 [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/258.out.bad)

The main reason of the issue is the logic:

cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET)

At first, we take the lower 32 bits of the value and, then
we add the time offset. However, if we have negative value
then we make completely wrong calculation.

This patch corrects the logic of __hfsp_mt2ut() and
__hfsp_ut2mt (HFS+ case), __hfs_m_to_utime() and
__hfs_u_to_mtime (HFS case). The HFS_MIN_TIMESTAMP_SECS and
HFS_MAX_TIMESTAMP_SECS have been introduced in
include/linux/hfs_common.h. Also, HFS_UTC_OFFSET constant
has been moved to include/linux/hfs_common.h. The hfs_fill_super()
and hfsplus_fill_super() logic defines sb->s_time_min,
sb->s_time_max, and sb->s_time_gran.

sudo ./check generic/258
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #87 SMP PREEMPT_DYNAMIC Mon Feb 16 14:48:57 PST 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/258 29s ...  39s
Ran: generic/258
Passed all 1 tests

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/133

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/hfs_fs.h            | 17 ++++-------------
 fs/hfs/super.c             |  4 ++++
 fs/hfsplus/hfsplus_fs.h    | 13 ++++---------
 fs/hfsplus/super.c         |  4 ++++
 include/linux/hfs_common.h | 18 ++++++++++++++++++
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ac0e83f77a0f..7d529e6789b8 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -229,21 +229,11 @@ extern int hfs_mac2asc(struct super_block *sb,
 extern void hfs_mark_mdb_dirty(struct super_block *sb);
 
 /*
- * There are two time systems.  Both are based on seconds since
- * a particular time/date.
- *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
- *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
- *
- * HFS implementations are highly inconsistent, this one matches the
- * traditional behavior of 64-bit Linux, giving the most useful
- * time range between 1970 and 2106, by treating any on-disk timestamp
- * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
+ * time helpers: convert between 1904-base and 1970-base timestamps
  */
-#define HFS_UTC_OFFSET 2082844800U
-
 static inline time64_t __hfs_m_to_utime(__be32 mt)
 {
-	time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
+	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
 
 	return ut + sys_tz.tz_minuteswest * 60;
 }
@@ -251,8 +241,9 @@ static inline time64_t __hfs_m_to_utime(__be32 mt)
 static inline __be32 __hfs_u_to_mtime(time64_t ut)
 {
 	ut -= sys_tz.tz_minuteswest * 60;
+	ut += HFS_UTC_OFFSET;
 
-	return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
+	return cpu_to_be32(lower_32_bits(ut));
 }
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 97546d6b41f4..6b6c138812b7 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -341,6 +341,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NODIRATIME;
 	mutex_init(&sbi->bitmap_lock);
 
+	sb->s_time_gran = NSEC_PER_SEC;
+	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
+	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
+
 	res = hfs_mdb_get(sb);
 	if (res) {
 		if (!silent)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5f891b73a646..3554faf84c15 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -511,24 +511,19 @@ int hfsplus_read_wrapper(struct super_block *sb);
 
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
- *
- * HFS+ implementations are highly inconsistent, this one matches the
- * traditional behavior of 64-bit Linux, giving the most useful
- * time range between 1970 and 2106, by treating any on-disk timestamp
- * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
  */
-#define HFSPLUS_UTC_OFFSET 2082844800U
-
 static inline time64_t __hfsp_mt2ut(__be32 mt)
 {
-	time64_t ut = (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);
+	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
 
 	return ut;
 }
 
 static inline __be32 __hfsp_ut2mt(time64_t ut)
 {
-	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
+	ut += HFS_UTC_OFFSET;
+
+	return cpu_to_be32(lower_32_bits(ut));
 }
 
 static inline enum hfsplus_btree_mutex_classes
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 592d8fbb748c..dcd61868d199 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -487,6 +487,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sbi->rsrc_clump_blocks)
 		sbi->rsrc_clump_blocks = 1;
 
+	sb->s_time_gran = NSEC_PER_SEC;
+	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
+	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
+
 	err = -EFBIG;
 	last_fs_block = sbi->total_blocks - 1;
 	last_fs_page = (last_fs_block << sbi->alloc_blksz_shift) >>
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index dadb5e0aa8a3..816ac2f0996d 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -650,4 +650,22 @@ typedef union {
 	struct hfsplus_attr_key attr;
 } __packed hfsplus_btree_key;
 
+/*
+ * There are two time systems.  Both are based on seconds since
+ * a particular time/date.
+ *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
+ *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
+ *
+ * HFS/HFS+ implementations are highly inconsistent, this one matches the
+ * traditional behavior of 64-bit Linux, giving the most useful
+ * time range between 1970 and 2106, by treating any on-disk timestamp
+ * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
+ */
+#define HFS_UTC_OFFSET 2082844800U
+
+/* January 1, 1904, 00:00:00 UTC */
+#define HFS_MIN_TIMESTAMP_SECS		-2082844800LL
+/* February 6, 2040, 06:28:15 UTC */
+#define HFS_MAX_TIMESTAMP_SECS		2212122495LL
+
 #endif /* _HFS_COMMON_H_ */
-- 
2.43.0


