Return-Path: <linux-fsdevel+bounces-45320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9DA76311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747763A6D51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664C71D9A49;
	Mon, 31 Mar 2025 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9r1LbAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68326259C;
	Mon, 31 Mar 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412661; cv=none; b=oF9AoRvAKhXd4npsuBMTA2bIzviRhueNSV2JxGlGJ5vBvQfI1aIZaLDa5fD7vt3qHYZe/eGCJiPjHXcFCixzhuf4KGXGb7S20pHPHnkleWJmZ5q3w7q2NEdP4eLwmUsmnMjdrDjO2ZEHJ8pmf+yUoha/74Xijo3Vq+ifvuW52KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412661; c=relaxed/simple;
	bh=kaiELQkqTr0E/qcyQ8OuqflCAPZzOhc6NAzCCXMQDE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rfrJ3qr1BR6WCRQ8u0kIKm1Vip/iEemdj0x8VU6OwEW4mVLeLfcJBVIOQu53Km6vJWblLMYdUg/J73Y5i4wvw0Zce67wMh9F0XwFf5zyqaK5ajNydws38crORWo6kHRYPIb/FMegTu9s3YXwik7s5e+ZjeEwiILcoRwDNurl2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9r1LbAn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd89d036so90006475ad.1;
        Mon, 31 Mar 2025 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743412660; x=1744017460; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QznPLJKqzWPL35Cepg1nAB4/tw1/hzZeJhITfjvZmpQ=;
        b=T9r1LbAn6JdD0Qzi4lKRi6D378uAI9duAk1SXfw+HsXvsrY+jm2jgjqwSK9GXDFc8b
         PqJT6H4izKeKvZXXm/e+KkJm+Z2olYi3323nCJag3RYTxeIzvEdrlNcIxkki7iFHqUGP
         gx1RdHbc8p4JpxSjet+uUcQWuO6Avg82401uwSGigBHXZCD75rqVgyrB3lYfuTLGaQkN
         Xbb2dcxR3PEEBwdTB+ZsgGgNb07xJ8WqCxT1Ddb0ZfaD5H8elFO6R2CLPJO7xnPoqk9J
         AaQbrYhaLcnq5BTDMp6WX7eAuyS4cblp3kF0vDjTZCJDpR99dPi/6qOwKNddwQLCcNUw
         ahsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743412660; x=1744017460;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QznPLJKqzWPL35Cepg1nAB4/tw1/hzZeJhITfjvZmpQ=;
        b=gar/eknsqdG24yy5rFsCWluCbhEb8e+nKn6aNAZU0QkZqpsgu/3Cs8cR8snkeq2GsR
         43ej3BR9Hdj1OAkOtazBfAMR1VSBSHa2AfCfjK8k37Yo8kvd5Ha/dI483egWHIaxjIsB
         LCdsM5yK5K1GdHf5hNIIIWr3UCjc3OiD5qf/BHrC6iLTO1YtZOaEDct6HHJUzzNerB1I
         LjYCuiFbfIjPIZvKE8kqa+aboX970NCRoy9BONVjT8MP+NohntG/3xS/pRZhqBUqmH4p
         KAum5fL7qF06S7eLqtw4nDIkBMZAo56R4/aLQbWfZo6LE9hf7RxEULRkUiaDnWjQ0FON
         LheQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBbHR0Ax9C+eAqB3++zq/yF4OmNvZ48SeZVoFRy4vxZt7CJ43TJgF+TXgflq4pkNFwil78Wa9+GMXty/59@vger.kernel.org, AJvYcCXkFJqRCsE/cGa7gkreyEoINZsTbWDK4gpeS1m0vYivKkK4QzDK3FpnHPui5pUWw6XeLjmzT0AFR754DN4k@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/zuSr/Z04sM9x61KlvJzJqoK2Yt+JWvKn6EJBUEO0MH8iYez
	DTiDy/5j1xCXscNxffNRGsWb1GD+QjIv8c0W4slvjSQ2UjX4841L
X-Gm-Gg: ASbGncuLDuNV8Tt9CxLidhB+xePsC/JscA7insClMZvT0jq7CIHg7LFVcgakw5b8pZ0
	eMCvrLbDsFVwlfK4oJEXw9Fui4+63ygYXJVos+mlDR+AE1ki9TIwuPmdwDoV2AOSciyH3cESeBW
	DwiC2Rxhb14fc6FnuniaIhiYYbH1VSS3jN8YVohGELkJY9rbp/7pz1FbIolnR/LPgU9mjZBxxBx
	TnoaoXGJOQ2b21vUR9tYrHwAKbMfiAEdoA429zre3seH8RroDBmEGvcqb5LlaxNUwCn7+r1jNaV
	kR/pwceQPAK5fr2rmPDndvNteV1Q99+8t5s4QhsFYZHMqsbjgydwxy7W7ZZQxepLuZNWHBW9sQ=
	=
X-Google-Smtp-Source: AGHT+IH+90jBd+jyhuEi5x/gEVYfwAW5yK2+2Vf5DhsZy52DOKGxwEc7qUKBE9+aHjxyyxVburC4yw==
X-Received: by 2002:a17:902:d550:b0:220:fe51:1aab with SMTP id d9443c01a7336-2292f9e84a5mr166869355ad.38.1743412659660;
        Mon, 31 Mar 2025 02:17:39 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d61799sm6754474a91.23.2025.03.31.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:17:39 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: akpm@linux-foundation.org
Cc: adrian.ratiu@collabora.com,
	brauner@kernel.org,
	felix.moessbauer@siemens.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mjguzik@gmail.com,
	superman.xpt@gmail.com,
	syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	xu.xin16@zte.com.cn
Subject: [PATCH V3] proc: Fix the issue of proc_mem_open returning NULL
Date: Mon, 31 Mar 2025 02:16:35 -0700
Message-Id: <20250331091635.36547-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250327122445.cbd211c3216aa754917f3677@linux-foundation.org>
References: <20250327122445.cbd211c3216aa754917f3677@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Thu, 27 Mar 2025 12:24:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 24 Mar 2025 21:14:48 -0700 Penglei Jiang <superman.xpt@gmail.com> wrote:
>
> > > >  if (IS_ERR(mm))
> > > > -return mm == ERR_PTR(-ESRCH) ? NULL : mm;
> > > > +return mm;
> > > >
> > > >  /* ensure this mm_struct can't be freed */
> > > >  mmgrab(mm);
> > > > --
> > > > 2.17.1
> > > >
> >
> > Mateusz Guzik provides valuable suggestions.
> >
> > Complete the missing NULL checks.
>
> proc_mem_open() can return errno, NULL or mm_struct*.  It isn't obvious
> why.
>
> While you're in there can you please add documentation to
> proc_mem_open() which explains its return values?

I apologize for the delayed response.

Add documentation comments to proc_mem_open() and add NULL checks in
several call sites.

Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/proc/base.c       | 12 +++++++++---
 fs/proc/task_mmu.c   | 12 ++++++------
 fs/proc/task_nommu.c |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5538c4aee8fa..cbe4e7d557e1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -827,7 +827,13 @@ static const struct file_operations proc_single_file_operations = {
 	.release	= single_release,
 };
 
-
+/*
+ * proc_mem_open() can return errno, NULL or mm_struct*.
+ *
+ *   - Returns NULL if the task has no mm (task->flags & PF_KTHREAD)
+ *   - Returns mm_struct* on success
+ *   - Returns error code on failure
+ */
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
@@ -854,8 +860,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
 	struct mm_struct *mm = proc_mem_open(inode, mode);
 
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 
 	file->private_data = mm;
 	return 0;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f02cd362309a..14d1d8d3e432 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -212,8 +212,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -1312,8 +1312,8 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		ret = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -2045,8 +2045,8 @@ static int pagemap_open(struct inode *inode, struct file *file)
 	struct mm_struct *mm;
 
 	mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 	file->private_data = mm;
 	return 0;
 }
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bce674533000..59bfd61d653a 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -260,8 +260,8 @@ static int maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.17.1


