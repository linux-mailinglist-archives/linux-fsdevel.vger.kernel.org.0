Return-Path: <linux-fsdevel+bounces-39091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F4A0C44D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E971889AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF71F8F18;
	Mon, 13 Jan 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv2yPhCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035518FDAB;
	Mon, 13 Jan 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805638; cv=none; b=WN62WYBq+iEez2wLSYP9UuYCG1TiISq8gWeD4Dq70mydf949RyVq8I5zhFh6BfnVX/gF9ZTATT54TsIr2Yww7BNAp7wMtAj6Uf04k3vKjNMcPqwL6zIRpWeFCT08Ysd32mSgw+T5Q6+FefkiNONeNhI+uc+XUp5b/NnZo/FMPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805638; c=relaxed/simple;
	bh=SHj2x4csW6qKOxkAvS1hn9sClL6HxYfNRcCMrXeIEAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjKvk3Cy+ZVzgh9EuRlLNxtdYhby9qXUFiSYEAc87wNdas/k2IX0U5azXXLnEkjKD136NC35z4jRI5WWGIH3+sP0lNhGkaufKByKMjn3UixrASMZnbcBsc0DyK2Lft2PJIoNtTXgjadHcjmha1cCaSmzCEYjsHpTrUmtcd82PxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv2yPhCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66862C4CEE9;
	Mon, 13 Jan 2025 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736805637;
	bh=SHj2x4csW6qKOxkAvS1hn9sClL6HxYfNRcCMrXeIEAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kv2yPhCBRNRQJFsIZ9Lsz8Gh2NQJI3hsaljfz+93a8iykYzbqnpgvK6Ftovt6uUz9
	 ygxuzWWs9HpJpDl4+LjTMLSrRn9/+uOcXcrQYkG9DAPN4arRgycRWSIy6kpGOKkTvo
	 dpDl3v4tawLtNGZ+oXxz9LJKEuKyfR/zBuzlZ2xWFBa6BCRMXjLBg2mWvjhRU23zD5
	 BvHTcAnf4/jbk54dy5EnASux+O5s3ZJtc5PMBFp+CjQkWcgdFXh7+J0HkOw/HOkTR6
	 Mk7SliVubp3LWozGq0ZtG8oNSKCK/FLcgHTRnBpQD7iV5jOnmhGODgUryp8XA6Wx9Z
	 +QaKHPOjdfNag==
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844ee43460aso371591839f.1;
        Mon, 13 Jan 2025 14:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo0+XlIKIWsxfOGpIFPTIze0aAhWimFJkmXgBvQmeukmOp1mkv2jsEDDhW8VVBdYT0eH8sbqjRrs3kugMn@vger.kernel.org, AJvYcCWuu1QT3WrF8uwmWXE+p/KteGDiNWsz8fMTr9ugiQLkK+ihrJUDExQvkVnEgCd8w9g/+XRwb6RCNKIpdIF6@vger.kernel.org, AJvYcCXe/yERbVteIAfAjZpqBhjFOLXb5Pm3BODW4BKvRZ3xngW0xrVUzXLIGKUQQLzoAIDWYQQ6/1svSg/zL3ldLTBNNQB7SAtc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KLNihNWUQXzxz+7RF89os465ARusD3uJFURrZTJm9oNw+SWD
	dlGdwe/aAivpMVhl5M7P/DpINhLYLl+ZF12AnWEHhOstqxefodYUOOXiOs8Gwjd/oHuSOHLBELk
	s3sKjgu5ux6cMjqKYn6oSh86NEcw=
X-Google-Smtp-Source: AGHT+IEQlyQf/KVL587SY2eWDCLzaBjslt1hYN6IsEiAFjQkOvD9N1MLvfQt8mSSr/KIaHJemVyTZrAU6kO12ghjam4=
X-Received: by 2002:a92:cda6:0:b0:3a7:70a4:6877 with SMTP id
 e9e14a558f8ab-3ce3a87a690mr184148635ab.7.1736805636704; Mon, 13 Jan 2025
 14:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110011342.2965136-1-song@kernel.org>
In-Reply-To: <20250110011342.2965136-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 13 Jan 2025 14:00:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5nsd0HbkPC5hJsDJhN36NPcKN8dTd+KqQ6eB+mPc9LFg@mail.gmail.com>
X-Gm-Features: AbW1kvaDLmTima93aLP4tDWxfLt8MQYJ84-4Gw4IHdIafOonXw7QJ1jMh7EWcRI
Message-ID: <CAPhsuW5nsd0HbkPC5hJsDJhN36NPcKN8dTd+KqQ6eB+mPc9LFg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 0/7] Enable writing xattr from BPF programs
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kpsingh@kernel.org, 
	mattbobrowski@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al Christian and Jan,

Could you please help review this set? The fs side change is
in 1/7 (already reviewed by fs folks) and 6/7.

Thanks,
Song

On Thu, Jan 9, 2025 at 5:13=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add support to set and remove xattr from BPF program. Also add
> security.bpf. xattr name prefix.
>
> kfuncs are added to set and remove xattrs with security.bpf. name
> prefix. Update kfuncs bpf_get_[file|dentry]_xattr to read xattrs
> with security.bpf. name prefix. Note that BPF programs can read
> user. xattrs, but not write and remove them.
>
> To pick the right version of kfunc to use, a remap logic is added to
> btf_kfunc_id_set. This helps move some kfunc specific logic off the
> verifier core code. Also use this remap logic to select
> bpf_dynptr_from_skb or bpf_dynptr_from_skb_rdonly.
>
>
> Cover letter of v1 and v2:
>
> Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
> prefix. This set adds "security.bpf." xattr name prefix, and allows
> bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.
>
> [1] https://lpc.events/event/18/contributions/1940/
>
> Changes v8 =3D> v9
> 1. Fix build for CONFIG_DEBUG_INFO_BTF=3Dn case. (kernel test robot)
>
> v8: https://lore.kernel.org/bpf/20250108225140.3467654-1-song@kernel.org/
>
> Changes v7 =3D> v8
> 1. Rebase and resolve conflicts.
>
> v7: https://lore.kernel.org/bpf/20241219221439.2455664-1-song@kernel.org/
>
> Changes v6 =3D> v7
> 1. Move btf_kfunc_id_remap() to the right place. (Bug reported by CI)
>
> v6: https://lore.kernel.org/bpf/20241219202536.1625216-1-song@kernel.org/
>
> Changes v5 =3D> v6
> 1. Hide _locked version of the kfuncs from vmlinux.h (Alexei)
> 2. Add remap logic to btf_kfunc_id_set and use that to pick the correct
>    version of kfuncs to use.
> 3. Also use the remap logic for bpf_dynptr_from_skb[|_rdonly].
>
> v5: https://lore.kernel.org/bpf/20241218044711.1723221-1-song@kernel.org/
>
> Changes v4 =3D> v5
> 1. Let verifier pick proper kfunc (_locked or not _locked)  based on the
>    calling context. (Alexei)
> 2. Remove the __failure test (6/6 of v4).
>
> v4: https://lore.kernel.org/bpf/20241217063821.482857-1-song@kernel.org/
>
> Changes v3 =3D> v4
> 1. Do write permission check with inode locked. (Jan Kara)
> 2. Fix some source_inline warnings.
>
> v3: https://lore.kernel.org/bpf/20241210220627.2800362-1-song@kernel.org/
>
> Changes v2 =3D> v3
> 1. Add kfuncs to set and remove xattr from BPF programs.
>
> v2: https://lore.kernel.org/bpf/20241016070955.375923-1-song@kernel.org/
>
> Changes v1 =3D> v2
> 1. Update comment of bpf_get_[file|dentry]_xattr. (Jiri Olsa)
> 2. Fix comment for return value of bpf_get_[file|dentry]_xattr.
>
> v1: https://lore.kernel.org/bpf/20241002214637.3625277-1-song@kernel.org/
>
> Song Liu (7):
>   fs/xattr: bpf: Introduce security.bpf. xattr name prefix
>   selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr
>     names
>   bpf: lsm: Add two more sleepable hooks
>   bpf: Extend btf_kfunc_id_set to handle kfunc polymorphism
>   bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
>   bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
>   selftests/bpf: Test kfuncs that set and remove xattr from BPF programs
>
>  fs/bpf_fs_kfuncs.c                            | 246 +++++++++++++++++-
>  include/linux/bpf_lsm.h                       |   2 +
>  include/linux/btf.h                           |  20 ++
>  include/linux/btf_ids.h                       |   4 +
>  include/uapi/linux/xattr.h                    |   4 +
>  kernel/bpf/bpf_lsm.c                          |   2 +
>  kernel/bpf/btf.c                              | 117 +++++++--
>  kernel/bpf/verifier.c                         |  31 +--
>  net/core/filter.c                             |  49 +++-
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
>  .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 +++++++++++-
>  .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
>  .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++
>  13 files changed, 740 insertions(+), 63 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xat=
tr.c
>
> --
> 2.43.5

