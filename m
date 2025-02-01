Return-Path: <linux-fsdevel+bounces-40530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148EA247FC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D297A307B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7D148310;
	Sat,  1 Feb 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSCfX8KN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69A433BE;
	Sat,  1 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738402804; cv=none; b=mwASXbJGzJlBDvtPU7ERJKydiL5KGnZ3fh6SORI/H6y6iP5mrYJBGFtB26uk76wGJrtW78LP9mDOLifxKpIAk/JUPVGprxgOrjl/qPxbjTYRuVS1JO4zQaziG8976M0xAVoOghy1GK0VuW0+0xW+6NDoJe44luY1WZlysOiqJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738402804; c=relaxed/simple;
	bh=aAMRfRl5ZHwn79N0tp/fQ8i+GehS66SCFBO187z07bE=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AkBFWDlU3OCJowLnW/L8VpZdlg1IprOprobNbFlFvpNIDL6D4WmbsB22apVCvu4Iv68Om3Yj94Gcteu0zJ7OGVBPuj5cnJIzZfBbpkF/YFNRHdL8wgNwCgXdXL9Hc7objWpcp1+P3C7rm5cP77R5JYEK65DpYKQ55eRAUE7din4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSCfX8KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827E1C4CED3;
	Sat,  1 Feb 2025 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738402803;
	bh=aAMRfRl5ZHwn79N0tp/fQ8i+GehS66SCFBO187z07bE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=PSCfX8KNh15ymm4kfHgnW1KsRLIzB1kmBvu8P/ZPITWkUKaBP8aAJmCDo1aWrhcS7
	 9J6U2aHbzUf0YQ0GIKl15eCr5SimYPJW3PxE4XX/0Lqn3+pDD8VgvTIdQvJJ5eUOAi
	 rOxvqva+v77/EA8iyoc0Vc4wQJk71yQUFokKP6mka3zq89AWRv5q8y5oaaN/n9a3z2
	 w8g77L2qq9oFzb63YSWFLmojozL8GTBtqJmG5zBE9GAh8OUQOAZdMt8hNy9w9vTLwn
	 PhmTwoImt5Lybw/oY+qB2ypewSuiKAm0Kwk6h9w2cAeiExi1CL9BZUYlqgA+vyRyFY
	 PDrbycaYs4fmA==
Date: Sat, 01 Feb 2025 01:40:00 -0800
From: Kees Cook <kees@kernel.org>
To: Nir Lichtman <nir@lichtman.org>, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: remove redundant save asides of old pid/vpid
User-Agent: K-9 Mail for Android
In-Reply-To: <20250201083127.GA1185473@lichtman.org>
References: <20250201083127.GA1185473@lichtman.org>
Message-ID: <0B25310A-0907-481E-8ADF-EEFA78927BFF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 1, 2025 12:31:27 AM PST, Nir Lichtman <nir@lichtman=2Eorg> wro=
te:
>Problem: Old pid and vpid are redundantly saved aside before starting to
>parse the binary, with the comment claiming that it is required since
>load_binary changes it, though from inspection in the source,
>load_binary does not change the pid and this wouldn't make sense since
>execve does not create any new process, quote from man page of execve:
>"there is no new process; many attributes of the calling process remain
>unchanged (in particular, its PID)=2E"

See commit bb188d7e64de ("ptrace: make former thread ID available via PTRA=
CE_GETEVENTMSG after PTRACE_EVENT_EXEC stop")

This is for making sense of a concurrent exec made by a multi threaded pro=
cess=2E Specifically see de_thread(), where the pid *can* change:

 /*
  * At this point all other threads have exited, all we have to
	 * do is to wait for the thread group leader to become inactive,
	 * and to assume its PID:
	 */

The described problem in the commit hasn't changed, so this code needs to =
stay as-is=2E Or perhaps the comment could be improved?

-Kees

>
>Solution: Remove the saving aside of both and later on use them directly
>from the current object, instead of via the saved aside objects=2E
>
>Signed-off-by: Nir Lichtman <nir@lichtman=2Eorg>
>---
>
>Side-note: Tested this solution with a defconfig x86_64 and an initramfs
>with Busybox and confirmed to work fine=2E
>
> fs/exec=2Ec | 12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
>
>diff --git a/fs/exec=2Ec b/fs/exec=2Ec
>index 506cd411f4ac=2E=2E6bb0a7b15f7e 100644
>--- a/fs/exec=2Ec
>+++ b/fs/exec=2Ec
>@@ -1789,15 +1789,8 @@ static int search_binary_handler(struct linux_binp=
rm *bprm)
> /* binfmt handlers will call back into begin_new_exec() on success=2E */
> static int exec_binprm(struct linux_binprm *bprm)
> {
>-	pid_t old_pid, old_vpid;
> 	int ret, depth;
>=20
>-	/* Need to fetch pid before load_binary changes it */
>-	old_pid =3D current->pid;
>-	rcu_read_lock();
>-	old_vpid =3D task_pid_nr_ns(current, task_active_pid_ns(current->parent=
));
>-	rcu_read_unlock();
>-
> 	/* This allows 4 levels of binfmt rewrites before failing hard=2E */
> 	for (depth =3D 0;; depth++) {
> 		struct file *exec;
>@@ -1826,8 +1819,9 @@ static int exec_binprm(struct linux_binprm *bprm)
> 	}
>=20
> 	audit_bprm(bprm);
>-	trace_sched_process_exec(current, old_pid, bprm);
>-	ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
>+	trace_sched_process_exec(current, current->pid, bprm);
>+	ptrace_event(PTRACE_EVENT_EXEC,
>+			task_pid_nr_ns(current, task_active_pid_ns(current->parent)));
> 	proc_exec_connector(current);
> 	return 0;
> }

--=20
Kees Cook

