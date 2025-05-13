Return-Path: <linux-fsdevel+bounces-48891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83FAB5549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BCE1B46459
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504728DF43;
	Tue, 13 May 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuXrkrSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B56286439;
	Tue, 13 May 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140812; cv=none; b=JA/bh2tnZzifgi4QuE05ypqtmmkoeEs0nIp1CtXE47INtiM/1BSQjqaighg9PEDAjuJXXXhbp/8NGqZfw8e9xQJ1OuLiqx4euPCR93OJmtbIsN0M5DfSY5JqOMr1fyFrprGIWWPC9x/dysugTsTNrYd5LiTkr+EyhYC2NfTa/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140812; c=relaxed/simple;
	bh=i14x7HK+wQByi+0aKyFzNcOhWac1lJuJhW5b260ntpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mumr5vF6jDD3Fy3Rp/6CfoRgl8B1iSwKyXB3b4kQ4TGyamHE7o9ukTPd6qj9zchptF83NIx2hW4cJkRbXwSp5MyPLshngHBysqThad7VV49/jdhnRpDrLvuKuTFzBPKAI4W7pfxFLdocyu9EtPuRb8JAgeFsMPEARRuXbLDT73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuXrkrSi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad4ce8cc3c1so183121966b.2;
        Tue, 13 May 2025 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747140809; x=1747745609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhUsGW6Aej7UtwPk8Fo3WswAje2EzwjwJ+3T+imRPIA=;
        b=QuXrkrSiJBAik3QaKSWS+HCnTCmriB79zSscrWJTudsfLcCdBYURl4R+C+rz0p88Al
         y1SnyopHLPBjZk1IZI7/9BLTpiykvL+HgLYdzr9hW/O2soRNiM2KXYEIfWHGpShVSoj0
         hw3YQ/aVmyF2kh4neaYC7LbQpW39YzqrKe9Ln0rVlJB9CFYktdTKyIhc9mpw3Cx5Y5JF
         zGN25CitcI+6r1dMoYHxd6kbeIaV3OaHJpq5dw94jhIkTgMBFWc+hTcU4e/mzNNSF6Yp
         r0EbycRgLUdjAJ3gwHmT1mxvsAVqBAWtIBd25OXgxuXr3uuhemqkzQxKkHAye9efZZAw
         yrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140809; x=1747745609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhUsGW6Aej7UtwPk8Fo3WswAje2EzwjwJ+3T+imRPIA=;
        b=fk9n/0i5SHHGShj1aABH9XbUXj8VLnJ6hWskizdQ/Hv6+pvfLvJTiAtR1GIDAQ0SU6
         8o4Mu5c6+8JMuvppWZ/HILHeh8Fi7sjXgQ7mtLefyMWCVypLu8pvfU53wqhqPjwDbOma
         hleWf5TAmZRrQqBLkiyCQ55vNn2PbFRSsoGrJ54TSB6rZ8BTBKbSKK4+5Nb5J+bEWab8
         M7OHcv9BLEuqfTusGLttzncsFS5ssQwKgGFwhENRWMw45jDIuM1DhjNEJwaJHTYvdE5+
         y1RybgBw8vEx1JG+aWmuFvE1xLQquR8OP0EYaJv9cO/gUgjcGDbhuLQzfb+KaXSJH91H
         5bNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7e6L9mnrLNooJ9RkHA6ife5t/gy9K25ybm6oqmgzLNPkxadcewB0Q84T3DvnsigKiwCvvyS4yIKQoxEU=@vger.kernel.org, AJvYcCU9mDM6H9T3sz3E554QZWqDrD5rf+qFMM7kw/ORDLPE+1evJYV9Pch539b5BhjgWzhA8Jy6rwz+R6CI@vger.kernel.org, AJvYcCUEDNWuYp/pxKalJXWWlVtzByDM8VpnkS4nFb5mjjSfTeVLfQIX6qLtO5R9zN/s7S37La6/MorrS3q9@vger.kernel.org, AJvYcCUUZcobAqzsK5VY+uEFVQQ7lUNMBHopNXhlDJUGmb2AivwVbTSxD1OeL1xLNunH7ymPjEuu0gYJ2ZCGOg==@vger.kernel.org, AJvYcCUq7yF5v72wOEhtTjmn+EUeTFbucWySHFISH6NMd5TehZIX5U/By+MmziKdpkfvNK8vanOQBR29mw==@vger.kernel.org, AJvYcCV08vqx9uqctDhNUHBlHsayXIP4bb5yrb4i472bEYgGkxrAbDcT7zCNXAP1kRKLnTvDUg2XhoVGvyVdcxiS@vger.kernel.org, AJvYcCVvUrHY5foOtwZ1BUZACwOSKJ/P5st1t1eXjV+nx2AMCQ/CT3gKhezSIA8fIoLY87ZL7SVOo+zzgzfrqpuGPw==@vger.kernel.org, AJvYcCWEgChK2604Cs0evHzTc6/05n6f/a+19uhiKBP7owG6oHz97yX4vgPeE1S/w13z27OUAPL+Nt/7wQ==@vger.kernel.org, AJvYcCWHFfMeaC5nxbtGT3oBViXoNCHuYxNxkHqUt6pxx2+xd7yfpxE1DzkRQo75SiEmpk1ID6I10Bt1ESbleg==@vger.kernel.org, AJvYcCWRekuiSXiiT/D559N5rQC8
 RIZ4ZgBFwsKO4WnCc0DSCBNpvVqrfN4NXBhQtr+sqRTESPb8NqquRB1pTw==@vger.kernel.org, AJvYcCX9zzBVchTPcWHRSkQgdLCbGa+qVaiP0Mz7gHPPRHIHoDz0fJ6ndyhSSBeI2EWwZRshzGlDTDsXF6ZNTd2vqIkdoKj/voAJ@vger.kernel.org, AJvYcCXL7+hGHVOMpQe9QxfWCmGTiLQF0ZvcyJc9HOrdCBWz3QltWhqE9S/uAzXi9u6lljMNL+yll1VOtWdiWzX+@vger.kernel.org, AJvYcCXMru4J2JwBr6AKU3hllsAf4fbuzRBxQN6HErSvZ7COW/hsvRTLry+q1FYYbFfLXHf3LotstNJ9ttlMA+EJCw==@vger.kernel.org, AJvYcCXMvsnBVLqpvPL68tOrZ8aD2pfaVy11gtH4/pkm6bZ5RLMhO+bL0nauXc1DBHaLDC1D/15JN8GlCUn6eg==@vger.kernel.org, AJvYcCXjfzn+oRwGRlQV1zQ1I4Hg/3+qNIjbrLmHuLga+e7y/rzGDP/4avrZJPfrqotEuOTUASZKQZO1rm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBy+xrGuTOo/BHoy2MF1yeFX5Fb7UUdoWy5+Go7SmeXOVhBDFr
	+0jN+kq9uAGcJy+E6qzHrCzySZ+i3idSxVlzKpH5Lo0DddIHgHKs/t9dRLnYVfTEYI0OzHIFgLx
	QE1o3gxc9o/qjMMxOZ6lJ5W3W8GI=
X-Gm-Gg: ASbGncvgC5MxgfdU96tnDtzsnHzv0XYRKofolm7sto42gMHQcx5U/N/qLDD+WLUeLu6
	JgaUFVTokmO1GuItT5jjFNEHv9BP4uCa+UbnlRqn+ZsBrPYWLpm3Cqre2dToPqB/FkWXhMHqEe3
	P2TE4pHJXXqHODET9kcDOnwwvoPzJYuoQ3
X-Google-Smtp-Source: AGHT+IE/b0BCD4zsWzgMefEsXbY+DbhCAD/XOG3dRDcg9jP4PpucFQp1j7NsiRF8Za5+3lLoqjezqR5fGVfm35+9pG4=
X-Received: by 2002:a17:907:7617:b0:ad2:23fb:5a03 with SMTP id
 a640c23a62f3a-ad223fb7c87mr1075619066b.7.1747140808774; Tue, 13 May 2025
 05:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org> <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
In-Reply-To: <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 May 2025 14:53:17 +0200
X-Gm-Features: AX0GCFu24ZFGPch6zxlVZkmp4exgi2YQWGGbqSjGo76MZv2IKCv94Wv0HRsT2OA
Message-ID: <CAOQ4uxgOAxg7N1OUJfb1KMp7oWOfN=KV9Lzz6ZrX0=XRGOQrEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
To: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:53=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
>
> >
> >       long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> >               struct fsxattr *fsx, size_t size, unsigned int at_flags);
> >       long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> >               struct fsxattr *fsx, size_t size, unsigned int at_flags);
>
> I don't think we can have both the "struct fsxattr" from the uapi
> headers, and a variable size as an additional argument. I would
> still prefer not having the extensible structure at all and just
> use fsxattr, but if you want to make it extensible in this way,
> it should use a different structure (name). Otherwise adding
> fields after fsx_pad[] would break the ioctl interface.
>

Are you are suggesting that we need to define this variant?:

--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -148,6 +148,17 @@ struct fsxattr {
        unsigned char   fsx_pad[8];
 };

+/*
+ * Variable size structure for file_[sg]et_attr().
+ */
+struct fsx_fileattr {
+       __u32           fsx_xflags;     /* xflags field value (get/set) */
+       __u32           fsx_extsize;    /* extsize field value (get/set)*/
+       __u32           fsx_nextents;   /* nextents field value (get)   */
+       __u32           fsx_projid;     /* project identifier (get/set) */
+       __u32           fsx_cowextsize; /* CoW extsize field value (get/set=
)*/
+};
+

> I also find the bit confusing where the argument contains both
> "ignored but assumed zero" flags, and "required to be zero"
> flags depending on whether it's in the fsx_pad[] field or
> after it. This would be fine if it was better documented.
>

I think that is an oversight.
The syscall should have required that fsx_pad is zero,
same as patch 6/7 requires that unknown xflags are zero.

If we change to:
       error =3D copy_struct_from_user(&fsx, sizeof(struct
fsx_fileattr), ufsx, usize);

It will take care of requiring zero fsx_pad even if user calls the syscall =
with
sizeof(struct fsxattr).

Thanks,
Amir.

