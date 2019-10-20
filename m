Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D78DDFBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfJTRaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 13:30:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45665 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfJTRaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:30:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so6267996wrs.12;
        Sun, 20 Oct 2019 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Hp6/7aiRcZ0yQQZ/KGKHJFbeoYr0FPIkHZCliAG4wpw=;
        b=SVx3vkZLaoVR+ubRyrKDjia4xbpjAv1zlKzbH4bo+G0emFjLxUWQjkT/dNfEzzZwkm
         6zrP4h7r9GYsBl6U6i2xHlerl7ib9HhtelLYiRXYQRwyfLq8WrnFZd6Qg3uuaz9Fb/gm
         HWaoDy39ZfeXiqfEeXkqfuwtt0opZ3dO9fw5+DfA+Ut+JpQ2Eu/Vbhp1Nip5+CF2rlxB
         cUdRy9yXIscqP+zdQ9zLrVZpGsSGvAaUrAAiphVa2gOhfLzBZNkAoTjQxDnNroYBHXzc
         KUF1daL3lsdNt4JY7fg3st2B9lm3RxVGVcfwmSOgg8RbpuS70JOScfPde86DoAJ6vUJx
         LLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Hp6/7aiRcZ0yQQZ/KGKHJFbeoYr0FPIkHZCliAG4wpw=;
        b=DaqfEbDkhqgbbEf9kwuYUbTyU0zClVUQuE9IlortbtLhRty2MBuYl1eiOkDLhXcsrP
         8at06Zpq9SsOWwxWGc4a/Uqr1GvDy7MqEqN/e7W9RpN6ugUGYj8LoRgFyPrAhBfrjmCA
         p5mQFgru9PjD5wOdcd8BC4EYrVKZ1EI4szw8oGUwW/19i02UtenNmB0pP3/d/kLn4cqu
         u90F+8MpoL7pKqntAOM5S/hvTsbPHJBZgp1UFPRJ7NGWSNVM51aO2OriVQSjkeMyTTwi
         BfJG9plP9qDTpfCuUEZsGIDtGzaSKHTQBEWLcNFJY0LuUMoeqL/lTaaRgbFt38UBGk/Y
         Vc4A==
X-Gm-Message-State: APjAAAUKTfxDuY5/DPyZD5/ue1Mi7fNDRi034DejJp8fFLLDgSFd33qq
        8X83iwHSC5z8Kk0P6FuxFQ==
X-Google-Smtp-Source: APXvYqzSA9ZMmuXEmm67nRUhHr1P0lids01/BF5eido3mjpTKGQ53FFREhGvNlFykkelY8q3NG9oLA==
X-Received: by 2002:adf:9044:: with SMTP id h62mr10556717wrh.91.1571592613209;
        Sun, 20 Oct 2019 10:30:13 -0700 (PDT)
Received: from avx2 ([46.53.254.76])
        by smtp.gmail.com with ESMTPSA id a3sm11251353wmc.3.2019.10.20.10.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 10:30:12 -0700 (PDT)
Date:   Sun, 20 Oct 2019 20:30:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        elver@google.com, viro@zeniv.linux.org.uk
Subject: [PATCH] proc: fix inode uid/gid writeback race
Message-ID: <20191020173010.GA14744@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(euid, egid) pair is snapshotted correctly from task under RCU,
but writeback to inode can be done in any order.

Fix by doing writeback under inode->i_lock where necessary
(/proc/* , /proc/*/fd/* , /proc/*/map_files/* revalidate).

Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c     |   25 +++++++++++++++++++++++--
 fs/proc/fd.c       |    2 +-
 fs/proc/internal.h |    2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1743,6 +1743,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	*rgid = gid;
 }
 
+/* use if inode is live */
+void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
+			      struct inode *inode)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	task_dump_owner(task, mode, &uid, &gid);
+	/*
+	 * There is no atomic "change all credentials at once" system call,
+	 * guaranteeing more than _some_ snapshot from "struct cred" ends up
+	 * in inode is not possible.
+	 */
+	spin_lock(&inode->i_lock);
+	inode->i_uid = uid;
+	inode->i_gid = gid;
+	spin_unlock(&inode->i_lock);
+}
+
 struct inode *proc_pid_make_inode(struct super_block * sb,
 				  struct task_struct *task, umode_t mode)
 {
@@ -1769,6 +1788,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	if (!ei->pid)
 		goto out_unlock;
 
+	/* fresh inode -- no races */
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
 
@@ -1802,6 +1822,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 			 */
 			return -ENOENT;
 		}
+		/* "struct kstat" is thread local, atomic snapshot is enough */
 		task_dump_owner(task, inode->i_mode, &stat->uid, &stat->gid);
 	}
 	rcu_read_unlock();
@@ -1815,7 +1836,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
  */
 void pid_update_inode(struct task_struct *task, struct inode *inode)
 {
-	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
+	task_dump_owner_to_inode(task, inode->i_mode, inode);
 
 	inode->i_mode &= ~(S_ISUID | S_ISGID);
 	security_task_to_inode(task, inode);
@@ -1990,7 +2011,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 	mmput(mm);
 
 	if (exact_vma_exists) {
-		task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+		task_dump_owner_to_inode(task, 0, inode);
 
 		security_task_to_inode(task, inode);
 		status = 1;
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -101,7 +101,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 				fmode_t f_mode)
 {
-	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+	task_dump_owner_to_inode(task, 0, inode);
 
 	if (S_ISLNK(inode->i_mode)) {
 		unsigned i_mode = S_IFLNK;
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -123,6 +123,8 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
 
 void task_dump_owner(struct task_struct *task, umode_t mode,
 		     kuid_t *ruid, kgid_t *rgid);
+void task_dump_owner_to_inode(struct task_struct *task, umode_t mode,
+			      struct inode *inode);
 
 unsigned name_to_int(const struct qstr *qstr);
 /*
