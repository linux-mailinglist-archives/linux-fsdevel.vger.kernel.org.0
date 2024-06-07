Return-Path: <linux-fsdevel+bounces-21143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C6B8FF9CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1545B284AC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75A17C98;
	Fri,  7 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lLdStX70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3711CBD
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725602; cv=none; b=agOtGqS+d4Es3Jwdy7MkAgkIZBCPtQygwoP2CyLHL+K8teN97OvIZ4cMjOCqkrXFBVkCpNj58pZ34Dd4A+6djcIkvBGOqYKyENTGWbM2WjoG1iDRuKYAS3rsH0wrHjMExHjZi3Mllseb226S0YA5+0hUBtrNjWAsEgvwcUnQWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725602; c=relaxed/simple;
	bh=DCBZw3e9qIg3d3t/0liOOAR0aM8WXTIml8KX0wiuLw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCFTA6zwoyOHxSEUpDj32EE3sXTwAehWN6844AD1xcQTIhkAnOhxw25eHHC1cW39R+EtdmDdgjnouh1vDgavQ9mvq9EDw8rGOAPJyyxI5nV3hdKoSSJA/d2c5VmxrIbVwV2yzRToMvliVKeOv0RPp1tLKYZTTe7N/An62P162kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lLdStX70; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+9NAfyCfKWAFq+HWRf00UnHnGDAwbGTwWuWcJFc+7ys=; b=lLdStX70HouwPx7CIQF46eGxCu
	9SMdlLf4RE8cQjiSqt53lPH21ALiYyKqRh++CsTWXLkHQhbwkUuCMzwEj3dCMigi1tXC5q4jORl8c
	sGSf63tk3Zy6DZ+JxHZnN3pH/fpZzsuqYi5vkXBTj+1v5zt3X5AgHCDVJ4PMpnwXlvA5CZ/SNfnnw
	+V5oveCn2CDX1ISjFO2k3msbMmmKuuNm8mLFJ7Sp9iIvwxCXd+uIViBZ1MDe9LBXFKy3/kGa9FiXV
	BUaJtYeV1nvIAmdrorx0oKV+RU5CbTW5uZskKm2kZECFJzaKEoyowvcSeLyvXBeS3toETWCuitx9I
	r57CJe7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOta-009xBX-12;
	Fri, 07 Jun 2024 01:59:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 05/19] add struct fd constructors, get rid of __to_fd()
Date: Fri,  7 Jun 2024 02:59:43 +0100
Message-Id: <20240607015957.2372428-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	Make __fdget() et.al. return struct fd directly.
New helpers: BORROWED_FD(file) and CLONED_FD(file), for
borrowed and cloned file references resp.

	NOTE: this might need tuning; in particular, inline on
__fget_light() is there to keep the code generation same as
before - we probably want to keep it inlined in fdget() et.al.
(especially so in fdget_pos()), but that needs profiling.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c            | 26 +++++++++++++-------------
 include/linux/file.h | 33 +++++++++++----------------------
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 8076aef9c210..f78e114a03cc 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1128,7 +1128,7 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -1145,22 +1145,22 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 	if (likely(atomic_read_acquire(&files->count) == 1)) {
 		file = files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
-			return 0;
-		return (unsigned long)file;
+			return EMPTY_FD;
+		return BORROWED_FD(file);
 	} else {
 		file = __fget_files(files, fd, mask);
 		if (!file)
-			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+			return EMPTY_FD;
+		return CLONED_FD(file);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+struct fd fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
-EXPORT_SYMBOL(__fdget);
+EXPORT_SYMBOL(fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+struct fd fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
@@ -1181,16 +1181,16 @@ static inline bool file_needs_f_pos_lock(struct file *file)
 		(file_count(file) > 1 || file->f_op->iterate_shared);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+struct fd fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	struct fd f = fdget(fd);
+	struct file *file = fd_file(f);
 
 	if (file && file_needs_f_pos_lock(file)) {
-		v |= FDPUT_POS_UNLOCK;
+		f.word |= FDPUT_POS_UNLOCK;
 		mutex_lock(&file->f_pos_lock);
 	}
-	return v;
+	return f;
 }
 
 void __f_unlock_pos(struct file *f)
diff --git a/include/linux/file.h b/include/linux/file.h
index 39eb10a1bbfc..7bc6e24e86ce 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -53,6 +53,14 @@ static inline bool fd_empty(struct fd f)
 }
 
 #define EMPTY_FD (struct fd){0}
+static inline struct fd BORROWED_FD(struct file *f)
+{
+	return (struct fd){(unsigned long)f};
+}
+static inline struct fd CLONED_FD(struct file *f)
+{
+	return (struct fd){(unsigned long)f | FDPUT_FPUT};
+}
 
 static inline void fdput(struct fd fd)
 {
@@ -63,30 +71,11 @@ static inline void fdput(struct fd fd)
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
 extern struct file *fget_task(struct task_struct *task, unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
-static inline struct fd __to_fd(unsigned long v)
-{
-	return (struct fd){v};
-}
-
-static inline struct fd fdget(unsigned int fd)
-{
-	return __to_fd(__fdget(fd));
-}
-
-static inline struct fd fdget_raw(unsigned int fd)
-{
-	return __to_fd(__fdget_raw(fd));
-}
-
-static inline struct fd fdget_pos(int fd)
-{
-	return __to_fd(__fdget_pos(fd));
-}
+struct fd fdget(unsigned int fd);
+struct fd fdget_raw(unsigned int fd);
+struct fd fdget_pos(unsigned int fd);
 
 static inline void fdput_pos(struct fd f)
 {
-- 
2.39.2


