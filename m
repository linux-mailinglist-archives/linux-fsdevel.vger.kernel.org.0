Return-Path: <linux-fsdevel+bounces-27109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5D95EA7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED6D1F21ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDB13A257;
	Mon, 26 Aug 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="Hqw5WX4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr08.pc5.atmailcloud.com (omr08.pc5.atmailcloud.com [54.252.57.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DE548E1;
	Mon, 26 Aug 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.57.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657561; cv=none; b=NnV8Spukg9MhwuoHMim6KjY5dt6AcAOo+LwnysBW++0Ps8gSmWOKHzOCTJvXyspHj3I6XgsbdQqwy6L3NPhOMEVtr47haKyDU/ao1Z7qRVGUvuog4U+o1j9yH1n3HgLSm45LiJJcuFJdOS1YOMwcbyDlkAglW+EzgIhZdnU9jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657561; c=relaxed/simple;
	bh=iojfrvhf57dCDTJPpOzKfz8icNONcLHcWrQbweA/6EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXwGnMYU/3NI53DMzElrR7eCU2IzLA/l60uoq+lCOVlBihv2XUDJEo0nz7YGDiDpXHgMNgcqyaHUjl3f1hqCWorceRi/tkn3CT1r/5tvVU2vacv4d4a6UbWFVq14e+dVC6GyumYAg0yglVhuwsE17VHpZwy8O564b8/XZbBMJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=Hqw5WX4a; arc=none smtp.client-ip=54.252.57.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=6tTKEaM8sdRBiX5y2fo+cH7GFaEbUFd+8Q0elSOPc0A=; b=Hqw5WX4asG6LLE
	qMnfahpCSjBz9bCq2gLidqsBim9VUx1ErvMMazAhWX4PV0mZ86iRV1d58GQTBaGplo+tR0SXfI2TH
	g2IAb4I0aTdMDsICR3QpbHUaktggeu/dVrEyvvOqptB/0a9fmOAjMlaiFIVmqqENZKGGbuqxn8+Dm
	zIzG5KEk2A1Uzys7WRu6E8pCMX8XrMFQs199TU7lBRKlZ2FM4as5aCIvfvl1Jb4DdmhGpGB/Hl6YW
	eu3X4eSRD6jA58iRx32QYJ5NDPLybBIGSqIoMYyn9n4KI+/ReonLE7TNQO/zTkwhPehjI0mS58zw6
	gQckQNzVVtLLUFntZ83g==;
Received: from CMR-KAKADU04.i-041f7649e5739ea40
	 by OMR.i-0e5869b43dfedcea0 with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1siTi5-0000xB-Sa;
	Mon, 26 Aug 2024 07:00:17 +0000
Received: from [202.125.30.52] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-041f7649e5739ea40 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1siTi5-0004jR-0q;
	Mon, 26 Aug 2024 07:00:17 +0000
Message-ID: <aa4af643-47d3-4c26-8537-d86c1f73af68@westnet.com.au>
Date: Mon, 26 Aug 2024 17:00:13 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf_fdpic: fix AUXV size calculation when
 ELF_HWCAP2 is defined
To: Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org
References: <20240826032745.3423812-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <20240826032745.3423812-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=H9/dwfYi c=1 sm=1 tr=0 ts=66cc2801 a=7K0UZV/HFv9j2j1oDe/kdQ==:117 a=7K0UZV/HFv9j2j1oDe/kdQ==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=VwQbUJbxAAAA:8 a=8-D65JXZAAAA:8 a=pGLkceISAAAA:8 a=IAVgKGYuzIukzJpoevsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Cm-Envelope: MS4xfAEQRyZOM7Ozk2Q30aT2s8+z5DSkcoTMnkpPaNgnkdmyxjHDCcOXh/ehMGleTLiP+Ky4uEwbkGP5ldYJHOzoQ/6yNr65xYwz4W4DbXCnREQN+zb3rj2c Qd64FsCwD8ebrOp90dVjYxlWAzbKDeZwfBftLayC7ZN8re8eamhmSdKAmGM/exVui2lf1wMiZYH5lw==
X-atmailcloud-route: unknown

Hi Max,

On 26/8/24 13:27, Max Filippov wrote:
> create_elf_fdpic_tables() does not correctly account the space for the
> AUX vector when an architecture has ELF_HWCAP2 defined. Prior to the
> commit 10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv") it
> resulted in the last entry of the AUX vector being set to zero, but with
> that change it results in a kernel BUG.
> 
> Fix that by adding one to the number of AUXV entries (nitems) when
> ELF_HWCAP2 is defined.
> 
> Fixes: 10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv")
> Cc: stable@vger.kernel.org
> Reported-by: Greg Ungerer <gregungerer@westnet.com.au>

Feel free to use my gerg@kernel.org email for this.


> Closes: https://lore.kernel.org/lkml/5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au/
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Certainly fixes it for all my failing test cases, so:

Tested-by: Greg Ungerer <gerg@kernel.org>

Thanks for looking into it and the fix.

Regards
Greg


> ---
>   fs/binfmt_elf_fdpic.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index c11289e1301b..a5cb45cb30c8 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -594,6 +594,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   
>   	if (bprm->have_execfd)
>   		nitems++;
> +#ifdef ELF_HWCAP2
> +	nitems++;
> +#endif
>   
>   	csp = sp;
>   	sp -= nitems * 2 * sizeof(unsigned long);

