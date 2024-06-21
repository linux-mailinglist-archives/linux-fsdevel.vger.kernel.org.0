Return-Path: <linux-fsdevel+bounces-22081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5E911EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E262E2824F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A7616D4DD;
	Fri, 21 Jun 2024 08:28:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16AD3AC1F;
	Fri, 21 Jun 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958507; cv=none; b=JnIKjN/t7QEcIsETyA9asE/RVx2suYBo61YhZd3ZVFR+LFrTghMUkXvR0b8l6PUcd+uGmohyFYnm6Mpq9xoCazlEznUGXrM+zxx0V3dwev/1uHWKUedJ1UMRYJFzewDh7qIT+ckvAqp9XnaS3TK93mfK08ioolP2mZMPAJg2oIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958507; c=relaxed/simple;
	bh=qcVbwN+dhj8TYggsWmgVtWaoNotrBJlRv0mGP9WVNwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkenvMdvwbf4CWx6uD05BNiWOtNaxguuf+wvm0b1Ux9cszUHMftOdjdcNuLoeFD/5jH0A5R+DZMvQ0CHGKVJRiVwmq/9PXJlbCblFXTBDTY+Aqs/Og4bpt7b+Os4aeb9V0YF4nftCL9wFbGHdfHBRk4ulkfq6re+RHLa/K/+GP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sKZbl-0001Si-00; Fri, 21 Jun 2024 10:26:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 2189CC0120; Fri, 21 Jun 2024 10:25:23 +0200 (CEST)
Date: Fri, 21 Jun 2024 10:25:23 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zenIV.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com, ltp@lists.linux.it
Subject: Re: [PATCH 03/15] mips: fix compat_sys_lseek syscall
Message-ID: <ZnU480Ypb3f3nOek@alpha.franken.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620162316.3674955-4-arnd@kernel.org>

On Thu, Jun 20, 2024 at 06:23:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is almost compatible, but passing a negative offset should result
> in a EINVAL error, but on mips o32 compat mode would seek to a large
> 32-bit byte offset.
> 
> Use compat_sys_lseek() to correctly sign-extend the argument.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/kernel/syscalls/syscall_o32.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 85751c9b9cdb..2439a2491cff 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -27,7 +27,7 @@
>  17	o32	break				sys_ni_syscall
>  # 18 was sys_stat
>  18	o32	unused18			sys_ni_syscall
> -19	o32	lseek				sys_lseek
> +19	o32	lseek				sys_lseek			compat_sys_lseek
>  20	o32	getpid				sys_getpid
>  21	o32	mount				sys_mount
>  22	o32	umount				sys_oldumount
> -- 
> 2.39.2

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

