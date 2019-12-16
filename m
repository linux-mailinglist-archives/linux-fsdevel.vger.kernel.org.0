Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613B8121A1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 20:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLPTi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 14:38:56 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:32785 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPTi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:38:56 -0500
Received: by mail-qv1-f67.google.com with SMTP id z3so3231947qvn.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 11:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=LCB0hNRG4v+p9dpfKdy3ZBAOPMoNY6/T21WrOre9gfo=;
        b=dno9akdodZ4J7VJAYPHs9URzsfsXYZcGZjePs599AnQpd0bCpdpRHrNrdlNm7fEy2S
         3NFUpRyEe6uxdfVkwn4bUBBBRhQoz+Fq9CuvB+2gS39RhfajsAXEilNgGfMCezBMonO9
         HdLiMebWMfDzKkC9hU5wMHpYs9lwg/q7F4gv2JW1ThT+rDmxNDnl+2Qb76kzAZdWz01A
         FFRd3XjxGyPQpAMQuR7I+iYLpk+aIdkyEB8zjTGk/RYGDa9A5YH0ETDagPSHG3WlQJJe
         ZwzQCcv2gql57CoBPfH2gByGbxj7nuWYQEF5guzK6z2x/7GA1Vx+fS5LvEz2+4nrfq19
         f8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=LCB0hNRG4v+p9dpfKdy3ZBAOPMoNY6/T21WrOre9gfo=;
        b=qqbiDpDuzXPgLpgILh42OiG6JGRHboAhrWvOlJkpEhd5e7YzA8/CalCgBJA+HUg/jW
         WZICR5IbmUwMUcCdb5PI8mFSie5iDrMwssCvLkI+fLGujSybEumj8oXdADyuLO5shB/s
         2/BGcs3322w9lWpfwsUmnUyva3PsHWV/zYzzboNlzI9WkSmIlDLPDE4uBAUVTSfG6rbO
         rkvMOhTjEwERySGkvPsBjOElat1eKtqo6DCVTQ0DybOvLHCMoZbyvGYoiShMPbiq/kM2
         MQVpVulOE77nlo9JXrGbrqCWgvKsoXZGFgWFgpHFVjADUgH5Yi9R0ka/pb/t2VcLLw7K
         Gydg==
X-Gm-Message-State: APjAAAXtdBpiuEPyivSFp2hohnsiS34WIoryPA4QIyb9jNQ1CKglNTPt
        ZNCnEt9+1ZD0JqCDmTgO3pDZA3A=
X-Google-Smtp-Source: APXvYqyJ/p/IWWXm03RuNnjgugFO1XI3/EoRwUQWGpve9A92gUazKS5zx1KdzSq5mgNc/bgqxUutOw==
X-Received: by 2002:a0c:d223:: with SMTP id m32mr1060230qvh.36.1576525135083;
        Mon, 16 Dec 2019 11:38:55 -0800 (PST)
Received: from kmo-pixel ([65.183.151.50])
        by smtp.gmail.com with ESMTPSA id k184sm6259427qke.2.2019.12.16.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:38:54 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:38:52 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Bcachefs update
Message-ID: <20191216193852.GA8664@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all, I'd like to poke my head up and let everyone know where bcachefs is at,
and talk about finally upstreaming it.

Last LSF (two years ago), bcachefs was coming along quite nicely and was quite
usable but there was still some core work unfinished (primarily persistent alloc
info; we still had to walk all metadata at mount time). Additionally, there some
unresolved discussions around locking for pagecache consistency.

The core features one would expect from a posix filesystem are now done, and
then some. Reflink was finished recently, and I'm now starting to work towards
snapshots.

If there's interest I may talk a bit about the plan for snapshots in bcachefs.

The short version is: all metadata in bcachefs are keys in various btrees
(extents/inodes/dirents/xattrs btrees) indexed by inode:offset; for snapshots we
extent the key so that the low bits are a snapshot id, i.e.
inode:offset:snapshot. Snapshots form a tree where the root has id U32_MAX and
children always have smaller IDs than their parent, so to read from a given
snapshot we do a lookup as normal, including the snapshot ID of the snapshot we
want, and then filter out keys from unrelated (non ancestor) snapshots.

This will give us excellent overall performance when there are many snapshots
that each have only a small number of overwrites; when we end up in a situation
where a given part of the keyspace has many keys from unrelated snapshots we'll
want to arrange metadata differently.

This scheme does get considerably trickier when you add extents; that's what
I've been focusing on recently.

Pagecache consistency:

I recently got rid of my pagecache add lock; that added locking to core paths in
filemap.c and some found my locking scheme to be distastefull (and I never liked
it enough to argue). I've recently switched to something closer to XFS's locking
scheme (top of the IO paths); however, I do still need one patch to the
get_user_pages() path to avoid deadlock via recursive page fault - patch is
below:

(This would probably be better done as a new argument to get_user_pages(); I
didn't do it that way initially because the patch would have been _much_
bigger.)

Yee haw.

commit 20ebb1f34cc9a532a675a43b5bd48d1705477816
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Wed Oct 16 15:03:50 2019 -0400

    mm: Add a mechanism to disable faults for a specific mapping
    
    This will be used to prevent a nasty cache coherency issue for O_DIRECT
    writes; O_DIRECT writes need to shoot down the range of the page cache
    corresponding to the part of the file being written to - but, if the
    file is mapped in, userspace can pass in an address in that mapping to
    pwrite(), causing those pages to be faulted back into the page cache
    in get_user_pages().
    
    Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ebfa046b2d..3b4d9689ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -740,6 +740,7 @@ struct task_struct {
 
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
+	struct address_space		*faults_disabled_mapping;
 
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
diff --git a/init/init_task.c b/init/init_task.c
index ee3d9d29b8..706abd9547 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -77,6 +77,7 @@ struct task_struct init_task
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
+	.faults_disabled_mapping = NULL,
 	.restart_block	= {
 		.fn = do_no_restart_syscall,
 	},
diff --git a/mm/gup.c b/mm/gup.c
index 98f13ab37b..9cc1479201 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -849,6 +849,13 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		}
 		cond_resched();
 
+		if (current->faults_disabled_mapping &&
+		    vma->vm_file &&
+		    vma->vm_file->f_mapping == current->faults_disabled_mapping) {
+			ret = -EFAULT;
+			goto out;
+		}
+
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
 			ret = faultin_page(tsk, vma, start, &foll_flags,
