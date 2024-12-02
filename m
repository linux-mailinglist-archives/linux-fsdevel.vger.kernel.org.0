Return-Path: <linux-fsdevel+bounces-36258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0D9E0392
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA233B27013
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94201FECAE;
	Mon,  2 Dec 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPhy1djw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9C1D86C9;
	Mon,  2 Dec 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143108; cv=none; b=M13WYoXdXVGjKLw9bKUgr9Gmb7HlxrkCojlztLlXe0lUS74VNDiuOQ8jnj6OK5VdUSDDE7uDvgg7a0NIWIRC6cwibl0kJeqBcmeEZQP2i40vurEoGoYmHhiiq+I8RmZz8/uyGkmANsmny44CcwUU+Vlml6siVZgI1euPB7LjzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143108; c=relaxed/simple;
	bh=g20qBYlXeNwQUsiewfivl+fCumQUvVsethy31GmWhWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KkiUloCySQ4a7d50dt5CnTPwGZMArWZy4WMBKQZRmKjviLV6t4cyk2n3u9fTfqeFKmcRfCyLRfcdiPiHsnQ65PmmdMkDT7dystbM+Xdn8i4K/ruoziLn2Tcxahan98wBkq6KEW7iwJ9hvN9dtOnjpiuHSbaJNOlE6bSTGQ0wsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPhy1djw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CC4C4CED1;
	Mon,  2 Dec 2024 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733143107;
	bh=g20qBYlXeNwQUsiewfivl+fCumQUvVsethy31GmWhWA=;
	h=Date:From:To:Cc:Subject:From;
	b=VPhy1djwN2JsmpJlUbIw4kNwHT+eZ5MP+e6rw9LdNFWUjIHazHMeOSoA4YwqjrqWE
	 NIQyeiXbP6F1fCbGQB+Ami8wgMF3wgXnAc7UHIXElLTx0aDiklhX4aL+nWcIKTMl8+
	 IaRX5DquGC2CZQ21sTAwJySyr7LgkT0b8t9VayG6rA7PJF+I99Bqi744VbFYLznbiD
	 pT4wOqgHmtB4ZC/S6bgVAuBklpsX+pzMV4/fuJn14gp4s6yWTdtmC6+Tl2V4ZCH/Fr
	 9V6LP89mxWn/1d+Rx8MVGVznjIdUx1Omku+fPVkkPjNVFwTmiT/mGjiFNJClWATZya
	 1+zDxN+5kwkFw==
Date: Mon, 2 Dec 2024 13:38:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	KP Singh <kpsingh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: bpf_task_storage improvement question
Message-ID: <qwinzohs4pwawth5i6g7hfb2376pyfmkurbo2rwvglv77asbkr@mq2goetrtmpu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

I just had to take a quick look at kernel/bpf/bpf_task_storage.c and
realized that you're doing:


	fd = *(int *)key;
	pid = pidfd_get_pid(fd, &f_flags);

	// something something

	task = pid_task(pid, PIDTYPE_PID);

	bpf_task_storage_lock();
	// something something
	bpf_task_storage_unlock();
	put_pid(pid);

That reference count bump on struct pid seems unnecessary and I suspect
your lookup routines are supposed to be fast. So why don't you just
open-code this. Something like:

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index bf7fa15fdcc6..dc36a33c7b6d 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -92,10 +92,12 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
        struct task_struct *task;
        unsigned int f_flags;
        struct pid *pid;
-       int fd, err;

-       fd = *(int *)key;
-       pid = pidfd_get_pid(fd, &f_flags);
+       CLASS(fd, f)(*(int *)key);
+       if (fd_empty(f))
+               return -EBADF;
+
+       pid = pidfd_pid(f);
        if (IS_ERR(pid))
                return ERR_CAST(pid);

@@ -104,19 +106,13 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
         */
        WARN_ON_ONCE(!rcu_read_lock_held());
        task = pid_task(pid, PIDTYPE_PID);
-       if (!task) {
-               err = -ENOENT;
-               goto out;
-       }
+       if (!task)
+               return ERR_PTR(-ENOENT);

        bpf_task_storage_lock();
        sdata = task_storage_lookup(task, map, true);
        bpf_task_storage_unlock();
-       put_pid(pid);
        return sdata ? sdata->data : NULL;
-out:
-       put_pid(pid);
-       return ERR_PTR(err);
 }

which avoids the reference count bumps on @pid.
It remains pinned by the pidfd anyway.

