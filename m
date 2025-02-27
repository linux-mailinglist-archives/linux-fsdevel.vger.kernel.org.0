Return-Path: <linux-fsdevel+bounces-42787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEDA48A54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157ED188F8A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA30D27127C;
	Thu, 27 Feb 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSX5+dXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C45270ECD
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690796; cv=none; b=uM6WdnLIZFYobdwyOdkRFoYJ4PwKgPiu/vI3xWPMleoJy6vVwFP5Frpvu5+EyWRtowu5pCy6wvwBwyGm6m76FUYWnDUJn8w8Rc7fv8HYHFIil7JLg17B5KZ2POHSv/IMDESTYWzqxKZu11xnWQwF8CcKPjpjGx39hrcm6oHsdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690796; c=relaxed/simple;
	bh=SKCmTroUvDcIra/X5nBKjf+wiIUTlcAQ5y/YfKp6LCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCLjLufpPxnDuWXCmCX/R4u295YFPdWnVAsXuNMnRDPlQhH0+eaH/gjR3AROlvdp4cXPGJTpRKIQj3E9FCKz4IbUkVjUwfaqJ/GVlPHKjc0maHu2g0sx0Ygs78jRMXbW0vkXEECXFk2rqn3M7qjjMV+XqBmg3vToXIVrZ1nRMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSX5+dXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740690793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueahIvfJRfywNE/7meugkTbE1OIWv9rmw5z68EndZF0=;
	b=LSX5+dXYnMqmB6yhBSw+lShgkbE252VOCX7n1CyH2YX+U+RIgStcx/OWfN9V3Ik8oeVTyJ
	8UfxSZQAIsoudI5jdLwgZ5B6kDzqsKzj2vPCc3dIJ48mP8sIvzMoiN2UZZ5XUj67jAw47p
	MFtxTF6uFbh7OhVrkKSog/k3/2Sjz2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-j1RmnW9aMBuo8_yyXdCx9Q-1; Thu,
 27 Feb 2025 16:13:07 -0500
X-MC-Unique: j1RmnW9aMBuo8_yyXdCx9Q-1
X-Mimecast-MFC-AGG-ID: j1RmnW9aMBuo8_yyXdCx9Q_1740690786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C37E01800876;
	Thu, 27 Feb 2025 21:13:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 418D21800988;
	Thu, 27 Feb 2025 21:13:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Feb 2025 22:12:35 +0100 (CET)
Date: Thu, 27 Feb 2025 22:12:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250227211229.GD25639@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sapkal, first of all, thanks again!

On 02/27, Sapkal, Swapnil wrote:
>
> >1. with 1 fd instead of 20:
> >
> >/usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100
>
> With this I was not able to reproduce the issue. I tried almost 5000
> iterations.

OK,

> >2. with a size which divides 4096 evenly (e.g., 128):
...
> When I retain the number of
> groups to 16 and change the message size to 128, it took me around 150
> iterations to reproduce this issue (with 100 bytes it was 20 iterations).
> The exact command was
>
> /usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 128

Ah, good. This is good ;)

> I will try to sprinkle some trace_printk's in the code where the state of
> the pipe changes. I will report here if I find something.

Great! but...

Sapkal, I was going to finish (and test! ;) the patch below tomorrow, after
you test the previous debugging patch I sent in this thread. But since you
are going to change the kernel...

For the moment, please forget about that (as Mateusz pointed buggy) patch.
Could you apply the patch below and reproduce the problem ?

If yes, please do prctl(666) after the hang and send us the output from
dmesg, between "DUMP START" and "DUMP END". You can just do

	$ perl -e 'syscall 157,666'

to call prctl(666) and trigger the dump.

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..566c75a0ff81 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -376,6 +376,8 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	}
 	if (pipe_empty(pipe->head, pipe->tail))
 		wake_next_reader = false;
+	if (ret > 0)
+		pipe->r_cnt++;
 	mutex_unlock(&pipe->mutex);
 
 	if (wake_writer)
@@ -565,6 +567,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		wake_next_writer = false;
+	if (ret > 0)
+		pipe->w_cnt++;
 	mutex_unlock(&pipe->mutex);
 
 	/*
@@ -695,6 +699,42 @@ pipe_poll(struct file *filp, poll_table *wait)
 	return mask;
 }
 
+static DEFINE_MUTEX(PI_MUTEX);
+static LIST_HEAD(PI_LIST);
+
+void pi_dump(void);
+void pi_dump(void)
+{
+	struct pipe_inode_info *pipe;
+
+	pr_crit("---------- DUMP START ----------\n");
+	mutex_lock(&PI_MUTEX);
+	list_for_each_entry(pipe, &PI_LIST, pi_list) {
+		unsigned head, tail;
+
+		mutex_lock(&pipe->mutex);
+		head = pipe->head;
+		tail = pipe->tail;
+		pr_crit("E=%d F=%d; W=%d R=%d\n",
+			pipe_empty(head, tail), pipe_full(head, tail, pipe->max_usage),
+			pipe->w_cnt, pipe->r_cnt);
+
+// INCOMPLETE
+pr_crit("RD=%d WR=%d\n", waitqueue_active(&pipe->rd_wait), waitqueue_active(&pipe->wr_wait));
+
+		for (; tail < head; tail++) {
+			struct pipe_buffer *buf = pipe_buf(pipe, tail);
+			WARN_ON(buf->ops != &anon_pipe_buf_ops);
+			pr_crit("buf: o=%d l=%d\n", buf->offset, buf->len);
+		}
+		pr_crit("\n");
+
+		mutex_unlock(&pipe->mutex);
+	}
+	mutex_unlock(&PI_MUTEX);
+	pr_crit("---------- DUMP END ------------\n");
+}
+
 static void put_pipe_info(struct inode *inode, struct pipe_inode_info *pipe)
 {
 	int kill = 0;
@@ -706,8 +746,14 @@ static void put_pipe_info(struct inode *inode, struct pipe_inode_info *pipe)
 	}
 	spin_unlock(&inode->i_lock);
 
-	if (kill)
+	if (kill) {
+		if (!list_empty(&pipe->pi_list)) {
+			mutex_lock(&PI_MUTEX);
+			list_del_init(&pipe->pi_list);
+			mutex_unlock(&PI_MUTEX);
+		}
 		free_pipe_info(pipe);
+	}
 }
 
 static int
@@ -790,6 +836,13 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	if (pipe == NULL)
 		goto out_free_uid;
 
+	INIT_LIST_HEAD(&pipe->pi_list);
+	if (!strcmp(current->comm, "hackbench")) {
+		mutex_lock(&PI_MUTEX);
+		list_add_tail(&pipe->pi_list, &PI_LIST);
+		mutex_unlock(&PI_MUTEX);
+	}
+
 	if (pipe_bufs * PAGE_SIZE > max_size && !capable(CAP_SYS_RESOURCE))
 		pipe_bufs = max_size >> PAGE_SHIFT;
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..48d9bf5171dc 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -80,6 +80,9 @@ struct pipe_inode_info {
 #ifdef CONFIG_WATCH_QUEUE
 	struct watch_queue *watch_queue;
 #endif
+
+	struct list_head pi_list;
+	unsigned w_cnt, r_cnt;
 };
 
 /*
diff --git a/kernel/sys.c b/kernel/sys.c
index 4efca8a97d62..a85e34861b2e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2483,6 +2483,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 	error = 0;
 	switch (option) {
+	case 666: {
+		extern void pi_dump(void);
+		pi_dump();
+		break;
+	}
 	case PR_SET_PDEATHSIG:
 		if (!valid_signal(arg2)) {
 			error = -EINVAL;


