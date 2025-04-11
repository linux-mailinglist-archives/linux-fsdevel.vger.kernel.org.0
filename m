Return-Path: <linux-fsdevel+bounces-46279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FFA860C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1B4A8B2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8671F4606;
	Fri, 11 Apr 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CyHHiE6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E81F8BDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382276; cv=none; b=WPCNUkOuYfha0hMqHp+u/cU96SRNqGCkUEAlOmBRprSPO6GA4ZYqs2+Bviw7f+4VWwnZzyY/eqf/9WnPp7CKwEXgIKLumcUv2FsI+Pio8urX1bjdAZBnFeIu7F3sA/yeLDNJ7VoMkkc5hLaN2NOyDb84m7pl6UISg+xiZzE72hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382276; c=relaxed/simple;
	bh=2LERUFr/wQhDkFwYICYrlJcPEQbXMIMG1NYz4MJH+zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4aBw/i5vbdcIe/m0LyHHpP5kczFCg71g3koZNVAepgh5Cniri8p3ylOzkbp/ARVZEoMOHj4tAuRldJOzWgSNgDqnzQ69HcriQ3dGVDkuZmvBkuz6GNyF3QdqbO/na/Ws0lcOeQwQ04wNaGrYR5eTmP2vn8HqK7PVJ0p+cvYqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CyHHiE6/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so74494839f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744382273; x=1744987073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1eWCMTidsdTrjz4Yo+Jb0xH3fGdUIK64yZp6T6k7Tw=;
        b=CyHHiE6/TJyJZGmAZtseCOKNN3ypO2jx9TBUpiORWqVm1x2PgO8FaeLlFv2F7eGjAc
         ICtm98Svsj1+bp3z1GZ9MEhE/bDq53agGompGhCGyqm1lFqYON1NAcP/SsTU05adqELT
         onvJM5KMOduZDgPflZynQMtcbSzAEnHe76fqgi3Td5vONFyvOHfd1+7JcdeiiWD4a1Nd
         0YE/RL/tzuUBCHqlppNFbxgZcy0z5QlRwSC8NStqakJweQ8NNXaaRAlT8i9lgFRivV5K
         R3uLBfDksxA/MMaxv7vtCwz1ct84AqLXUoWhvUxwQFILc5ft0AI4y+SiokqzmudUOaWv
         uUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744382273; x=1744987073;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1eWCMTidsdTrjz4Yo+Jb0xH3fGdUIK64yZp6T6k7Tw=;
        b=OLibyxaL9VzhXU1/Jl85cRs6M7v+wFH2x40j1aBmaTE9dncIW3uUnYZuwl6Bev95Vl
         eL/IeF67KaZKT4vGlvhP0YgJn3NEYNrbrKOhBWPpcWawCWThICdM03f/lgmrsrukBjjE
         dFWyhgHXywAADvwIp8Hj6KVYS5r51mZI3CvJghZ39TbELahQ/UR7SOe+RLpkiz35MJ1B
         RtewEul/WxdGmP0f+Y+xb1hPbs/fGBXRUCxUHzoQRtS+zc+1FqMb4d5E9RXBfMPt4/Z7
         5+cU4V3em/z0865a0vijNcUXlEPE/KgzEr7Sd18vu+q8La+3P6Edi6ILVTYNVZARz03D
         hGuw==
X-Forwarded-Encrypted: i=1; AJvYcCXWKjI1XY+JZfCLcH3Qs6WT/gSI9o4ZUq6OwBNiaXIlP+cPtW4qKCIwOHv5iCn6/oi5kRjtq3KaMPaflO58@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wVK4IUynmsPrBe6HjLivbmbWfkik5iMwi/obXK2yXaHKzbrq
	wuEdG6DrZB4gMDbPMvvhgjqUOvCNTuqS59ZdIjP1dB0a+DQxt/VjHWYP0UVoam+aK68kZDrVH69
	P
X-Gm-Gg: ASbGncuxLzicFnKVUqBS+qunL2Sql6pFxQ+/m0d+Hwz2aTjCtP8M4DDKgS9Te0pJjpO
	t+alNVV4DYFp5ESJdgf1Ux+R2TNXaACz211NW4meQhbDVPkAo5lka4EnQdVsKhFW2wSHthNaCgG
	TnWpHL05e40SLVh20fh5GwII+HOGa152bFsCNlWZ0eL/2h2GrmRrdrFWf20tD8HQ6Rg/GyzqBsY
	7DKYttiOZP/TRDSlwg66KxqDsneHIA8MRJtxOXprDy5ghN/VmRenAwQ6UTKLWObSL9tyqEItPwI
	nRRaqzTGmPEPYKk3wKDNzd6NvidgH2WfZXqk
X-Google-Smtp-Source: AGHT+IF95Fx+kdzXvOEQIuN4oN7RmOOKwm5acciBtYGnI/O5+u9w/LJUzrtkBGQao587PgFtViqHCg==
X-Received: by 2002:a05:6e02:b2f:b0:3d5:d743:8089 with SMTP id e9e14a558f8ab-3d7ec1fd1fdmr31616045ab.7.1744382273155;
        Fri, 11 Apr 2025 07:37:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc591b9bsm12948295ab.60.2025.04.11.07.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 07:37:52 -0700 (PDT)
Message-ID: <87fcae79-674c-4eea-8e65-4763c6fced44@kernel.dk>
Date: Fri, 11 Apr 2025 08:37:51 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs: gate final fput task_work on PF_NO_TASKWORK
To: Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org
References: <20250409134057.198671-1-axboe@kernel.dk>
 <20250409134057.198671-2-axboe@kernel.dk>
 <20250411-teebeutel-begibt-7d9c0323954b@brauner>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250411-teebeutel-begibt-7d9c0323954b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 7:48 AM, Christian Brauner wrote:
> Seems fine. Although it has some potential for abuse. So maybe a
> VFS_WARN_ON_ONCE() that PF_NO_TASKWORK is only used with PF_KTHREAD
> would make sense.

Can certainly add that. You'd want that before the check for
in_interrupt and PF_NO_TASKWORK? Something ala

	/* PF_NO_TASKWORK should only be used with PF_KTHREAD */
	VFS_WARN_ON_ONCE((task->flags & PF_NO_TASKWORK) && !(task->flags & PF_KTHREAD));

?

> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks!

-- 
Jens Axboe

