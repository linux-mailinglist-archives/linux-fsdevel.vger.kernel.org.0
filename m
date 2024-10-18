Return-Path: <linux-fsdevel+bounces-32351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AB9A403A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5571F1C244AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA06202649;
	Fri, 18 Oct 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2AkFMk4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF5202650
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258898; cv=none; b=qjXELDtHC6z2tsBju7uwtT6GK90ixFD0KMHdNS4Bg8Z1wxsC2bzN0zf2AASqcsKXcoCSxPm7mOBFOwP/nm75e4+jF1m3r6puvPX8VO7svHWf/SuHX5LNK05PtF0sE2ojJY9maNDnejLw1cwcVMZQSpm08cfRUBCUNz1VpfBh/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258898; c=relaxed/simple;
	bh=kh5oD6A/6KbJFilOKOiK9/PajEa/k9LBfHKTJY9YqPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSWQK0ygzxPA0z1kr3CK1Ku1YmNMY+Xz/nDH9/+bKJDSbhhfM0ZW/YKNpexhTCDv/xiRAZbUEC1GE77+UGhOPyRljt31TAd8Mk1l0dWMJJXH7q4AvOK6dVPXQ3gUVOx8RwiC86lwDaymoCknc4wTOP6oBiBMwj7Hl5MUU+HW49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2AkFMk4m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e67d12d04so1614366b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729258896; x=1729863696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1VnLrCVNMejlDWuQ0DoAd9DQoJYLg29l4ybJKv1YpA=;
        b=2AkFMk4m5Ug+e2Ms8pjJir9IVANUVVyJLnI+ghfFL+hXBtnHRUFLuemfkclOjGLuqB
         cUMMMp3vpKvpPSsgxZ89sVpWYcID3kgiZ5OYsyKMReeZgbvGu1tU7Ozwghbevu1Omavr
         ibJxE5ikX+0J/5GOfWAEsaZVXcp1Xvv6BNufy7CKI/LpNgSvFrDIlM59zVgoZwJEp1Jy
         J2O7B1jEvO4zUj5CR1ggpkovsjbW/NWpAnm8AKvp5xDj3+q5euZnbSRATuu+uCcRDA0k
         jhTAKvq2izosVHso3xUJftPtFuc2fOHS7S9YHD80fIdheaaZBlJhcD3yIPFCPGOJ1ftm
         cYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258896; x=1729863696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1VnLrCVNMejlDWuQ0DoAd9DQoJYLg29l4ybJKv1YpA=;
        b=e+LA4u4LbuTEYaRlPzgs9EruWwPWmRE6Q6nPiRJVxpWW3fGpMUcIliv3R/UpYTGZQ0
         bXTYsK6YbreCyIzbJCtQeZ9/wkRNUBh8zZImGfnRstj9Sw0dEGLAob4L+Mh0CKYXOyxg
         YSo4CD6KKmTToWq/7FVfjdWo/Lb/k0j3zCS2i3DUg3xmyMdjzUDWxbAK7TUHfYA0MU3f
         zzmF9hhGOSf6A0EfjK7yIiOfwD5TJgT18oQl9KjLceiZnvFz1+Jwckhl8/w67VuL4+4d
         uxpRvjAZY/B1ljwvKmiGKnSBfx7FLcuqOU+nGdD1cWrY37YgXRyy9EVv7/8T3Fc8jpiL
         tmGA==
X-Forwarded-Encrypted: i=1; AJvYcCVj3px3GiHTemGw5bKau9YudIRayz+19wjjm/8cIKwVG1pMH/8CFiwkFIcdcGsD+w5RRyCsypkwUvco+QBi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bA2Xs1M/nJWefP4XzF8/7MLf6YF7R8mvDR1FpQdBG3oS8hN1
	Bb+EyyNfIZ30RCB2U4lggR5snQzG3i8McYLkiDMQLLOIWoIpTkabZvjRutzTgww=
X-Google-Smtp-Source: AGHT+IG1/mO3+HiIvU3+IE0QD88Z1xxPcN2N+LR7fjbokMxSsXIpqBDobU3fEylpeyFNFDelrHqPNg==
X-Received: by 2002:a05:6a00:2d8d:b0:71e:4cff:2654 with SMTP id d2e1a72fcca58-71ea31d289dmr3631082b3a.6.1729258896041;
        Fri, 18 Oct 2024 06:41:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3409928sm1420212b3a.113.2024.10.18.06.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 06:41:35 -0700 (PDT)
Message-ID: <9e42e6a2-f6ad-4fb5-af9b-72d0c7f6889b@kernel.dk>
Date: Fri, 18 Oct 2024 07:41:33 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/8] block atomic writes for xfs
To: John Garry <john.g.garry@oracle.com>, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
 martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, brauner@kernel.org,
 djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 dchinner@redhat.com, hch@lst.de
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <8107c05d-1222-4e47-bbcd-eba64e085669@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8107c05d-1222-4e47-bbcd-eba64e085669@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 3:29 AM, John Garry wrote:
> On 16/10/2024 11:03, John Garry wrote:
> 
> Hi Jens,
> 
> There are block changes in this series. I was going to ask Carlos to
> queue this work via the XFS tree, so can you let me know whether you
> have any issue with those (block) changes. There is a fix included,
> which I can manually backport to stable (if not autoselected).
> 
> Note that I still plan on sending a v10 for this series, to fix a
> small documentation issue which Darrick noticed.

To avoid conflicts, let's do a separate branch that we can both pull in.
I'll take a closer look and set that up once you post v10.

-- 
Jens Axboe

