Return-Path: <linux-fsdevel+bounces-16465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E889E11F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148531F2199A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFF1553A4;
	Tue,  9 Apr 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iBzYfnWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C7153826
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682644; cv=none; b=YgUphMHtiE+Mr2GXjxGXmdG9EQSkpfvmAEpZY1lJcwS1X3HDyfQSwtqfhj5IcQ8nGXLKvWFlkf+IkUhd7R/FHzB8HsesrEI5aTUkD3YhptzFNsGa5KXVUiioemSSeRBL7UmwSxwUPTDn3SiXtVVxlO8LCp4+AUU9nTOCZximnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682644; c=relaxed/simple;
	bh=DaPCXUGC5SI+VvCrK6iY6VKR70jtnLy+38KfZddgl/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggkikmI/2lo8IPMAzYjF0q6NO2uIGu6lAWwmy80BOyAyS7Mf0m5YdW+QOSXk5tJIR/Eatwvnb4LzP05cbxzkGJUgImjahW/tzWg7rTYODxIaGJa2Rb+dqRO9ZJFJAlPxyLNKFedLgx3lONyM1bsctgUQs1gh0pins/2FNLpZ4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iBzYfnWv; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22ed9094168so251108fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712682640; x=1713287440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCF4brmK1xna8X9dl4JbyVl4tAdSfSlHlPsOdrXYGDA=;
        b=iBzYfnWvTTgUTCdTUIKYJcav2CXcE99UyyXqPEFifHVrBSQNBC+wDwuPXNyuR9FGEP
         /UfI+b4bmsZdxJpOE1wKPvvGFiForg+zpX6Gv3ZP0EJd239nTI/GrYAKi5TfZX1pQXny
         r4mMlAoMaB87vKLH8H/xjCt0x140+VvoQHB9vF6HQGuK/27Z/vrlp03HG6coqqqd5xXm
         SxosxqAYJtmI0NfPgSbYLhrBSQqQXz9MsithjCwyzGOBYU6E36exuhkOsd5wJ9aUgyS7
         4oAcZ4l82d50odbKdEDGZ2KRC0WPK89VMcEl7H1wqbyyYPBnADO7CbdG8ZMegtPjkVT0
         w0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712682640; x=1713287440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCF4brmK1xna8X9dl4JbyVl4tAdSfSlHlPsOdrXYGDA=;
        b=n6sKRJChvmcR0Rb5bdShZVMagsrmLlOB3PQarDFosPb8kCWs7ZkzFeiDMTRS6f8ZpD
         hNDgkkGgBCHuRmRhPVnCgVpPcq7s8lYRpmCPz/FiA/OU1W/IyaVnH0GzSWkQEnuwUNK6
         1TluSRM/Tbu2jYmroIv/jwXDKLHtx291qbbt6odlBr4QRJanz9X91mWKUoSS4s+ZK0Wj
         0+GalAxducCwDfuIlS40AmJ/zQC+WFbfIOj0CBnVjMZcixg7WeL7pYpJc/9Hv4k7OOdt
         vDJq1NTzlcgo+FrufYyLimANxiFIgQo6TzNEn+NYv+LLjl7R6hQsIMx/Chi3gq3cJT+O
         PnoA==
X-Gm-Message-State: AOJu0Yyj6fcu7OT++NxH1EKmgTnD5q9/wJGodtGW/rpAv6EIEAT71gjn
	YZY5DCnGcezfikeSsIp0/md+B36KjXROs591iEpS/w5HeLpN2rGTxgh6zmlxwzg=
X-Google-Smtp-Source: AGHT+IG0Q+2GTIz4xzJKQZb4/LaRz7TK4ronqVobmO/AKkEHPaGT79eQEbnXx4hY8yxj2ScSHCLFlA==
X-Received: by 2002:a05:6359:2ea3:b0:186:10ee:b04 with SMTP id rp35-20020a0563592ea300b0018610ee0b04mr431149rwb.1.1712682640194;
        Tue, 09 Apr 2024 10:10:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w9-20020a63fb49000000b005bd980cca56sm8397770pgj.29.2024.04.09.10.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:10:39 -0700 (PDT)
Message-ID: <8187c490-b1e1-4c7d-9f7c-590ade4777c4@kernel.dk>
Date: Tue, 9 Apr 2024 11:10:38 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iov_iter: add copy_to_iter_full()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409152438.77960-1-axboe@kernel.dk>
 <20240409152438.77960-2-axboe@kernel.dk> <20240409170644.GE2118490@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240409170644.GE2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 11:06 AM, Al Viro wrote:
> On Tue, Apr 09, 2024 at 09:22:15AM -0600, Jens Axboe wrote:
>> Add variant of copy_to_iter() that either copies the full amount asked
>> for and return success, or ensures that the iov_iter is back to where
>> it started on failure and returns false.
> 
> FWIW, see git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.iov_iter
> 
> There was an open-coded instance (skb_copy_linear()) that I'd converted to
> that helper in the same commit; I can split it, of course, but I don't
> see much point in that.

No reason to split it, I'll have a dependency regardless. I'll just pull
your branch in, so ignore patch 1 here, 2-4 will remain the same.

-- 
Jens Axboe


