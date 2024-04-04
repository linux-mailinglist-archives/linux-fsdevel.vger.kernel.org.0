Return-Path: <linux-fsdevel+bounces-16113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3889884C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9A52861B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9785934;
	Thu,  4 Apr 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MHLe0R92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC3745C4
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235156; cv=none; b=Pf/idBSM8pMMcPDCOmCqLa8oxDquRN6xoEqyfi095ZJujjbhEH4dtg1QI5LRvoF9A6GxLCV7hpeZkiudnsY/8na1Pc+yeoUI2/PeCjvKEBLaoZGO3mJFIx2LYGRmbVB5UX3vOjaNcVkZNv9sexrhtpPqaCH/JuzW9ikyAFCw/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235156; c=relaxed/simple;
	bh=jq68TBI1+1Bv8IHYnLKOXjoKNoP1enIkW2sf4MAUOrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8YgaH47kslRKaDYzioRUbX3x5d1JlUxyZsb+YRb7Bl5oMHdI3tKfM1VgEnRsZJfR0cDvyo5MW9YhUcvQDTa/NzuMVARl+s7MqAA4i5OuZuWjUQId9PJZtlHEK32JCkCNeeJB+HLVUPEfA6Cz1uCbjlb4fsRYusjxhvfpbKgvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MHLe0R92; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a47680a806so297704eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712235154; x=1712839954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvDzxdQYYt9cVKDgut1wVA4eoq6mvQm7w4QB8oYVEVY=;
        b=MHLe0R92M79Kr6/Hh76+lghTH+JoJPw+dMpzu3Q59H8uSgv7XBNUztPuUrsF3gQKHn
         v/8fs689Wl60Z/fBqQ3HDHIavwLh1JPmSnxVSq9c1ealQ9TOeUz8ZZABKmrFWG4CvJvf
         ZW1W4q7cK0f6ZhOSa4ZmDdD/LN+ys/QUvasr4GBzJ69dKOHCrBgAqW54tc9nLYl8gVFl
         ruSTxcXkD7YaJVV8yBrASXo6Ck9/41QVkMzVCkBe0d9jT5yejETNv/Kq2oVp/jfxPMcy
         1yF8qBTxIh6zgAIW7syDNWM5PONuWIw4bWVpmSlajlH8PJPQN56C0Iq8Vq3GJEwt1FiE
         VyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235154; x=1712839954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvDzxdQYYt9cVKDgut1wVA4eoq6mvQm7w4QB8oYVEVY=;
        b=qov/uMYEg54gq/Z0MvJjRO3lSHCpAffZoTVrSROtmU49Ic14xlt4yjmmLf18lBc9xF
         k4U85HSRvr7gq8myQsH7iOyQiGnsXDCA9G2GUM6eVIPnxFVWIIN7PNyAESz8hofJkhqD
         9Q07dYu90gIYwbbo92snoKvE+IPrHeo5fTCB1L/FVv6sDLd1YBY0hYkFyMWC/Iw66kga
         0Ll+4jwmA3J4AB2f2aBROTK81tOH/hwUYaAfgmJ9J0cITJ+YKkiaHlkD9fWO6J12WL/O
         uVXbL4hTMXwRRIOwA0JtrbuidXKX69Pb8mflB8cK9GBkH/eV3EIuBYGHcS3NiK3HXRzy
         Q4iw==
X-Gm-Message-State: AOJu0Yxuipl2RBmFlOgV72doRl/RP/CCel/1M026bc7A9DMmqGuqkE7G
	/A5Xe7VjAqPlRmXQbY4v9S4zBHAGtGyOZQ2uTj2TPuXNcbyBIvr3oagpO6Y6O2p9IJJkgHMR8fF
	W
X-Google-Smtp-Source: AGHT+IF/L/CDTuFHhct2gyCato4idz1M3V9O/b6BNVbGz7856lMQPS+BTaTxv4FbKq4fZIr4Z5CdmA==
X-Received: by 2002:a05:6871:2881:b0:22e:514f:cd11 with SMTP id bq1-20020a056871288100b0022e514fcd11mr2493204oac.1.1712235153785;
        Thu, 04 Apr 2024 05:52:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b26-20020a6567da000000b005dc507e8d13sm11739074pgs.91.2024.04.04.05.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:52:33 -0700 (PDT)
Message-ID: <8de27ff2-d53f-4900-b755-6a05bff98f78@kernel.dk>
Date: Thu, 4 Apr 2024 06:52:32 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] signalfd: convert to ->read_iter()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403140446.1623931-1-axboe@kernel.dk>
 <20240403140446.1623931-4-axboe@kernel.dk> <20240403225747.GO538574@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240403225747.GO538574@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 4:57 PM, Al Viro wrote:
> On Wed, Apr 03, 2024 at 08:02:54AM -0600, Jens Axboe wrote:
>> Rather than use the older style ->read() hook, use ->read_iter() so that
>> signalfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
>> read attempts.
>>
>> Split the fd setup into two parts, so that signalfd can mark the file
>> mode with FMODE_NOWAIT before installing it into the process table.
> 
> Same issue with copy_to_iter() calling conventions; what's more, userland
> really does not expect partial copies here, so it might be worth adding
> 
> static inline
> bool copy_to_iter_full(void *addr, size_t bytes, struct iov_iter *i)
> {
>         size_t copied = copy_to_iter(addr, bytes, i);
> 	if (likely(copied == bytes))
> 		return true;
> 	iov_iter_revert(i, copied);
> 	return false;
> }
> 
> to include/linux/uio.h for the sake of those suckers.  Then
> they could go for
>         return copy_to_iter_full(&new, sizeof(new), to) ? sizeof(new) : -EFAULT;
> and similar in other two.

That's a good idea, makes the transformations easier too and avoids
dealine with the partial case.

> NOTE: the userland ABI is somewhat sucky here - if the buffer goes
> unmapped (or r/o) at the offset that is *not* a multiple of
> sizeof(struct signalfd_siginfo), you get an event quietly lost.
> Not sure what can be done with that - it is a user-visible ABI.

The ABI could be nicer, but isn't this a case of "well don't do that
then"?

-- 
Jens Axboe


