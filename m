Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708B76DE3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 06:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfGSEHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 00:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732460AbfGSEHC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:07:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FF421852;
        Fri, 19 Jul 2019 04:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509220;
        bh=4845ciycBl66P3mpNIpBAcwqxVKag7mtH/YYAjhwpTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=08UWadr5z69xGEB4VJO9Qkh1cjNjEdMEHtOezCHhHEafMZDDBkwo4ocBMtjPhsfIC
         +rk7rzRnRtfhFO4fjdIWscWcvqb59TYMfiQET7DkToLoBWKzLA/VUrYtamHelwSjtz
         oa+uT0gRqChffJla544Llr21sUOC6/XFWTANUMtY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Roman Gushchin <guro@fb.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 133/141] proc: use down_read_killable mmap_sem for /proc/pid/smaps_rollup
Date:   Fri, 19 Jul 2019 00:02:38 -0400
Message-Id: <20190719040246.15945-133-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit a26a97815548574213fd37f29b4b78ccc6d9ed20 ]

Do not remain stuck forever if something goes wrong.  Using a killable
lock permits cleanup of stuck tasks and simplifies investigation.

Link: http://lkml.kernel.org/r/156007493429.3335.14666825072272692455.stgit@buzz
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/task_mmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 95ca1fe7283c..c5b1b6db9a70 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -828,7 +828,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	memset(&mss, 0, sizeof(mss));
 
-	down_read(&mm->mmap_sem);
+	ret = down_read_killable(&mm->mmap_sem);
+	if (ret)
+		goto out_put_mm;
+
 	hold_task_mempolicy(priv);
 
 	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
@@ -845,8 +848,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	release_task_mempolicy(priv);
 	up_read(&mm->mmap_sem);
-	mmput(mm);
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(priv->task);
 	priv->task = NULL;
-- 
2.20.1

