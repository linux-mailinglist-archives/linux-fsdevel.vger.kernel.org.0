Return-Path: <linux-fsdevel+bounces-19630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729418C7F30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 02:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299482837F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3888472;
	Fri, 17 May 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BodnNUsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAB7490
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905750; cv=none; b=F2HqN1PN+YQLsM3XuXzlp0mUWYyKYfVW7UQ2hSzVfFm+ppbYVlP65vHgBULEDAmjObmGEE/D1oIV2Xp3GAj0zenZFZuXiFDq95bV1ol1eDWSBiWYeNmakMuzl+v8mAMFxuP7WrU2ImDsS6AfUOmrhBOQTTrMB39QsjkvEUnFTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905750; c=relaxed/simple;
	bh=gQ3Z4if0NCnHXjJscYunu4D0mRks+UukL032g9TjvSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WoKLuPHqYldrO0+5sypKLTGf/hSJ3hdavWbZwHTjM+LuKgpzkDIFJnBORCCFV7Zh5oEyjhewD7tfoWRJ4qjiAaRhMKUST3D5B5rZDrrXxFs4a4SbJMlGNw8nmo0uI5AD+YN092lxpRX0Pwwei0Vh69ypTIWVIF5e87CAYdsILC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BodnNUsM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so18929073276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715905747; x=1716510547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lE+oHrKpJl/rpkYtTR5+jfWYh1cBDJx1MoxTnYfmQ5U=;
        b=BodnNUsMDdzzau9h5t4Ion0DCPsEHZKC7C5CsY4d/Zelp/V2kPIK26ynxDFRLZDDIn
         exnb9Ojv/OQ6KvOauFygsyayj+0XUBy0r8YPLxZFZzGk2LrHFE1ZyQvqEiejaE9Nip6X
         DoYYN/P4RW4o+GdeTbjgkM1n+HVNGrO2BhufujCayv/PMqcoIvLNwgkpp1p4VAr1T+Hw
         0XEaGgbYReNWhueQCBTkXO1FqFniFX1Fh4hw6fnrC/f1NSZGU/59/zeqPanmbqqcawx8
         nN980pbQJ/q0FclI4LjlN3yKmh9A9uJoctuwu7r8emIri8QP7cyPtWNjnhEmmBgs+PdC
         zJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905747; x=1716510547;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lE+oHrKpJl/rpkYtTR5+jfWYh1cBDJx1MoxTnYfmQ5U=;
        b=RPJhrQzM8vWZYhmU7oNAKTkYomXnA14uhQTCMyQuqaQIldEggocnVKTr8y5x2UkuEX
         1Lx2Ilhob1FTze9XTUUX70ZbYvh3iHCIfuiBk9xXP3ngZFJgyD7RVxTptXySJT9Wyjbq
         B2U77tnSqa4eeYkmYNUU2i+on4pFt4QWps/4a0BIBHOdN91vcYZmWt7Y9OpWBOpkh/DW
         cefaod0ryRfqpS/W6w7zfo/6ee60X9H3x4KdgmigMKjy5tmC80MFYHlVqhZXj41QhMfF
         IscOCLp1QqC5L6uOTb0tO2hRhtiEwSQ3WWnxWnqZ7O+nyvrtCY6x3VlAMHUwhJWEQSoP
         we3w==
X-Forwarded-Encrypted: i=1; AJvYcCViBohjZA8rqLNMvVlazMiFE5C6ozOE0129RKvDwPc35IoT7f+EYy1mh8RLJ1M9oEnHqCjrEoAg/BPuW02qFhBuMH5oBj9MuQJQFHUs/Q==
X-Gm-Message-State: AOJu0YwUsA1vZKNTBV+HPg+I9X/Yg+IOHeW2I3zjMBHBI80tCEF54fZ6
	AZ6l0cbm5zvpYyXU7GeL7qDatTbCDl397kac4fx4lXes8oZ20SXWSK+YkH28Mvi+HrRdTMLTlgY
	GYzmXyWSkathdoRdE8NMN1Q==
X-Google-Smtp-Source: AGHT+IHsm3A3n7MqDMvmWlLVL36ymXM4bAo3S6sZ2zLfdTzL/TzI7fAjCdnyRv309qm0dkbegqI0EV9AKZBYJ1N2pA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:f81:b0:de4:5ec1:57af with
 SMTP id 3f1490d57ef6-dee4f3022d0mr5316676276.10.1715905747620; Thu, 16 May
 2024 17:29:07 -0700 (PDT)
Date: Fri, 17 May 2024 00:29:06 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANGkRmYC/4XNQQ6CMBAF0KuQWTumLbUIK+9hjIEywCRKTUuqh
 nB3Czs3uvyT/9/MEMgzBaiyGTxFDuzGFPJdBnaox56Q25RBCaXFQZTYaEwd9FS316fniVDoWha
 tFkYJgrR7eOr4tZnnS8oDh8n59/YiyvX6S4sSJQrTkE0lZcri1DvX32hv3R1WLqq/hFoJeeysJ JPnpfoilmX5AJDnflv2AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715905746; l=6762;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gQ3Z4if0NCnHXjJscYunu4D0mRks+UukL032g9TjvSE=; b=LIOOmuQGKnIVdx7wWcIXa2kQ91OAmVr3Iwyn7sDMB+ecfZxlw8ap6gweS+c8niZT4HLDC9U6F
 nG5iLBqw9aeDcbEUoaO1xlYJjeEy6dFKVMhYkGP4J6W2x17kj9hzU5O
X-Mailer: b4 0.12.3
Message-ID: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
Subject: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset calculation
From: Justin Stitt <justinstitt@google.com>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

When running syzkaller with the newly reintroduced signed integer
overflow sanitizer we encounter this report:

UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
Call Trace:
 <TASK>
 dump_stack_lvl+0x93/0xd0
 handle_overflow+0x171/0x1b0
 generic_file_llseek_size+0x35b/0x380

... amongst others:
UBSAN: signed-integer-overflow in ../fs/read_write.c:1657:12
142606336 - -9223372036854775807 cannot be represented in type 'loff_t' (aka 'long long')
...
UBSAN: signed-integer-overflow in ../fs/read_write.c:1666:11
9223372036854775807 - -9223231299366420479 cannot be represented in type 'loff_t' (aka 'long long')

Fix the accidental overflow in these position and offset calculations
by checking for negative position values, using check_add_overflow()
helpers and clamping values to expected ranges.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/358
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- use check_add_overflow() instead of min() to keep old -EINVAL behavior (thanks Jan)
- shorten UBSAN splat in commit log, reword commit log
- Link to v2: https://lore.kernel.org/r/20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com

Changes in v2:
- fix some more cases syzkaller found in read_write.c
- use min over min_t as the types are the same
- Link to v1: https://lore.kernel.org/r/20240509-b4-sio-read_write-v1-1-06bec2022697@google.com
---
Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Here's the syzkaller reproducer:
| # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
| # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
| # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
| # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
| # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
| # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
| # Fault:false FaultCall:0 FaultNth:0}}
| r0 = openat$sysfs(0xffffffffffffff9c, &(0x7f0000000000)='/sys/kernel/address_bits', 0x0, 0x98)
| lseek(r0, 0x7fffffffffffffff, 0x2)

... which was used against Kees' tree here (v6.8rc2):
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer

... with this config:
https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
---
 fs/read_write.c  | 20 +++++++++++++-------
 fs/remap_range.c | 12 ++++++------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..8be30c8829a9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -88,7 +88,8 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 {
 	switch (whence) {
 	case SEEK_END:
-		offset += eof;
+		if (check_add_overflow(offset, eof, &offset))
+			return -EINVAL;
 		break;
 	case SEEK_CUR:
 		/*
@@ -105,7 +106,9 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 		 * like SEEK_SET.
 		 */
 		spin_lock(&file->f_lock);
-		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
+		if (check_add_overflow(offset, file->f_pos, &offset))
+			return -EINVAL;
+		offset = vfs_setpos(file, offset, maxsize);
 		spin_unlock(&file->f_lock);
 		return offset;
 	case SEEK_DATA:
@@ -1416,7 +1419,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
-	loff_t size_in;
+	loff_t size_in, in_sum, out_sum;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1450,8 +1453,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
 		return -ETXTBSY;
 
-	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &in_sum) ||
+	    check_add_overflow(pos_out, count, &out_sum))
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
@@ -1467,8 +1470,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 
 	/* Don't allow overlapped copying within the same file. */
 	if (inode_in == inode_out &&
-	    pos_out + count > pos_in &&
-	    pos_out < pos_in + count)
+	    out_sum > pos_in &&
+	    pos_out < in_sum)
 		return -EINVAL;
 
 	*req_count = count;
@@ -1649,6 +1652,9 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 	loff_t max_size = inode->i_sb->s_maxbytes;
 	loff_t limit = rlimit(RLIMIT_FSIZE);
 
+	if (pos < 0)
+		return -EINVAL;
+
 	if (limit != RLIM_INFINITY) {
 		if (pos >= limit) {
 			send_sig(SIGXFSZ, current, 0);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index de07f978ce3e..4570be4ef463 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	uint64_t bcount;
-	loff_t size_in, size_out;
+	loff_t size_in, size_out, in_sum, out_sum;
 	loff_t bs = inode_out->i_sb->s_blocksize;
 	int ret;
 
@@ -44,17 +44,17 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
 		return -EINVAL;
 
-	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
-		return -EINVAL;
+	if (check_add_overflow(pos_in, count, &in_sum) ||
+	    check_add_overflow(pos_out, count, &out_sum))
+		return -EOVERFLOW;
 
 	size_in = i_size_read(inode_in);
 	size_out = i_size_read(inode_out);
 
 	/* Dedupe requires both ranges to be within EOF. */
 	if ((remap_flags & REMAP_FILE_DEDUP) &&
-	    (pos_in >= size_in || pos_in + count > size_in ||
-	     pos_out >= size_out || pos_out + count > size_out))
+	    (pos_in >= size_in || in_sum > size_in ||
+	     pos_out >= size_out || out_sum > size_out))
 		return -EINVAL;
 
 	/* Ensure the infile range is within the infile. */

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240509-b4-sio-read_write-04a17d40620e

Best regards,
--
Justin Stitt <justinstitt@google.com>


