Return-Path: <linux-fsdevel+bounces-2709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16307E7A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC71C20DB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D921125CE;
	Fri, 10 Nov 2023 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N12bRTZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904B125B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 08:31:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CE9006
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 00:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699605111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvwm8Zn22AXacglWGsXzntpmbjMrm/qepljzJqi7EKM=;
	b=N12bRTZVkJzPBKWXdeaKAGJGkXlIekDQSzsKcHLVyb2U6KkNV3rb9H3PUGXmaKQr6Um/K/
	kxySRZSXLSl97bOgUdA0+pKjtzqU1kUX3xedJDUGq4xjs1jMT4IcseNOk5kT4eFYs0ENK3
	D1MfKSowiqYiT03YWW5uOsEopwuOwU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-VAiY79xYMsOHg94TPTDuFA-1; Fri, 10 Nov 2023 03:31:44 -0500
X-MC-Unique: VAiY79xYMsOHg94TPTDuFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6EB85A58A;
	Fri, 10 Nov 2023 08:31:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5382B25C1;
	Fri, 10 Nov 2023 08:31:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Nov 2023 09:30:41 +0100 (CET)
Date: Fri, 10 Nov 2023 09:30:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, akpm@linux-foundation.org,
	jlayton@kernel.org, dchinner@redhat.com, adobriyan@gmail.com,
	yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH next V3] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231110083037.GA3381@redhat.com>
References: <20231110151928.2667204-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110151928.2667204-1-wozizhi@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 11/10, Zizhi Wo wrote:
>
> From: WoZ1zh1 <wozizhi@huawei.com>
>
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

I am wondering if we can do something like the patch below instead...

but I agree that the "proc_lseek == mem_lseek" in proc_reg_open()
looks ugly.

Oleg.

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 532dc9d240f7..af7e6b1e17fe 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -496,6 +496,8 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 
 	if (!pde->proc_ops->proc_lseek)
 		file->f_mode &= ~FMODE_LSEEK;
+	else if (pde->proc_ops->proc_lseek == mem_lseek)
+		file->f_mode |= FMODE_UNSIGNED_OFFSET;
 
 	if (pde_is_permanent(pde)) {
 		open = pde->proc_ops->proc_open;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..729b28ad1a96 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1748,7 +1748,9 @@ static int pagemap_open(struct inode *inode, struct file *file)
 	mm = proc_mem_open(inode, PTRACE_MODE_READ);
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
+
 	file->private_data = mm;
+	file->f_mode |= FMODE_UNSIGNED_OFFSET;
 	return 0;
 }
 


