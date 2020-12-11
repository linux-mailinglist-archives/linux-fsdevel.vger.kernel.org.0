Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A52D70AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 08:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436648AbgLKHMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 02:12:24 -0500
Received: from m12-14.163.com ([220.181.12.14]:39588 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390203AbgLKHLs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=7k57n
        zgxTmg63EGVLxW5mIM+m/V9eJh8YrG1t/tkZPE=; b=EsK2GrZRn+2W2n3hVfaWx
        antpcA0kmBCxjlo6ujDd5h2YXMvWqFX6ELDLu0PQ5UVb6QUHKu6tnsftwQWBnfTM
        JkYxYm9H8UAPNCUuRRn2vPXMkivdgaQFiJu6A+N2IJxmQ00ywN8qcRVpHYM8ABLv
        1VDTttgmPIw21WyozE+MYw=
Received: from localhost (unknown [223.104.64.138])
        by smtp10 (Coremail) with SMTP id DsCowAC3gLaAD9NfCoNjaQ--.26709S2;
        Fri, 11 Dec 2020 14:19:45 +0800 (CST)
Date:   Fri, 11 Dec 2020 14:19:44 +0800
From:   Hui Su <sh_def@163.com>
To:     adobriyan@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: make pde_get() return nothing
Message-ID: <20201211061944.GA2387571@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowAC3gLaAD9NfCoNjaQ--.26709S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyftFy8Ary8Cry5JF4rGrg_yoWfGFg_Cr
        92vF18Gr4rKryrtw4jkr1S9ryrXw4rKas5WF4fta97J398JFZ0yrZrGr97Zr97WrWrtF15
        Cw1vvFnIqr4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbIJm5UUUUU==
X-Originating-IP: [223.104.64.138]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitwH3X1aEGw1QPAAAs2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

we don't need pde_get()'s return value, so make
pde_get() return nothing

Signed-off-by: Hui Su <sh_def@163.com>
---
 fs/proc/internal.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..0abbd93a4a08 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -190,10 +190,9 @@ struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_e
 extern int proc_readdir(struct file *, struct dir_context *);
 int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
 
-static inline struct proc_dir_entry *pde_get(struct proc_dir_entry *pde)
+static inline void pde_get(struct proc_dir_entry *pde)
 {
 	refcount_inc(&pde->refcnt);
-	return pde;
 }
 extern void pde_put(struct proc_dir_entry *);
 
-- 
2.29.2


