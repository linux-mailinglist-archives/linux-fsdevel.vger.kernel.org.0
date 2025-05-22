Return-Path: <linux-fsdevel+bounces-49654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E3AC03F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 07:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FBA9E0DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 05:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2B178CC8;
	Thu, 22 May 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEJUPsxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD5C2E0;
	Thu, 22 May 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747891191; cv=none; b=tYIrB58Ubw+F5ZaBZMMJ9iY88SUD7uvag+63rmLW0LJXbHJC3emMogVUIIMkvqLepK9VCEax9F4Ho4mywmt/j3CIIjN6vPe2ZgZwAMM82Ygj4a1XTEoREURLiFTHmMdK3OzIFSrhTHYt5R+t1g0NtqzdzDFn/WEX7TmHtnjCeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747891191; c=relaxed/simple;
	bh=VijUeTiGpFtN9iggaj1a+yPdew7hU8P0ucSP9iPy/iQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NGOom9EeWyZ2z/79f77Ol6GWQtnDmp4Xi4GYP26NR/tHJeCXKRUiv0CekkN5GiFFNT34ZXz2oOQoAKANE9DAZTcrapVk2nOSP6XPYVNWEUcKcanwRaaX2JnNNCkHJV7CEGrdGRtfulHnDWWodvz9MMD0EddsIEIsiRpc2BmtRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEJUPsxJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5eb16a5so4953797a12.0;
        Wed, 21 May 2025 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747891189; x=1748495989; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1igg20bqpstphWp0rLMP60quR69S5C8ddpAzpUJgpds=;
        b=WEJUPsxJjO4+kmV/SUQl45x/OqkvhnlrXftlr2+Pz4vRAkqD+KYVefmcifjenRAv5E
         zNq4j4/mgQUHaA1PzFfKIo2hH3EKTbx15CvuxNWUcAoDuoS0z/ti3KmlhMEIbXMDrUcq
         hB6Uk4tqL9BCIbKNAhh7ZJLAI/4UtNE/23MZWsV0jjeilpoMYcc6bOFSJwKPEdWXjxej
         xGJqPkq7ak30hK9F4r11jECUASYG96zNJzEs2Qo0jdF6W47NvP1tOKhLJvLXTLf/tFLn
         LhIYdAitJCHpXr5elKtVblHZ2iGIP2vH3B9IkUZ+kH+CrzfBB62iEEha9YqJYco2+Rz2
         v4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747891189; x=1748495989;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1igg20bqpstphWp0rLMP60quR69S5C8ddpAzpUJgpds=;
        b=SGzASdZ3pSviXVOwGDrB/Zzx+o9lZAXD1xwyfyJMBUThFEx1denxnMQEOeWiQsuH4w
         nioF+LWkonbZYhhVxacF0RTXNYdH5lrfco5Bvee5WqtfI4/dizy+r6CTd0Gq2X6VKNa6
         QF0EM4ZJjr2aZpX1QCYmIQ0SWYL9eoW67pY4zl1uR6nuRn1ysn7yQs9ddiPfCJ6jRFeH
         k1kQRabrJ2kzS/l3/D4A5MPD57GGgEeWD0lXMUXB0NF6NNi2Mpa0JR2jmfxq3bjgxH12
         llfc9LPyOqWTUn6hcWxP785/Cg1ozB1PMWdv1nZQDylWhDAw514jlX4u9kraniHzZlvW
         79sA==
X-Forwarded-Encrypted: i=1; AJvYcCXxkElpl4IH819ExDoKn4EyCPocsLeWlnvdeP1hhAe67s4NpP0eMd748vpVQjGKbaWyHAQovybpQEuwgKIm@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzOgR+WK2A8gFa+nZ31RXjQrNbV+SbTy4hAPXByJ7XtiVwMn4
	W8OL5vSakHkNFbHg9tdRkZN+KVMo26zt0i8e4jiuxkbu6PIgUv7HHn1nd5WN7g==
X-Gm-Gg: ASbGncu4SoomL0dqtLfKnmLGx6r5gEZ4p4oK2K9tz0VNBbj1/Ydc4th0aOeFQSI1ZwI
	k/1iu6mi8AVDZ4QV4A7up9SK8hwJghu8K07k9eVEiRCstGuzxM0uWT3KCTDUQ9S5fELfPBUs2JZ
	ezq7cClJBjNUYtBEJrtLbqwOXvoi+ij8iDjxeSaWeO8aCczycYXcHabUSr4B5b96KkTnZEhl3SD
	3foG+vBbo/1/HKbwF/BwJ7rA28MX9UeoM3D+bUSMlGTQXbNecK8rvrRapvOqcU4GqrgM2ZByC9x
	W3DWPTeBIOWw2+d8/C2CztvWsG3dXa4NPjsL0ORKZp5V
X-Google-Smtp-Source: AGHT+IFsBrGa+8wtjYy9K1UTBiQKVe24KYcBi8CjpsVMEJzw62zi9rtNd8dgAj4Jozseqk0Raf3oEA==
X-Received: by 2002:a17:902:f707:b0:232:11dc:d95f with SMTP id d9443c01a7336-23211dce734mr239418595ad.4.1747891188905;
        Wed, 21 May 2025 22:19:48 -0700 (PDT)
Received: from dw-tp ([171.76.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4af1b75sm101425105ad.85.2025.05.21.22.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 22:19:48 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC] traceevent/block: Add REQ_ATOMIC flag to block trace events
In-Reply-To: <87tt752jgd.fsf@gmail.com>
Date: Thu, 22 May 2025 10:45:26 +0530
Message-ID: <87msb52pld.fsf@gmail.com>
References: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com> <cad0a39d-32d2-4e66-b12b-2969026ece37@oracle.com> <87tt752jgd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> John Garry <john.g.garry@oracle.com> writes:
>
>> On 03/04/2025 06:28, Ritesh Harjani (IBM) wrote:
>>> Filesystems like XFS can implement atomic write I/O using either REQ_ATOMIC
>>> flag set in the bio or via CoW operation. It will be useful if we have a
>>> flag in trace events to distinguish between the two. 
>>
>> I suppose that this could be useful. So far I test with block driver 
>> traces, i.e. NVMe or SCSI internal traces, just to ensure that we see 
>> the requests sent as expected
>>
>
> Right.
>
>> This patch adds
>>> char 'a' to rwbs field of the trace events if REQ_ATOMIC flag is set in
>>> the bio.
>>
>> All others use uppercase characters, so I suggest that you continue to 
>> use that.
>
> It will be good to know on whether only uppercase characters are allowed
> or we are good with smallcase characters too? 
>
>> Since 'A' is already used, how about 'U' for untorn? Or 'T' 
>> for aTOMic :)
>>
>
> If 'a' is not allowed, then we can change it to 'T' maybe.
>

Gentle ping on this.. Any comments/feedback?

It will be good to have these trace events with an identifier to
differentiate between reqs/bios submitted with REQ_ATOMIC flag.

-ritesh

> -ritesh
>
>
>>> 
>>> <W/ REQ_ATOMIC>
>>> =================
>>> xfs_io-1107    [002] .....   406.206441: block_rq_issue: 8,48 WSa 16384 () 768 + 32 none,0,0 [xfs_io]
>>> <idle>-0       [002] ..s1.   406.209918: block_rq_complete: 8,48 WSa () 768 + 32 none,0,0 [0]
>>> 
>>> <W/O REQ_ATOMIC>
>>> ===============
>>> xfs_io-1108    [002] .....   411.212317: block_rq_issue: 8,48 WS 16384 () 1024 + 32 none,0,0 [xfs_io]
>>> <idle>-0       [002] ..s1.   411.215842: block_rq_complete: 8,48 WS () 1024 + 32 none,0,0 [0]
>>> 

