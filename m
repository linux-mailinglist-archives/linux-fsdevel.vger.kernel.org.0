Return-Path: <linux-fsdevel+bounces-19226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5653D8C1A05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C828568D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D715130A46;
	Thu,  9 May 2024 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zw9hjYV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24351132808
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298131; cv=none; b=e9kT6KNTUXvvqMEQYo76QUsq4tOovObVUWsKhEnv5QnzyuLahffkNcH3JniGrLjQAvDzhZ0LYJY9Gp2QbJZMOI8NoE+0GC2K9eVYw2XD4gEmmfpoSPL1tHOFhbLz8UbNBtxQKwgjQsV50K7vdBikjQNwCCutgIHi63RiNyzOpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298131; c=relaxed/simple;
	bh=upkR+XksKysYVRUNXvUH9L45v4/aavvI+H4cuZkXN2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NjvB4T4qc+BYhZMwGKL5w8PxRo1BCOyGFK9FTCLIbRObZwuriYa1EDF8vhj2CqcGrr0BOVxAbAUXl3EKJK7n8iTI00ZlCiSlZpf0D15Jjh7ZoXtD5eEXh422kfF3wldSqob6nkC3hMSE+JqYdXO/ywaNriGbrkkRc3Hrgcwcl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zw9hjYV1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be530d024so23122037b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715298129; x=1715902929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eKEsBmeaAZMUE4eVHP/KrRhV46Xl2ww7aZZs66g2CU=;
        b=zw9hjYV1DqM5a7ypTJ2HOe0CXbBRQ0PxMLV3qyzZ/yCUU1CKz+45opoSdwF966DKzm
         Cojmwy3FTFTUWLCcpPlmVt3OSLfQ8MePdp5nSQOwGCMSgkzG2SzCVYIFoh3fZIm2O5Ta
         n4OlTBgXJ+6sM5opkczGIlE77qFH4T7Oz39EufeDmFnIkq+E8n0BdTXxOe0QCYy+70Dc
         vhz6xBm2KJkqPr0Ui7aQskEWpsRdSXp3JD6zSq9dlcRh0NoprhlTiIo5C0nhu3S/zxfV
         1s7SWzHjhp85hIqRr/puX5z0Xi7inW9yNg4SIddHWwmleJqxrLkRjKQrpXa2akN8cawJ
         99EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715298129; x=1715902929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eKEsBmeaAZMUE4eVHP/KrRhV46Xl2ww7aZZs66g2CU=;
        b=bA+Gcw019WlIHEjzOyXx2Y+AWWmyDG4FTWsNWzlhb+1ejO9w0qLiQ7OfOJtIaNThqz
         4KQrYF/dxGgqeXaHPtkp+QCqyANInov3p+XqzSjOKYLdETECeevNZSPurL/RpxTBCKue
         n0irK5/Hwkjd+mYmGPZ6Zpk67YI4S41M1K0pp3xF/S1fYO9dt6a3tJoKqpssgIxWitcZ
         yK6jJakicIThZXuiQZETC/1i4bcVYWQTVKcyNHFb5PpuqtxAjL4eVYwmbxNtvZRt+/3i
         W5rrSIM5u3HJ3whpTCfQyHT6wMSLu6KNmt3IpE5NFKHzSljBtNuUxQSp0N5sQ9VX9+1V
         s9gA==
X-Gm-Message-State: AOJu0YxZD3zvKjT7C3lBzVoSl8XYlZhT8+xEtFrV+TyhW3SRuRbjXPl6
	pZCIyHjnv6E+b9Nc5BcDDHZTd/mi3cMZCBmTENjE6lcpQnNvNz9MQc91MnY9l/sgIjb6R3HGJPc
	p4CrIQQaLDEKpVSoRrM/9wQ==
X-Google-Smtp-Source: AGHT+IF3IktBPUp05ZCNGiRUWE9GBrzvrzUFZM+LfPayXNouSjgolDRwmURT/GTW9zmbvJ4tidNZrp1F3HllK4lD1A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:45c2:b0:61b:eab3:f18a with
 SMTP id 00721157ae682-622afffcf3emr2505507b3.8.1715298129166; Thu, 09 May
 2024 16:42:09 -0700 (PDT)
Date: Thu, 09 May 2024 23:42:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE5fPWYC/32NUQrCMBBEr1L225VNiCn1y3tIkbZZ0wVtSlKqU
 nJ3Yw/g5xtm3myQOAonOFcbRF4lSZgK6EMFw9hNnlFcYdCkDZ2owd5g6WDkzt1eURZGMp2qnSG riaHs5sh3ee/Oa1t4lLSE+NkvVvVL/9lWhQrJ9jyUkrZNffEh+Acfh/CENuf8BVEpVCKzAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715298128; l=7104;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=upkR+XksKysYVRUNXvUH9L45v4/aavvI+H4cuZkXN2w=; b=i7SXO3XY46Qn+ZApSYZic1ynZf/xvXNfvXj44LuuS1zaowHiLkglP1WdgpiD6RtB6PEMpMqHH
 QoPLdPXyLp9Dh22aVSYMwIJWNLC/Qp0QverfCRyFSvSk0crH0KIfClF
X-Mailer: b4 0.12.3
Message-ID: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>
Subject: [PATCH v2] fs: fix unintentional arithmetic wraparound in offset calculation
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

When running syzkaller with the newly reintroduced signed integer
overflow sanitizer we encounter this report:

[   67.995501] UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
[   68.000067] 9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
[   68.006266] CPU: 4 PID: 10851 Comm: syz-executor.5 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[   68.012353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   68.018983] Call Trace:
[   68.020803]  <TASK>
[   68.022540]  dump_stack_lvl+0x93/0xd0
[   68.025222]  handle_overflow+0x171/0x1b0
[   68.028053]  generic_file_llseek_size+0x35b/0x380

amongst others:
UBSAN: signed-integer-overflow in ../fs/read_write.c:1657:12
142606336 - -9223372036854775807 cannot be represented in type 'loff_t' (aka 'long long')
...
UBSAN: signed-integer-overflow in ../fs/read_write.c:1666:11
9223372036854775807 - -9223231299366420479 cannot be represented in type 'loff_t' (aka 'long long')

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Fix the accidental overflow in these position and offset calculations
by checking for negative position values, using check_add_overflow()
helpers and clamping values to expected ranges.

Since @offset is later limited by @maxsize, we can proactively safeguard
against exceeding that value (and by extension avoiding integer overflow):
	loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
	{
		if (offset < 0 && !unsigned_offsets(file))
			return -EINVAL;
		if (offset > maxsize)
			return -EINVAL;
		...

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/358
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- fix some more cases syzkaller found in read_write.c
- use min over min_t as the types are the same
- Link to v1: https://lore.kernel.org/r/20240509-b4-sio-read_write-v1-1-06bec2022697@google.com
---
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
 fs/read_write.c  | 18 +++++++++++-------
 fs/remap_range.c | 12 ++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..d116e6e3eb3d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 {
 	switch (whence) {
 	case SEEK_END:
-		offset += eof;
+		offset = min(offset, maxsize - eof) + eof;
 		break;
 	case SEEK_CUR:
 		/*
@@ -105,7 +105,8 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
 		 * like SEEK_SET.
 		 */
 		spin_lock(&file->f_lock);
-		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
+		offset = vfs_setpos(file, min(file->f_pos, maxsize - offset) +
+					      offset, maxsize);
 		spin_unlock(&file->f_lock);
 		return offset;
 	case SEEK_DATA:
@@ -1416,7 +1417,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
-	loff_t size_in;
+	loff_t size_in, in_sum, out_sum;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1450,8 +1451,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
 		return -ETXTBSY;
 
-	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
+	if (check_add_overflow(pos_in, count, &in_sum) ||
+	    check_add_overflow(pos_out, count, &out_sum))
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
@@ -1467,8 +1468,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 
 	/* Don't allow overlapped copying within the same file. */
 	if (inode_in == inode_out &&
-	    pos_out + count > pos_in &&
-	    pos_out < pos_in + count)
+	    out_sum > pos_in &&
+	    pos_out < in_sum)
 		return -EINVAL;
 
 	*req_count = count;
@@ -1649,6 +1650,9 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
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


