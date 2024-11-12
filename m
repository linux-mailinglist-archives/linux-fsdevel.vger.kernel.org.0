Return-Path: <linux-fsdevel+bounces-34370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026CE9C4BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD8B2A932
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D52209680;
	Tue, 12 Nov 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fk0xFeY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DB205E22
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375107; cv=none; b=GLpwzC+XI4bg/Y39YrRuYS3FO0GQIfgfsAjn27WwzUc68rBg0KjFeQjYHPXi5BzgWmMjAh39y9ELC9Bcf/i5Ah0NWkwwEB6H4fH+IAwRTQp86mZN64wJt79V8tz24NMCIEqyMAqB6CPNsfa58tnpGTNxSvLhO7aFMaqXwP5a/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375107; c=relaxed/simple;
	bh=IpmcEo62gy/fO5HtpCeApmyIz2PfIn6pOC2cdQ4GHCw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iGDqTZcXwcSwZ3ZMXN4wnFXnD3OkUdc6akMapW7Z3vMP1pVMnMVZmuvINlYp5NQL6NcpYmu7oK7B1AQmY7UBPRLFYw5F2iuSlNdA24sUG/Q7cvN4DzfEe5Q5c9WQQ+YCtJJiWJsp2GMhcUzN97cIyXaZnwqAsXr4CJ8vOcREbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fk0xFeY6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso4091064a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 17:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731375105; x=1731979905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=fk0xFeY6gtktU2cKAq0ApNA2Om+VG6icM8HW/NSp4HJFYfokmi1i6hDb4aiItvta1n
         7mcJFCXcJPADONGRaYrPW+jWrxeK+noSdnuKeEB50sbgKWo1sTi3umfD++jNuRrLL+GJ
         KtdktOSMUcMUpIVWkpDB3fVAWcU9RNvupqUK1M86Z8S0SGGIieqD7aveURpch2nnu8+Y
         tIIbLiONsjxrnhAIleWnTED3AcC+WuO3GCaB1lji8efZ2zC7832Y+etv7s9nWGsa4YcY
         nAV+Lrdo6vlH7hExClQhpCrOt50KS91yqjOwhoM96b1iHbGB+fwTmZhf9KMXz9EOtJcd
         fR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731375105; x=1731979905;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=Dorb6R8gNrD8+GjP+7nExQHDZYWvn+MzQri8u138yP4FeEXdZjAP7S0ffGEJVCmLli
         C53fz92q00tExByun2S4s/rYidLXYvWkOK0hbSFP+Sjh1/2C1wCzmmVkzVbdOc42MZuS
         LKFVL0pKje4AvK8t5c6hgt+hBcs0QGYkYwpYA64ONCO4jdVhEnAdO5fiRnAXkfNIINz5
         fYcosM1BDAo4AUP1TkBRFQ3zqfdbc0yM2+RXSDZmn4g+pp1cIUSQCLy80t3yIQPhQM5V
         daBRonbGlByYFooJw4U4fS79tO46b83sDRmAG+8599sWGFiaXfhWtMVcYT4Nr5xAD2fE
         MKcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd8b3oDDv67OVJdB1Kb7DBld4Gbl46D0dPiye/iKxOFa4Lj7rSuz+aG6l+Mv/huUFRu7VxtRTWR/R3vInb@vger.kernel.org
X-Gm-Message-State: AOJu0YymCokxBQ81g/LAvSOSduSQpsHoDqI17xTCMsHjNJxiE2mJ6nxK
	odW9iNhD+tFcwhfJfrleYj6i75QulddNlguvbDQ7QuAgRgFkyMpjWlXfCJxuiM0=
X-Google-Smtp-Source: AGHT+IGrJ7GoBrb8g7tX8vxgASw/4ctrZN1Qqxd0Yyhht39fAFMWQ6UdTE6G8NXshyU/lP4mJ98ijw==
X-Received: by 2002:a17:90b:5105:b0:2e2:d9f5:9cf7 with SMTP id 98e67ed59e1d1-2e9b17748f2mr18818948a91.26.1731375104857;
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd31esm11349139a91.40.2024.11.11.17.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Message-ID: <33396695-7668-404f-8908-17c5badd5920@kernel.dk>
Date: Mon, 11 Nov 2024 18:31:42 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v3 0/16] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 4:37 PM, Jens Axboe wrote:
> I ran this through xfstests, and it found some of the issue listed as
> fixed below. This posted version passes the whole generic suite of
> xfstests. The xfstests patch is here:

FWIW, the xfs grouping also ran to completion after that, some hours
later... At least from the "is it semi sane, at least?" perspective, the
answer should be yes.

-- 
Jens Axboe

