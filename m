Return-Path: <linux-fsdevel+bounces-27588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100809629A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FA21F2567C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3582189502;
	Wed, 28 Aug 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYHfzpm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A913BAC3;
	Wed, 28 Aug 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853838; cv=none; b=lBCYS6UVu65GFESVjFdp4t9l//94hJ25kq7WJC1viRCmkYypUNyf0m5lLsoGEudwRBfbiEfJFGj5DLzFcuhEcEQnLRb60fmcMT8o2Btd/gfYAwtgygmTU1TxHodxQrFPoyysJHKTIwfaZANvJCeRsEk20B0U6USVJzhMgDDKsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853838; c=relaxed/simple;
	bh=lcHIdMYhBsJloW9fSwc6JWgDLrvYPjB0GKNuKWcKMcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AVr9b3axMTmZpxPaMYC37mBtX9l1A44CuOg6eizZWkkLjxDeSG09yLVzfMI8Sr0yKeGnPVbT/kGDgPikl5d7SQLJj2nVRWahTz4VliAa26n7Nguu7y/L5TyDbpYCzr0zSqwMhLkwIFuDLJEApDPpm0GR4vJg2MmU2I/+m0uLsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYHfzpm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A1C98ED1;
	Wed, 28 Aug 2024 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724853837;
	bh=lcHIdMYhBsJloW9fSwc6JWgDLrvYPjB0GKNuKWcKMcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uYHfzpm/VEEl9wksfaG1d5QteWMrPN+ZXmcPmB4Ia/soAnFKfgp9mhZnydUdJy6t3
	 5hOMGih31y5Y0fN1t96rLTITQopjIB1gRZgSkMnTAd5YlwLPxUACpAe4a5PXgNd1x2
	 hpU8nDF5Zc6Bc8653vJzBfHxUfifFRTQnHGsz/tw6NzvgFnHzEfDdXZeB7kEqktYAm
	 Wc8LHvMMW1amVNWZ0JQzHloemAhzlGZNsRMSB7QJdgQgyDYRfzf/czVtJC+gsxoSV0
	 E1HK5namjymsUD6QBpH/p4y8aAuzx2hW1oimDQwAINC0Kv0Tg+aurxOigRs5WPigA4
	 Z3zuMYGKFHTcQ==
Date: Wed, 28 Aug 2024 07:03:58 -0700
From: Kees Cook <kees@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
CC: torvalds@linux-foundation.org, alx@kernel.org, justinstitt@google.com,
 ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <keescook@chromium.org>, Matus Jokay <matus.jokay@stuba.sk>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
User-Agent: K-9 Mail for Android
In-Reply-To: <20240828030321.20688-2-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-2-laoar.shao@gmail.com>
Message-ID: <8A36564D-56E3-469B-B201-0BD7C11D6EFC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 27, 2024 8:03:14 PM PDT, Yafang Shao <laoar=2Eshao@gmail=2Ecom> =
wrote:
>We want to eliminate the use of __get_task_comm() for the following
>reasons:
>
>- The task_lock() is unnecessary
>  Quoted from Linus [0]:
>  : Since user space can randomly change their names anyway, using lockin=
g
>  : was always wrong for readers (for writers it probably does make sense
>  : to have some lock - although practically speaking nobody cares there
>  : either, but at least for a writer some kind of race could have
>  : long-term mixed results
>
>- The BUILD_BUG_ON() doesn't add any value
>  The only requirement is to ensure that the destination buffer is a vali=
d
>  array=2E

Sorry, that's not a correct evaluation=2E See below=2E

>
>- Zeroing is not necessary in current use cases
>  To avoid confusion, we should remove it=2E Moreover, not zeroing could
>  potentially make it easier to uncover bugs=2E If the caller needs a
>  zero-padded task name, it should be explicitly handled at the call site=
=2E

This is also not an appropriate rationale=2E We don't make the kernel "mor=
e buggy" not purpose=2E ;) See below=2E

>
>Suggested-by: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Link: https://lore=2Ekernel=2Eorg/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-=
npJooP8chLPEfaFV0oNYTTBA@mail=2Egmail=2Ecom [0]
>Link: https://lore=2Ekernel=2Eorg/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwK=
wu99v7+b6AyHMmaDFA@mail=2Egmail=2Ecom/
>Suggested-by: Alejandro Colomar <alx@kernel=2Eorg>
>Link: https://lore=2Ekernel=2Eorg/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueu=
rfbosf5wdo65dk4@srb3hsk72zwq
>Signed-off-by: Yafang Shao <laoar=2Eshao@gmail=2Ecom>
>Cc: Alexander Viro <viro@zeniv=2Elinux=2Eorg=2Euk>
>Cc: Christian Brauner <brauner@kernel=2Eorg>
>Cc: Jan Kara <jack@suse=2Ecz>
>Cc: Eric Biederman <ebiederm@xmission=2Ecom>
>Cc: Kees Cook <keescook@chromium=2Eorg>
>Cc: Alexei Starovoitov <alexei=2Estarovoitov@gmail=2Ecom>
>Cc: Matus Jokay <matus=2Ejokay@stuba=2Esk>
>Cc: Alejandro Colomar <alx@kernel=2Eorg>
>Cc: "Serge E=2E Hallyn" <serge@hallyn=2Ecom>
>---
> fs/exec=2Ec             | 10 ----------
> fs/proc/array=2Ec       |  2 +-
> include/linux/sched=2Eh | 32 ++++++++++++++++++++++++++------
> kernel/kthread=2Ec      |  2 +-
> 4 files changed, 28 insertions(+), 18 deletions(-)
>
>diff --git a/fs/exec=2Ec b/fs/exec=2Ec
>index 50e76cc633c4=2E=2E8a23171bc3c3 100644
>--- a/fs/exec=2Ec
>+++ b/fs/exec=2Ec
>@@ -1264,16 +1264,6 @@ static int unshare_sighand(struct task_struct *me)
> 	return 0;
> }
>=20
>-char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *ts=
k)
>-{
>-	task_lock(tsk);
>-	/* Always NUL terminated and zero-padded */
>-	strscpy_pad(buf, tsk->comm, buf_size);
>-	task_unlock(tsk);
>-	return buf;
>-}
>-EXPORT_SYMBOL_GPL(__get_task_comm);
>-
> /*
>  * These functions flushes out all traces of the currently running execu=
table
>  * so that a new one can be started
>diff --git a/fs/proc/array=2Ec b/fs/proc/array=2Ec
>index 34a47fb0c57f=2E=2E55ed3510d2bb 100644
>--- a/fs/proc/array=2Ec
>+++ b/fs/proc/array=2Ec
>@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_s=
truct *p, bool escape)
> 	else if (p->flags & PF_KTHREAD)
> 		get_kthread_comm(tcomm, sizeof(tcomm), p);
> 	else
>-		__get_task_comm(tcomm, sizeof(tcomm), p);
>+		get_task_comm(tcomm, p);
>=20
> 	if (escape)
> 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
>diff --git a/include/linux/sched=2Eh b/include/linux/sched=2Eh
>index f8d150343d42=2E=2Ec40b95a79d80 100644
>--- a/include/linux/sched=2Eh
>+++ b/include/linux/sched=2Eh
>@@ -1096,9 +1096,12 @@ struct task_struct {
> 	/*
> 	 * executable name, excluding path=2E
> 	 *
>-	 * - normally initialized setup_new_exec()
>-	 * - access it with [gs]et_task_comm()
>-	 * - lock it with task_lock()
>+	 * - normally initialized begin_new_exec()
>+	 * - set it with set_task_comm()
>+	 *   - strscpy_pad() to ensure it is always NUL-terminated and
>+	 *     zero-padded
>+	 *   - task_lock() to ensure the operation is atomic and the name is
>+	 *     fully updated=2E
> 	 */
> 	char				comm[TASK_COMM_LEN];
>=20
>@@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_stru=
ct *tsk, const char *from)
> 	__set_task_comm(tsk, from, false);
> }
>=20
>-extern char *__get_task_comm(char *to, size_t len, struct task_struct *t=
sk);
>+/*
>+ * - Why not use task_lock()?
>+ *   User space can randomly change their names anyway, so locking for r=
eaders
>+ *   doesn't make sense=2E For writers, locking is probably necessary, a=
s a race
>+ *   condition could lead to long-term mixed results=2E
>+ *   The strscpy_pad() in __set_task_comm() can ensure that the task com=
m is
>+ *   always NUL-terminated and zero-padded=2E Therefore the race conditi=
on between
>+ *   reader and writer is not an issue=2E
>+ *
>+ * - Why not use strscpy_pad()?
>+ *   While strscpy_pad() prevents writing garbage past the NUL terminato=
r, which
>+ *   is useful when using the task name as a key in a hash map, most use=
 cases
>+ *   don't require this=2E Zero-padding might confuse users if it=E2=80=
=99s unnecessary,
>+ *   and not zeroing might even make it easier to expose bugs=2E If you =
need a
>+ *   zero-padded task name, please handle that explicitly at the call si=
te=2E

I really don't like this part of the change=2E You don't know that existin=
g callers don't depend on the padding=2E Please invert this logic: get_task=
_comm() must use strscpy_pad()=2E Calls NOT wanting padding can call strscp=
y() themselves=2E

>+ *
>+ * - ARRAY_SIZE() can help ensure that @buf is indeed an array=2E

This doesn't need checking here; strscpy() will already do that=2E=20

>+ */
> #define get_task_comm(buf, tsk) ({			\
>-	BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);	\

Also, please leave the TASK_COMM_LEN test so that destination buffers cont=
inue to be the correct size: current callers do not perform any return valu=
e analysis, so they cannot accidentally start having situations where the d=
estination string might be truncated=2E Again, anyone wanting to avoid that=
 restriction can use strscpy() directly and check the return value=2E

>-	__get_task_comm(buf, sizeof(buf), tsk);		\
>+	strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));	\
>+	buf;						\
> })
>=20
> #ifdef CONFIG_SMP
>diff --git a/kernel/kthread=2Ec b/kernel/kthread=2Ec
>index f7be976ff88a=2E=2E7d001d033cf9 100644
>--- a/kernel/kthread=2Ec
>+++ b/kernel/kthread=2Ec
>@@ -101,7 +101,7 @@ void get_kthread_comm(char *buf, size_t buf_size, str=
uct task_struct *tsk)
> 	struct kthread *kthread =3D to_kthread(tsk);
>=20
> 	if (!kthread || !kthread->full_name) {
>-		__get_task_comm(buf, buf_size, tsk);
>+		strscpy(buf, tsk->comm, buf_size);

Why is this safe to not use strscpy_pad? Also, is buf_size ever not TASK_C=
OMM_LEN?

> 		return;
> 	}
>=20

--=20
Kees Cook

