Return-Path: <linux-fsdevel+bounces-34463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B99C5C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A4EB3C6F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB661FC7F6;
	Tue, 12 Nov 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q581Fl3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BA1FBF6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420442; cv=none; b=Q+z2XIBKU2uQVB7d/mW6M5xPqcDqSxUVMSoQmZC3XPpWipj5Yf58wdey5KSKAKEIj+xvlLqbvr9FeV2WJNpTHyAuYbNnapz8u8AdD0qabgAQEjU8aGiWc3mVN5MrrpWKN9Awe4H0DwjHF+oBeVbV8IrFsrWM4rgJNm7Hu8j9Rb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420442; c=relaxed/simple;
	bh=FgXKW6BhffGyYtDU5ECCxoHBzDo0QQz41DIfSkBu6LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZlShHSi0n4ZVEI38LGSXEVN41oWWEaUibu+agCsZ6RbMYuR1WyTDN+nAJPEUsqLh/Ht+DjL8SAnaPvoab/LB2v12NSE75i2ykFn8lQ13HtWhx7mBB5/1mEYJum2O0oSlTG70/PHj1GM4TDzIV5hVkSWOXxEyBWtgEtEWn67NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q581Fl3C; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-295d27f9fc9so312309fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731420439; x=1732025239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBLxl8MQn90IOYFQNE2QB3bhcSqpZYc/78jBtkc8gSY=;
        b=Q581Fl3C6vodl50RvVDAzxLsSqnREQ062qx27W8c6tI+slZqca+De3AkT7dWm1BQ42
         A9Dkp6IgY1DybaEpM+zC+39rqWDkHMhG0lvxQsKCW2QAx/dcCtFMenMD9YJfPXOjiKV1
         W6bXtttTHFoaJKLDzhAAFbGvf+jerD4xswuJA7uBjGowW9kdXMpZ8M3bC1SdX4osCE17
         +BWo2ZI9CJNv0uV3UH8HfIawhGPa3q3r7kHt1RppgE31wUZtO3xg7KCtYZXMlWbZLYuy
         /l4Kac1BdFCr5is15MBtMforzhVqOlT/3C3dmonSjkb+PdIQNT/FCsfgUhOtCWfOhH1m
         aQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420439; x=1732025239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBLxl8MQn90IOYFQNE2QB3bhcSqpZYc/78jBtkc8gSY=;
        b=J4DI+qyYajTMorNeek5yFKq62Zms8XB8BziEP3uc6oFa21D5y7z8OGGYWw0mPePnBp
         gHW1xGmm69mVtis/3pIPSXizxpkCuFKFlR8bGq9Gfkpk6ZJagwx24RNIt5PRmRh7m19k
         0SORDpsceeN2ABonWXd2k7KAz0Y8Of+hvu7J5UREc81N1nqMo7/gazjecXvTWqDbq6g3
         BIy5H7RYtzzBFozQnE7tkCRVxwhtdBNuycPx28ui2ds+TPJGyzN4/+voBA15kT3n4liz
         gJfPabqjGQ5wUDb5Qls2DOSh8JnDD4LEz6EtSDmpvtMnTy9EOb1wPeGwKhMtgyH6X8s1
         2rkw==
X-Forwarded-Encrypted: i=1; AJvYcCVKRDEkVvuzYnw2v5AFbH0xo11j5QSJzeIJ9kZKbJm8Ge+2O6kjDt1HuSJNITrpr91cvBSekeDI0GTXOJ8U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oMcj3caYQlom2XrSMxLlO5cCF/5NEVaNVO+MlN2KI33Sn0jj
	2I0NMpg1AH7bwL2wsLPWUGkBggvefcAu0coRkU6UOGi+GVLur2HZ+zoEGdzvA1M=
X-Google-Smtp-Source: AGHT+IE6/Zulglee42EqR6pm4NxzY3D1VnQ/4OdFs+x6lB09KGsOVRrOZIf6id75vga3Werl3HOmGQ==
X-Received: by 2002:a05:6871:7b09:b0:277:da52:777 with SMTP id 586e51a60fabf-295600acfa1mr13774116fac.11.1731420438736;
        Tue, 12 Nov 2024 06:07:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c92853sm3381006fac.18.2024.11.12.06.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:07:18 -0800 (PST)
Message-ID: <1671bb73-2e51-4ecc-b33d-d0b483348cda@kernel.dk>
Date: Tue, 12 Nov 2024 07:07:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add PG_uncached page flag
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-4-axboe@kernel.dk>
 <lponnb7dxjx3htksbggjoasvby6sa2a4ayrkcykdnxvypwy4pp@ci2fnmcyrke7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <lponnb7dxjx3htksbggjoasvby6sa2a4ayrkcykdnxvypwy4pp@ci2fnmcyrke7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 2:12 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 11, 2024 at 04:37:30PM -0700, Jens Axboe wrote:
>> Add a page flag that file IO can use to indicate that the IO being done
>> is uncached, as in it should not persist in the page cache after the IO
>> has been completed.
> 
> I have not found a way to avoid using a new bit. I am unsure if we have
> enough bits on 32-bit systems with all possible features enabled.

I think it should be OK, at least the kernel test bot reports build
success on all the archs it tests, which has a lot of 32-bit archs. I
have to say I didn't check on numbering and if the mm subsystem has a
BUILD_BUG_ON() for bits exceeding the allowable value for unsigned long
on the host, but I'm assuming it does?

> In the worst-case scenario, we may need to make the feature 64-bit only.
> I believe it should be acceptable as long as userspace is prepared for the
> possibility that RWF_UNCACHED may fail. It is not going to be supported by
> all filesystems anyway.

Right, I would not even see that as a big issue. 32-bit would just see
-EOPNOTSUPP for any fs, even ones that support it on 64-bit archs.

-- 
Jens Axboe

