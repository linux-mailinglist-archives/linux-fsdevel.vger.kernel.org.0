Return-Path: <linux-fsdevel+bounces-22057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D499118C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CAAB2232F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0F84E0B;
	Fri, 21 Jun 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="edMnv3jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573E8289A
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937405; cv=none; b=OfGGD7dlgW5QseizwjIfTXwi1g+XkyZTiiL3XVX8DXcRy12J2+QVpv4PXMczSFvCVduuTICNZjqzSyWKMTDOs8ApyC63ifYXkEaO3HIisPCGrf/uhHH6BPbQGGTwej7HyZU1FF6HNU3/1Xb1cGs2k9huiRL2G+kBunHYnlEpgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937405; c=relaxed/simple;
	bh=XpCVL9a3HAJzUcDsCRQhjlGYzoYp9tRjJO+SvqvT5Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKp2ba9B2GcU7iVbY0D5Q4CzddU6sd1Z9k5muQZqhLDUkwwKSuBxKtfYmsh4MSkdVp4ngDwW+U8VIjxGbRc2bRbIpAd+xbHGwCxNAoArWgX+VmyjdT2F0Gfj8k/Zw7Q3RbcTwn3pxXIkPurPqrdw40LUUBacsCAz0QGpfY0y4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=edMnv3jy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706524adf91so180965b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 19:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718937403; x=1719542203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ29XVyr2F7PE1OlyXcXzhHYCQ8VYiYUNotAJkqWiP4=;
        b=edMnv3jyRVSM96UEeE5zrtXULT9j7q9g40FQrZGgZqsF3o1u8JMaggI420I7p+YuXG
         vmoFBaTIl2eZT+GdWug8DBt/B/XS5fMdHyiMxkUnGv3OmJqgu90WU3FkYbaFK07ske6h
         Q1HJF0ZZNMoajZnXzpZjt3w4yma2MDadgFv5BNnVt/EF/o4Q6RYPmv0R5VXCQR1e1yt7
         imYzmGRehFgDSQGjrzq1vKIPr0CQwqa8atSzk6JVgK6Lx3NEzfnSFtBu0f4FfY4XnUuS
         rE1wl4CNRjWOM/7WDkYfD6ga9wZXbWqlUAC+MHKS5ATsVKvHtv1n+Q0x7R8wxLJadfi6
         /OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937403; x=1719542203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZ29XVyr2F7PE1OlyXcXzhHYCQ8VYiYUNotAJkqWiP4=;
        b=tDThAVqXDhh1Q4uawl7m9l11OEZYIi9l6VLrqBWZPtxwPocNPjgcaVzXtk4rjm+mTO
         k7MSCGab/eZERuRu8fjMHMFtF2YTfoG2OGEKM3rzl+sEYJdxP+VnODorloiP/Uw08gNS
         Di9pi2/fm447a+WaNmAr7xk14/ktkIGfd5O1VQx7i9doeHSscWlUgXTd2tLTIJbCjMkv
         E7NAtZtnov5tymnak+T9z47meRumzYRCswq90skr9u6m8bp8MNU0pGXcS4ynagBjg5fn
         j4/EV8A6ZoBnyhOk0V4JfYGlj3ZVT71w6pLycZReZZ5Yc4yvdyREeUv8L3Er+p9jEyun
         i0dA==
X-Gm-Message-State: AOJu0YznDmhFjl6w8gfHDnRWDYstJEX/ft96pRvTwhl1SI8ahjjkdsQS
	zwQxvXQz6X2ZOI+ID7vOCo4f8NheuDe9jW4en2z5TC25j40/voCDaWg0dMv+shY=
X-Google-Smtp-Source: AGHT+IErLRidr7JcKQ7BI8LT1ghwTfF/DmMM7EmNAp9djFIXW0H3ppZINezGbMwGItwjeJhSvbnvPw==
X-Received: by 2002:a05:6a20:4c8f:b0:1b5:d143:72f2 with SMTP id adf61e73a8af0-1bcbb60f7f3mr7108765637.57.1718937403211;
        Thu, 20 Jun 2024 19:36:43 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f2690sm3337225ad.40.2024.06.20.19.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:36:42 -0700 (PDT)
Message-ID: <03658a84-09e0-40a1-aa30-9f92e82a6b0d@shopee.com>
Date: Fri, 21 Jun 2024 10:36:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
 <20240617-vanille-labil-8de959ba5756@brauner>
 <2cf34c6b-4653-4f48-9a5f-43b484ed629e@shopee.com>
 <db4ed4e5-7c23-468d-8bac-cee215ace19e@fastmail.fm>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <db4ed4e5-7c23-468d-8bac-cee215ace19e@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/6/21 05:40, Bernd Schubert wrote:
> 
> 
> On 6/20/24 08:43, Haifeng Xu wrote:
>>
>>
>> On 2024/6/17 15:25, Christian Brauner wrote:
>>> On Fri, Jun 14, 2024 at 12:01:39PM GMT, Miklos Szeredi wrote:
>>>> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>>
>>>>> So why the client doesn't get woken up?
>>>>
>>>> Need to find out what the server (lxcfs) is doing.  Can you do a
>>>> strace of lxcfs to see the communication on the fuse device?
>>>
>>> Fwiw, I'm one of the orignal authors and maintainers of LXCFS so if you
>>> have specific questions, I may be able to help.
>>
>> Thanks. All server threads of lcxfs wokrs fine now.
>>
>> So can we add another interface to abort those dead request?
>> If the client thread got killed and wait for relpy, but the fuse sever didn't 
>> send reply for some unknown reason，we can use this interface to wakeup the client thread.
> 
> Isn't that a manual workaround? I.e. an admin or a script needs to trigger it?

Yes.

> 
> There is a discussion in this thread to add request timeouts
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dkernel_20240605153552.GB21567-40localhost.localdomain_T_&d=DwIDaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=8O09nPSMPRZHOnfDnsm3lTwcO7AV93meeZP-F_k_u8w7XO04ISrP36bbcoEMUSrW&s=FRDpgmP8jGWJnoZna3OrFnvx44cCgywsGOeMY3fCeFc&e= 
> I guess for interrupted requests that would be definitely a case where timeouts could be
> applied?

Yes. If the requset can be cancelled until the timeout elapsed, we don't need to abort the dead requests manually.

Thanks!

> 
> 
> Thanks,
> Bernd

