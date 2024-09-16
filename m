Return-Path: <linux-fsdevel+bounces-29427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117E9799EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 04:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819A51F22355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 02:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2217758;
	Mon, 16 Sep 2024 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlweSP4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DB2F5E;
	Mon, 16 Sep 2024 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726454478; cv=none; b=X06mYHXnSESC5ppOcR8T3jHoY4JJnH/913DJCJjZZgywMrJso9tEUOyaJfiR73hNWsa2Zd/p8xO40QxyZb5nOJEr59wQQaTspyDBMHgfbm4lqPYh0WIlq/J4EOmRRy9zHx1D76MfIn4uFLMM/Q8A1YydWztIGmpFf/aUCfhQGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726454478; c=relaxed/simple;
	bh=WPv4EHBABijpb+Zm84aFlDpeJrBmPt126XFbkXi3p5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIsGAqM7xRAeMAYwxa8u0aTwdF325y6ddqC9bE6VCYkDvbo4XyRd5CLa0QdrgJ0XEpFpj0rdU+JCkqgnbAIxTdRiqlxugSz96XKh3D80pqAIBwTZ+RTSwz0nrUgQgTLtNKz5XcamarZVDiA1N9rNu3N4Gt+2EKKqw1n1fieOyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlweSP4g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206e614953aso39451385ad.1;
        Sun, 15 Sep 2024 19:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726454476; x=1727059276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ7bc5SqcE0TyYrB+t+d7+/GZbyQXftQ6Hsj5bON1WY=;
        b=XlweSP4gX3PaOryaTBjIfil9imo7uVW4gLq0RRi7nmz2eUEN6AREWywkxsn0wMCZs9
         LUxEg0aPc/2pCtf3NVhTe79QEQj0ScRfJT1oZ/Vb2DnIIw5MIU0LSkeLrJglg5s1Zq9b
         e/69+s5dt2R6u0si2fm7c7c3FUcJRcahsMzgxS0ODKsMqQu/XwO0L7scooroou1hi3pu
         arpVshWFEjqGStudGdHGoawI9a6d4ltPFhuzBuYjh0J5zW/Rhsmde9w8eQ7Ys1pecM8E
         NnZzkz410OUT87S6WDQrn+qdG1N30aYkIlytwj+0STucrhmQD33McrQNZQTeFJOrgUHb
         KkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726454476; x=1727059276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ7bc5SqcE0TyYrB+t+d7+/GZbyQXftQ6Hsj5bON1WY=;
        b=b8bZzvRjEgvuRoETvQTOgpdQmoxZv+/q5I8P4drgfs3GWmJuoqFIGjS0EB2Y2O32w+
         0Z7yGDZZAIEpf58/1RB0PGem2CBjDyl6dIHx6yRfi6fgQgvihb1JrA09vUgtPLal32Sq
         TsZIZlzqL37UODvKLVFcWksQUDWavbou87pKx+TFc/88Us/koR56RoIFrmw3hdreLJ3v
         RvzNucWYavn/pms1xSy4duF6ZYZjyWQUjRuqx2lPlMz0YtTtfDBuPcDoO6vTRChLsanh
         mbyGtnFM1Vt9Qdt2Wbj5DKyda6XuW/88kqvoBvs2lfo5JxrDQEiKx60NHhJ+V3M/AHSL
         YSgg==
X-Forwarded-Encrypted: i=1; AJvYcCU5y/RaobjCf8amN3VSo6BtgWkP8yzNADIHOPLE4fhXvEiF8GwzNtO11KUOklOJS6ZqSWTExiOrAG3S@vger.kernel.org, AJvYcCV9wWkckLoy7gGH0MElR1GGmGuCg6brFeYU5jN/ct4pY0e7NL1RJM/R5v7d+ltvzp7baeRuYezhLGTpew==@vger.kernel.org, AJvYcCVE3n3f/HbVfYM/Cyp7A+TUAOkfMqba86YdGcBGuYe+I0UJbwLb/xseOKydMkh3cSsdXbABuLJ368BXL7M5@vger.kernel.org, AJvYcCVUyIIy6vsk+t9IzVkKbAinFl5KILsTm99zzE4C02QqsEZC3Ro6mPEBGQxOBZqh6RZQmc1oc1jA+wVE@vger.kernel.org, AJvYcCVu4mHz54yhSsgkYiINm49yMYJb5yPJ/tCEj3w2dnRpP4doUrRm2NGtxLX7S/acicrEaFqTHl73FmEHKA2ZDQ==@vger.kernel.org, AJvYcCWwjT1PqYraab8fOJmSyvSH/zTTtjqnBNkjir2XHvO13cIDKN6swf4WhQt7X5sBz5g+PEVHTfznJUltRatF2rCa@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrhLfEKTse1mBGDB5mhHgUl8UWdoZBbUQwYgdsT3uh7ZojLF3
	oY4QgMI3TWpxey0zgOfXADuyxegS51Gm+wyT6appD76QiPODOAAq
X-Google-Smtp-Source: AGHT+IHyg9ETyOh3qGNV5xRv1vfyKKfn6VYgML/Wb5aCl5WICkNwHMDNERLYbO7fqElfy2DB6QBQgw==
X-Received: by 2002:a17:902:fc47:b0:205:94df:e087 with SMTP id d9443c01a7336-2076e31eb57mr193154645ad.9.1726454475246;
        Sun, 15 Sep 2024 19:41:15 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f7073sm3277198a12.20.2024.09.15.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 19:41:14 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D32814A358AE; Mon, 16 Sep 2024 09:41:09 +0700 (WIB)
Date: Mon, 16 Sep 2024 09:41:09 +0700
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
Subject: Re: [PATCH v4 28/30] riscv: Documentation for landing pad / indirect
 branch tracking
Message-ID: <ZueaxRZgIf0crs4a@archie.me>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-29-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJXqtcSEhuPy+P+r"
Content-Disposition: inline
In-Reply-To: <20240912231650.3740732-29-debug@rivosinc.com>


--IJXqtcSEhuPy+P+r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:16:47PM -0700, Deepak Gupta wrote:
> Adding documentation on landing pad aka indirect branch tracking on riscv
> and kernel interfaces exposed so that user tasks can enable it.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/arch/riscv/zicfilp.rst | 104 +++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/arch/riscv/zicfilp.rst

Don't forget to add toctree entry:

---- >8 ----
diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/=
index.rst
index eecf347ce84944..be7237b6968213 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -14,6 +14,7 @@ RISC-V architecture
     uabi
     vector
     cmodx
+    zicfilp

     features


> +Function pointers live in read-write memory and thus are susceptible to =
corruption
> +and allows an adversary to reach any program counter (PC) in address spa=
ce. On
> +RISC-V zicfilp extension enforces a restriction on such indirect control=
 transfers
> +
> +	- indirect control transfers must land on a landing pad instruction `lp=
ad`.
> +	  There are two exception to this rule
> +		- rs1 =3D x1 or rs1 =3D x5, i.e. a return from a function and returns =
are
> +		  protected using shadow stack (see zicfiss.rst)
> +
> +		- rs1 =3D x7. On RISC-V compiler usually does below to reach function
> +		  which is beyond the offset possible J-type instruction.
> +
> +			"auipc x7, <imm>"
> +			"jalr (x7)"
> +
> +		  Such form of indirect control transfer are still immutable and don't=
 rely
> +		  on memory and thus rs1=3Dx7 is exempted from tracking and considered=
 software
> +		  guarded jumps.

Sphinx reports new htmldocs warnings:

Documentation/arch/riscv/zicfilp.rst:30: ERROR: Unexpected indentation.
Documentation/arch/riscv/zicfilp.rst:96: ERROR: Unexpected indentation.=09

I have to fix up the lists:

---- >8 ----
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/risc=
v/zicfilp.rst
index 23013ee711ac2c..c0fad1b5caa3d8 100644
--- a/Documentation/arch/riscv/zicfilp.rst
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -23,22 +23,24 @@ flow integrity (CFI) of the program.

 Function pointers live in read-write memory and thus are susceptible to co=
rruption
 and allows an adversary to reach any program counter (PC) in address space=
=2E On
-RISC-V zicfilp extension enforces a restriction on such indirect control t=
ransfers
+RISC-V zicfilp extension enforces a restriction on such indirect control
+transfers:

-	- indirect control transfers must land on a landing pad instruction `lpad=
`.
-	  There are two exception to this rule
-		- rs1 =3D x1 or rs1 =3D x5, i.e. a return from a function and returns are
-		  protected using shadow stack (see zicfiss.rst)
+- indirect control transfers must land on a landing pad instruction `lpad`.
+  There are two exception to this rule:

-		- rs1 =3D x7. On RISC-V compiler usually does below to reach function
-		  which is beyond the offset possible J-type instruction.
+  - rs1 =3D x1 or rs1 =3D x5, i.e. a return from a function and returns are
+    protected using shadow stack (see zicfiss.rst)

-			"auipc x7, <imm>"
-			"jalr (x7)"
+  - rs1 =3D x7. On RISC-V compiler usually does below to reach function
+    which is beyond the offset possible J-type instruction.

-		  Such form of indirect control transfer are still immutable and don't r=
ely
-		  on memory and thus rs1=3Dx7 is exempted from tracking and considered s=
oftware
-		  guarded jumps.
+      "auipc x7, <imm>"
+      "jalr (x7)"
+
+    Such form of indirect control transfer are still immutable and don't r=
ely
+    on memory and thus rs1=3Dx7 is exempted from tracking and considered s=
oftware
+    guarded jumps.

 `lpad` instruction is pseudo of `auipc rd, <imm_20bit>` with `rd=3Dx0`` an=
d is a HINT
 nop. `lpad` instruction must be aligned on 4 byte boundary and compares 20=
 bit
@@ -92,10 +94,11 @@ to lock current settings.
 --------------------------------------------------

 Pertaining to indirect branch tracking, CPU raises software check exceptio=
n in
-following conditions
-	- missing `lpad` after indirect call / jmp
-	- `lpad` not on 4 byte boundary
-	- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
+following conditions:
+
+- missing `lpad` after indirect call / jmp
+- `lpad` not on 4 byte boundary
+- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`

 In all 3 cases, `*tval =3D 2` is captured and software check exception is =
raised
 (cause=3D18)


> +
> +`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` with `rd=3Dx0`` =
and is a HINT
> +nop. `lpad` instruction must be aligned on 4 byte boundary and compares =
20 bit
> +immediate withx7. If `imm_20bit` =3D=3D 0, CPU don't perform any compari=
sion with x7. If
> +`imm_20bit` !=3D 0, then `imm_20bit` must match x7 else CPU will raise
> +`software check exception` (cause=3D18)with `*tval =3D 2`.
> +

Also inline identifiers/keywords to be consistent with rest of riscv docs:

---- >8 ----
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/risc=
v/zicfilp.rst
index c0fad1b5caa3d8..b0a766098f2335 100644
--- a/Documentation/arch/riscv/zicfilp.rst
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -26,38 +26,38 @@ and allows an adversary to reach any program counter (P=
C) in address space. On
 RISC-V zicfilp extension enforces a restriction on such indirect control
 transfers:

-- indirect control transfers must land on a landing pad instruction `lpad`.
+- indirect control transfers must land on a landing pad instruction ``lpad=
``.
   There are two exception to this rule:

   - rs1 =3D x1 or rs1 =3D x5, i.e. a return from a function and returns are
     protected using shadow stack (see zicfiss.rst)

   - rs1 =3D x7. On RISC-V compiler usually does below to reach function
-    which is beyond the offset possible J-type instruction.
+    which is beyond the offset possible J-type instruction::

-      "auipc x7, <imm>"
-      "jalr (x7)"
+      auipc x7, <imm>
+      jalr (x7)

     Such form of indirect control transfer are still immutable and don't r=
ely
     on memory and thus rs1=3Dx7 is exempted from tracking and considered s=
oftware
     guarded jumps.

-`lpad` instruction is pseudo of `auipc rd, <imm_20bit>` with `rd=3Dx0`` an=
d is a HINT
-nop. `lpad` instruction must be aligned on 4 byte boundary and compares 20=
 bit
-immediate withx7. If `imm_20bit` =3D=3D 0, CPU don't perform any comparisi=
on with x7. If
-`imm_20bit` !=3D 0, then `imm_20bit` must match x7 else CPU will raise
-`software check exception` (cause=3D18)with `*tval =3D 2`.
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=3Dx0=
`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate with x7. If ``imm_20bit`` =3D=3D 0, CPU don't pe=
rform any
+comparision with x7. If ``imm_20bit`` !=3D 0, then ``imm_20bit`` must matc=
h x7
+else CPU will raise software check exception (cause=3D18) with ``*tval =3D=
 2``.

 Compiler can generate a hash over function signatures and setup them (trun=
cated
-to 20bit) in x7 at callsites and function prologues can have `lpad` with s=
ame
+to 20bit) in x7 at callsites and function prologues can have ``lpad`` with=
 same
 function hash. This further reduces number of program counters a call site=
 can
 reach.

 2. ELF and psABI
 -----------------

-Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
-`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+Toolchain sets up ``GNU_PROPERTY_RISCV_FEATURE_1_FCFI`` for property
+``GNU_PROPERTY_RISCV_FEATURE_1_AND`` in notes section of the object file.

 3. Linux enabling
 ------------------
@@ -70,25 +70,26 @@ indirect branch tracking for the program.
 4. prctl() enabling
 --------------------

-`PR_SET_INDIR_BR_LP_STATUS` / `PR_GET_INDIR_BR_LP_STATUS` /
-`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect bra=
nch
+``PR_SET_INDIR_BR_LP_STATUS`` / ``PR_GET_INDIR_BR_LP_STATUS`` /
+``PR_LOCK_INDIR_BR_LP_STATUS`` are three prctls added to manage indirect b=
ranch
 tracking. prctls are arch agnostic and returns -EINVAL on other arches.

-`PR_SET_INDIR_BR_LP_STATUS`: If arg1 `PR_INDIR_BR_LP_ENABLE` and if CPU su=
pports
-`zicfilp` then kernel will enabled indirect branch tracking for the task.
-Dynamic loader can issue this `prctl` once it has determined that all the =
objects
-loaded in address space support indirect branch tracking. Additionally if =
there is
-a `dlopen` to an object which wasn't compiled with `zicfilp`, dynamic load=
er can
-issue this prctl with arg1 set to 0 (i.e. `PR_INDIR_BR_LP_ENABLE` being cl=
ear)
+``PR_SET_INDIR_BR_LP_STATUS``: If arg1 ``PR_INDIR_BR_LP_ENABLE`` and if CPU
+supports ``zicfilp`` then kernel will enabled indirect branch tracking for=
 the
+task. Dynamic loader can issue this ``prctl`` once it has determined that =
all
+the objects loaded in address space support indirect branch tracking.
+Additionally if there is a ``dlopen`` to an object which wasn't compiled w=
ith
+``zicfilp``, dynamic loader can issue this prctl with arg1 set to 0 (i.e.
+``PR_INDIR_BR_LP_ENABLE`` being clear)

-`PR_GET_INDIR_BR_LP_STATUS`: Returns current status of indirect branch tra=
cking.
-If enabled it'll return `PR_INDIR_BR_LP_ENABLE`
+``PR_GET_INDIR_BR_LP_STATUS``: Returns current status of indirect branch
+tracking. If enabled it'll return ``PR_INDIR_BR_LP_ENABLE``

-`PR_LOCK_INDIR_BR_LP_STATUS`: Locks current status of indirect branch trac=
king on
-the task. User space may want to run with strict security posture and woul=
dn't want
-loading of objects without `zicfilp` support in it and thus would want to =
disallow
-disabling of indirect branch tracking. In that case user space can use thi=
s prctl
-to lock current settings.
+``PR_LOCK_INDIR_BR_LP_STATUS``: Locks current status of indirect branch
+tracking on the task. User space may want to run with strict security post=
ure
+and wouldn't want loading of objects without ``zicfilp`` support in it and=
 thus
+would want to disallow disabling of indirect branch tracking. In that case=
 user
+space can use this prctl to lock current settings.

 5. violations related to indirect branch tracking
 --------------------------------------------------
@@ -96,12 +97,12 @@ to lock current settings.
 Pertaining to indirect branch tracking, CPU raises software check exceptio=
n in
 following conditions:

-- missing `lpad` after indirect call / jmp
-- `lpad` not on 4 byte boundary
-- `imm_20bit` embedded in `lpad` instruction doesn't match with `x7`
+- missing ``lpad`` after indirect call / jmp
+- ``lpad`` not on 4 byte boundary
+- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with x7

-In all 3 cases, `*tval =3D 2` is captured and software check exception is =
raised
+In all 3 cases, ``*tval =3D 2`` is captured and software check exception i=
s raised
 (cause=3D18)

-Linux kernel will treat this as `SIGSEV`` with code =3D `SEGV_CPERR` and f=
ollow
+Linux kernel will treat this as ``SIGSEV`` with code =3D ``SEGV_CPERR`` an=
d follow
 normal course of signal delivery.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IJXqtcSEhuPy+P+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZueawQAKCRD2uYlJVVFO
o72rAP0f2qcQlNSisvlhhZn9AoKwhyuBcmQUB3iNJOvDWNAp/gD7BxOWxP3cyxbX
Y3SfLQ1Amz7nw/R2vuD/vMlR498G6Ak=
=GJtS
-----END PGP SIGNATURE-----

--IJXqtcSEhuPy+P+r--

