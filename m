Return-Path: <linux-fsdevel+bounces-43499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF05A577A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B04E1894EF1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F40146A72;
	Sat,  8 Mar 2025 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WyslvGXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D014AA9
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741400569; cv=none; b=JghqQbEw5Q0gaA+YrVh3T2p5feAst1VPQA4Crn4dAzewI62AcHjaRrEIO1x1ztRjvWm7d5X4doJndZmzrhUDxusSy6UVAEQl6BlkPIL20IrV5KUs3GyX8m67ScjVbhVM7aWIIuOQgg09P/TnaZyKilIsgKXBIXOCkFUCgYQ+lRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741400569; c=relaxed/simple;
	bh=L/7jaKoLREh8m9RJKqR0YdJUC506zG80lLbEZM3Eaw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9nH7W6y4PLVSvGutmbKB9xpc+ySFeQ+BdhvrB+N4ZMdEi3HlTY4PkYrti/jDmFCwIMAeNGusTOsiPdbq2MFfT7k9ftyrBO4g7/2IqjVPI8jckfItNx5fIdnJ2NkYjFvTUq7+50O2+SM+m+RB9M9APUryGDqCvcaaA2iagNjX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WyslvGXS; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe4802f2-f81b-6e33-6ee1-af2f3771f8fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741400555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjhDoAzUW/5FGOnDp5v3OzlWQhpu3YvcufnBv3JkkCM=;
	b=WyslvGXSkVSfE45H250Oc8xhGdfep6CJ03v8xSTm1NlBuuoYFOJekXiQapFNHzVBr0sFgf
	aPVdC/D1z9yTXMwG76VmJNwp7EOEunCUVEeachPWaLqL6QiP4oU1vXiRusZzj9OS5F2cdi
	rBVZHezXAvweCUq6RmimulD3iMtv+Gw=
Date: Sat, 8 Mar 2025 10:21:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used
 warning
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
 kernel test robot <lkp@intel.com>
References: <20250307061128.2999222-1-sunliming@linux.dev>
 <a555rynwidxdyj7s3oswpmcnkqu57jv3wsk5qwfg5zz6m55na3@n53ssiekfch4>
 <202503071227.578545FF9@keescook>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sunliming <sunliming@linux.dev>
In-Reply-To: <202503071227.578545FF9@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/3/8 04:30, Kees Cook wrote:
> On Fri, Mar 07, 2025 at 03:47:28PM +0100, Jan Kara wrote:
>> On Fri 07-03-25 14:11:28, sunliming@linux.dev wrote:
>>> From: sunliming <sunliming@kylinos.cn>
>>>
>>> Fix below kernel warning:
>>> fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
>>> used [-Wunused-but-set-variable]
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: sunliming <sunliming@kylinos.cn>
>> The extra ifdef is not pretty but I guess it's better. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> Since we allow loop-scope variable definitions now, perhaps this is a
> case for defining the variable later within the #ifdef, like this?
>
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index e3cf2801cd64..b0ef71238328 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1024,7 +1024,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>   	/* deal with each load segment separately */
>   	phdr = params->phdrs;
>   	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
> -		unsigned long maddr, disp, excess, excess1;
> +		unsigned long maddr, disp, excess;
>   		int prot = 0, flags;
>   
>   		if (phdr->p_type != PT_LOAD)
> @@ -1120,9 +1120,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>   		 *   extant in the file
>   		 */
>   		excess = phdr->p_memsz - phdr->p_filesz;
> -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>   
>   #ifdef CONFIG_MMU
> +		const unsigned long excess1 =
> +			PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>   		if (excess > excess1) {
>   			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
>   			unsigned long xmaddr;
I think this is a good idea. I will resend this patch in this way，thanks.
>> 								Honza
>>
>>> ---
>>>   fs/binfmt_elf_fdpic.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>>> index e3cf2801cd64..bed13ee8bfec 100644
>>> --- a/fs/binfmt_elf_fdpic.c
>>> +++ b/fs/binfmt_elf_fdpic.c
>>> @@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>>   	/* deal with each load segment separately */
>>>   	phdr = params->phdrs;
>>>   	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
>>> -		unsigned long maddr, disp, excess, excess1;
>>> +		unsigned long maddr, disp, excess;
>>>   		int prot = 0, flags;
>>> +#ifdef CONFIG_MMU
>>> +		unsigned long excess1;
>>> +#endif
>>>   
>>>   		if (phdr->p_type != PT_LOAD)
>>>   			continue;
>>> @@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>>   		 *   extant in the file
>>>   		 */
>>>   		excess = phdr->p_memsz - phdr->p_filesz;
>>> -		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>>>   
>>>   #ifdef CONFIG_MMU
>>> +		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
>>>   		if (excess > excess1) {
>>>   			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
>>>   			unsigned long xmaddr;
>>> -- 
>>> 2.25.1
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR

