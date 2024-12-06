Return-Path: <linux-fsdevel+bounces-36609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3C9E67EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBFA1885355
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49C1DDA1B;
	Fri,  6 Dec 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="J/C7hIeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m1035.netease.com (mail-m1035.netease.com [154.81.10.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5B3D6B;
	Fri,  6 Dec 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470120; cv=none; b=I42+2Lr/CqO+xGCXCpm0lCUKLEOHEESwT0a1mdna27rKbd0ydR7Kgn3EkdE0mN+CRrBiPRj7WKUjI1KRjBKFS6KYekTfddesTu0hPYaAzhx4X9vTt6UNBAQioD1FplQx9WggkDk53U3W++7ZSnl8PmHS6ngfy40q+ohu0mNj3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470120; c=relaxed/simple;
	bh=YL+9m+fKpEznl2nFJijfWwhBg5EzwRct9DJv4KiLwLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJa/kUPaSA9PrsfW1VIP4eFSzzqsTMFq+T7twvOAXJIL5n2N0zM10I9QVY+e+7VTgCRaHKdqMUCp/xZw/yzVJFs7vauUfod5GWhe+D6s8ZqNIk3B2emRCg7oL6gZUzoqzT3WaxlD78HbypLcJk0CMPdXulv/yW5mlk6iU6Yqtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=J/C7hIeW; arc=none smtp.client-ip=154.81.10.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e55eede;
	Fri, 6 Dec 2024 15:13:16 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: mjguzik@gmail.com
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	xujianhao01@gmail.com,
	zilin@seu.edu.cn
Subject: Re: [QUESTION] inconsistent use of smp_mb()
Date: Fri,  6 Dec 2024 07:13:15 +0000
Message-Id: <20241206071315.2958512-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc>
References: <ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkoaVh0aTRlDQ09DGBkYHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk5MSVVKS0tVSk
	JLS1kG
X-HM-Tid: 0a939ad0cff603a1kunm4e55eede
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6Hio*TjIfCVEwSTkoUR4X
	MS0KCyJVSlVKTEhIT01CSkJMSkNPVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFJSk1KNwY+
DKIM-Signature:a=rsa-sha256;
	b=J/C7hIeW+cVAxKPsAOD+OCo4W1hlx1gNOp/TIOdds4T9JRa2cuOENSbs4cfX+lDxC3HsPAYSEpQlmgVkiCWFVQsV7ivF7vIq0oLizpvt+/KMqXJZXmnWzlGrHxdzHuwsBw2GpESqqO7bsvjVnhNlEeuDGb5wR+Oq0I2d+JPXWp8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=KaeUVXapuHKSzLw5ctqEebg9c7ruMdXt2f6CPGdCRmE=;
	h=date:mime-version:subject:message-id:from;

On Wed, Dec 04, 2024 at 09:27:22AM+0100, Mateusz Guzik wrote:
> On Wed, Dec 04, 2024 at 06:48:18AM +0000, Zilin Guan wrote:
> > Hello,
> > 
> > I have a question regarding the use of smp_rmb() to enforce 
> > memory ordering in two related functions.
> > 
> > In the function netfs_unbuffered_write_iter_locked() from the file 
> > fs/netfs/direct_write.c, smp_rmb() is explicitly used after the 
> > wait_on_bit() call to ensure that the error and transferred fields are 
> > read in the correct order following the NETFS_RREQ_IN_PROGRESS flag:
> > 
> > 105	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> > 106		    TASK_UNINTERRUPTIBLE);
> > 107	smp_rmb(); /* Read error/transferred after RIP flag */
> > 108	ret = wreq->error;
> > 109	if (ret == 0) {
> > 110		ret = wreq->transferred;
> > 111		iocb->ki_pos += ret;
> > 112	}
> > 
> > However, in the function netfs_end_writethrough() from the file 
> > fs/netfs/write_issue.c, there is no such use of smp_rmb() after 
> > the corresponding wait_on_bit() call, despite accessing the same filed 
> > of wreq->error and relying on the same NETFS_RREQ_IN_PROGRESS flag:
> > 
> > 681	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS, 
> > 		    TASK_UNINTERRUPTIBLE);
> > 682	ret = wreq->error;
> > 
> > My question is why does the first function require a CPU memory barrier 
> > smp_rmb() to enforce ordering, whereas the second function does not?
> 
> The fence is redundant.
> 
> Per the comment in wait_on_bit:
>  * Returned value will be zero if the bit was cleared in which case the
>  * call has ACQUIRE semantics, or %-EINTR if the process received a
>  * signal and the mode permitted wake up on that signal.
> 
> Since both sites pass TASK_UNINTERRUPTIBLE this will only ever return
> after the bit is sorted out, already providing the needed fence.
 
Since the code does not need the fence, should I send a patch to 
remove it? Commit 2df8654 introduced this fence during the transition 
to a new writeback implementation. However, the author added this fence 
as part of the changes and did not intend to address a specific CPU 
reordering issue.

