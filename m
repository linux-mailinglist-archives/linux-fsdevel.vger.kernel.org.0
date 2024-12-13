Return-Path: <linux-fsdevel+bounces-37376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97B9F17FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4F161C63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56261191F9C;
	Fri, 13 Dec 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt/0iz/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A01DA5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125031; cv=none; b=Y1LKZ6aXqgbY/p5HY6YhbidoWVqkHWPb/3qCX1ZTO5C7nI0Ow8A0G/d5zeSxzbcc6U3jp/rbsDQDhmTYvxKftMBO3NhdEYNGn9290GKoaVLv5XpSoW6P7+TIoMb8O2QShmvtBenmVltkBsgZUQ+jWxCJMjb4RzXGDkBbRb6XnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125031; c=relaxed/simple;
	bh=BhlIh50U1OoPi6GBj/QFRAhacRMBMxwxWNgWknfq6CM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IntXIeChmYckuiBA5K4h73kjN41Q77jdqNUmA7EYphSsk1R96eDunode2AP51/CEaxrxzYzYPGaqM7AkHnW/Ij5XoLufbRwy/EBQLJdl2tnpn7X81FbEDzstkMEi8taHxvQz5PW+cXzIXiV+QnYU3gXBMPgdGMCA/b38eyzcNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt/0iz/6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728f337a921so2402055b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734125029; x=1734729829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8t+pvAMtOWDjCtG5J8ZuTH7O8Q4x6TstRG2+LrMbBso=;
        b=Gt/0iz/6e3VPxhWZXIeuGAhBRsBou8j0JqfpCrsbTMnRyuD+0lLyIm7SeNG0LJRjAF
         d8rGzQY+Q3Ls8zt+Zh0jmlsbkZLfEQcQlxnFhvOT2Lt5BAH9bZZU65jPnYJqwJFgGNne
         XtSBVGLd/SAUe2nESFd09Fj1Ngmrj3xAToxwvkBduYvHI0WNkjGBI8H+S99Q1GrIXaD7
         NLOD+33E/Whvf35VK59YcCC/QDHymVsAo/Qr7nTZpB2XwUZXUEs535KN92Lh8nfPomw8
         B22+xNR3wxqG27dYCSj3fxl06U+JNb9RiGUTDWWagUFN0N9YI9gUYXTYRUyhU0NeVtsx
         nzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125029; x=1734729829;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8t+pvAMtOWDjCtG5J8ZuTH7O8Q4x6TstRG2+LrMbBso=;
        b=gHt9LjCzWWiuokjl3ccBPBAY/uq7WN0NqfYkzOXPpP7tiPuvxMUvXgBdfJNFyOsZaI
         A0gmTNt3jAe0btIN8kxxaBe3JIcJhTIt1yb0r6yP84yBFNiUsnzZtZnpOzyhJTeS3Am9
         7sGm5htPeIMOC4pU0q/fUaWHarn+dNXHALqkYzMrf8AaHWEo8HW1GU3FjNAPF5Zp7Eop
         rkHRl7pXfbFbiS9A2j3twb0r9Id9SpBqSuQexaWBbLQz3xNB7iqNX2z5AhbBb878aM1O
         lA8biw7lIcFwZalVqawLCvwXr1HlgvVrQgLHBNfMgoVr0yGDn4q/hWiYqxi+puWBd8QP
         QMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwEgx1B8oVr470DvoCpysFrDrIZeOsHE31cnjEXai0E+SXqJgaPCNp45C4PeEMfFnanMI4tPnO5aFI0uoW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/H70K0ZGkX/z8ZjNjEwW6zbAme9bsVP5WqUkhXXAOO1Q5pSF
	9is8JacSeIoUPcn7g0dmnyrHLU+xNVaur+JSKcaNBjQvtuxa914V
X-Gm-Gg: ASbGncvNKp6PCN1L+70mzRrum6NZ4qlUhCJPTcBzjyMwC0nQGSeNBvl/t+IW3wmamHK
	od8YzoIsONalV9fKn0fa2dPHoQO1yP9fHPRs2FXG6B/t78H/Z25wZFgGkT7r96GrrCcWY9hNj18
	k/whXfRh/zPQYAhGpuQ85iXjEEi+UBV+PeDrjM91qAk0HoZ6FwTJ6I5nFIidKGW0wspw8kIbrwy
	CzO9AifTf3i5CTCYP/QVy6k/HmLuUFfh133mO83+TDi6D8JMM2EwLSqm9BHkelDDug2yyph1Xgx
	huPZxB3ONnJMCqDr6Sc2/lsiud/JJyNkkoI9Foe49HU=
X-Google-Smtp-Source: AGHT+IHm5jDaFWl/YmgjUBKhId5yd6hUrqANfbI90i7yVFkha7OT2ZmyCwMQWfL65vYaU3UyHkwPQw==
X-Received: by 2002:a05:6a20:1590:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1e1dfd6c603mr6501049637.21.1734125029354;
        Fri, 13 Dec 2024 13:23:49 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bac570sm227247b3a.131.2024.12.13.13.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:23:48 -0800 (PST)
Date: Sat, 14 Dec 2024 06:23:44 +0900
Message-ID: <m2pllv5lb3.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ebiederm@xmission.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <87bjxf1he1.fsf@email.froward.int.ebiederm.org>
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	<87r06d0ymg.fsf@email.froward.int.ebiederm.org>
	<m2r06c59t9.wl-thehajime@gmail.com>
	<87bjxf1he1.fsf@email.froward.int.ebiederm.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable


On Sat, 14 Dec 2024 05:01:58 +0900,
Eric W. Biederman wrote:

> >> Last time I looked the regular binfmt_elf works just fine
> >> without an mmu.  I looked again and at a quick skim the
> >> regular elf loader still looks like it will work without
> >> an MMU.
> >
> > I'm wondering how you looked at it and how you see that it works
> > without MMU.
>=20
> I got as far as seeing that vm_mmap should work.  As all of the
> bits for mmap to work, are present in both mmu and nommu.

hmm, at least MAP_FIXED doesn't work in current mm/nommu.c.
# also documented at Documentation/admin-guide/mm/nommu-mmap.rst.

> > I also wish to use the regular binfmt_elf, but it doesn't allow me to
> > compile with !CONFIG_MMU right now.
>=20
> Then I may simply be confused.  Where does the compile fail?
> Is it somewhere in Kconfig?
>=20
> I could be completely confused.  It has happened before.

If I applied to below in addition to my whole patchset,

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 419ba0282806..b34d0578a22f 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -4,7 +4,6 @@ menu "Executable file formats"
=20
 config BINFMT_ELF
        bool "Kernel support for ELF binaries"
-       depends on MMU
        select ELFCORE
        default y
        help
@@ -58,7 +57,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
        bool "Kernel support for FDPIC ELF binaries"
        default y if !BINFMT_ELF
-       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !M=
MU)
+       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
        select ELFCORE
        help
          ELF FDPIC binaries are based on ELF, but allow the individual load

this is the output from `make ARCH=3Dum`.

  GEN     Makefile
  CALL    ../scripts/checksyscalls.sh
  CC      fs/binfmt_elf.o
In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ../include/linux/compiler.h:317,
                 from ../include/linux/build_bug.h:5,
                 from ../include/linux/container_of.h:5,
                 from ../include/linux/list.h:5,
                 from ../include/linux/module.h:12,
                 from ../fs/binfmt_elf.c:13:
../fs/binfmt_elf.c: In function =A1load_elf_binary=A2:
../include/asm-generic/rwonce.h:44:71: error: lvalue required as unary =A1&=
=A2 operand
   44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x)=
 *)&(x))
      |                                                                    =
   ^
../include/asm-generic/rwonce.h:50:9: note: in expansion of macro =A1__READ=
_ONCE=A2
   50 |         __READ_ONCE(x);                                            =
     \
      |         ^~~~~~~~~~~
../fs/binfmt_elf.c:1006:49: note: in expansion of macro =A1READ_ONCE=A2
 1006 |         const int snapshot_randomize_va_space =3D READ_ONCE(randomi=
ze_va_space);
      |  =20

I avoided this issue (with nasty MAP_FIXED workaround) but there seems
to be still a lot of things that I need to fix to work with nommu.

> I just react a little strongly to the assertion that elf_fdpic is
> the only path when I don't see why that should be.
>=20
> Especially for an architecture like user-mode-linux where I would expect
> it to run the existing binaries for a port.

I understand your concern, and will try to work on improving this
situation a bit.

Another naive question: are there any past attempts to do the similar
thing (binfmt_elf without MMU) ?

-- Hajime

