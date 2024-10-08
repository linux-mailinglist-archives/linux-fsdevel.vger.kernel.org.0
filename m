Return-Path: <linux-fsdevel+bounces-31344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F205994F14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1334C1F24971
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3691DFDB2;
	Tue,  8 Oct 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDv1TiPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DF1DED7A;
	Tue,  8 Oct 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393791; cv=none; b=fOCX6tyhUU3ELo0GHCZ7tw68cgfcCJ2L3Tvl0S9J8i7YukBsp/add84GIKX7WQ2n/pYDM1eIvR17dEmvjz9WUgFglTejl1yCxPfOuagJIq3tRK3kZatCKFCMZutkP9uBSmFdAbcA79+UCZ6cVE8focjXl1Twn2awJ7q+WVFTcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393791; c=relaxed/simple;
	bh=Qo7uY7516n2CtfdCfqkenk2KagxCPBaQX2nSTTcau2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOh4ZS4ToEf2fYilDXL/1poUfX6fPie9382mkpcefZYSC1lwvOtvIqVJkXZyUSQzBLSRlLewd3MbQBiDQEVL3ccn1xC0euCry2nrpXGkztbcbCMj9ZHLXI+vXepcm4fB1We1iYX/PnE62XpX4vZyvjw6b4xCVc2/Vv+jfX6oLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDv1TiPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B98C4CEC7;
	Tue,  8 Oct 2024 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393791;
	bh=Qo7uY7516n2CtfdCfqkenk2KagxCPBaQX2nSTTcau2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDv1TiPCHTi3QcPNjknsBvAZ/T4PnslpMU4RaLg+uEXI08OcrM43ZWZsqojeHdHT6
	 ytOx6M/rncH1n8PU1R9hTbjsJVaz3/KlJS78hqUZIeEQ4mZO7PThcp3EBfGyvL4K8w
	 Wtp8MGIWN6dHbAJ4S+YXNqntenOnzIVO0NQF01eCTBtaFU8u/fmurhJIiLj2HIeRly
	 9LL+W/yUwbyjNEXMGGd3dWv0YA7LZjVKJ1JVnfnVZy05v7OBPac3u2rqXGvGiqD0+t
	 cVbPKzP0sWjfcCvC+S2cM0meb2o1q0JYxb24QppjtrSvZdhplqVN0KDQr1SU1FKv+7
	 hIe6yoj8SdK4g==
Date: Tue, 8 Oct 2024 15:23:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: luca.boccassi@gmail.com, oleg@redhat.com
Cc: linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241008-kruste-aufguss-bd03e60997ab@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <20241008-parkraum-wegrand-4e42c89b1742@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008-parkraum-wegrand-4e42c89b1742@brauner>

> > +#ifdef CONFIG_CGROUPS
> > +	if (request_mask & PIDFD_INFO_CGROUPID) {
> > +		struct cgroup *cgrp;
> > +
> > +		guard(rcu)();
> > +		cgrp = task_cgroup(task, pids_cgrp_id);
> > +		if (!cgrp)
> > +			return -ENODEV;
> 
> Afaict this means that the task has already exited. In other words, the
> cgroup id cannot be retrieved anymore for a task that has exited but not
> been reaped. Frankly, I would have expected the cgroup id to be
> retrievable until the task has been reaped but that's another
> discussion.
> 
> My point is if you contrast this with the other information in here: If
> the task has exited but hasn't been reaped then you can still get
> credentials such as *uid/*gid, and pid namespace relative information
> such as pid/tgid/ppid.

Related to this and I just want to dump this idea somewhere:

I'm aware that it is often desirable or useful to have information about
a task around even after the task has exited and been reaped.

The exit status comes to mind but maybe there's other stuff that would
be useful to have.

Since we changed to pidfs we know that all pidfds no matter if they
point to the same struct file (e.g., dup()) or to multiple struct files
(e.g., multiple pidfd_open() on the same pid) all point to the same
dentry and inode. Which is why we switched to stashing struct pid in
inode->i_private.

So we could easily do something like this:

// SKETCH SKETCH SKETCH
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..eeeb907f4889 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -344,9 +344,24 @@ static const struct dentry_operations pidfs_dentry_operations = {
        .d_prune        = stashed_dentry_prune,
 };

+struct pidfd_kinfo {
+       // We could even move this back to file->private_data to avoid the
+       // additional pointer deref though I doubt it matters.
+       struct pid *pid;
+       int exit_status;
+       // other stuff;
+};
+
 static int pidfs_init_inode(struct inode *inode, void *data)
 {
-       inode->i_private = data;
+       struct pidfd_kinfo *kinfo;
+
+       kinfo = kzalloc(sizeof(*info), GFP_KERNEL_ACCOUNT);
+       if (!kinfo)
+               return -ENOMEM;
+
+       kinfo->pid = data;
+       inode->i_private = kinfo;
        inode->i_flags |= S_PRIVATE;
        inode->i_mode |= S_IRWXU;
        inode->i_op = &pidfs_inode_operations;

and that enables us to persist information past task exit so that as
long as you hold the pidfd you can e.g., query for the exit state of the
task or something.

I'm mostly thinking out loud but I think that could be potentially
interesting.

