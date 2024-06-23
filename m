Return-Path: <linux-fsdevel+bounces-22214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF9913D08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F8283532
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CC18309F;
	Sun, 23 Jun 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHcWkbRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549F183082;
	Sun, 23 Jun 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162640; cv=none; b=KJZQqP/BhlVu6ZhCAgMZdmQuoDwd2SfyD2NwEDwfyGqJbOIoFEH3iZ40SRa8XDlTWKX1p0FFYVZhImbiX9lfwoQHQrwbHLEgo5CLP/LOHO/QUddYNWoi/9/AgYVWcCEypQ/jC1ob/bdm4sDKft/OxTrQxp60vols2R3TlWmKBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162640; c=relaxed/simple;
	bh=aosSO/S+etUamgM4SS3mlQ3heoMUr6FZbeXpiXEovy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtiE5Nt0nFcnQljGlPPSqKqqVt9Ta7s/HUCXkDn/V4bo76YLtVeH6GBdyEVZJqf7Z1z+LNIJhaDnH4Do1ogb1FPxyQ0BjymFDIYH7Sb0oKfTNnGO8Tf5dwGG+I57rGIXar6MKGvALPUhXBRLlaDGp8bc+5gU+L9J+U8pc0kBr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHcWkbRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1215EC4AF19;
	Sun, 23 Jun 2024 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719162640;
	bh=aosSO/S+etUamgM4SS3mlQ3heoMUr6FZbeXpiXEovy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SHcWkbRTRysffowmKeNtbvp9bhDl+zoDvjEJ2fFDHg7LSDrwqFsJdD9YYXV4Vr+sp
	 2E8pAnecGBkfcW3fYWlLjSsfPlPKcXnQ8nJbcMvEmYSYZS0YcgH+rt/qDOrTB8Gvu+
	 agZuIo6AmTpr2D4xK4pBnUswovpS9ueZT7VqTzkz0VoNehsJKjKIbT7Hxbmzrk7px2
	 nKkeeohgJbLaTj1UD/4bc2iBlfTD7iIkm5ON/CNdK03bV+FGcWIvguDXvdHM+5cgLf
	 OB8EHfsL2MFz6vrCmyH5CregCIOmWkoz7MbvmFg/cF39yMwxMHUAlyiXqW1imSaGS0
	 Nv1EJ4Jnnv/6A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso38463451fa.3;
        Sun, 23 Jun 2024 10:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUABcrWO+546WA1uq/7iZtUfrtI/F8b3SCqjuQoTkdlv00T6gIbcBPtNW860k9lZCksUyptHLTKTPx5Ry9PlTGpYgXaz8Q6Pc8d4ViFGEGXd00NSe5SY080a7But/HVjU/K/XbEm4TcqPYSyFraOEjoGPQnCETFMgAS8syfAd1KuhZHOKsCiFbYygqoLXuKzE0YDjH0BIZok7JLuYRNtKYh1cDqEbYIg0zMOffnXEuL8oCsRUB5E9Aoo2HxJXIHkOHykqq+OmC0s6JxPGesMrTN0oAr467I+B4OJgef7fy8pVehj7mUnWwR71Jgmti7yYhFuLBR83jIcWn74u8BqTaD9Qr7CrC/Q+W7WixgrxRhm5Oym2OJ533GrvLiArZ7iNUNPgi8XL/4e/YCewaZ1V2EWkcIdpt+F9D7lLyZ6/aZYhBr5cMOLgMJ5d0=
X-Gm-Message-State: AOJu0YwlgS3fibMxZXsahhE6nqg8Txd2oqTFnvZr/y0iSDTRuMZIOiFl
	AzkjI2K/klNnQ5tYVDglow4ULt7DWn7CPfw2aHP8VAbsQZFzWYqAIK/Jh76DQE+I6ik18Zmwi9B
	sWDR9R06h9ucP+I2mFYh3Nt8ApuI=
X-Google-Smtp-Source: AGHT+IHxMABTsjE/bTBoMOuJE1ctF+u0ZebsEtw1bh3nJ1bb3woGpWj5W/Pz1qQmYslYoKzzGRd0eu1pNlr+yN6Ofzo=
X-Received: by 2002:a2e:3101:0:b0:2ec:1cf1:b74c with SMTP id
 38308e7fff4ca-2ec594cfe8fmr16740431fa.32.1719162638077; Sun, 23 Jun 2024
 10:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620162316.3674955-1-arnd@kernel.org> <20240620162316.3674955-11-arnd@kernel.org>
In-Reply-To: <20240620162316.3674955-11-arnd@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 24 Jun 2024 01:10:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS9xKLSbSN2Scs016Boxzr6TdNxVLr2TYEfbJ0KqSgppw@mail.gmail.com>
Message-ID: <CAJF2gTS9xKLSbSN2Scs016Boxzr6TdNxVLr2TYEfbJ0KqSgppw@mail.gmail.com>
Subject: Re: [PATCH 10/15] csky, hexagon: fix broken sys_sync_file_range
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>, 
	linux-hexagon@vger.kernel.org, linux-csky@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	libc-alpha@sourceware.org, musl@lists.openwall.com, ltp@lists.linux.it, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:24=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Both of these architectures require u64 function arguments to be
> passed in even/odd pairs of registers or stack slots, which in case of
> sync_file_range would result in a seven-argument system call that is
> not currently possible. The system call is therefore incompatible with
> all existing binaries.
>
> While it would be possible to implement support for seven arguments
> like on mips, it seems better to use a six-argument version, either
> with the normal argument order but misaligned as on most architectures
> or with the reordered sync_file_range2() calling conventions as on
> arm and powerpc.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/uapi/asm/unistd.h    | 1 +
>  arch/hexagon/include/uapi/asm/unistd.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi=
/asm/unistd.h
> index 7ff6a2466af1..e0594b6370a6 100644
> --- a/arch/csky/include/uapi/asm/unistd.h
> +++ b/arch/csky/include/uapi/asm/unistd.h
> @@ -6,6 +6,7 @@
>  #define __ARCH_WANT_SYS_CLONE3
>  #define __ARCH_WANT_SET_GET_RLIMIT
>  #define __ARCH_WANT_TIME32_SYSCALLS
> +#define __ARCH_WANT_SYNC_FILE_RANGE2
For csky part.
Acked-by: Guo Ren <guoren@kernel.org>

>  #include <asm-generic/unistd.h>
>
>  #define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/includ=
e/uapi/asm/unistd.h
> index 432c4db1b623..21ae22306b5d 100644
> --- a/arch/hexagon/include/uapi/asm/unistd.h
> +++ b/arch/hexagon/include/uapi/asm/unistd.h
> @@ -36,5 +36,6 @@
>  #define __ARCH_WANT_SYS_VFORK
>  #define __ARCH_WANT_SYS_FORK
>  #define __ARCH_WANT_TIME32_SYSCALLS
> +#define __ARCH_WANT_SYNC_FILE_RANGE2
>
>  #include <asm-generic/unistd.h>
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

