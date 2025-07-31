Return-Path: <linux-fsdevel+bounces-56365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F5B16A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 03:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D711AA2583
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAF13A258;
	Thu, 31 Jul 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WusmOceC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE633062
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925904; cv=none; b=cnwf37AShokLDR1VRYdqxAYOTvgSpjBAxfioR+2sRUPdSzAddWT2rLP3NAJTXiJSnih6KjLaXsKl4OJC63TeR4+ddAnnQOqIBwwY2uFmWqnnoYNBkM0MS8VNYBIZDv/+Is3wCVfE5F5G7dUVlWblF04RvNld2C/7RMcHaKCXuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925904; c=relaxed/simple;
	bh=8ya7e6/CKYInYotmvzdXqePRXf+We+Yf0/tthtPk6a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4b37ywHdRUFbOOtYpLP9CCjnKWrWtpYxZchqARS+N0uMXVMcZKoVlSB5C0O6soh4+zUS19XHiH5zkWkGEhwgLqDDYz6WoVwxcOBrj/ZIh9QEeHmcnE+lkqkP9iUH2ndj5Vx3ERdBbx9NCWOdugFI22sbtoOa0BdtxWjTQI3ERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WusmOceC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753925902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
	b=WusmOceC1ChbgaCH44N4zpNHw8etE+AGdYv7kuF2STLFWXtPyYghoQt7GlO1StRDdPr2fr
	nkzYZcFGFUmVFnl5BEx0odabFjMiAUsB1f2rUMyX4ipZ1JOdGsXca2gMQotaHmvSRNzwn9
	mSMm1G9PzPiLjCk2/P/mG4AIAxwb/z0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-zDpE_Jy2NfSkP8gIB4UV7g-1; Wed, 30 Jul 2025 21:38:20 -0400
X-MC-Unique: zDpE_Jy2NfSkP8gIB4UV7g-1
X-Mimecast-MFC-AGG-ID: zDpE_Jy2NfSkP8gIB4UV7g_1753925900
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c33c0b62eso36665939f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 18:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925899; x=1754530699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8OY69MZlq/xsrBb9axeH4pIVOb+xTllFUAYP1I6n5U=;
        b=ncILxf5h0Z8PvlHxLf4syzPiGixH/kjCkagW1kep//maJjrLdpGvBXfiVn6MQI+3HP
         wJeV5/hgFc9pTq4NLfi9cr6aAAfdhYs44X3MywSbHitVUyJgIn0dGHrTD3hlvIqoN8Vg
         X5QiDQ82eq3MzjqbJlOI70368URU2Njx4SCt/5GYV4jZe06fQQGev3U6PP5nssXMp2Ih
         baTaflCRhoC9GVOcOJZSm9UnnPGlwk8d7iVqS3rmIixXwEbD/c5vlhLv3vqrIGiMt/9O
         iQiddjRKnKvAYZd5DAUt/8mcQNX42j48dpBHptbh2ACMyDMIIWebkqwfgyV5QtZy2VRB
         eEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXluHD18DAVAcVQ0kqtbIGdgVh34SdsEwpcl7QJ9lQSUhJ5a1J88yZ9wz31UaG9dwRAdijG50gayLvrGNXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu8rxw3JFCxiZ5J7DKZu1YWDo9Oh3ptYzNWdxCUhgXdOFkjcb
	WgLDjKK0H01lXb+MlEzucr2iqvP8HK9LhqMYU1zHnxDX5cjzvzyBsTuZkVc0FDdiDoKnOi8fKWf
	mIHivDURbAvISGkEdopdluZar1gkj7z353kIhP6SgizjajneieDqFTg0mMBYltPcUsJU=
X-Gm-Gg: ASbGncvz8tJ8ND87s2Uhu/xWKYwknTScao32yZkFPhdkyYje6tS2CKxT88SM3OgodIm
	qK91sQ3Yg93FmHf0eWcPRSSoJOkk1wvtcAgLP9sqaHXhU9ktzdXFCryUxJ13C3mPt0pkGcRCwVQ
	sjM29J8na6zuTo7r1RL4fW6XXRBUGtaFVwaJ9h3Fb2a71vdEUxdmitPNE32yf4kS9cysKgt0Klt
	aVHJRl1r/mpXtAhFewsBivAL0UY0dwCVGA+b0lhNLoxepfM278U021VwZC0B4IcT5PWlvPuT7cS
	L2SxRO6B1egEwdzIoqIG0HOxGXzIM8EoS7wC1ousDCcdWZ4raGUIdPbWMppXsJ0roU1PGA7/WKW
	h
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029070239f.14.1753925899512;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDYpvJqVTQun48scooKx53IQp8MzyEscpkj6Zf7fOtkrrh/YzKc++iz/oiD39bF32aJz1UpQ==
X-Received: by 2002:a05:6602:1592:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-88138b04598mr1029067239f.14.1753925899081;
        Wed, 30 Jul 2025 18:38:19 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814dfa2282sm12147439f.27.2025.07.30.18.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 18:38:18 -0700 (PDT)
Message-ID: <fb7e2cc2-a13a-4ff7-b4ab-8f39492d3f76@redhat.com>
Date: Wed, 30 Jul 2025 20:38:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aIqa3cdv3whfNhfP@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 5:21 PM, asmadeus@codewreck.org wrote:
> Hi Eric,
> 
> Eric Sandeen wrote on Wed, Jul 30, 2025 at 02:18:51PM -0500:
>> This is an updated attempt to convert 9p to the new mount API. 9p is
>> one of the last conversions needed, possibly because it is one of the
>> trickier ones!
> 
> Thanks for this work!
> 
> I think the main contention point here is that we're moving some opaque
> logic that was in each transport into the common code, so e.g. an out of
> tree transport can no longer have its own options (not that I'm aware of
> such a transport existing anyway, so we probably don't have to worry
> about this)

I had not thought about out of tree transports. And I was a little unsure
about moving everything into fs/9p/* but I'm not sure I saw any other way
to do it in the new framework. @dhowells?

> OTOH this is also a blessing because 9p used to silently ignore unknown
> options, and will now properly refuse them (although it'd still silently
> ignore e.g. rdma options being set for a virtio mount -- I guess there's
> little harm in that as long as typos are caught?)

Well, that might be considered a regression. Such conversions have burned
us before, so if you want, it might be possible to keep the old more
permissive behavior ... I'd have to look, not sure.

> So I think I'm fine with the approach.
> 
>> I was able to test this to some degree, but I am not sure how to test
>> all transports; there may well be bugs here. It would be great to get
>> some feedback on whether this approach seems reasonable, and of course
>> any further review or testing would be most welcome.
> 
> I still want to de-dust my test setup with rdma over siw for lack of
> supported hardware, so I'll try to give it a try, but don't necessarily
> wait for me as I don't know when that'll be..

Cool, thanks.

-Eric


