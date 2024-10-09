Return-Path: <linux-fsdevel+bounces-31432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5D9967AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86281C2477F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8DA190059;
	Wed,  9 Oct 2024 10:50:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADBE18FDAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471042; cv=none; b=CbCca7fF6OWWfiK/8gFwvMMY4VK3721yNxBykGMfE8+IAV2AKqyj0gMDFx4/AEty2kqpz42FiGSLAUBmLntLOnx258lsMKWBIGvAU7loH6sbF5o0dLEI1hfHtGpfzAuQIx6HOB75MXmGVbEnVxnsNOH4wPX6v3DHK4d6FG6grwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471042; c=relaxed/simple;
	bh=on9vV97LWPs2SKa2NNuA52v1chQoxBDhJB6N0CC7t3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwhgk0XsH19b0/sdMgozVJWeAzaC1dnYgiMyprGw/4Y6FtYzVh7Pa4UNIoXCHwHjwnTQgJFj9TPKMVRyTLK+tVIDs1hUU+saVNBP91aWdE31U5h1fru9vnSmc+VRxcR3H0O7Ce2W1ofwYk1Qr/igcuS7b9/rE5jZKq7aom2FJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B17CFEC;
	Wed,  9 Oct 2024 03:51:09 -0700 (PDT)
Received: from [10.57.78.234] (unknown [10.57.78.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99B73F64C;
	Wed,  9 Oct 2024 03:50:38 -0700 (PDT)
Message-ID: <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>
Date: Wed, 9 Oct 2024 11:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
 <20241007174358.396114-10-viro@zeniv.linux.org.uk>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20241007174358.396114-10-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2024 18:43, Al Viro wrote:
> ->close_on_exec[] state is maintained only for opened descriptors;
> as the result, anything that marks a descriptor opened has to
> set its cloexec state explicitly.
> 
> As the result, all calls of __set_open_fd() are followed by
> __set_close_on_exec(); might as well fold it into __set_open_fd()
> so that cloexec state is defined as soon as the descriptor is
> marked opened.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/file.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index d8fccd4796a9..b63294ed85ec 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
>  	}
>  }
>  
> -static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
> +static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
>  {
>  	__set_bit(fd, fdt->open_fds);
>  	fd /= BITS_PER_LONG;

Here fd is being modified...

>  	if (!~fdt->open_fds[fd])
>  		__set_bit(fd, fdt->full_fds_bits);
> +	__set_close_on_exec(fd, fdt, set);

... which means fd here isn't the same as the passed in value. So this
call to __set_close_on_exec affects a different fd to the expected one.

Steve

>  }
>  
>  static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
> @@ -517,8 +518,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (start <= files->next_fd)
>  		files->next_fd = fd + 1;
>  
> -	__set_open_fd(fd, fdt);
> -	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
> +	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
>  	error = fd;
>  
>  out:
> @@ -1186,8 +1186,7 @@ __releases(&files->file_lock)
>  		goto Ebusy;
>  	get_file(file);
>  	rcu_assign_pointer(fdt->fd[fd], file);
> -	__set_open_fd(fd, fdt);
> -	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
> +	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
>  	spin_unlock(&files->file_lock);
>  
>  	if (tofree)


