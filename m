Return-Path: <linux-fsdevel+bounces-30757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C747598E204
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF581C23070
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC81D1508;
	Wed,  2 Oct 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XCTkLsF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF151D174C
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892050; cv=none; b=h50HqtnnXxwOsnXcgPMr1V9rIVeekTGSgW4jpFo0EPUov7cbD/BDIvoGkJdmSJapaDDKlSflSqjsO5qAFQNCcuDIC3VoSgtFSgljW9fcjWQY4FgvFmNmdRG7ain7SOhdmKT/SaRczoqYAHbVyd25YxlDhmi+LK6MFPJ8EagMj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892050; c=relaxed/simple;
	bh=05yGC6hKcwAdcRf2UNZvWovJuEM40Fh85xtp43QdXw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nS0mD4H5Mu5N8CUgLdCW9540gEiWSJu0t80s+dY/vGOjl0gHCiAAXeOQ/QK5+zOp7FdFzYgR+aukugqi2HbrgEmq3vgKik3KXT9KLv7pd6YGdbOwOiZIisbfQ9yCu8hSsO17sS7vPutB7H4/+Xw3qI+cMDc26PwjVcOIq8btWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XCTkLsF5; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8324124a172so4058739f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727892047; x=1728496847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozC4Wyjdu4pmuRDMmWKmlCuUQ8Fi4PleS7Ihu8qdzqI=;
        b=XCTkLsF5N1KWJzDSbmV3mQUMCmkrzLpyNO5sElOzLS+PG6lCvStq/Mnr7ovCLhfD/y
         exGpoKNkRFBT203heedOdSKCEiJl9YyuQQaSiNPMTYfzCE5Avb0CvfEIwdV7h9aAjIx6
         4fYBUzLL2OvVHgWpfK+JlwxvcxoYnAisX5Ame0hrXIRvwym+Ow6jhAqqisxN6TzJYMCL
         /id1szqRyCxrHTtkn02RUVgCCFZNZQjZ0wVGxKZLj5iZdwqRpaDBSboWQd7LW2xjIt71
         GWQ1uFSi7BAynuuilFCr1zItXMcp8HCfEcJ5Aqu93hGuD7FzBhOuxz8dmoca9WZFzidK
         9w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892047; x=1728496847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozC4Wyjdu4pmuRDMmWKmlCuUQ8Fi4PleS7Ihu8qdzqI=;
        b=vAah5/1rkRmq+ByKhe1XlzLvTqBQSO5iOM/mqz2sq3/nbP0i1Q5EHw9OmZLyu6eJVF
         PPy3pj7FyTlCJnkdbGwfq+w5YthZL+SXyVub2Qtzp7QOU7a7kmCI8N2HR9y/ikX+edaa
         dVmH/LSQiYJLI9zWlmNSwFYAQPNrO+aKxMXbeJJ2rCx1mS5uid9Nj2oFA7ABUOaRjKp/
         6mgDvuBjkSKnjk4QkjQyaJESetRe6fjsSGHiyDB9zoNL8Sl+qz40b+PQjACbCP2XFCiI
         5TJ2i3NokQAzPXv+nznlp78Evl8zrHBm6UhC1vts5LFodCuY9Mgic69c4djHAWnIZgpr
         dmpA==
X-Gm-Message-State: AOJu0YxRx5qkW9/szUSpFjuRGwm7MaqvV13Cvzq0A9qjevZ5G1iGpNd6
	R/IyiBBCOP9U3rdK25pQBqYeuogndRzBa//ZxYVtUaU1A8i2FvT2zRDzd4kusSc=
X-Google-Smtp-Source: AGHT+IH/ifZ/wMzuWeC+hfqcHscZJhSVf6PjF+TaiduZ1HBSmEb0uj5p+wUO7ZhbON7h4/zjUcNT5Q==
X-Received: by 2002:a05:6602:6d0e:b0:82d:2a45:79f5 with SMTP id ca18e2360f4ac-834d84d4e78mr356729039f.13.1727892046900;
        Wed, 02 Oct 2024 11:00:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9b30sm3200185173.171.2024.10.02.11.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:00:46 -0700 (PDT)
Message-ID: <a2730d25-3998-4d76-8c12-dde7ce1be719@kernel.dk>
Date: Wed, 2 Oct 2024 12:00:45 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] replace do_setxattr() with saner helpers.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 io-uring@vger.kernel.org, cgzones@googlemail.com
References: <20241002011011.GB4017910@ZenIV>
 <20241002012230.4174585-1-viro@zeniv.linux.org.uk>
 <20241002012230.4174585-5-viro@zeniv.linux.org.uk>
 <12334e67-80a6-4509-9826-90d16483835e@kernel.dk>
 <20241002020857.GC4017910@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002020857.GC4017910@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 8:08 PM, Al Viro wrote:
> On Tue, Oct 01, 2024 at 07:34:12PM -0600, Jens Axboe wrote:
> 
>>> -retry:
>>> -	ret = filename_lookup(AT_FDCWD, ix->filename, lookup_flags, &path, NULL);
>>> -	if (!ret) {
>>> -		ret = __io_setxattr(req, issue_flags, &path);
>>> -		path_put(&path);
>>> -		if (retry_estale(ret, lookup_flags)) {
>>> -			lookup_flags |= LOOKUP_REVAL;
>>> -			goto retry;
>>> -		}
>>> -	}
>>> -
>>> +	ret = filename_setxattr(AT_FDCWD, ix->filename, LOOKUP_FOLLOW, &ix->ctx);
>>>  	io_xattr_finish(req, ret);
>>>  	return IOU_OK;
>>
>> this looks like it needs an ix->filename = NULL, as
>> filename_{s,g}xattr() drops the reference. The previous internal helper
>> did not, and hence the cleanup always did it. But should work fine if
>> ->filename is just zeroed.
>>
>> Otherwise looks good. I've skimmed the other patches and didn't see
>> anything odd, I'll take a closer look tomorrow.
> 
> Hmm...  I wonder if we would be better off with file{,name}_setxattr()
> doing kvfree(cxt->kvalue) - it makes things easier both on the syscall
> and on io_uring side.
> 
> I've added minimal fixes (zeroing ix->filename after filename_[sg]etxattr())
> to 5/9 and 6/9 *and* added a followup calling conventions change at the end
> of the branch.  See #work.xattr2 in the same tree; FWIW, the followup
> cleanup is below; note that putname(ERR_PTR(-Ewhatever)) is an explicit
> no-op, so there's no need to zero on getname() failures.

Looks good to me, thanks Al!

-- 
Jens Axboe

