Return-Path: <linux-fsdevel+bounces-45373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378BA76B67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4056518833F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD921423E;
	Mon, 31 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzqhJsjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A31E1023
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436669; cv=none; b=CjXK14U6HxEqgLNJ8d94IvLS//gMSnASJNVQErx3jWJV7keqcCxW87T9Ol7p1LNQapD5kvq9S33xjQXRnKy5zyesvYdCQDwJLBJPf+huY8rR5wMU9UWoX1//eToQjREBYZg/MWNqhhxCjHaoftFKNmyHusT5NM2p2aDcCccLOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436669; c=relaxed/simple;
	bh=T4ZXoS4+z+X59eVjgvFMxhCV0fHswDRnLNk16rznrx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkn/pJoae2izzwlVDNhXBCYINO9rFpWoi/VvVIgAfPCtmr5S8St+MERQ711k0ILJcHkvEzDgL7466RlPrbYB5uJeiP5VTITSs38I7VSFWYuG8pYVAscQgcHiXT41n6jPG2s6v0Q6pEPeNOKaYXaT7gFzSBk/juDy4JnuzVMtEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzqhJsjX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743436666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARQvl6eb5G/d0Q5+QAgY0Ic2dtUK7SZy2q5rXofgMwk=;
	b=GzqhJsjXMDXN80+rkxpusapiPFrObSybJl8wu3mRm9SENthzz4wEiCYrCdr50+k7JLVvmm
	HudJwRCBRDBstfjTnRGoRhXH4LlHTLdMjeod9zDGVZLMAeH2TiywpEb2T2lCVw023NNIee
	VXnkZOgy8iurI9/kCBmnERJt29TliR4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-3zE2mMRdPcaIFyBmGCRSIg-1; Mon, 31 Mar 2025 11:57:44 -0400
X-MC-Unique: 3zE2mMRdPcaIFyBmGCRSIg-1
X-Mimecast-MFC-AGG-ID: 3zE2mMRdPcaIFyBmGCRSIg_1743436664
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5750ca8b2so766904985a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 08:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436664; x=1744041464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARQvl6eb5G/d0Q5+QAgY0Ic2dtUK7SZy2q5rXofgMwk=;
        b=OviA/aWhV51kd8WZ58TMIIa40TqKNfZFGUN2Yq7QDnqRQZBUw+sYQN+tyDHsihtSl+
         ggVsrnuptv6YgKQfj+NpIZ+xqqSPymxS0do9Zp4DxKia+25fZTAL3gZieGu3BQ1IKmYC
         SwSwj7SEzYWl0kErJegBaeX4yGUFR/7KL72fzw/p40c/s0ttjfY6yosG5TuLrH6yaekP
         YRsgso1QaCSYtqJInF6K5+EHEcTw6xWyRFS+xdb8A9FY1544V2eQTrpogq98hCx6ccz5
         fA38j6zkHWM71BSMBgakLLg6GzFppM2GP7wJ9t7fQEjMP9ZAUIfcITDZtycWq3YoPBjW
         uAZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTtcab84ocdVD1CwA4V2oLnfrk+L43/7EUl7ZsLXcw0t6Ni25wDcC3jnG/aZjjw5Csvr+J+MtFTHclOaBf@vger.kernel.org
X-Gm-Message-State: AOJu0YydFaOK+ntBUnMYF+S27tL9hfkqneo3KDdu2g/zgYbGZi6Ca/qU
	y0WMbCYVtc5nkDUrphyA5XZKAwuMvd0oe0NaEG+gKh89BEK9uiMjRCzDLoZm2kqFJ7q2dTQ8+qo
	eysAQyMnWYMU1Y8gMvLBERZrNsw/CpSGqHXhW8hbfQ8giA8LTr9jhT7ZLD5Yxdbs=
X-Gm-Gg: ASbGnctXH0KFjmYvdBlQZwDtkw/E0+aloJMDBsj8r9TJ4UVdSaKhXabvCvmuhHL8y5l
	VIN5rw+mId+RNqMOv2uatpu3aw+UdVixe8qywFa7qV9SmQrZ7c2VTovE8MxBiyV2XUbvXEoDHML
	5oAA+0+51y4pjr5xKfHVcSn8PW0OF4Jvy3r30//l0LtTeJkSMS9xF293wXVVaO5oifyRWlgI7Bw
	mhAb1Rc/lYaw3JhX+xysDcHQyLRAvOXSiTAM0aL8cCgcLW3bBIkxhmSeDvFN/5N+5gZPGiN1X/C
	rrcURt+CP74jYG0knA==
X-Received: by 2002:a05:620a:2681:b0:7c5:59e1:f0d with SMTP id af79cd13be357-7c69087dd1emr1110561885a.39.1743436664161;
        Mon, 31 Mar 2025 08:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJkfzA2bgSBj5bMXVb5RPFZXUDrOzGE+hxX2ryFfa0NqKfabKeiu4FaR4V0+jp9Wn/Rz6pdw==
X-Received: by 2002:a05:620a:2681:b0:7c5:59e1:f0d with SMTP id af79cd13be357-7c69087dd1emr1110558385a.39.1743436663831;
        Mon, 31 Mar 2025 08:57:43 -0700 (PDT)
Received: from [10.193.213.71] ([144.121.52.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768227asm514285285a.31.2025.03.31.08.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:57:43 -0700 (PDT)
Message-ID: <5393a1f8-898e-4e1d-b516-7d0070086655@redhat.com>
Date: Mon, 31 Mar 2025 11:57:42 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: nfs-utils-2.8.3 released.
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>
 <Z-oRa3cF97JCGkVo@lorien.valinor.li>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z-oRa3cF97JCGkVo@lorien.valinor.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/25 11:52 PM, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Sun, Mar 30, 2025 at 03:37:33PM -0400, Steve Dickson wrote:
>> Hello,
>>
>> The release has a number changes in time for
>> the upcoming Spring Bakeathon (May 12-16):
>>
>>      * A number of man pages updates
>>      * Bug fixes for nfscld and gssd
>>      * New argument to nfsdctl as well as some bug fixes
>>      * Bug fixes to mountstats and nfsiostat
>>      * Updates to rpcctl
>>
>> As well as miscellaneous other bug fixes see
>> the Changelog for details.
>>
>> The tarballs can be found in
>>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/
>> or
>>    http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.3
>>
>> The change log is in
>>     https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/2.8.3-Changelog
>> or
>>   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.3-Changelog
>>
>>
>> The git tree is at:
>>     git://linux-nfs.org/~steved/nfs-utils
>>
>> Please send comments/bugs to linux-nfs@vger.kernel.org
> 
> Thansk for this new release!
> 
> Noticed that the nfs-utils-2-8-3 and release commit is not yet in
> https://git.linux-nfs.org/?p=steved/nfs-utils.git . Could you push
> those as well?
Done!! My bad... sorry about that... Can you say brain fart :-)

steved.
> 
> Regards,
> Salvatore
> 


