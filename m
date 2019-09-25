Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35ABE64C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfIYUYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 16:24:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbfIYUYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:24:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so8394724wrw.9;
        Wed, 25 Sep 2019 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZYUsiGN/v7rmxvBrV3sHc6QG8Ce/8ZTjhJ5Xtq+sCx4=;
        b=KQ+pCsX1YvaB6H0enMKCB7mzgab6D/CN/kJTXGRSEB9Rn29Rao+eJ+9rAkvXadg0Vd
         YKqwT6kJvL4CLELrAowo+qY0UdCy7HMdTjbLeGu27ZUDuuJ/g5XGIIaE2SCwJYblto+3
         YtI8rbkrwoEkAaSiawik7tJZ7tqpW30W/+DUSKQwwLybuKK+ndyG5FH9Lw7c1xvIBDcv
         PbJt7HBmsbw0FBdx9OdesCVjudniua+jxgIDw8FkS39HZ9rYwvvxEKTUG/QewNpk3Hht
         hE1CQA7ciTlj0HyeY1SyY5ShWiXmsjskLs/8wQvbPIT5pvRqzfomLUtG9vurooAfWC5S
         TRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZYUsiGN/v7rmxvBrV3sHc6QG8Ce/8ZTjhJ5Xtq+sCx4=;
        b=ccka429/dmeX1mu2RL4+5+vjcZvGGh59Kng5FusxuYZZ3GyAnW4Cx1LLgwnrnVtpPu
         ORR0fuHEElAfPmHeCYKgff+7qbEW+mYZs9uYENpfQnvdUroaISx2vPrgIMqqgCJLsLFv
         X3dKmqQ7BEApUrrro4fMuAvTZb1g1YpiqrOm9s+vMzfb10sJZ/Vp/1HOMMWC0IYQCTDD
         eeuZ8AKPDvUxfUtvWgSRwV2G6kflh2YukDOIThnw9AW05cN/QIVicz66NWfxLHDg2T5b
         IgsGRImmPS50k88MhXocwWAgrzVP8sEPGvCf+4IlUdNRI0ggb7Itxtp8J5DQx2X3WunS
         BGZg==
X-Gm-Message-State: APjAAAUSAP5cCL6hFB3/cksnSuCRgPV82XMGmfIYyU3d/LWPiGpMhQkD
        LhbhFfVAS9msjvrI0vV/gwUilh4=
X-Google-Smtp-Source: APXvYqzeu/NAV6g9ZUHN4kNPNSgsF0k5MbDeToK7uKXCf6w5rOlWQ12KBSynRqOgWn77TAiKAPCHNg==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr99239wre.391.1569443079701;
        Wed, 25 Sep 2019 13:24:39 -0700 (PDT)
Received: from avx2 ([46.53.249.15])
        by smtp.gmail.com with ESMTPSA id r65sm200401wmr.9.2019.09.25.13.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:24:38 -0700 (PDT)
Date:   Wed, 25 Sep 2019 23:24:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc: change ->nlink under proc_subdir_lock
Message-ID: <20190925202436.GA17388@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently gluing PDE into global /proc tree is done under lock,
but changing ->nlink is not. Additionally struct proc_dir_entry::nlink
is not atomic so updates can be lost.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -138,8 +138,12 @@ static int proc_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct proc_dir_entry *de = PDE(inode);
-	if (de && de->nlink)
-		set_nlink(inode, de->nlink);
+	if (de) {
+		nlink_t nlink = READ_ONCE(de->nlink);
+		if (nlink > 0) {
+			set_nlink(inode, nlink);
+		}
+	}
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -362,6 +366,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		write_unlock(&proc_subdir_lock);
 		goto out_free_inum;
 	}
+	dir->nlink++;
 	write_unlock(&proc_subdir_lock);
 
 	return dp;
@@ -472,10 +477,7 @@ struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
 		ent->data = data;
 		ent->proc_fops = &proc_dir_operations;
 		ent->proc_iops = &proc_dir_inode_operations;
-		parent->nlink++;
 		ent = proc_register(parent, ent);
-		if (!ent)
-			parent->nlink--;
 	}
 	return ent;
 }
@@ -505,10 +507,7 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 		ent->data = NULL;
 		ent->proc_fops = NULL;
 		ent->proc_iops = NULL;
-		parent->nlink++;
 		ent = proc_register(parent, ent);
-		if (!ent)
-			parent->nlink--;
 	}
 	return ent;
 }
@@ -666,8 +665,12 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 	len = strlen(fn);
 
 	de = pde_subdir_find(parent, fn, len);
-	if (de)
+	if (de) {
 		rb_erase(&de->subdir_node, &parent->subdir);
+		if (S_ISDIR(de->mode)) {
+			parent->nlink--;
+		}
+	}
 	write_unlock(&proc_subdir_lock);
 	if (!de) {
 		WARN(1, "name '%s'\n", name);
@@ -676,9 +679,6 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 
 	proc_entry_rundown(de);
 
-	if (S_ISDIR(de->mode))
-		parent->nlink--;
-	de->nlink = 0;
 	WARN(pde_subdir_first(de),
 	     "%s: removing non-empty directory '%s/%s', leaking at least '%s'\n",
 	     __func__, de->parent->name, de->name, pde_subdir_first(de)->name);
@@ -714,13 +714,12 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 			de = next;
 			continue;
 		}
-		write_unlock(&proc_subdir_lock);
-
-		proc_entry_rundown(de);
 		next = de->parent;
 		if (S_ISDIR(de->mode))
 			next->nlink--;
-		de->nlink = 0;
+		write_unlock(&proc_subdir_lock);
+
+		proc_entry_rundown(de);
 		if (de == root)
 			break;
 		pde_put(de);
