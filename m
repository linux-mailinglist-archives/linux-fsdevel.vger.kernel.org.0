Return-Path: <linux-fsdevel+bounces-16028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CB89716E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD1D28A2FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EE14882A;
	Wed,  3 Apr 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tb+ReZxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4194DA0C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151897; cv=none; b=CwqT2XU/L6c7ADfP3F7TaIIBDaTPnsog8pMAcSP6CLbSnGmCh/zGfjG9puBft9/zZ1On2N2uMefjmKKHg0bFSbhW139najcT/5fiQXOtjcTOBgwVDSpQMZ5Z2fDaclJb8o7J449QZpWMdrI1Q/hCqW2ROfCH4/2iXnLKAcAYP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151897; c=relaxed/simple;
	bh=F75LonjtDwlNXFBva+zn4kv8XePXXdYv9gTZZ/GIFdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ9vZ27fc5l/++CJIX2UlWoTR+q6wb5vKJE0vgdLqDk0dCwTGF2VcyZ/SyUZSEDphrvOzZi8fdHhuCu6plr8F2ygZ/onBWpNmWGzXz1HIN5NwdGQP710MrWT+4hANDylMAApJfNTkfOo0LipPAsfwjLMj+vnEQBRRe/CEXgvg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tb+ReZxg; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso126703739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712151893; x=1712756693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYUiEK8E1sx7xpi6BOcpI2EaSW3yUWioYsWwaMCl5Gg=;
        b=tb+ReZxgCubJoYxQEetWeeqtoX/BqGePEtWW7IWcckCBgrFdXemkjy+dPV++j2ajSe
         D9zzhXLURPlYUmtxpHxkUVFUdXdh0efJU3Awxurd/N1ohuskh8jxlVTue28owSPsIVnb
         OTNygT0K8JexcFBYR16HHfoVnBG1o3cTVlqfEc/GYEbiugGjs1E0a6ulxcrSvWNQqQ7h
         J2y/rSRgdtoTsHKydNQemVh2bbdl/OFJizOBQSjbTrJYent19jE2n54To06LOdrwjorv
         noNFQhVRr3zbmbIAEbuByDpIRaq2RTVQdHvt8vxccUydK/NQUC7WNJ0Aqylg5mHj9XLv
         iQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151893; x=1712756693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYUiEK8E1sx7xpi6BOcpI2EaSW3yUWioYsWwaMCl5Gg=;
        b=Mvdh1HQa0qhh01cnRNLI2F1JBt51Q1KcKtoXPE8MeqPL532DDZ8YeaRgYUlrnpmXaT
         tEfW6ciErMnIHbETH4NdOylurXdV2e+i02SqcdDntkRo7b1tE+XHEOgHQR+QpSbjG0Hl
         goqKEYTSz+CwqeHFeK/I9pVHdeLInQMyEB7kecRhdqg9aUJripnBvhcm+jDd7KvparR6
         rfHZ2B1pyZXM7rBPcnaXG+WNbeVklyuFJvxohijjT/tSgVPizJN7bYh2HIfdjwA+V1GT
         bp/znri+YsIloKuKX8BaQSkKbv9kmNaUnMYQO2z/vLC637gyMGpYAiK01KPAbBxpjvYh
         lJ/A==
X-Gm-Message-State: AOJu0YyUVm3b3zN5RwKAH7RWmptVw+K3pBthnAq0ZwrJwjbD/kqYlMHD
	ZTgVd9XHWRxGsyErGLOl5cCeaeKBG9b/4ToHsFjgbfkGLvs6VhotURs9UztJHnVSbXxjh3cNFyy
	P
X-Google-Smtp-Source: AGHT+IFiVj2+RbRrFiPSwAJLbcVhGhHRt/GlPoPiS3ctCNlSrvDN2vDkatZJo4osH6z/B6RQkar2kA==
X-Received: by 2002:a05:6602:3422:b0:7d0:5b47:8f57 with SMTP id n34-20020a056602342200b007d05b478f57mr18956163ioz.1.1712151893563;
        Wed, 03 Apr 2024 06:44:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w9-20020a056638138900b0047f14f6a3f8sm477987jad.107.2024.04.03.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:44:52 -0700 (PDT)
Message-ID: <8fc38d0e-4138-4624-800e-b503bbd744e1@kernel.dk>
Date: Wed, 3 Apr 2024 07:44:51 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402202524.1514963-1-axboe@kernel.dk>
 <20240402202524.1514963-3-axboe@kernel.dk>
 <20240403-plant-narren-2bbfb61f19f0@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240403-plant-narren-2bbfb61f19f0@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 4:09 AM, Christian Brauner wrote:
>> @@ -2215,16 +2216,25 @@ static int new_userfaultfd(int flags)
>>  	init_rwsem(&ctx->map_changing_lock);
>>  	atomic_set(&ctx->mmap_changing, 0);
>>  	ctx->mm = current->mm;
>> -	/* prevent the mm struct to be freed */
>> -	mmgrab(ctx->mm);
>> +
>> +	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
>> +	if (fd < 0)
>> +		goto err_out;
>>  
>>  	/* Create a new inode so that the LSM can block the creation.  */
>> -	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
>> +	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
>>  			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>> -	if (fd < 0) {
>> -		mmdrop(ctx->mm);
>> -		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
>> +	if (IS_ERR(file)) {
>> +		fd = PTR_ERR(file);
>> +		goto err_out;
> 
> You're leaking the fd you allocated above.

Oops yes - thanks, fixed.

-- 
Jens Axboe


