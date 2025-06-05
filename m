Return-Path: <linux-fsdevel+bounces-50754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25989ACF4CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E8216BA29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB7275842;
	Thu,  5 Jun 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+qIwzhI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233E5FEE6;
	Thu,  5 Jun 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142416; cv=none; b=FnF0FWD1m3eqrJkWNt4/Fc4hb99HT6pGEeKlOlcd0A6oRvB9VPtAaTuQ1UkXvpen2AJ+DzocM1CiXmmNVuS/tl9XcFpQqeZKc66j9v2eyfGHGNN8nnoQ7mnV/VzJ2nR4qvznh08RM1o/hF7aTM/67bfgH8VPsBZwd9Flw1+JG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142416; c=relaxed/simple;
	bh=KMP3dS1zMtkplUXSRP0+47kw4xWK5soLRj6GgNgsYBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQSQnj2iwTyoDV8XvKRu4skM5pHB/nUO+2fYQ//0PzSRH21x5AIzatedU+TE3fzZYMVBReZPogPAPNHRVmLGDTDjH6b+6riKgeXTbSsmYnYgvh1PQpVw1kDig72RTmW6ePqVwdS47UoZJE53VsxqkwnejoxFzu82Ig4ykCFcdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+qIwzhI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b07d607dc83so958400a12.1;
        Thu, 05 Jun 2025 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142415; x=1749747215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQM6PXKTYAEfinFV/Ka9g3mqQ+xIrk/UWiYd7yLaIo0=;
        b=J+qIwzhIqms1Z9pxV3fBuPWkRu907oYy+YRaKXac7dHgpfVmF9BcA3feIYFrb6aocb
         ss0fbgeXABFePwqrsCChaJjjf2l3kJcT7q6F2TJ1iHwuvVxXnhxE74W/CPvaU1+R9IM0
         O6R2pg2iePpf/NYSafoO6Ci3XTJYeI0mNjzHuPLHmY9aAwTbqlJ6skch4CD18+O174vk
         ORnIm7U0GciMBFZa7iNM5u7oJXi0ak6yoW6QcpfCCzZQMP0Sh9DGtyYx7a8S0YEmxHOY
         ss7MnzZMjhssIxlknYN77TJikR6Mydca91sHqkkarD4GwcGncYa2BvFEGARqHuiFY91q
         a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142415; x=1749747215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQM6PXKTYAEfinFV/Ka9g3mqQ+xIrk/UWiYd7yLaIo0=;
        b=hj3gUAQrx5c2YdSN1iKjzf7DR5cfKnZ66U3jv7h7QUN1IaV/5twbTYF2yagAT3oMUH
         DYRXGnnwIROVIPQl0P7YPR4nozQaRUaiLAlli2bGGJpC5jJ//xCrjMEqYE+96R8PwASY
         YHj8c1sADZ+cAyDgp5F5kKdwolQ8qk4zbKh/63EA5G+L7Pf6/nK9F5ptGwm69duVjlVG
         vuNyyJzej1RPwuQdxulR3/av1rHfiyvszybo7GcLmTjADo3c15Z75PD0cZ5ek7QaHXaR
         M7m6OoOPU00T1Cf3oLcz9R0zVuzMpgv9IaY+Uo75qqfF0sJ3jsi3vbDc1J3QAASY57E5
         TTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBuKE9dXNFlnnFkd6oywb/hCKXbGtskaZYFzonujGgHe52yC8D5MNrlFj0LX7zk6DhJ2Zusg6/h+BF8yJn@vger.kernel.org, AJvYcCUgqkdTY+gGBLsYeYoB3WQLAPuAIsQz636RBGo+YvrjXuwFqAg+4k+om36yfMh/Znvda3QcWhW64WBQwEMG@vger.kernel.org, AJvYcCVhuqDYLPyIs08NgX+7lFEQG0pLdOAIHQ50yAGCDLxeVx0gTVdT4EuixV2t8VrsZaKRl8yOAXirNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu6raARTPxKDl7cNzTPEqxCzbnk6STmL1N1gCtYjuYHeXBBfM
	VPFSZoWFiTOgyPAS+BWPkw91PYB66f7otSWrX7RCypaqjoMwqlkWPMSRQd+54fcGca/zO1UH9Jo
	t/elbqXbpybZth4VqiWhlhDZOXdzGQvU=
X-Gm-Gg: ASbGncv5CJguIfoGNncOjEyGD8UhB8yFUCAS3CD8pRZbANf+A5xTof+dJihmF+0kbPa
	Y1WImmheRE7q1pjZXHTVsOLEJuJtoPgvnWr4yWyJ2iuOPPEwd0HwXy5QyTncaAXRhDbJO0KhQlY
	VDAFjlxUp31u5ZaiB/hjr+Ush11KdQETmk
X-Google-Smtp-Source: AGHT+IE/5H2jkZv77CpbItShpHzziKM+aqSnFe+GjugBeHnkqgmBIqWOy7EbRMHkqfXS3ZsMbgegfUm2tI8IpkFiSi4=
X-Received: by 2002:a17:90b:1c08:b0:312:1ae9:153a with SMTP id
 98e67ed59e1d1-3134767ec13mr426905a91.25.1749142414552; Thu, 05 Jun 2025
 09:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734ceal7q.fsf@gmail.com> <CAEjxPJ4Jge=Kwryv_dmghj83i1wYArge7rKS=Ukq1SUjxsbe-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Jge=Kwryv_dmghj83i1wYArge7rKS=Ukq1SUjxsbe-A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Jun 2025 12:53:23 -0400
X-Gm-Features: AX0GCFvtKOmh9H8kC1hKvON9BQPlXn_qHWmC1Mg29GIL1Ul4siO629qy9a3-Ink
Message-ID: <CAEjxPJ4gCRaH3vBa9doenr86Xm7NMaPGkpFSngCEZkBuC7_LAw@mail.gmail.com>
Subject: Re: Recent Linux kernel commit breaks Gnulib test suite.
To: Collin Funk <collin.funk1@gmail.com>
Cc: bug-gnulib@gnu.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 5, 2025 at 12:03=E2=80=AFAM Collin Funk <collin.funk1@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > Using the following testdir:
> >
> >     $ git clone https://git.savannah.gnu.org/git/gnulib.git && cd gnuli=
b
> >     $ ./gnulib-tool --create-testdir --dir testdir1 --single-configure =
`./gnulib-tool --list | grep acl`
> >
> > I see the following result:
> >
> >     $ cd testdir1 && ./configure && make check
> >     [...]
> >     FAIL: test-copy-acl.sh
> >     [...]
> >     FAIL: test-file-has-acl.sh
> >
> > This occurs with these two kernels:
> >
> >     $ uname -r
> >     6.14.9-300.fc42.x86_64
> >     $ uname -r
> >     6.14.8-300.fc42.x86_64
> >
> > But with this kernel:
> >
> >     $ uname -r
> >     6.14.6-300.fc42.x86_64
> >
> > The result is:
> >
> >     $ cd testdir1 && ./configure && make check
> >     [...]
> >     PASS: test-copy-acl.sh
> >     [...]
> >     PASS: test-file-has-acl.sh
> >
> > Here is the test-suite.log from 6.14.9-300.fc42.x86_64:
> >
> >     FAIL: test-copy-acl.sh
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     /home/collin/.local/src/gnulib/testdir1/gltests/test-copy-acl: pres=
erving permissions for 'tmpfile2': Numerical result out of range
> >     FAIL test-copy-acl.sh (exit status: 1)
> >
> >     FAIL: test-file-has-acl.sh
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> >     file_has_acl("tmpfile0") returned no, expected yes
> >     FAIL test-file-has-acl.sh (exit status: 1)
> >
> > To investigate further, I created the testdir again after applying the
> > following diff:
> >
> >     diff --git a/tests/test-copy-acl.sh b/tests/test-copy-acl.sh
> >     index 061755f124..f9457e884f 100755
> >     --- a/tests/test-copy-acl.sh
> >     +++ b/tests/test-copy-acl.sh
> >     @@ -209,7 +209,7 @@ cd "$builddir" ||
> >        {
> >          echo "Simple contents" > "$2"
> >          chmod 600 "$2"
> >     -    ${CHECKER} "$builddir"/test-copy-acl${EXEEXT} "$1" "$2" || exi=
t 1
> >     +    ${CHECKER} strace "$builddir"/test-copy-acl${EXEEXT} "$1" "$2"=
 || exit 1
> >          ${CHECKER} "$builddir"/test-sameacls${EXEEXT} "$1" "$2" || exi=
t 1
> >          func_test_same_acls                           "$1" "$2" || exi=
t 1
> >        }
> >
> > Then running the test from inside testdir1/gltests:
> >
> >     $ ./test-copy-acl.sh
> >     [...]
> >     access("/etc/selinux/config", F_OK)     =3D 0
> >     openat(AT_FDCWD, "tmpfile0", O_RDONLY)  =3D 3
> >     fstat(3, {st_mode=3DS_IFREG|0610, st_size=3D16, ...}) =3D 0
> >     openat(AT_FDCWD, "tmpfile2", O_WRONLY)  =3D 4
> >     fchmod(4, 0610)                         =3D 0
> >     flistxattr(3, NULL, 0)                  =3D 17
> >     flistxattr(3, 0x7ffda3f6c900, 17)       =3D -1 ERANGE (Numerical re=
sult out of range)
> >     write(2, "/home/collin/.local/src/gnulib/t"..., 63/home/collin/.loc=
al/src/gnulib/testdir1/gltests/test-copy-acl: ) =3D 63
> >     write(2, "preserving permissions for 'tmpf"..., 37preserving permis=
sions for 'tmpfile2') =3D 37
> >     write(2, ": Numerical result out of range", 31: Numerical result ou=
t of range) =3D 31
> >     write(2, "\n", 1
> >     )                       =3D 1
> >     exit_group(1)                           =3D ?
> >     +++ exited with 1 +++
> >
> > So, we get the buffer size from 'flistxattr(3, NULL, 0)' and then call
> > it again after allocating it 'flistxattr(3, 0x7ffda3f6c900, 17)'. This
> > shouldn't fail with ERANGE then.
> >
> > To confirm, I replaced 'strace' with 'gdb --args'. Here is the result:
> >
> >     (gdb) b qcopy_acl
> >     Breakpoint 1 at 0x400a10: file qcopy-acl.c, line 84.
> >     (gdb) run
> >     Starting program: /home/collin/.local/src/gnulib/testdir1/gltests/t=
est-copy-acl tmpfile0 tmpfile2
> >     [Thread debugging using libthread_db enabled]
> >     Using host libthread_db library "/lib64/libthread_db.so.1".
> >
> >     Breakpoint 1, qcopy_acl (src_name=3Dsrc_name@entry=3D0x7fffffffd7c3=
 "tmpfile0", source_desc=3Dsource_desc@entry=3D3,
> >         dst_name=3Ddst_name@entry=3D0x7fffffffd7cc "tmpfile2", dest_des=
c=3Ddest_desc@entry=3D4, mode=3Dmode@entry=3D392) at qcopy-acl.c:84
> >     84    ret =3D chmod_or_fchmod (dst_name, dest_desc, mode);
> >     (gdb) n
> >     90    if (ret =3D=3D 0)
> >     (gdb) n
> >     92        ret =3D source_desc <=3D 0 || dest_desc <=3D 0
> >     (gdb) s
> >     attr_copy_fd (src_path=3Dsrc_path@entry=3D0x7fffffffd7c3 "tmpfile0"=
, src_fd=3Dsrc_fd@entry=3D3, dst_path=3Ddst_path@entry=3D0x7fffffffd7cc "tm=
pfile2",
> >         dst_fd=3Ddst_fd@entry=3D4, check=3Dcheck@entry=3D0x4009b0 <is_a=
ttr_permissions>, ctx=3Dctx@entry=3D0x0) at libattr/attr_copy_fd.c:73
> >     73          if (check =3D=3D NULL)
> >     (gdb) n
> >     76          size =3D flistxattr (src_fd, NULL, 0);
> >     (gdb) n
> >     77          if (size < 0) {
> >     (gdb) print size
> >     $1 =3D 17
> >     (gdb) n
> >     86          names =3D (char *) my_alloc (size+1);
> >     (gdb) n
> >     92          size =3D flistxattr (src_fd, names, size);
> >     (gdb) print errno
> >     $2 =3D 0
> >     (gdb) n
> >     93          if (size < 0) {
> >     (gdb) print size
> >     $3 =3D -1
> >     (gdb) print errno
> >     $4 =3D 34
> >
> > After confirming with the Fedora Kernel tags [1], I am fairly confident
> > that it was caused by this commit [2].
> >
> > But I am not familiar enough with ACLs, SELinux, or the Kernel to know
> > the fix.
> >
> > Adding the lists where this was discussed and some of the signers to CC=
,
> > since they will know better than me.
>
> Thank you for the bug report. Looks like the security xattr handling
> is somehow replacing the overall length with just the length of the
> security.selinux xattr rather than adding it to the length of the acl
> xattr. Will check to see if this is already fixed on vfs.fixes; if
> not, will look into a fix although it wasn't immediately obvious to me
> why this is happening. There is also another patch related to this
> pending that is supposed to go through the LSM tree which might fix
> it.

Sorry, mea culpa; should be fixed by
https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

>
> >
> > Collin
> >
> > [1] https://gitlab.com/cki-project/kernel-ark
> > [2] https://github.com/torvalds/linux/commit/8b0ba61df5a1c44e2b3cf68383=
1a4fc5e24ea99d

