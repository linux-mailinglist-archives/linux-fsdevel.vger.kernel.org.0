Return-Path: <linux-fsdevel+bounces-57008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17189B1DC76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AA3584520
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E052273816;
	Thu,  7 Aug 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ADGwjtsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0926656F;
	Thu,  7 Aug 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587771; cv=none; b=UHfXrmcwqlegIp2DgCyIgDUtHzlGLo+C0lj7eoiS42w3D2/UZN+VMNhA3ZZFdmir8jYFTwqxgg5ay8wh2AcuUQ3OGFicg5QaVGsForfARMJTRdU9PTbd9YhYbWTQa6m0TBZSGy+vwWWcewAxOmj0IzKWeDZBF2VerZ+IryBYImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587771; c=relaxed/simple;
	bh=abN7FWYJ9n4PnJ2nptn+IZxpX+R03aiCxX6Egw0HV/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTX2izW9wlPwDR2mKBFYSNU5/iylEgcbKKRAAL5WvJomoz4fQDuyIyURHU2H5HZMsqdoTQNIDdf+eZIgt3bTeUSh3r8NDt/6UTnr5P9hJlq14AT+LNWonzb/FYVOIphYuRzznbiftXkl2AEK34MOIbg4/WigcvjlA8NWsmoueXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ADGwjtsu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso8785155e9.0;
        Thu, 07 Aug 2025 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1754587768; x=1755192568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTAnsmMVInt84a0rRtuGfwHSes3MvNlMw3JuJDAgYBE=;
        b=ADGwjtsuZUXTsEJkIr0XMFXn697XbixVlQeVCcK+9AEVP8Dxn4uiRR2ywTcQLo1m2p
         3oPEEyyZXz5kD6LYBGgwsSnoc4E+9vW5Z5s167+dffwpAdBZVvMOxPVOYwXFjMQdMKRY
         K1mjiCJXGUWX9yC3YZN2LbGKNo9nqqwVJ4rirYZE4gTC9iQTpUUKmA2gU+c7uuav0YgZ
         bX4i5XXv27qhxbY/YkJ9mceynERAGFvUagTX5RG8PVK3iWxK5Y+rRx5VBvl2fco1f/vv
         dRhMWEPnE0dRmA5AKkXxugzXbsxsUckJB6YGw8ZhYMI0s3/tPWsZ1zkHicDB8DyddNis
         a8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587768; x=1755192568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTAnsmMVInt84a0rRtuGfwHSes3MvNlMw3JuJDAgYBE=;
        b=K3TuX5CGrkJ2ZB6oJgwmKhnpRiityYkjsTEv18OTA0crK7msZebtDLTPaJYCTqo3fX
         ROr1bcdXd/RyZPcpUNhTRb636qkjOvQQ+/cRaiLtNXH/DmEjauT7nD5+teV8ff05eana
         Cd44/znWefqVYFiL9szjKT75GtgUeyGoFvsQttxxciprBBjGhFqAXFBgInRsXzxT/wNO
         HkNjuyQ02vXAbhj+3Tlvr+Rxq3slYUsSJVF1zzTNFHyDVY07UReZZI0CXXHHFAGVpT6S
         6fHLvPL6SrZ78i3BWAWgVhPHkTKAVC53HF4xpfo5LSoi6cGLbOA6PG584rhDua9Q4aRA
         7laA==
X-Forwarded-Encrypted: i=1; AJvYcCWsEfTfvz8d4IjgdzvSJN7+9EDMSRmXV7fhNwBBO4+Xq1ydRxfPhnFYuFQIpS5f2UPbEfkmdY2LHj1ZFciB@vger.kernel.org, AJvYcCXBeo2Pry2UwLQleE1AlTCxhmi0DLkt/+C6w1hZJ9yrzLvGg1gED0htlS0DKWSYyS2Hf14ip2OXAweLHW6M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hQPpzg1eGdvINQOsLjUiGuInHsDXO2k9ro9QUwqNJ2ZoUDK0
	yFChJhecPgVCKO4Yhk2Mbb88darKI9BA1Yn6LPPXAUIEnwgJ85DCYmGqsQSk
X-Gm-Gg: ASbGncunSeqJqT2lbuSlq7JGl8B6STdETq58dPupYSNh7I62WDgrtoGalrW2BWK51S9
	10Cberctma2LJeAsvqrqUWEtJ9NCbVZmk/u8FEI8ptu9NVgnbCAaBoLatmfXQi1IN6KHZx1M8bw
	reSFS/gQotpUasIp1xGVWRekPv2FWnthkSvfqVuk+tUeObH+m5qRdShHrmBhZpayTPl1bzlVoZL
	8EX36MWcjypOOUQrKKP11Zh0YBHovKVElX9bFX4qLBccPbLbc0IE8tOgzUVKJ5ejmTnrbS1McHg
	wTubfmPFb6Kkp7K42jKC1+4ZR+Qyn88lWM/W7RyCXJecsWLU7+8ZX2lRn4KYJBrOfvjSP1H+fd7
	QgOdxKVdEwd5gFuwdbFoVY1zEYYzoWdHd39Ovj3tbiSNbfNjZkJcVUP0ha5e+4Eso4JKs63gepj
	Ea91R+AGc/ng==
X-Google-Smtp-Source: AGHT+IEZDOYe4svYBh9ff3iG1PbhdFbKmWz5B692/g0RwH4qLymUncJFaX3PG4EkLKGyTcwnURL7jA==
X-Received: by 2002:a05:600c:1e0f:b0:458:f70d:ebd7 with SMTP id 5b1f17b1804b1-459f43a7b2emr4617675e9.20.1754587768256;
        Thu, 07 Aug 2025 10:29:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd27.dip0.t-ipconnect.de. [91.42.205.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5873c43sm111753255e9.22.2025.08.07.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:29:27 -0700 (PDT)
Message-ID: <438041ff-b54a-457b-8a5e-04af81a3e358@googlemail.com>
Date: Thu, 7 Aug 2025 19:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.08.2025 um 23:19 schrieb Malte SchrÃ¶der:

> So, no merge yet? That really is a bummer. I was really hoping to
> finally be able to run mainline Linux again on my boxes (yes, I
> converted all of them to bcachefs early this year), now that pretty much
> all issues I was hitting are fixed by this merge request.
> 
> I mean, at the rate Kent's tree is stabilizing right now I am actually
> considering moving some productive systems over there. But those will
> need to run distro kernels. So, please merge, I don't want to jump
> through the hoops to run OpenZFS ...


I'm just a user, but please allow me to chime in with my 2 cts:

Linux is much better and more useful to more users WITH bcachefs included than it would be 
without it. Throwing it out or even only freezing it would hurt Linux users, only to 
please Linus' ego for a short amount of time. I don't think that's a good trade-off, and 
that certainly (IMHO) would be a very bad decision. Also, it would be a big violation of 
the promise to not break userspace. How could you possibly break userspace more than by 
needlessly throwing out a much needed filesystem that is in active use?

Of course, Kent has, to some extent, not quite adhered to the letter of the process, but 
as I see it, he did so only to show responsibility towards his users, and this is a good 
thing. We should wish for all developers and maintainers to have this much sense of 
responsibility. We need people who care, and not just bureaucratically follow a strict 
process that in this case was not designed to handle the criticality of the situation for 
the affected users.

Linus, long time ago, in a Google talk about (then new) SCM tool git, you said that a 
distributed workflow is all about respecting other people's decisions, even if sometimes 
you don't fully agree with them. Kent's pull request in the last cycle which is the source 
of this quarrel is one you could and should, in hindsight, have respected as Kent's 
responsible decision!


So Linus, may I humbly ask you to please merge!


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

