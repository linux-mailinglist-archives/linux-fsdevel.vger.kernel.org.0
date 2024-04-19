Return-Path: <linux-fsdevel+bounces-17321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C22C8AB715
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F61F21E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108813D24C;
	Fri, 19 Apr 2024 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="FMfBbKYL";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="8ijJUuK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333C12DD97
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564485; cv=pass; b=hnT9c6ReBKnFGCtKRwXg+tZ4PDf7aIEb/k8s9y1q02YgYiaGdEnvLWmCz8J75W0BThewDEOJYC2VYBl1RB8XY2CgAMB1Ifmtcw7GV8mmDsRnSuGChZdw9cKGIlp+ES7BVpWx8cFW6emvWK3cCYjAMPHzC0i/MMd2oTtDNXqcOcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564485; c=relaxed/simple;
	bh=DM4lLfehuwuouCO0CZatisr8tIvjeJGmKxoekcceDac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2ipI9SQ0ZEu5wQgzbRG1q/QrKZtPqKscNLfqJwlhONpFPhT4p2Z+Q+BZ88yKK9V4u1KXeoBvcHkNIMnBtL6LPrnTMO0zzlHf9I5lE+DiH0swLdOfmbT5vJ2ruabfxgo6alvoLflNBgnWD8VAooQU+ZZYP96mY1uX21sb8ylqns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=FMfBbKYL; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=8ijJUuK5; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713564291; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qCAZvwXTOE+inu+N/CqskpirNT462i52nFBEPRbFUgVi5nFaawYt9Zv+4wkTPUi4Vh
    3372/AN9IpoXnbu+5y8XMntjBNniKjALeFGsuoQjT309nWcAdlSq605fggYUpl7GGFxv
    mRDQHfRJsdDMVs0REvH6tO7S7H9On94FK0O6+s4clFySKnOKWdStCzuz7mjGWA1c8peO
    tFKhf4EfpuoqCxtyUhaNFnmWrpK8V9oSyKXg7IC3Ibj7OD8jcOkonew7v0AmZ5VbdGKT
    oFCF1LZ+BfJynsoK9150L2tr8WanTvhzzoTYshhZsgQawI8xjqrCTf8qxrT3pghg4s31
    Zd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713564291;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Ym4lIsOB5LTmfzCRZyoWOcaieX4jOk1ewS8qwVXJOo8=;
    b=a9fXf3MUMzvKFa4Da82lnqeLcMyG+GCvpIxTSVrjZtHXBhfrQGw5F3Wnqyhf4Jct8j
    4yP+jk93LMp6psLCERC7ufXaL5HttCmhLAHv+ggWODd82pgBMKqPTr8ETTtmIzQCmdRm
    Zqm+U0+Ou9pxWKrMRQszP5arxJu6/l3TscDFpNMrBkWrRerRHKjQ7aKDDszz37sRUxJE
    eYvCGSHPNaVQyeqZ6jfzXIZ/gjQOPieYpkgIrzYuDCc3sMGr57BYRsnaFEiH8NWcpfCT
    uvlq8R3h5tUH2+BBCBUzvP42uW4rBptKuVE5Y/vVHQaHuweL49MYJqtzjA90KsqdHAiN
    5XLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713564291;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Ym4lIsOB5LTmfzCRZyoWOcaieX4jOk1ewS8qwVXJOo8=;
    b=FMfBbKYLEcRL5XZ+L3Jl88xmhmdFW4LKe3Mj8lsJ8bTEVdNCoKQkew0j2gwfKty884
    O7CD+XEStcolKkeiRmJmY8105kjnZTgMLyYFA1o8ltVokvr0PwyMlRRPbaN++h4ZwVp0
    t6w+c8oTBFjQt9+NaDP1r75TAONB9gEprzMClW2bD/8wlQTSQlangydODD/SkoAfacJE
    DXQAjLgsrSHmSV5P/oXMCO7ofYTn4CKkIIJRNdKSa+AGStVfZlfcEqzQ8V6O527Nx7PN
    NRdDW7W6R9PtJVTHG70npFsxrIADaJABRNcJgvrozco6kBcsbLY7js6YFPbNu85HiM9R
    BD6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713564291;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Ym4lIsOB5LTmfzCRZyoWOcaieX4jOk1ewS8qwVXJOo8=;
    b=8ijJUuK5Fo55VRLuH2gaZyLpbLCC7T44VSl2RFeJBLNsnQIFq0qX8T389IGeq07g/L
    MW9kUDIkg8o7fPaurJCw==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkQW4xSV/VuPB8g/jrf+fgOZAiP5qKuiDjps0="
Received: from [IPV6:2003:de:f746:1600:cb3:28a:2d4e:f26f]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id 26f4d103JM4oz1F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Apr 2024 00:04:50 +0200 (CEST)
Message-ID: <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
Date: Sat, 20 Apr 2024 00:04:50 +0200
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
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19-04-2024 23:29, Antonio SJ Musumeci wrote:
>> Proper API documentation and stability guarantees are important
>> so we can write robust software against them.
>>
>> Note that write(2) documents
>>
>>       Other errors may occur, depending on the object connected to fd.
>>
>> close(2) has no such note.
> Your idea is laudable but not realistic. errnos are not even fully
> consistent across devices or filesystem. Yes, there are norms and some
> standards but they are not enforced by some central arbiter across all
> forms of *nix.

I'm writing to a linux mailing list, am I not? And referring to linux-specific
manpages, not the POSIX ones. The way the linux kernel chooses to pass
what FUSE sends to userspace is under its control.

I would like linux to adhere more closely to its own API contract or improve its
documentation.

>> That does not mean userspace should be exposed to the entirety
>> of the mess. And in my opinion EIO is better than EBADF because
>> the former "merely" indicates that something went wrong relating
>> to a particular file. EBADF indicates that the file descriptor
>> table of the process may have been corrupted.
> "should"... but it is exposed to it. *Most* software doesn't even
> attempt to handle errors intelligently and just return the error up the
> stack blindly. EIO is about as generic as can be and I've seen it used
> many times as the "catch all" error making it meaningless. Further
> incentivizing client software to behave as they do... not paying
> attention. I will again point out that I've seen EXDEV treated like any
> random other error several times in my career by important pieces of
> software made by major vendors.

That seems hardly relevant to this case here.

>> Will try. But the kernel should imo also do its part fulfilling its API
>> contract.
> Then you are barking up the wrong tree. This isn't an issue unique to
> FUSE. FUSE just makes it more obvious to you because anyone can write a
> FUSE server and return (almost) anything they want.

If other things can cause this too, then yes of course, a more general
solution would be fine too for my purposes.
Should I have written to another list? Or filed a report on bugzilla instead?

>> That it requires perhaps some thought to do it properly does not seem
>> sufficient to me to dismiss the request to provide a proper
>> abstraction boundary with reliable semantics that match its documentation.
> I simply don't see what you could do to "do it properly." I am trying to
> argue there is no such thing. And again it would require breaking every
> single FUSE server.

I don't understand what would be broken here. In a previous mail you agreed
that FUSE servers have no business sending EBADF and should have a
bug filed against them. If that's the case then sanitizing problematic cases
should be ok.

The libfuse documentation even notes that servers should not assume errors
from flush get delivered to userspace.


