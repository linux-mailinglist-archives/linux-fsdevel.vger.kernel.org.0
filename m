Return-Path: <linux-fsdevel+bounces-17323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354F8AB767
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 01:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A236F1C20B9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333813D63F;
	Fri, 19 Apr 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="NudW0h+B";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="UNaejFFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CB7D416
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713567853; cv=pass; b=VhSV4pAjzzI9l9Zwm94aABw7IO0+Hgmu/95kMYqke2QbBHshf5eJlgiWL7lIF8/Wi59xdfUoIwVqd6yqOAAwi9ww84cdsUWvMP2bnsgvOOnMnu5TECxOyHvOfDdT/rPnES23vEeDvXGAhYTAtjy9eKYcQRUjxaGClNprHO9talM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713567853; c=relaxed/simple;
	bh=mricqxdh4nUPzdctX29L+9fpuqfexvjUnuik613Ho7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EYsC7yWOKTw3ao4e69QWRz1+vhO1xAuWfamNqA1ytoUxEmRy8D6R0ESdSWrzfUa4YJSI143PZ4CdWFIDuhZzjC9chk7LhxlRVYaOpCqdhKCqDt1FVNMRIJtMVG+DdXO5BSl8i4EnKQni9HC4jmcfKELHFwF0/U8YqRuK+RK64jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=NudW0h+B; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=UNaejFFc; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713567845; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=peAJmZ3qhSpLklXMA8qTXMFImkBptkQe1pn7g6WtsbQN2nGziTxhT4FHVzB6AZGvTD
    NFy1/9AZox4i9NVPszNTlV/oMYw47VHK0xQI4ZdrbAL/RZn8Be68HKxlx5VcduZym/CV
    bmCRN8gBqdx0cvkDttPfgij5w60fDTVpTdH5PZFCeh37vS2wlfEaEvcGzIjg6/tmgrpf
    ZDSkTaot4TYTToHGyTLfmiPMnRTfB5enIwJItuayD7p3pD6xwOjC30hm0OYYrqFitVNx
    ZglyrZNf4Gv7AD5DJKaCiNmsujS+ZICoB1V4LaDXl44Sguq2l/1gnB3eLPz7TqEESbU5
    2A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713567845;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=mricqxdh4nUPzdctX29L+9fpuqfexvjUnuik613Ho7s=;
    b=spHeGZPJC2yoflEV2vaXmVAkJhshgd11yF/gKgB8+77WCSAtgGLQ+RL8NN8y5ELFNK
    GrX1+vuegR4IGKma72Gz+N2KMntyTNrP7Ww5lSY9zITCyNgezO5HO/SYtV7g/wxkOykn
    M17Ept4FN1FBIezFjg5FsH4kcBFQf1gENdw01l84tFpGo+rCxIhJOZZQkfBKNHkJq9pQ
    xNJkk5WpYHMIEDQkR0wvgMRxPLLTLY9fyIcOYJ9EHMYJoiJ+HA4Wyad8w+b0Cdjfjrrb
    7QNi1dzQriuQzf7zysn6ZQVaB2weoqypYS6gR0qA5iQW6mJQA0klSLsdkulPOa/y9r+J
    HNGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713567845;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=mricqxdh4nUPzdctX29L+9fpuqfexvjUnuik613Ho7s=;
    b=NudW0h+Bs0/lpwRN+N37F7av/RANEp15Np/v9EJgmCVAt9d/cRHMzLrFNN1Yn9D9Y4
    UCiRurddL4NCCEj3eO3kHk7EvbBx0DU2mJsaTu793D+Wc7EZzHFFX+ga6gYVGwvATdiT
    gbozZsaTDwyYmxtWs47l8q0nUeswQp4RSBKfIboppSbbF38V9US00N36dooPGi0ppF1I
    Cvyc1SD/TQvk9Tlv3nu1GAuV8/VHChXhN+K2Cb441s+a/wXlM4bPrHMEJ4JQFL6GpDEu
    d+1gJ33NtytTjiwtIeMMRhpM4WcCTrwuG0Kbb3AL9hg7U1NC7FHAJ6sRon2hQcyQ9WWQ
    Og5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713567845;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=mricqxdh4nUPzdctX29L+9fpuqfexvjUnuik613Ho7s=;
    b=UNaejFFcKstz+1meUXyH2/I8TU0vyOm4KuLkuQGogVgyd3Weai8KuVyUGbiENvlMMM
    vmuWjGd/CNpRdplbjsBA==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkQW4xSV/VuPB8g/jrf+fgOZAiP5qKuiDjps0="
Received: from [IPV6:2003:de:f746:1600:cb3:28a:2d4e:f26f]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id 26f4d103JN45z4v
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Apr 2024 01:04:05 +0200 (CEST)
Message-ID: <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de>
Date: Sat, 20 Apr 2024 01:04:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EBADF returned from close() by FUSE
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link>
 <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de>
 <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link>
 <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
 <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
 <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
 <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
 <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
 <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20-04-2024 00:47, Antonio SJ Musumeci wrote:
> On 4/19/24 17:04, The 8472 wrote:
>> I'm writing to a linux mailing list, am I not? And referring to linux-specific
>> manpages, not the POSIX ones. The way the linux kernel chooses to pass
>> what FUSE sends to userspace is under its control.
>>
>> I would like linux to adhere more closely to its own API contract or improve its
>> documentation.
> And you're talking about FUSE which is a cross platform (Linux, FreeBSD,
> MacOS, Windows) protocol. And that protocol defacto includes what
> happens when the FUSE server returns and error. If Linux suddenly
> changes what happens when the server returns an error it will affect
> everyone.

If it is the official position that the whims of FUSE servers have
primacy over current kernel API guarantees then please update
the documentation of all affected syscalls and relax those
guarantees, similar to the note on the write(2) manpage.


