Return-Path: <linux-fsdevel+bounces-44935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9460A6E8D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 05:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B246188A6CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634A1A76AE;
	Tue, 25 Mar 2025 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Y2j2C1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C419E98C;
	Tue, 25 Mar 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876100; cv=none; b=MAd7xlFfVzQ9I9Ov+Cq/Hf2O5lR0/hQcFEHXbcuLarZb3pk+oYgL5I2uFwImRDkuTMzTaNVU3K3TIydkuO13QEH8UYctmdg8RWR7Df01lF+bLmeo6WlK5fLOL5of/h9GZm3fvur+4DDwSxshyxf7UWWfQpXsD+aUXG3g/zbiATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876100; c=relaxed/simple;
	bh=13ymGvOxQHq7CtZ+BMVOFQ4rdep4nCwxm257XsS+T8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s5N78Dq2x4kRNzHpr1Iwh4pKRQY23ifbcAxY2Asg4L8BWYYRnI2PLNKPzThdGifNByvv7NwoI58AfgEwqNNJ7txVf7Sm9AgWv+XsBQqhjl/8k7helb8AFnV1oTIaJwbjRExQhojdksf14QSqt552pfoXV/0vEk99jJTBj4Hi/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Y2j2C1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224341bbc1dso96830865ad.3;
        Mon, 24 Mar 2025 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742876098; x=1743480898; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Z+v7Jn9beBer1FkhIJ6pBhkHOPTxa22J6kYt2PvD38=;
        b=H+Y2j2C1A50V2jdb7yVzssn0SEp1NBQTOBEVClPSjFcZOt32itBY4g/dAZd0hkDfxd
         YCIk4lAl39/29NTbC7/Mly3vpCoI5x4CoCzP1KHL174bXnp1SfmuAGFx3P1MLHI7Fr+D
         PBiug+Zt52ge8hYhOD7OpjCm2bjvUnqEdipvOtVjpGXLOwtylFCz6X8eZPzeEJnVrw5O
         H7rbHhIZCavRBnVDO91JI7XQ/mSFSKg2uw38CeN9oPzAcbOk2g4iuy1p6NoVejeafbw+
         GHD8xZ/l53y6kR3RiLLfWZGshPn5krzMwZnIhj3qKOTHBWFECC4lzShrzpnEkTd/OUR2
         /6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742876098; x=1743480898;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z+v7Jn9beBer1FkhIJ6pBhkHOPTxa22J6kYt2PvD38=;
        b=FGGT+1XMmnjSKP0UOgJApPjjYBJFwIiMx3B+ZmzZbtyXMigtxyBOxxsBbkb56TeW3B
         PNNKRaAuew/Aoq4Xr07lNFvhj55d/1Z44ctZhTmHscodPBIQI3z+BIvKwkg28aeu0IV8
         4lxhPz9mq8VpqZf8DFSGM5n2ushL/kbQtbwdqJ0vJP95xfCOf2y4K6zVLLND5AjltvD4
         UJ9GKjU8HDMkejGMRqOpclCsvRmPeAA3cf7ufN1qGR+FPn5UE/VphV38BsMhm4rNJuQq
         IvI7cDo14frbNut+4ZJjS3hl7sQ1CacMIqFlHYyjp/CqAxb6A9Wej9zzDpOO3lM2EvmU
         dasQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQliJci6dS+1Cq8NCO2cqSI93U+xVWqVgn8eoeV7WedicBwJIvj/t23yy6yTt2bWVPqO+wswUE9s7BXgH@vger.kernel.org, AJvYcCX6xg/FXfz8ZLaUqq+YK5al2dGdzsoUh+LKobLUZEPzLPkUTS5gaqkdL/W2bQBMCrrECkTIDovuhdBY4Q7R@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrj0I74j0wdcPhfIz8dG5OzC8SSVQ81F2vDmjKsvk7UrwImqC7
	os+oT0/chXP4/+ycKl0P5/doMLoR2A4mWhm8Q5kfOyeQlxQh+px5
X-Gm-Gg: ASbGncsYxcPQqFNXEAPLv9OdIv/EHUvdQxioen1tkm9A7hoQKu29VqnKi3g3jAaVGT4
	W77E8JmyJzS/k8boAUYxq1QajB+3tKQ7CqwUeMT/f6sH01GU/5WN3Wuz38LYZySbXEuRuZrUWom
	DupfjInJan3JTuSdw94ZluAQ23RRzWLqfwtmAAUryyw+CZkyfHNNNHEq5Cn8yI1rI0mDG9Ujd0H
	03EFw64e+FHwB03XAxSC6So54o72e75Xyv+PI3LE+wtRZ+oOmiMLHYu1lKBuydiuwaKxYWezr7i
	T9lr29RunEeCasvRLi9Iw0BGT1EGTLPmaMJ7qH8a2MPPczFUJRwOT0Ti7/XbofJePoDhkh6rNEy
	w6Wfy
X-Google-Smtp-Source: AGHT+IGhOZmiC2eth2WL1r0oxdj8u60sBUhVZ+SVsC11s7uTwEQzGmI4MIGxY8M00w4ZHPEej2wgRA==
X-Received: by 2002:a05:6a00:84c:b0:736:4644:86e6 with SMTP id d2e1a72fcca58-739059c3dfdmr22049172b3a.12.1742876097778;
        Mon, 24 Mar 2025 21:14:57 -0700 (PDT)
Received: from ubuntu.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa4021sm9327650b3a.13.2025.03.24.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 21:14:57 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: mjguzik@gmail.com
Cc: adrian.ratiu@collabora.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	felix.moessbauer@siemens.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	superman.xpt@gmail.com,
	syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	xu.xin16@zte.com.cn
Subject: [PATCH V2] proc: Fix the issue of proc_mem_open returning NULL
Date: Mon, 24 Mar 2025 21:14:48 -0700
Message-Id: <20250325041448.43211-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ajipijba74lvxh2qqyxbxtbmlqil2smsuxayym5ipbmjdysxq2@stvu4kt62yzu>
References: <ajipijba74lvxh2qqyxbxtbmlqil2smsuxayym5ipbmjdysxq2@stvu4kt62yzu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi, all

On Mon, 24 Mar 2025 18:48:35 +0100, Mateusz Guzik wrote:
> On Mon, Mar 24, 2025 at 09:23:53AM -0700, Penglei Jiang wrote:
> > The following functions call proc_mem_open but do not handle the case
> > where it returns NULL:
> >
> >   __mem_open in fs/proc/base.c
> >   proc_maps_open in fs/proc/task_mmu.c
> >   smaps_rollup_open in fs/proc/task_mmu.c
> >   pagemap_open in fs/proc/task_mmu.c
> >   maps_open in fs/proc/task_nommu.c
> >
> > The following reported bugs may be related to this issue:
> >
> >   https://lore.kernel.org/all/000000000000f52642060d4e3750@google.com
> >   https://lore.kernel.org/all/0000000000001bc4a00612d9a7f4@google.com
> >
> > Fix:
> >
> > Modify proc_mem_open to return an error code in case of errors, instead
> > of returning NULL.
> >
>
> The rw routines associated with these consumers explictly NULL check
> mm, which becomes redundant with the patch.
>
> While I find it fishy that returning NULL was ever a thing to begin
> with, it is unclear to me if it can be easily changed now from
> userspace-visible behavior standpoint.
>
> I think the best way forward for the time being is to add the missing
> NULL checks instead.
>
> > Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> > ---
> >  fs/proc/base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index cd89e956c322..b5e7317cf0dc 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -840,7 +840,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
> >  put_task_struct(task);
> >
> >  if (IS_ERR(mm))
> > -return mm == ERR_PTR(-ESRCH) ? NULL : mm;
> > +return mm;
> >
> >  /* ensure this mm_struct can't be freed */
> >  mmgrab(mm);
> > --
> > 2.17.1
> >

Mateusz Guzik provides valuable suggestions.

Complete the missing NULL checks.

Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/proc/base.c       |  4 ++--
 fs/proc/task_mmu.c   | 12 ++++++------
 fs/proc/task_nommu.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..d898cec3ee71 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -854,8 +854,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
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


