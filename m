Return-Path: <linux-fsdevel+bounces-48971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99250AB6FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD509A25FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009A281509;
	Wed, 14 May 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="djZFgxiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113D1C6FF9;
	Wed, 14 May 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235965; cv=none; b=Qx3BFUgIVgkaZ5If0QV3XsoS/saEl4R+eqvJLuTJwtDA4FkRMssREWgwUz3INlDeqjW2mSIJtFW/YQF+W2NGFKCsEh5uEOKU5ZA6Ocl1jtAbVotth0W9enRy5xkgWHc5t3fB2P9Jo+yrm0umwXMjr/KjWEBRsmiOwUF1ZGFs2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235965; c=relaxed/simple;
	bh=fbDxkuzpwYjrGZLFi5VIbeGvuh+o5LtR/w6gApnTSJQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PBbTx9Xys+AZ94m1F3tzBRKbIbtL7Ym3EcA5WHTc9GgRWCe4onHEXII/pIuvuwwezilFekuO5M6WdtIhTV9hfS72jrHG6RK4LYu4jZqLqJoliaxK7lpDewsYJXXdrVsIdKMCVm6AR1KMywBBFzdUUJa9gVcpQHaXEtsb9Rj7JOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=djZFgxiA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54EFAEbT3012887
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 14 May 2025 08:10:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54EFAEbT3012887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747235422;
	bh=yapZ2s67BLNwus6ibHABzXGBCoZzVlVupFJe/q2qy/U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=djZFgxiAUJE7iFHA0Wd/yFppU4TGqi4fxmoBT1mvTgxRmRiu+8QH1zl3CND+QbbP4
	 97UVxN+J8QD8iz78UlxzP16emoOIxJpWaoO9qxu1Ec5we80T+FOOb4RfHy40YAODf4
	 27XX25rvc06YcNMTsxppaOiXgVXhowu2DQa6R8gC1Tcuq8Oq9GVQp3swa9CciK5Vg/
	 jv/tWyK4JR8CJyAVAYMpVNTUaE0Ax5AVAQfxExqancQ8ZpUjlh9FBEWFvjm5PCVbut
	 6qwwqWO9GyDweGO8bFsU0TsmuX3ejxdQaqkTWk3Ymh6Yue7onjRsMrCGmrkfplN9Ef
	 P/Ifsp+Ororjw==
Date: Wed, 14 May 2025 08:10:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrey Albershteyn <aalbersh@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther_Noack?= <gnoack@google.com>,
        =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
CC: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        selinux@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_0/7=5D_fs=3A_introduce_fi?=
 =?US-ASCII?Q?le=5Fgetattr_and_file=5Fsetattr_syscalls?=
User-Agent: K-9 Mail for Android
In-Reply-To: <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org> <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
Message-ID: <B17E8366-DB80-45E6-90D6-294824C40FD9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 13, 2025 2:53:23 AM PDT, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
>
>>
>> 	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
>> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
>> 	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
>> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
>
>I don't think we can have both the "struct fsxattr" from the uapi
>headers, and a variable size as an additional argument=2E I would
>still prefer not having the extensible structure at all and just
>use fsxattr, but if you want to make it extensible in this way,
>it should use a different structure (name)=2E Otherwise adding
>fields after fsx_pad[] would break the ioctl interface=2E
>
>I also find the bit confusing where the argument contains both
>"ignored but assumed zero" flags, and "required to be zero"
>flags depending on whether it's in the fsx_pad[] field or
>after it=2E This would be fine if it was better documented=2E
>
>
>> 		fsx=2Efsx_xflags |=3D FS_XFLAG_NODUMP;
>> 		error =3D syscall(468, dfd, "=2E/foo", &fsx, 0);
>
>The example still uses the calling conventions from a previous
>version=2E
>
>       Arnd

Well, ioctls carry the structure size in the ioctl number, so changing the=
 structure size would change the ioctl number with it=2E

