Return-Path: <linux-fsdevel+bounces-44742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE694A6C44F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 21:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BA93BCC78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC5230BFB;
	Fri, 21 Mar 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MZQKcIkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C422FE0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589358; cv=none; b=IA0WIBnPDYudrXC7VuvGYzc+td/S+c+Qd6BmHJdON0TeDPCslYRPX2EZ2hG0u+Xr+W7JguUxvAzp7FMs860LmThq1gkuBCEUhK2ezQ4OP2PCFSguLs12woOFD9obo1WVP7o4hrVlS7tkxiC01Z5Jozsl83nCeFm1Sjm4uPStxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589358; c=relaxed/simple;
	bh=Q4yJA3jsyp0Q05YHLWgkGPj0BYZnr/626JQJoRaup9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IiLCGShUSM20WGkTynaT7fRaiOeUsTkc/hqT/ID47r/GrvS0N/lHS4tMsTaeL26u562tMcptY01w6hImTHqLuRlA3fXxo8lbpyBvkxf134HHofSHeyCwpa7AakYMGRXbkW2DKmi1fNFYAO4EKcKMRs5+xRF1fk8ey28yJ85gnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MZQKcIkO; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85db3475637so114204939f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742589355; x=1743194155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvMwDu0BMSrh7CaSCaQYm2+c+HftuBgbOun19NXMMCQ=;
        b=MZQKcIkODtlB8IzsiOOakT6x76IB4Yq1lgJYIKJSTEfoaBWSl+wJL0k7IvBWJnDZ/C
         sRMiO2aGs0q36yGgrmHcpDsyuol45b/Ixhfn+eePULsLQdR7fznLuGjBvz+rBjB2iTSR
         WomG4LprAGXddDy2JYJ46fcToSzGFiyeSw/NtomiMHWW9jBES0LQdHRbC+JZLluB5P3a
         JPQREz4U8K1fJcmFBnSttbB2QZE+/eCdUX48UmYC/uE11GT0ieI9pSOi5alU/a243cmA
         YJp5ZuKC+PmiS4NXhoLZiPMvz5ysXo3aUc5vqqv8jU8DpqxVGBS0DwctRuIWU/RsVSds
         9RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589355; x=1743194155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvMwDu0BMSrh7CaSCaQYm2+c+HftuBgbOun19NXMMCQ=;
        b=oJ4IbeqDMtqWcwOC5xFntzhN6+v9FWX9vkoKZCvMeinDmv7rHVvApAFAECqqGQ5Go6
         msIWAFNghFA4tYVrhKx0ZGA7mzuFnhje+zu4nOP/fuOfikxpzdKq/mVaxX8qfhmluq4/
         W5wDCdRJhO2Tjy7C0D9F2Nwr5+T7CwEriRazntDyxDu05uK+D77IlQRsJMdnVBK4p0mE
         di+bbWkUm6SCcD+uML/5QTDzOgVlaP0yCZG9kbEsaurllvNuQ8vXjxFtPJ6TDdvrdtOn
         xs2FIDCRQAEaq+5Fj/iGnBHtNPDudIL5roVqtDJr0lyTfSApGfPCO76WE08sMwFib0R3
         WXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL9LWmqUV7dMPxmhNxJYHpOfmoia6imjRs4AT8nQqHWyzZVaWEgSC9Rl6uIZVUjqGF+aeDL6hd3o9muV5z@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJnKnDAfCrecRo0JXNi/mZDOJpMvfvEvJwVMGNNz1wdi6ppSG
	FNWl7z3HKpzz/+LmKosMma9vttgWyxET9OEv0Hzf0pRALiSrWeQEKGbshUvfAro=
X-Gm-Gg: ASbGnctonpD/2IOynJiP9mMtPVNrULOry+t5aL9hoyakwTgH3aCN/z+/jE9M7AcGaHY
	YwvVM+txwX2XIBhKxk9y2rC40Ut7mzdpbM+/ra2cwO/pn+t8XyNhE066cZVAFNoLDho0EmTX/jD
	UAPC6u8reXXViUk4ET7IOnjl+MXURMJ+0J1/4OqzSrVvLDZyyNJV8VaEyoXF9ipbmy+NChUduCL
	lKwtRWw1g+UeK+D2CQdWQFY6v0NHQXzpku39OsQ5IZ+xnHi6n18LKTur1BmFCK5KsS0GpolG/A7
	crD5PDyomO7zH7ltuMLUVQCIaZUh1/y4mz+sPtlwDA==
X-Google-Smtp-Source: AGHT+IEPWzk5ry4zHWNFdi8KTg5KcDVgbTXsCl1DzYqeTt8WkJX5AIeUX7DfgyW/W2CDL0vQ6sVZlg==
X-Received: by 2002:a05:6e02:1f01:b0:3d3:d1a8:8e82 with SMTP id e9e14a558f8ab-3d595f91c7emr52500135ab.9.1742589354635;
        Fri, 21 Mar 2025 13:35:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d59607ea6fsm6112915ab.24.2025.03.21.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:35:53 -0700 (PDT)
Message-ID: <4e582b92-2f4d-4a0d-b479-3cf4f054bb5f@kernel.dk>
Date: Fri, 21 Mar 2025 14:35:51 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 10:36 AM, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
>> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>>>> I don't know the entire historical context, but I presume sendmsg
>>>> did that because there was no other mechanism at the time.
>>>
>>> At least aio had been around for about 15 years at the point, but
>>> networking folks tend to be pretty insular and reinvent things.
>>
>> Yep...
>>
>>>> It seems like Jens suggested that plumbing this through for splice
>>>> was a possibility, but sounds like you disagree.
>>>
>>> Yes, very strongly.
>>
>> And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.
> 
> It is clear to me now, though, that adding a flag to splice as
> previously proposed and extending sendfile based on the SO_ZEROCOPY
> sock flag being set are both unacceptable solutions.
> 
> If you happen to have a suggestion of some piece of code that I
> should read (other than the iouring implementation) to inform how I
> might build an RFCv2, I would appreciate the pointer.

I don't know what to point you at - you need an API that can deliver
notifications, and I'm obviously going to say that io_uring would be one
way to do that. Nothing else exists on the networking side, as far as
I'm aware.

Like Christoph said, struct kiocb is generally how the kernel passes
around async or sync IO, which comes with a completion callback for IO
that initially returns -EIOCBQUEUED, meaning the operation is started
but not yet complete. Outside of that, yeah need some delivery
mechanism, as you're generating two events per zero copy send here. You
could obviously roll your own, good luck with that, or use the existing
one.

-- 
Jens Axboe

