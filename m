Return-Path: <linux-fsdevel+bounces-25369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86394B3B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106B7284216
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CA155CBD;
	Wed,  7 Aug 2024 23:39:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1F154BEB;
	Wed,  7 Aug 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073983; cv=none; b=PLkluGALbNPcFLSUafhHg3EPYAvsPyWJBJ1T/0x4/lJ5IOgdp58uZfFMSBB0DcMdd6M2RxFzjVVgpqmGtyYv5CFcMMy6Q4g26JQXFU+vRcAor1JOKogCxnf0Y6AimsK9s4RHCu9ILjQE2l3BWgZWz2elhQo7JCzqw9u6p1+XaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073983; c=relaxed/simple;
	bh=f+HJqX1/WmL3ocpq3A8cUrCzlOyC16bwZa4gA+mJ6Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqMzELWOw0pN+Nlrq93RNVeXLt9GBhrb4nX7otpNsNYDQeT5kcl3YNOcjuogYs6/4u1Dd5pgqteHB1XcikmhLjPec+0McH6JaQY4JHUVSchFEIe4wjSyBeBVjOpmh3jwENofL2A35G+79fmHAtexxtA9RG9afvgIaNi8ytebaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40981C32781;
	Wed,  7 Aug 2024 23:39:40 +0000 (UTC)
Message-ID: <aa67f1df-f2c4-4427-9e06-5f659fc7ec24@linux-m68k.org>
Date: Thu, 8 Aug 2024 09:39:37 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binfmt_flat: Fix corruption when not offsetting data
 start
To: Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Stefan O'Rear <sorear@fastmail.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Damien Le Moal <damien.lemoal@wdc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240807195119.it.782-kees@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20240807195119.it.782-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kees,

On 8/8/24 05:51, Kees Cook wrote:
> Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
> introduced a RISC-V specific variant of the FLAT format which does
> not allocate any space for the (obsolete) array of shared library
> pointers. However, it did not disable the code which initializes the
> array, resulting in the corruption of sizeof(long) bytes before the DATA
> segment, generally the end of the TEXT segment.
> 
> Introduce MAX_SHARED_LIBS_UPDATE which depends on the state of
> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET to guard the initialization of
> the shared library pointer region so that it will only be initialized
> if space is reserved for it.
> 
> Fixes: 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
> Co-developed-by: Stefan O'Rear <sorear@fastmail.com>
> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>   v2: update based on v1 feedback
>   v1: https://lore.kernel.org/linux-mm/20240326032037.2478816-1-sorear@fastmail.com/
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>   fs/binfmt_flat.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index c26545d71d39..cd6d5bbb4b9d 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -72,8 +72,10 @@
>   
>   #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
>   #define DATA_START_OFFSET_WORDS		(0)
> +#define MAX_SHARED_LIBS_UPDATE		(0)
>   #else
>   #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
> +#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
>   #endif
>   
>   struct lib_info {
> @@ -880,7 +882,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
>   		return res;
>   
>   	/* Update data segment pointers for all libraries */
> -	for (i = 0; i < MAX_SHARED_LIBS; i++) {
> +	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
>   		if (!libinfo.lib_list[i].loaded)
>   			continue;
>   		for (j = 0; j < MAX_SHARED_LIBS; j++) {

