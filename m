Return-Path: <linux-fsdevel+bounces-33113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64059B4887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 12:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802BD1F21A13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E29205AC1;
	Tue, 29 Oct 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv+D4CYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F766188CDC
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202310; cv=none; b=shiOcbPltiwBGA9/I83853zXl2o0MvtaF+Me7J+utQGsp3clmTEbRfZfm/Y6MS6Nkm0CoL7wlNArjIgjuq5mjsHgDe3HJrVYekMOFGnQkFHdtMfLO7jZV6FIzoN8rAXEkt32CkcGyblmdY2D+HwJqHRmbY2YeCSvQjRAjqeywVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202310; c=relaxed/simple;
	bh=CX437E5Nyr2HYosbicnnbaJHOmbM/1dS1617DLcMqpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kB2fE/Cy14ypTTm7ik4z2W6RPZJAWWbXUn7QHHZhr0KINsdfaipKnSjv7OAEGhbpQfHPCOb+oRN8B0nyKUqI8hTKbdjMIKRhSf6qNJhJ168/mytc90EY7aNFWfCWpDr72alQgbLTElReF5VecppKnDB1v0EIAR7Q+g+ctp9UsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv+D4CYE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730202307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49UcOAd11qTq48MxmdhR0W2W8pgp3a9g0OPoFOxPnQQ=;
	b=Bv+D4CYEAGTVxrvinlJFmGF9OOaqI5h+5nz5N9KcKKmCRUsOnbxRVU4eZ+VHA6malVhXEs
	0mZZRAQlVqaCDTync1RM67NY0KTKa5I32n672Dz2gg3aeHVUB0uER7GHRtxKDymPtb0k/Y
	D5WhOsTcRVIDsj8C9IJlaKz2jcy8HL8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-sQ199WDFNzCNIvm0HH-kxg-1; Tue, 29 Oct 2024 07:45:05 -0400
X-MC-Unique: sQ199WDFNzCNIvm0HH-kxg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d458087c0so3791156f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 04:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202304; x=1730807104;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49UcOAd11qTq48MxmdhR0W2W8pgp3a9g0OPoFOxPnQQ=;
        b=r3dqaAQUyfLNQXIVqbmdeAzzkMwVDqTiG6ZZxEYpA+ECDL+TqGLhuSoRprCQuVqcGe
         hYAEDR6S/eZ+hXGwblkAbGvtHRWJ2RqI5ZmWnAIHbM6oO+zPUpRjQlhaBAdzU2nIM8Ei
         Ug3Xn8EXuw70A0/SPJJXnIvkM3wTVcx0hj+wqGeStGxvttzy6t5ft0wl/YKjmlIhYb7F
         bNwqawwtCA0hZw/SMPyfrDh32AjUDOuUu1UlcWgQ514MTTISWacbvhv972KbDHROlcnQ
         gFdkuHHtsx7YBVjuLkx6Zzgtwvd0b6QQN9OEbHCXMTmp9UYyiiVQOjFRqeG0/CvbdDmq
         YB/g==
X-Forwarded-Encrypted: i=1; AJvYcCXV7wZYXcoUbPDaAlIg3AK9JuGzmWayyoTAd7rYM+/4G4pzzcqnLGhDeo4Avxgh+yvbKKFanoa/veUWYmbt@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ86NG65hH6n4xJEXtTesFQ5YjRTzehh7J+olldQfPtGfqQlq
	UhTZquZjf74oB4Mj8UwAJ9VFGa6s9vuDigDNtsg8XPdwJTquBtSU8hgWRbPvfHetr0UB9mD6S65
	GYaHpFJb/SRRdCKuWlXzNQRMwpLG9m0japYFV4vcL9odlS8TzJZ/BYGmyZIOrFRQ=
X-Received: by 2002:a5d:5d81:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-3817d61fb7fmr1367030f8f.14.1730202304587;
        Tue, 29 Oct 2024 04:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/lxsuiQaY7ZPpA/B+Yv1BwvjwJSqs6qwfakzz1rOvHV9fzRSiAVjNm271n7SSsQctwyc2/g==
X-Received: by 2002:a5d:5d81:0:b0:37c:ce3c:e15d with SMTP id ffacd0b85a97d-3817d61fb7fmr1367006f8f.14.1730202304188;
        Tue, 29 Oct 2024 04:45:04 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c65dsm12359697f8f.8.2024.10.29.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:45:03 -0700 (PDT)
Message-ID: <6b5b7133-0dee-4539-8109-674f236e0fa5@redhat.com>
Date: Tue, 29 Oct 2024 12:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 04/14] tcp: extend TCP flags to allow AE
 bit/ACE field
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-5-chia-yu.chang@nokia-bell-labs.com>
 <3f194c95-5633-42c2-802a-9a04b4a33a8c@redhat.com>
Content-Language: en-US
In-Reply-To: <3f194c95-5633-42c2-802a-9a04b4a33a8c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 12:43, Paolo Abeni wrote:
> On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 9d3dd101ea71..9fe314a59240 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -2162,7 +2162,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>>  	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
>>  				    skb->len - th->doff * 4);
>>  	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
>> -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
>> +	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
>> +				     TCPHDR_FLAGS_MASK;
> 
> As you access the same 2 bytes even later.

[Whoops, sorry part of the reply was unintentionally stripped.]

I suggest creating a specific helper to fetch them.

/P


