Return-Path: <linux-fsdevel+bounces-23245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B5928DCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746DFB24AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226017166B;
	Fri,  5 Jul 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2Q5mEWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE170843
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208073; cv=none; b=JagemWdoc1lvKy7yPLV536/iYCIo88W16ZIeEKP5o9KQ+jU10vfq0Q+IjkF9AaDUwm4TN6OnlYrpBuckHjv/OOxRX+dPtd0VnGq6/4VbVZdvtzHKPZ95wMxkpu7Iz3Q38JD5lyKUae7GAz/9S2Ju4/VZU5C0FQEgsAh8kj3CzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208073; c=relaxed/simple;
	bh=oq2dwNVnjkHa+0a/z+uAGC4hLutL54benZugmgRmxGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rX7uOlIIgseFlOQx37DuWpKm5eGtfEOIbIA1fbCIxAymXz31KYJ79DazzJIPnlyagawQmJPtQw2zlKR5wzvQOzy96qftU8KKUMVHqKnT1qzPJN9ptrsUKmjv1jQulRTaXQI2PCzFR/a/qsCWCXYhTwsPyefmYVAPU/DZ5Tgs51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2Q5mEWX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3d395dcf9so10750939f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2024 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720208071; x=1720812871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMwcWC3o3HrUVeD8fd8AU+OfLGD14mr9eYqviZBaZNs=;
        b=N2Q5mEWXRa45mIAZMrGntA+jgYi7m83HN56Qb4HfcRRcQB1JqF4Gce4kq+d1rKHwWh
         UiOv+/UTy0bBp4KXSYjV/uN/4ibPVjwdbKgxX9P59Y3BzMd5mn251uLZf2sHfbyFhXEc
         +aBnshDAm+QGjs1tAY3WM8Vs1jme7arNK/2G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720208071; x=1720812871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMwcWC3o3HrUVeD8fd8AU+OfLGD14mr9eYqviZBaZNs=;
        b=QXbg2ayJru3KRnvqQjiRzxsYgtmlvt8rISMkl52m2HUcD+WM3vwVQCQojzWDmOWmWP
         qhEuv5oVDdkGEEmeG7xNVGZiiy8bhEojDj+HPywBB6gGOPVbv3k5Chid13EGJqoQOL06
         jKPp3TdUwmw9Ki64z5z9gl3WQ0KPgjxbvjQa41HXynWsZxorH3ZGIr25gGD3zeOyz7su
         mVpAFdL6Ekw3QZDsqn1pubVLeocIEZ9II7XGuFeUgPxKP0xLABMn9l0E6zQWDELjdzgG
         zExTE/zFYUTQfwLGjIvhsXIAHrHGBD7jJ+pO4QyWcqfSW3zhX73HxBp8Jru+xCepKcJr
         uCUw==
X-Forwarded-Encrypted: i=1; AJvYcCWB/S0upfEiR6g9GRykTYGU+raVtl6N5YB10V9pg5YfvbGHxn+HXMRcoTRq28yC0ZfdCZ2gYnx1Q5QWfaVqlixytXeHGNVSKmRGubpjJw==
X-Gm-Message-State: AOJu0Yx3vJLrJ4Red7DW1lVNiBzXrygB2lKqUU8fIYAJA711c+bYx6P+
	9VXvUuT8MPgXf8MLz426sDzQvWmMCQjjNlCm0vOgXvH90/YV/BofNCWLZxlNguQ=
X-Google-Smtp-Source: AGHT+IFVfC3ipyP6qVo1x6Bb2rPetYjbe/+5LIMBYOIKkl+pUyXkyZoVtgaToDJ3zLia3VmYin/naA==
X-Received: by 2002:a05:6602:6304:b0:7eb:69ec:43f2 with SMTP id ca18e2360f4ac-7f66dedecb6mr645266439f.1.1720208070940;
        Fri, 05 Jul 2024 12:34:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c085dd5c7dsm225863173.77.2024.07.05.12.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 12:34:30 -0700 (PDT)
Message-ID: <cd1d4033-b4ec-408d-aff7-94330615a69a@linuxfoundation.org>
Date: Fri, 5 Jul 2024 13:34:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/29] kselftest/arm64: Add test case for POR_EL0
 signal frame records
To: Mark Brown <broonie@kernel.org>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
 catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-29-joey.gouly@arm.com>
 <58fb8a27-6c40-4b13-a231-b0db1c16916c@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <58fb8a27-6c40-4b13-a231-b0db1c16916c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 09:51, Mark Brown wrote:
> On Fri, May 03, 2024 at 02:01:46PM +0100, Joey Gouly wrote:
>> Ensure that we get signal context for POR_EL0 if and only if POE is present
>> on the system.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

For kselftest:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

