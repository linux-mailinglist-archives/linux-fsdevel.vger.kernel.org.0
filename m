Return-Path: <linux-fsdevel+bounces-58813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F084EB31B04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7B1C84CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BD3054C5;
	Fri, 22 Aug 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoCahja5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531852EB5D1;
	Fri, 22 Aug 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871925; cv=none; b=lzUlB/F4ShF3kA01ScUX0B5l20QYul4yatOMy9EnZAjVo2OZHdrHHD3g7riDn7cmO9e6iBsJ91xUcm2lXxwHZ+JlJpm4sRSPds1ENkkM3QNBvlWvWxDsvm5oa3CwrtAneJX6zi5sPzQutala5hrX1toSjn7eSkOZ690zw14XWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871925; c=relaxed/simple;
	bh=+TKObB0AlaNIYbYugxrZxt/fF1Z783K4/w4R1udf4Q4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SbinD9zBe5Ko0feg4pGXBBenAr0RxJWoMIxu3b2qaRvN63dntl6PJn7+3m06aRgqh0s3Gn+xIoo1+QcoBciizK6rdOLiNXNzeCte0W7axM9wSOM3cL/NZquFAgMwMK0eG9q/pihZ63JbAb97CsFFcYg/Nlx0rtBemcwhVpSSUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoCahja5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c5594715e1so50122f8f.2;
        Fri, 22 Aug 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755871921; x=1756476721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUrkI8gRxT8al9H8bcipd0cfLDrY2l84rj0Cw0HvR90=;
        b=QoCahja5KtKcZIEYtH+WOGBeAddtdT/tDfiBJObTD2eCXsI3pC2Yd3ee3JciEnpLiK
         apITea4KJ72PNH7NwDNtmS6P49F5xBBBaota/H4scVwkaQKBb0TUZjanLeLJ4RZpIbHi
         xkMxieZdRCLIWIJC02jISrqK8KeSdTTiqDEtDgEt4Zff60ADx5fyEyV1zC3FeuT26O1D
         EUc/Z4pnToXaiZcOCJcOxlABNKLAtmk+Nj00SKGJ4jOqyggWEyCDCxzYzA77cmlzAY4e
         LOZKMoyidyJhpcvI+WMK9x6PEVM/wmwSDfv9GLDzqS6KzkmGV3Ga2HWR+KxYsVgeo3uB
         /9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871921; x=1756476721;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUrkI8gRxT8al9H8bcipd0cfLDrY2l84rj0Cw0HvR90=;
        b=vNV2+/S+ac2dtIOX6iCa3esVnEze8vvkJlD2CFv7KUn7tzt62gSbgXg1F5x8dj3H2I
         ENJD6VWkz92hlfaLJWdkNNbcGRJRnXW/RqcGZVrYJGTokpuzX9J41/kzzgGMRX626LrU
         KavR/oDjRPTaGFS2/NTu4XtaS4KEVdoD12olQBDgq8JAGNoCY5gufXi/dJtawV1vWSQh
         Kp/fPG0tgsAfrEiut31nfp+m9a8ovkVUYvXMjFCAUWglHRpyaYEFlGFmHxByVsK80ed5
         LuX6srLHxZfy2p4q8luSHNvtgMGnQUonCm37UWRz+TNtj6vs7dICqt6x0YAI2taVpQ0a
         k5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHQakfsAVXyfrvCMZ1gCRyef83Qjp543nlirl/nn32XeNMCdNwVOsfy1FdSWBJt6fGg5BvMTFcUWGVkg==@vger.kernel.org, AJvYcCX+JJUcOvIbwsgJVK9QEzflgRwMCqMe7g/Eg7xyck5R0KzBB/latsUa4lB8EGsaLfDSYUthnHd1fG3zrzuf@vger.kernel.org, AJvYcCX5kEeYwH62MlSOgskGJx+AamBJQxQMZBpVJSEKKEEAkE5jlW1AZ8olGfqr7l6xF+r/K7jAq02pjVDAFj79qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGXcCBioI2+d5w4utOicnZAOntK0Zn9TMynDLzqJQPgPqdyw0
	avHJ+Ylv2zvxpsit5MHbi+WG0edkUiTPMtnsD5Wk/dNTS/DJVdxAQHg/
X-Gm-Gg: ASbGncuh8zlWhHUUAxyCBnhMQirosHezebd3V0eSHa43wSNFjDuJ0Co44KZwMMQmOcu
	lbDJrWwNU/fy9mE/6s9w2KYsfmOyFCPBZ7clqffw2XMm4B0/5UwcdD3B6Hoert+ujz51w1APaU1
	xherfpEw74eVWUibnneIjvXwxHpHydqXN3K7wKt7B/vT8MgRiLmHepu8qxVvpisv9L/mKjjjoSy
	oTcGdvmIFC0aMwsInKdacopwZwBDnuq+Z+BufPcCihCqJdauTUYOp3d0aJUkywesq2n4Py0zOQ3
	URL+eretkxl1KGx9pBs/acaVD6xzpI61zUsOZ73ULFSE8jxywEIQwcDTA+KKH/DxKpObkQQPz83
	FrNrgb3m6zte3EY+rvI9pWf99Dn/vcGq05+Ft5hRIdaGu+PYPnwsuUNIovDzm7sM0PFaqziXl3J
	WB1I7Z0oFa
X-Google-Smtp-Source: AGHT+IFjwShx3D0jJMvSWdaLG4T39JgpaQyzemTxwtJre4OZUc8C3M5BPxw9JQYLkgJW8PLQe/esRQ==
X-Received: by 2002:a05:6000:25c3:b0:3c5:7050:e2af with SMTP id ffacd0b85a97d-3c5dcdfc35fmr1024231f8f.9.1755871921342;
        Fri, 22 Aug 2025 07:12:01 -0700 (PDT)
Received: from [192.168.100.6] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c6c737b303sm576035f8f.47.2025.08.22.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 07:12:00 -0700 (PDT)
Message-ID: <98191ca5-9581-44fd-b9b1-6f0b932f141e@gmail.com>
Date: Fri, 22 Aug 2025 18:11:58 +0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, andrealmeid@igalia.com, brauner@kernel.org,
 christophe.leroy@csgroup.eu, daniel@iogearbox.net,
 dave.hansen@linux.intel.com, dave@stgolabs.net,
 david.laight.linux@gmail.com, dvhart@infradead.org, jack@suse.cz,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com,
 mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, viro@zeniv.linux.org.uk
References: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] uaccess: Add speculation barrier to
 copy_from_user_iter()
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <CAHk-=whKeVCEtR2mQJQjT2ndSOXGDdb+L0=WoVUQUGumm88VpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

so we can use speculation barrier? and fix the problem locally


On 8/22/2025 5:52 PM, Linus Torvalds wrote:
> On Fri, 22 Aug 2025 at 05:58, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> > The results of "access_ok()" can be mis-speculated. The result is 
> that > you can end speculatively: > > if (access_ok(from, size)) > // 
> Right here
> I actually think that we should probably just make access_ok() itself do this.
> 
> We don't have *that* many users since we have been de-emphasizing the
> "check ahead of time" model, and any that are performance-critical can
> these days be turned into masked addresses.
> 
> As it is, now we're in the situation that careful places - like
> _inline_copy_from_user(), and with your patch  copy_from_user_iter() -
> do maybe wethis by hand and are ugly as a result, and lazy and
> probably incorrect places don't do it at all.
> 
> That said, I don't object to this patch and maybe we should do that
> access_ok() change later and independently of any powerpc work.
> 
>                   Linus
> 



