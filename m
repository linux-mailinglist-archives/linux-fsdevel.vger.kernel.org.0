Return-Path: <linux-fsdevel+bounces-45378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFDA76C6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 19:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626A31664F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EEE215073;
	Mon, 31 Mar 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnmGg3Qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55108214A7D;
	Mon, 31 Mar 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440873; cv=none; b=moUJ3j+rKFCPEhKTHrUOd4IboNKxqlW1OqpNR9KbKCFuAEGfmXH+tV09XoZ8EajPAGWQEnMb/jToh/k9HGKNw4uhQ6NeuYFHZdeA8Nayqk80xQC15mCXMwFi20n5mCKegdbEpZPZBkY8YRnJYhrV8XkYc66lZn3Gm7Ku/Xvzjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440873; c=relaxed/simple;
	bh=Ac5MStQWz5ZGSFJAWjJrRkS2cgVa+kWhUxEigbooqIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LERQqm+oo3TFE/spnPj5M3K8tVAMVThMNA3KBUyh16aDYulM1eCDWw85Uxd84lKQyOSpH1J7im2FN15JpsQuWX049Im5v/THo77iOWbbm8wPpFHbF2ny/tTjL1q6bESDkZpYQznZHnXYUcmY2dI+v1dI54A+5sw2M20JQcIFC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnmGg3Qx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so85978175ad.2;
        Mon, 31 Mar 2025 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743440871; x=1744045671; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aquQkKumd4VhkPXinf4JJ+BAI1iQnswaUODJpG5BEEc=;
        b=OnmGg3QxGanZoOe8OH6uhwWuFtIdvv1MrWgG1GIGdZgF976XIHddpBV48/o1sGsfRX
         a2H/A0nD7v6hIuI73YPW2Cg29wddHQR9VEQtLvpgW1AHvQXSMriI3jCqcC+4404sH5JF
         SuX6XC1vr74frICHntbIMdm5cbUv7UagY2gHw+X44Y3aKtGW4mwYemcHB+hdP2qGvj51
         eaMaTcG4KOm7TQX9BFAQrPh4zdYUUmeaIUPdu1LaNAzPjd3mpEidhKyLs+p/dcK/ZrwR
         UKx2Sf/Ikqj/hAncDy57rVr0jUPbXxQHByAR9ZY5JidL+rlnYeg+l46JgcfeLq/d88uc
         lm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743440871; x=1744045671;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aquQkKumd4VhkPXinf4JJ+BAI1iQnswaUODJpG5BEEc=;
        b=mtBh8wAosHRSq6yNygPV7b1cFXw6bjBs/JYjSdu0alcdN9ZtjsTRlIUIxIV0lGF+1P
         0GJSK3H9eJHLtoTFel6lVyUywLYEOlaYLayCWx6xTEYqYuhfD46PEysjylMwLiH2lSuq
         6X/U9QHLvHA0ia/Sn/qo76A747KvkkWcNdJ4etqTORp8KC/021JPKy3OzCSc0tdATOxA
         dHdwCDn4NLYehehiSQoZf2zPuMbyhnSLpNKSAojSh2q2jw2zhg6qekEevzYbB0hy4rPZ
         DWcOdYlFq0pmXTsZK7WeN5zGCUSbBYsJS0CzUWVt+8zCdUI4U2nmJxvYckAECd67JaVh
         bH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWOYbn4hXx8expwbV5dzz0v1JQN4dgDQAJLbMzXTivP7Ax3OfxBQ6nL6KP+x1YzB3dkvmT62denm/UVQIF0@vger.kernel.org, AJvYcCWixzgAe/jluOIuD/sX/+cg6LX75HtCigM/6HRfrSRb5WA0QSxwJzDTBZSfxOZxYFj/B/LPj5nZOEIy5IuS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oEWL05xGfIlSQZMwFiQA+jOSYI6ouGUGAOqMsSeejnrGr7Y6
	JIi0ooPUpmVXjsdgv19rdtv2dLHS2SULAK5kINO86V4kxWZ2Q1ed
X-Gm-Gg: ASbGncuIAZoZgoiNjewJxuS8N5zFjUVJ5sTNeHYWMX4Fg0rNfBIsNzlG8mXJ7XtirIG
	k5yg8/q21LwsG6qOgG7Pk0bBZF8O+ikwYgHwshO6T0oyWmNT4mWZgDo2cj/qpkMJ6vCMTiKdVQO
	7ZUAz5nAhVdi3iZ9yyv3r3WngcuBwJqXB1BB7Nggsq4QVO3+4DqQsTPbjZ5PU4Dovk3/MbSjmTq
	bq778XqsxuAfgDauyRCDjOrlETEGEMoH+Y+SrIG3xmtEDHdtWDfRc2VPNdKlKlEXElgueJA4tqE
	qmqAzUTXVaRgmOzE/agDZh9H90vQij/dylTpk2kCLzuIFyOIkitZSdA2YIZQ1Tme6dJ51bBo1Q=
	=
X-Google-Smtp-Source: AGHT+IHzCNER8mRUkPyrZ9q6jFS0Z4BZCz8Kh5pS1gk7gv6cbwmjXQEH/vhMurcSH8lxyqLdEhPeyg==
X-Received: by 2002:a05:6a21:9188:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-2009f5fdc52mr15349617637.11.1743440871528;
        Mon, 31 Mar 2025 10:07:51 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b69b127sm6584664a12.17.2025.03.31.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:07:51 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: akpm@linux-foundation.org
Cc: adrian.ratiu@collabora.com,
	superman.xpt@gmail.com,
	brauner@kernel.org,
	felix.moessbauer@siemens.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mjguzik@gmail.com,
	syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	xu.xin16@zte.com.cn
Subject: [PATCH V4] proc: Fix the issue of proc_mem_open returning NULL
Date: Mon, 31 Mar 2025 10:06:47 -0700
Message-Id: <20250331170647.36285-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250331091635.36547-1-superman.xpt@gmail.com>
References: <20250331091635.36547-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, 31 Mar 2025 02:16:35 -0700 Penglei Jiang <superman.xpt@gmail.com> wrote:

> On Thu, 27 Mar 2025 12:24:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > On Mon, 24 Mar 2025 21:14:48 -0700 Penglei Jiang <superman.xpt@gmail.com> wrote:
> >
> > > > >  if (IS_ERR(mm))
> > > > > -return mm == ERR_PTR(-ESRCH) ? NULL : mm;
> > > > > +return mm;
> > > > >
> > > > >  /* ensure this mm_struct can't be freed */
> > > > >  mmgrab(mm);
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
> > > Mateusz Guzik provides valuable suggestions.
> > >
> > > Complete the missing NULL checks.
> >
> > proc_mem_open() can return errno, NULL or mm_struct*.  It isn't obvious
> > why.
> >
> > While you're in there can you please add documentation to
> > proc_mem_open() which explains its return values?
>
> I apologize for the delayed response.
>
> Add documentation comments to proc_mem_open() and add NULL checks in
> several call sites.

Adjust comments based on the V3 patch.

Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/proc/base.c       | 12 +++++++++---
 fs/proc/task_mmu.c   | 12 ++++++------
 fs/proc/task_nommu.c |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5538c4aee8fa..c7619e8ef399 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -827,7 +827,13 @@ static const struct file_operations proc_single_file_operations = {
 	.release	= single_release,
 };
 
-
+/*
+ * proc_mem_open() can return errno, NULL or mm_struct*.
+ *
+ *   - Returns NULL if the task has no mm (PF_KTHREAD or PF_EXITING)
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


