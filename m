Return-Path: <linux-fsdevel+bounces-50741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406FACF131
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716481890354
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11622272E69;
	Thu,  5 Jun 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVRuchjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D7271A6D;
	Thu,  5 Jun 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131232; cv=none; b=tniDPZcrMRVndSJlp9AV0gfIbrq7i8nKarZHO/7GjPRQRrTRtbmrEZRJh8r04z5+LsqVrpFNT5rRkQVtaRO6Dco31ggzmygv3PUNmmHJWjjWARuwYI2cNvcnEvOd8+pguq8sfA/btrmt0ORdWjhHq3y5YNXYhgH5GoskvMSFxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131232; c=relaxed/simple;
	bh=NtWWFVU/pnUBQtAeZv7oayajsBI4yW3jMoICtgS0bIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXzyOFpQgFpm6STscsF1nscbNpT+HOtXkcxpWzkCcYnUw/NH2TeCFVkMoNWCCeSCdOXXs5esQKr/bA/eq6LptE6Af+eT+7uL8aJ7oJRZywIdsHuv3FSC+Em7VqkRoTTUDRvFyQ409/mE4759tQEuVzrd/Gv6jmh34n9BNFIRsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVRuchjP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-312a62055d0so1028679a91.3;
        Thu, 05 Jun 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749131230; x=1749736030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSDRKYBaYicU90r0Rf5lmDRIp7KxnJueuxoPVFPbmRw=;
        b=gVRuchjPTHR1zO/eBBs3L9hXtDJlFLuGDS/f/jVkav9THl8diOdxVXLi8ELYObdD+e
         7jKM3SY19X2khGf3gUFGSOEKD5uk20fpJQcBqF+5/qevESQyCqEGI6qdCmWIbgfdWDFz
         QRPyHcpp0M+TGM53jrBVN+jcQ2mBBfHf8Bx+z2OuC+rGb/QuJKEWTVFHMrg2h8tB7esK
         lVg3koNEOtrSKZ11C2yB4oGv4Na3lMaQvC28wY85bNO9UH/2AFguIboS+fsB7O0TGU/5
         9nELGtLk7+P+zLzuXjqEppJeed3Vww6RGprVCQEppntLhc25FpbihL9+HQ6tIGacS97i
         3dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131230; x=1749736030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSDRKYBaYicU90r0Rf5lmDRIp7KxnJueuxoPVFPbmRw=;
        b=SuBM4wh36fhBFZ0Qt91Lf2xBrcbaTC6fGvHOcBxeWlXOlJw2QJNPwQNX2ThVUK93wC
         h6GFAsbo8lQos3zek5zXQSQADSZkMwD5zjznwgIsV4gtbsicYxnr+XW/cwhpoSP3nHv0
         SNQTPIp0t52br2nxsYQxAWiKeolKeZ8XyedFDBLVlvrTlW0wLtr1lZSjC6i32GzqiJEy
         O2sEQ9g849Lf5x/ZoDXfO5qF5AaeCNNst4C46RnchXsF7uEpMrA95u53LY6Dv69ARCs9
         lbnYNKfgVvcxb7hW6asbNExd7NlgQekgqPU/O+3N426uz4KeLMOGjo6HAXOyd7jxrVI/
         NKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/O22CFTeMoVT83Is5FDZynCRHhWbCVFqApY8EDyPnHGGdX6MvcHkOWP/JmGW/QfiX8gcSxcPNfrF5REgl@vger.kernel.org, AJvYcCVqJqdjalECM+Er6qYilGH+HyGECjnyTcDGBh6BXv4xqm+qwRWD/43+GxXQchx8lExzR97JD8FqzQ==@vger.kernel.org, AJvYcCWDEwahV/BbH/i9cUt6+hT5mTv+R2YEDX1HK/ZuASpVDAsqxVStHEaH9ptGdziS7Mwwkjiro76J1cKm2Nm7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5vF1YhM/FIU7hXins+olmPghGsgIO39tju5f0x4AMMG6kUXt
	XF+pzOkLr5uuFqF6apr/z9OfriAdbDdb/3BdmdeOiHMn801aMKTKs5Ao+0cyGSUwBIgnSVIoDl8
	le72icOPl7bCPdm56FiOlnhV2fwrMbd4=
X-Gm-Gg: ASbGncsmVizufcQ356iwQzmlR7wYN1goyTunDizpNi8jqk//FAccyiBDMvf9/qCoEcN
	HNjnbZ09xOvpHB78r3RfH8YTP2Tc6EmpguqsdDknJxh/dYUDMDY15q+pHMpMrIwo8oQyqbxRquK
	lMDWvPGEO2qnVC946RlNR9OdFFlfKSZfirE8YnzA5Ha5k=
X-Google-Smtp-Source: AGHT+IH6mzY2HS4G9xqjl6vs+YsD1Pbk+zKKn5gOORX208P92KYnjmxOu8Xmx1azKN2g6R/1Ttnxc3/m4C8aoUgLJdc=
X-Received: by 2002:a17:90b:1b44:b0:312:db8f:9a09 with SMTP id
 98e67ed59e1d1-3130cd296famr11205935a91.14.1749131229734; Thu, 05 Jun 2025
 06:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734ceal7q.fsf@gmail.com>
In-Reply-To: <8734ceal7q.fsf@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Jun 2025 09:46:57 -0400
X-Gm-Features: AX0GCFtvQ2JSs2NAj79UbYpHUbF20FXAzMwVH-KUy4fKnFb3_nLGCapQ2dfDuHg
Message-ID: <CAEjxPJ4Jge=Kwryv_dmghj83i1wYArge7rKS=Ukq1SUjxsbe-A@mail.gmail.com>
Subject: Re: Recent Linux kernel commit breaks Gnulib test suite.
To: Collin Funk <collin.funk1@gmail.com>
Cc: bug-gnulib@gnu.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:03=E2=80=AFAM Collin Funk <collin.funk1@gmail.com=
> wrote:
>
> Hi,
>
> Using the following testdir:
>
>     $ git clone https://git.savannah.gnu.org/git/gnulib.git && cd gnulib
>     $ ./gnulib-tool --create-testdir --dir testdir1 --single-configure `.=
/gnulib-tool --list | grep acl`
>
> I see the following result:
>
>     $ cd testdir1 && ./configure && make check
>     [...]
>     FAIL: test-copy-acl.sh
>     [...]
>     FAIL: test-file-has-acl.sh
>
> This occurs with these two kernels:
>
>     $ uname -r
>     6.14.9-300.fc42.x86_64
>     $ uname -r
>     6.14.8-300.fc42.x86_64
>
> But with this kernel:
>
>     $ uname -r
>     6.14.6-300.fc42.x86_64
>
> The result is:
>
>     $ cd testdir1 && ./configure && make check
>     [...]
>     PASS: test-copy-acl.sh
>     [...]
>     PASS: test-file-has-acl.sh
>
> Here is the test-suite.log from 6.14.9-300.fc42.x86_64:
>
>     FAIL: test-copy-acl.sh
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     /home/collin/.local/src/gnulib/testdir1/gltests/test-copy-acl: preser=
ving permissions for 'tmpfile2': Numerical result out of range
>     FAIL test-copy-acl.sh (exit status: 1)
>
>     FAIL: test-file-has-acl.sh
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
>     file_has_acl("tmpfile0") returned no, expected yes
>     FAIL test-file-has-acl.sh (exit status: 1)
>
> To investigate further, I created the testdir again after applying the
> following diff:
>
>     diff --git a/tests/test-copy-acl.sh b/tests/test-copy-acl.sh
>     index 061755f124..f9457e884f 100755
>     --- a/tests/test-copy-acl.sh
>     +++ b/tests/test-copy-acl.sh
>     @@ -209,7 +209,7 @@ cd "$builddir" ||
>        {
>          echo "Simple contents" > "$2"
>          chmod 600 "$2"
>     -    ${CHECKER} "$builddir"/test-copy-acl${EXEEXT} "$1" "$2" || exit =
1
>     +    ${CHECKER} strace "$builddir"/test-copy-acl${EXEEXT} "$1" "$2" |=
| exit 1
>          ${CHECKER} "$builddir"/test-sameacls${EXEEXT} "$1" "$2" || exit =
1
>          func_test_same_acls                           "$1" "$2" || exit =
1
>        }
>
> Then running the test from inside testdir1/gltests:
>
>     $ ./test-copy-acl.sh
>     [...]
>     access("/etc/selinux/config", F_OK)     =3D 0
>     openat(AT_FDCWD, "tmpfile0", O_RDONLY)  =3D 3
>     fstat(3, {st_mode=3DS_IFREG|0610, st_size=3D16, ...}) =3D 0
>     openat(AT_FDCWD, "tmpfile2", O_WRONLY)  =3D 4
>     fchmod(4, 0610)                         =3D 0
>     flistxattr(3, NULL, 0)                  =3D 17
>     flistxattr(3, 0x7ffda3f6c900, 17)       =3D -1 ERANGE (Numerical resu=
lt out of range)
>     write(2, "/home/collin/.local/src/gnulib/t"..., 63/home/collin/.local=
/src/gnulib/testdir1/gltests/test-copy-acl: ) =3D 63
>     write(2, "preserving permissions for 'tmpf"..., 37preserving permissi=
ons for 'tmpfile2') =3D 37
>     write(2, ": Numerical result out of range", 31: Numerical result out =
of range) =3D 31
>     write(2, "\n", 1
>     )                       =3D 1
>     exit_group(1)                           =3D ?
>     +++ exited with 1 +++
>
> So, we get the buffer size from 'flistxattr(3, NULL, 0)' and then call
> it again after allocating it 'flistxattr(3, 0x7ffda3f6c900, 17)'. This
> shouldn't fail with ERANGE then.
>
> To confirm, I replaced 'strace' with 'gdb --args'. Here is the result:
>
>     (gdb) b qcopy_acl
>     Breakpoint 1 at 0x400a10: file qcopy-acl.c, line 84.
>     (gdb) run
>     Starting program: /home/collin/.local/src/gnulib/testdir1/gltests/tes=
t-copy-acl tmpfile0 tmpfile2
>     [Thread debugging using libthread_db enabled]
>     Using host libthread_db library "/lib64/libthread_db.so.1".
>
>     Breakpoint 1, qcopy_acl (src_name=3Dsrc_name@entry=3D0x7fffffffd7c3 "=
tmpfile0", source_desc=3Dsource_desc@entry=3D3,
>         dst_name=3Ddst_name@entry=3D0x7fffffffd7cc "tmpfile2", dest_desc=
=3Ddest_desc@entry=3D4, mode=3Dmode@entry=3D392) at qcopy-acl.c:84
>     84    ret =3D chmod_or_fchmod (dst_name, dest_desc, mode);
>     (gdb) n
>     90    if (ret =3D=3D 0)
>     (gdb) n
>     92        ret =3D source_desc <=3D 0 || dest_desc <=3D 0
>     (gdb) s
>     attr_copy_fd (src_path=3Dsrc_path@entry=3D0x7fffffffd7c3 "tmpfile0", =
src_fd=3Dsrc_fd@entry=3D3, dst_path=3Ddst_path@entry=3D0x7fffffffd7cc "tmpf=
ile2",
>         dst_fd=3Ddst_fd@entry=3D4, check=3Dcheck@entry=3D0x4009b0 <is_att=
r_permissions>, ctx=3Dctx@entry=3D0x0) at libattr/attr_copy_fd.c:73
>     73          if (check =3D=3D NULL)
>     (gdb) n
>     76          size =3D flistxattr (src_fd, NULL, 0);
>     (gdb) n
>     77          if (size < 0) {
>     (gdb) print size
>     $1 =3D 17
>     (gdb) n
>     86          names =3D (char *) my_alloc (size+1);
>     (gdb) n
>     92          size =3D flistxattr (src_fd, names, size);
>     (gdb) print errno
>     $2 =3D 0
>     (gdb) n
>     93          if (size < 0) {
>     (gdb) print size
>     $3 =3D -1
>     (gdb) print errno
>     $4 =3D 34
>
> After confirming with the Fedora Kernel tags [1], I am fairly confident
> that it was caused by this commit [2].
>
> But I am not familiar enough with ACLs, SELinux, or the Kernel to know
> the fix.
>
> Adding the lists where this was discussed and some of the signers to CC,
> since they will know better than me.

Thank you for the bug report. Looks like the security xattr handling
is somehow replacing the overall length with just the length of the
security.selinux xattr rather than adding it to the length of the acl
xattr. Will check to see if this is already fixed on vfs.fixes; if
not, will look into a fix although it wasn't immediately obvious to me
why this is happening. There is also another patch related to this
pending that is supposed to go through the LSM tree which might fix
it.

>
> Collin
>
> [1] https://gitlab.com/cki-project/kernel-ark
> [2] https://github.com/torvalds/linux/commit/8b0ba61df5a1c44e2b3cf683831a=
4fc5e24ea99d

