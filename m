Return-Path: <linux-fsdevel+bounces-36395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A99E33C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 08:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03407284F09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE88188CC9;
	Wed,  4 Dec 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WVi4fmgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ec2-44-216-146-170.compute-1.amazonaws.com (ec2-44-216-146-170.compute-1.amazonaws.com [44.216.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB391E522;
	Wed,  4 Dec 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.146.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733295830; cv=none; b=tT4riLzwzck2/wZQRUp2OP7lYFC3DueQ5mABOQc/QVuJ0N3nb97Qqrfmp6J3xmiO8TNx9dNLQ61QoSVmfZqbtp8Zp8qp2QwzyMsXH4nAWvs/meeFBJ1+uR0tx7gccYdg7+QeOSiMC5n1rKXSL7QLFfEzszJmCXfksDq5PpHQ+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733295830; c=relaxed/simple;
	bh=o8y0jaHm1vc1A6fPbLE8eSCbKomotemIUf8JvNn9ZN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XYlOhlG2b+YXZaMlbkKIFF/QEYyDxbZrMPF9e0f0i+6beHrDcy8Blj3TmosW2lOCIXZpj4+bdB8RNcXKwWjsOVeGal4j4QbPcjmaQcB6Qe24ocN46xYgs0nW23viuZh8kv/iL9jhDaBn8MAOzB7/E4GGlD53mj3SYMNQ9k2nb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WVi4fmgI; arc=none smtp.client-ip=44.216.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a901914;
	Wed, 4 Dec 2024 14:48:18 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dhowells@redhat.com
Cc: jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujianhao01@gmail.com
Subject: [QUESTION] inconsistent use of smp_mb()
Date: Wed,  4 Dec 2024 06:48:18 +0000
Message-Id: <20241204064818.2760263-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0IfVk9PSR9LGUtLQkpLSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a93906d3ea503a1kunm4a901914
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46Qzo*OTItCQpCSk0hGTk#
	Dy1PCStVSlVKTEhISUJPQ0JCQ01LVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKSU1KNwY+
DKIM-Signature:a=rsa-sha256;
	b=WVi4fmgIbV9J+SGyC6IU5X+xWlv5PLGYKwLTcmcDmUTwuZ4RNz7C7HFTWacmEcR1r+DPeQHwYBIhS33lbSSv/3A2jZpX5JYXsMbzvlXII49AAGcXGXmPMj5t43yxnISMqn3TdC2gMwJIa2WQ76QGAd0TUSU+22grECiqpiVkMfI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Tu6tGkbMYUAL0DYR8x2vk7K4QjqEHcaUrWdPubvdO9E=;
	h=date:mime-version:subject:message-id:from;

Hello,

I have a question regarding the use of smp_rmb() to enforce 
memory ordering in two related functions.

In the function netfs_unbuffered_write_iter_locked() from the file 
fs/netfs/direct_write.c, smp_rmb() is explicitly used after the 
wait_on_bit() call to ensure that the error and transferred fields are 
read in the correct order following the NETFS_RREQ_IN_PROGRESS flag:

105	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
106		    TASK_UNINTERRUPTIBLE);
107	smp_rmb(); /* Read error/transferred after RIP flag */
108	ret = wreq->error;
109	if (ret == 0) {
110		ret = wreq->transferred;
111		iocb->ki_pos += ret;
112	}

However, in the function netfs_end_writethrough() from the file 
fs/netfs/write_issue.c, there is no such use of smp_rmb() after 
the corresponding wait_on_bit() call, despite accessing the same filed 
of wreq->error and relying on the same NETFS_RREQ_IN_PROGRESS flag:

681	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS, 
		    TASK_UNINTERRUPTIBLE);
682	ret = wreq->error;

My question is why does the first function require a CPU memory barrier 
smp_rmb() to enforce ordering, whereas the second function does not?

Thank you for your time and assistance!

Best Regards,
Zilin Guan

