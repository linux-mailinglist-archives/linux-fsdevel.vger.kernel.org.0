Return-Path: <linux-fsdevel+bounces-29430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21B979A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 05:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36AD1F22436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F31BC4E;
	Mon, 16 Sep 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLO7R71M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5340134B1;
	Mon, 16 Sep 2024 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726456854; cv=none; b=NfPu1OLNcpyKCFFVIArI8HggOjH6w4Ttiuk5cuO1Xfog/Uh2t7JdYptRQlq0imeEwLGWLz+QEbsa1Te3ucPfjycjQRWdabI8GBKZk0OigcObPjAzWhGWc2bkekfJLSLBnKFYQglAf1SEIu/A47UhWhCLKy4OHciRw9WUvWZN5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726456854; c=relaxed/simple;
	bh=eA0Iyo15B/qZHSTE79fwDWNOYLYLojTtikOcENsT8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0NW3x3Y7fmLtR6k4IxMuMvR2uuj0Vo022EPBi5eJ/X1Nk6ye33DihtmUkNUb0zHmXq/v+eCXZo8iOS35pXfP1+4wB2UFCyAb72fLk2sVP0K0j030atgbg/uU1+eUMxX3VOVKH8LhD9190neVCvQmJ4h15xXSmGYtEIrCOHfupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLO7R71M; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-717934728adso2962924b3a.2;
        Sun, 15 Sep 2024 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726456852; x=1727061652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln43YramaFeXVEywvFE+ekQsGy0RBkrTNESqwuctvu0=;
        b=dLO7R71M3A/uuk44orClZw+2EAWXTCyVhkxV5ryLSgpwOCd/+sSr7Qj1Nfv2MSQwpS
         LZjiK0t92qL7Q5+Es9pa7muSLJVSkFATjfJpqCmpEvPGtqgJa5ps/4r+67YinpeReMyo
         d2j2z4X/3lAN7lehy6bkQp9GT3UJQK2FoDvZFGmU9eTyi/OSSqOI7FO3/qcqrRep1WJA
         4ZHzZlp6ky49AZrvojk7rt5a+Xp2VaKSHXBXOtDJwPXpdmiav5SfA9QS9iWotvL2iTeZ
         23Y9oM7UOMp5jqfq14W5LwtaAi8zZtBnR9PfpPlGrWV5+xW14XJ/pWoCSMfESu2UEmVL
         WLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726456852; x=1727061652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln43YramaFeXVEywvFE+ekQsGy0RBkrTNESqwuctvu0=;
        b=t9Yzh9lk/7SourlLArWWHLismHPdtLXLHNplQn/JI2H3/FfO0gxnwa4YQRlSvgBCOC
         IZa9aX/P3yptUoL+toE+XWJdDKgIPgieuy5SEpxZDjXz2az9UF8FU8YvRvvfeFPqXjN9
         MDvKbwpoNFqXa5q1dQuGTpHliEEo+PA6TfZMae6gS/SKdR7KbmqnIqhu7FFo9X/JECZz
         tyc/0dsbad+HPWCuMHxsSfduhbB5RmDEXHqtLrEhyOsRSFxzgIxhhydST1xS3EHCZHaQ
         oJeOkpGZk8PLxW4DQQsIU/+HX3cxrzn5ahJEwfmgFabNlfMrAvnmeO+jOtZbMJXiNGg1
         DccQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3XfIfk9Dj8O4tcOInIWD1QeBmsyhNFYs+eby0Lp9pqYECjF1sZA6zkWXi5RPpjCaUBXddgt6dJkpblg==@vger.kernel.org, AJvYcCV8CQtsImuo4/mYH95ouvofqaGzQdO2SryuEahCIS40x9UenR1H7pmkoO7POttgZhO9wi2Ku+5av7/U@vger.kernel.org, AJvYcCViu4x28AEiZbJn78jj4QKyZmQgPBx1P1JU4dY9bph77llyA9D/a0tyeytaQRhsaI/oyLNsl78OIlDxLhpyUg==@vger.kernel.org, AJvYcCVp6cK4HITwRX/u36c6QgUlun19hTSsv3M8TSA+tSinwedene76n2qUc3Y20NRgOJbp1ihPjVHPyqAiRsF4FHEH@vger.kernel.org, AJvYcCW+Dyf1mw+0447llbUeoTICznwdnEeaMgu/GZG5s/QdR8T1zMBjLoVZJxHKWZD3us2jcaV7qQANWIHoCygk@vger.kernel.org, AJvYcCXgLirdjaW3HCbuV66xYVK5nhRDdBeYZ0c80dOmFHfCmudBb14v68doQ5hIKQj3on/+kSX/SrDAgM3S@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/EQkz/H1c1P8xo90f6c9PM/avoVM0CrMB+w/ypfUyVbu7Trm
	CmAm6zo40lPcHqlaHjf1dHWYnjEfEYEzC3RumWlq8s3r0llTw344
X-Google-Smtp-Source: AGHT+IFJeoeu4HDyng0F6uvuul+DFxLEH9oIq4v5HXKbnb/zWfnwPLVWH+7Lt+lb5Pp93IGSFKsHJA==
X-Received: by 2002:a05:6a00:92a6:b0:717:8ece:2f8b with SMTP id d2e1a72fcca58-719261edde9mr21919216b3a.17.1726456851425;
        Sun, 15 Sep 2024 20:20:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944abb69esm2903079b3a.67.2024.09.15.20.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 20:20:51 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 279664A358AE; Mon, 16 Sep 2024 10:20:46 +0700 (WIB)
Date: Mon, 16 Sep 2024 10:20:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@sifive.com, conor@kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	robh@kernel.org, krzk+dt@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, kees@kernel.org, Liam.Howlett@oracle.com,
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, shuah@kernel.org,
	brauner@kernel.org, samuel.holland@sifive.com, andy.chiu@sifive.com,
	jerry.shih@sifive.com, greentime.hu@sifive.com,
	charlie@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	xiao.w.wang@intel.com, ajones@ventanamicro.com, anup@brainfault.org,
	mchitale@ventanamicro.com, atishp@rivosinc.com, sameo@rivosinc.com,
	bjorn@rivosinc.com, alexghiti@rivosinc.com, david@redhat.com,
	libang.li@antgroup.com, jszhang@kernel.org, leobras@redhat.com,
	guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, costa.shul@redhat.com, bhe@redhat.com,
	zong.li@sifive.com, puranjay@kernel.org, namcaov@gmail.com,
	antonb@tenstorrent.com, sorear@fastmail.com,
	quic_bjorande@quicinc.com, ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk, quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com, yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn, sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com, schwab@suse.de, dawei.li@shingroup.cn,
	rppt@kernel.org, willy@infradead.org, usama.anjum@collabora.com,
	osalvador@suse.de, ryan.roberts@arm.com, andrii@kernel.org,
	alx@kernel.org, catalin.marinas@arm.com, broonie@kernel.org,
	revest@chromium.org, bgray@linux.ibm.com, deller@gmx.de,
	zev@bewilderbeest.net
Subject: Re: [PATCH v4 29/30] riscv: Documentation for shadow stack on riscv
Message-ID: <ZuekDuJS66-YGg5L@archie.me>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-30-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfhcWBhyYL8bTXY7"
Content-Disposition: inline
In-Reply-To: <20240912231650.3740732-30-debug@rivosinc.com>


--cfhcWBhyYL8bTXY7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:16:48PM -0700, Deepak Gupta wrote:
> Adding documentation on shadow stack for user mode on riscv and kernel
> interfaces exposed so that user tasks can enable it.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/arch/riscv/zicfiss.rst | 169 +++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/arch/riscv/zicfiss.rst

Add the toctree entry:

---- >8 ----
diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/=
index.rst
index be7237b6968213..e240eb0ceb70c4 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -15,6 +15,7 @@ RISC-V architecture
     vector
     cmodx
     zicfilp
+    zicfiss

     features

> +Following structure has been added to sigcontext for RISC-V. `rsvd` fiel=
d has been kept
> +in case we need some extra information in future for landing pads / indi=
rect branch
> +tracking. It has been kept today in order to allow backward compatibilit=
y in future.
> +
> +struct __sc_riscv_cfi_state {
> +	unsigned long ss_ptr;
> +	unsigned long rsvd;
> +};

Sphinx reports indentation warning again:

Documentation/arch/riscv/zicfiss.rst:163: WARNING: Definition list ends wit=
hout a blank line; unexpected unindent.

I have to wrap __sc_riscv_cfi_state struct definition as a literal code blo=
ck:

---- >8 ----
diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/risc=
v/zicfiss.rst
index f133b6af9c1525..96d85ed352b146 100644
--- a/Documentation/arch/riscv/zicfiss.rst
+++ b/Documentation/arch/riscv/zicfiss.rst
@@ -155,12 +155,12 @@ make sure that there is a `shadow stack token` in add=
ition to invoking `sigretur
 -----------------------
 Following structure has been added to sigcontext for RISC-V. `rsvd` field =
has been kept
 in case we need some extra information in future for landing pads / indire=
ct branch
-tracking. It has been kept today in order to allow backward compatibility =
in future.
+tracking. It has been kept today in order to allow backward compatibility =
in future::

-struct __sc_riscv_cfi_state {
+  struct __sc_riscv_cfi_state {
 	unsigned long ss_ptr;
 	unsigned long rsvd;
-};
+  };

 As part of signal delivery, shadow stack token is saved on current shadow =
stack itself and
 updated pointer is saved away in `ss_ptr` field in `__sc_riscv_cfi_state` =
under `sigcontext`

> +
> +As part of signal delivery, shadow stack token is saved on current shado=
w stack itself and
> +updated pointer is saved away in `ss_ptr` field in `__sc_riscv_cfi_state=
` under `sigcontext`
> +Existing shadow stack allocation is used for signal delivery. During `si=
greturn`, kernel will
> +obtain `ss_ptr` from `sigcontext` and verify the saved token on shadow s=
tack itself and switch
> +shadow stack.

Also inline the code identifiers (keywords):

---- >8 ----
diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/risc=
v/zicfiss.rst
index 96d85ed352b146..9f721fbcaa6f6a 100644
--- a/Documentation/arch/riscv/zicfiss.rst
+++ b/Documentation/arch/riscv/zicfiss.rst
@@ -23,30 +23,30 @@ of the program.

 Return addresses live on stack and thus in read-write memory and thus are
 susceptible to corruption and allows an adversary to reach any program cou=
nter
-(PC) in address space. On RISC-V `zicfiss` extension provides an alternate=
 stack
-`shadow stack` on which return addresses can be safely placed in prolog of=
 the
-function and retrieved in epilog. `zicfiss` extension makes following chan=
ges
+(PC) in address space. On RISC-V ``zicfiss`` extension provides an alterna=
te stack
+(`shadow stack`) on which return addresses can be safely placed in prolog =
of the
+function and retrieved in epilog. ``zicfiss`` extension makes following ch=
anges:

 	- PTE encodings for shadow stack virtual memory
 	  An earlier reserved encoding in first stage translation i.e.
 	  PTE.R=3D0, PTE.W=3D1, PTE.X=3D0  becomes PTE encoding for shadow stack =
pages.

-	- `sspush x1/x5` instruction pushes (stores) `x1/x5` to shadow stack.
+	- ``sspush x1/x5`` instruction pushes (stores) `x1/x5`` to shadow stack.

-	- `sspopchk x1/x5` instruction pops (loads) from shadow stack and compares
-	  with `x1/x5` and if un-equal, CPU raises `software check exception` with
-	  `*tval =3D 3`
+	- ``sspopchk x1/x5`` instruction pops (loads) from shadow stack and compa=
res
+	  with ``x1/x5`` and if not equal, CPU raises software check exception
+          with ``*tval =3D 3``

-Compiler toolchain makes sure that function prologs have `sspush x1/x5` to=
 save return
-address on shadow stack in addition to regular stack. Similarly function e=
pilogs have
-`ld x5, offset(x2)`; `sspopchk x5` to ensure that popped value from regula=
r stack
-matches with popped value from shadow stack.
+Compiler toolchain makes sure that function prologs have ``sspush x1/x5`` =
to
+save return address on shadow stack in addition to regular stack. Similarly
+function epilogs have ``ld x5, offset(x2); sspopchk x5`` to ensure that po=
pped
+value from regular stack matches with popped value from shadow stack.

 2. Shadow stack protections and linux memory manager
 -----------------------------------------------------

 As mentioned earlier, shadow stack get new page table encodings and thus h=
ave some
-special properties assigned to them and instructions that operate on them =
as below
+special properties assigned to them and instructions that operate on them =
as below:

 	- Regular stores to shadow stack memory raises access store faults.
 	  This way shadow stack memory is protected from stray inadvertant
@@ -60,11 +60,11 @@ special properties assigned to them and instructions th=
at operate on them as bel
 	  shadow stack store.

 	- Shadow stack load / shadow stack store on read-only memory raises
-	  AMO/store page fault. Thus both `sspush x1/x5` and `sspopchk x1/x5`
+	  AMO/store page fault. Thus both ``sspush x1/x5`` and ``sspopchk x1/x5``
 	  will raise AMO/store page fault. This simplies COW handling in kernel
 	  During fork, kernel can convert shadow stack pages into read-only
 	  memory (as it does for regular read-write memory) and as soon as
-	  subsequent `sspush` or `sspopchk` in userspace is encountered, then
+	  subsequent ``sspush`` or ``sspopchk`` in userspace is encountered, then
 	  kernel can perform COW.

 	- Shadow stack load / shadow stack store on read-write, read-write-
@@ -75,8 +75,8 @@ special properties assigned to them and instructions that=
 operate on them as bel
 3. ELF and psABI
 -----------------

-Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_BCFI` for property
-`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+Toolchain sets up ``GNU_PROPERTY_RISCV_FEATURE_1_BCFI`` for property
+``GNU_PROPERTY_RISCV_FEATURE_1_AND`` in notes section of the object file.

 4. Linux enabling
 ------------------
@@ -89,25 +89,25 @@ shadow stack for the program.
 5. prctl() enabling
 --------------------

-`PR_SET_SHADOW_STACK_STATUS` / `PR_GET_SHADOW_STACK_STATUS` /
-`PR_LOCK_SHADOW_STACK_STATUS` are three prctls added to manage shadow stack
+``PR_SET_SHADOW_STACK_STATUS`` / ``PR_GET_SHADOW_STACK_STATUS`` /
+``PR_LOCK_SHADOW_STACK_STATUS`` are three prctls added to manage shadow st=
ack
 enabling for tasks. prctls are arch agnostic and returns -EINVAL on other =
arches.

-`PR_SET_SHADOW_STACK_STATUS`: If arg1 `PR_SHADOW_STACK_ENABLE` and if CPU =
supports
-`zicfiss` then kernel will enable shadow stack for the task. Dynamic loade=
r can
-issue this `prctl` once it has determined that all the objects loaded in a=
ddress
-space have support for shadow stack. Additionally if there is a `dlopen` t=
o an
-object which wasn't compiled with `zicfiss`, dynamic loader can issue this=
 prctl
-with arg1 set to 0 (i.e. `PR_SHADOW_STACK_ENABLE` being clear)
+``PR_SET_SHADOW_STACK_STATUS``: If arg1 ``PR_SHADOW_STACK_ENABLE`` and if =
CPU supports
+``zicfiss`` then kernel will enable shadow stack for the task. Dynamic loa=
der can
+issue this ``prctl`` once it has determined that all the objects loaded in=
 address
+space have support for shadow stack. Additionally if there is a ``dlopen``=
 to an
+object which wasn't compiled with ``zicfiss``, dynamic loader can issue th=
is prctl
+with arg1 set to 0 (i.e. ``PR_SHADOW_STACK_ENABLE`` being clear)

-`PR_GET_SHADOW_STACK_STATUS`: Returns current status of indirect branch tr=
acking.
-If enabled it'll return `PR_SHADOW_STACK_ENABLE`
+``PR_GET_SHADOW_STACK_STATUS``: Returns current status of indirect branch =
tracking.
+If enabled it'll return ``PR_SHADOW_STACK_ENABLE``

-`PR_LOCK_SHADOW_STACK_STATUS`: Locks current status of shadow stack enabli=
ng on the
-task. User space may want to run with strict security posture and wouldn't=
 want
-loading of objects without `zicfiss` support in it and thus would want to =
disallow
-disabling of shadow stack on current task. In that case user space can use=
 this prctl
-to lock current settings.
+``PR_LOCK_SHADOW_STACK_STATUS``: Locks current status of shadow stack enab=
ling
+on the task. User space may want to run with strict security posture and
+wouldn't want loading of objects without ``zicfiss`` support in it and thus
+would want to disallow disabling of shadow stack on current task. In that =
case
+user space can use this prctl to lock current settings.

 5. violations related to returns with shadow stack enabled
 -----------------------------------------------------------
@@ -115,22 +115,22 @@ to lock current settings.
 Pertaining to shadow stack, CPU raises software check exception in followi=
ng
 condition

-	- On execution of `sspopchk x1/x5`, x1/x5 didn't match top of shadow stac=
k.
-	  If mismatch happens then cpu does `*tval =3D 3` and raise software check
-	  exception
+	- On execution of ``sspopchk x1/x5``, x1/x5 didn't match top of shadow
+          stack. If mismatch happens then cpu does ``*tval =3D 3`` and rai=
se
+          software check exception.

-Linux kernel will treat this as `SIGSEV`` with code =3D `SEGV_CPERR` and f=
ollow
+Linux kernel will treat this as ``SIGSEV`` with ``SEGV_CPERR`` code and fo=
llow
 normal course of signal delivery.

 6. Shadow stack tokens
 -----------------------
-Regular stores on shadow stacks are not allowed and thus can't be tampered=
 with via
-arbitrary stray writes due to bugs. Method of pivoting / switching to shad=
ow stack
-is simply writing to csr `CSR_SSP` changes active shadow stack. This can b=
e problematic
-because usually value to be written to `CSR_SSP` will be loaded somewhere =
in writeable
-memory and thus allows an adversary to corruption bug in software to pivot=
 to an any
-address in shadow stack range. Shadow stack tokens can help mitigate this =
problem by
-making sure that:
+Regular stores on shadow stacks are not allowed and thus can't be tampered=
 with
+via arbitrary stray writes due to bugs. Method of pivoting / switching to
+shadow stack is simply writing to csr ``CSR_SSP`` changes active shadow st=
ack.
+This can be problematic because usually value to be written to ``CSR_SSP``=
 will
+be loaded somewhere in writeable memory and thus allows an adversary to
+corruption bug in software to pivot to an any address in shadow stack rang=
e.
+Shadow stack tokens can help mitigate this problem by making sure that:

  - When software is switching away from a shadow stack, shadow stack point=
er should be
    saved on shadow stack itself and call it `shadow stack token`
@@ -139,31 +139,34 @@ making sure that:
    from shadow stack pointer and verify that `shadow stack token` itself i=
s pointer to
    shadow stack itself.

- - Once the token verification is done, software can perform the write to =
`CSR_SSP` to
-   switch shadow stack.
+ - Once the token verification is done, software can perform the write to
+   ``CSR_SSP`` to switch shadow stack.

-Here software can be user mode task runtime itself which is managing vario=
us contexts
-as part of single thread. Software can be kernel as well when kernel has t=
o deliver a
-signal to user task and must save shadow stack pointer. Kernel can perform=
 similar
-procedure by saving a token on user shadow stack itself. This way whenever=
 sigreturn
-happens, kernel can read the token and verify the token and then switch to=
 shadow stack.
-Using this mechanism, kernel helps user task so that any corruption issue =
in user task
-is not exploited by adversary by arbitrarily using `sigreturn`. Adversary =
will have to
-make sure that there is a `shadow stack token` in addition to invoking `si=
greturn`
+Here software can be user mode task runtime itself which is managing vario=
us
+contexts as part of single thread. Software can be kernel as well when ker=
nel
+has to deliver a signal to user task and must save shadow stack pointer. K=
ernel
+can perform similar procedure by saving a token on user shadow stack itsel=
f.
+This way whenever sigreturn happens, kernel can read the token and verify =
the
+token and then switch to shadow stack. Using this mechanism, kernel helps =
user
+task so that any corruption issue in user task is not exploited by adversa=
ry by
+arbitrarily using ``sigreturn``. Adversary will have to make sure that the=
re is
+a `shadow stack token` in addition to invoking ``sigreturn``

 7. Signal shadow stack
 -----------------------
-Following structure has been added to sigcontext for RISC-V. `rsvd` field =
has been kept
-in case we need some extra information in future for landing pads / indire=
ct branch
-tracking. It has been kept today in order to allow backward compatibility =
in future::
+Following structure has been added to sigcontext for RISC-V. ``rsvd`` fiel=
d has
+been kept in case we need some extra information in future for landing pad=
s /
+indirect branch tracking. It has been kept today in order to allow backward
+compatibility in future::

   struct __sc_riscv_cfi_state {
 	unsigned long ss_ptr;
 	unsigned long rsvd;
   };

-As part of signal delivery, shadow stack token is saved on current shadow =
stack itself and
-updated pointer is saved away in `ss_ptr` field in `__sc_riscv_cfi_state` =
under `sigcontext`
-Existing shadow stack allocation is used for signal delivery. During `sigr=
eturn`, kernel will
-obtain `ss_ptr` from `sigcontext` and verify the saved token on shadow sta=
ck itself and switch
-shadow stack.
+As part of signal delivery, shadow stack token is saved on current shadow =
stack
+itself and updated pointer is saved away in ``ss_ptr`` field in
+``__sc_riscv_cfi_state`` under ``sigcontext`` Existing shadow stack alloca=
tion
+is used for signal delivery. During ``sigreturn``, kernel will obtain
+``ss_ptr`` from ``sigcontext`` and verify the saved token on shadow stack
+itself and switch shadow stack.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cfhcWBhyYL8bTXY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZuekCAAKCRD2uYlJVVFO
o++5AP9Xu2vqD0dx3z2ctEtTVxfDn/hZ0MG1BdgPDbMcuONwlQD/a5DYWvzVdYIn
M3JiT/WxCGHof1VpWC4uaWz4jKV08gE=
=Xiks
-----END PGP SIGNATURE-----

--cfhcWBhyYL8bTXY7--

