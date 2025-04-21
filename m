Return-Path: <linux-fsdevel+bounces-46844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06BA9574F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F51896088
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61A19F127;
	Mon, 21 Apr 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BSGpcK1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB61F03FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267064; cv=none; b=CasHRVXRpeGpLV7AZAuPXVmmFTStCHBtIhDjbxpJIlJw2mSKwq60ogwUdH9P8KimgMkM3GAomgBoiXau0CnCUyTzIG3wTEKmyvbsywkcPKyBSyUTgW4AOrwlFigKpg89dCypC0G9jJFbdY5mnhaxi3neyPcjN8MF/+5TNFJ0JFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267064; c=relaxed/simple;
	bh=mxCB9SUZBeClGFXURnIsA1QlVo+SMxflm+QReL1PuJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klgRfgrgX8xU3+zDfgGG1n8MWlBnQi8oVhy9SG960aeouK0DNbbDCZ7NbwlJq+xFYM7hIJ7PJ1UgPoGsB06rvwJTlOPbA21FaMPweFn7gW9faxZVRG25ZoOXp1sRfgSs6NA0LoeDKEtEkVDUKVzQomWEIjuLk5y5fuIub1iMaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BSGpcK1E; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85d9a87660fso407640839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745267062; x=1745871862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5maUrh0KQzV6aymom/1/wBhMZfCX557JEuH/6UWgEI=;
        b=BSGpcK1E9kehKVWeS1u4FrvaxcbpR70yuBIt8ZKzz6wfAgr615mX+SiGvKb1JZTPNW
         pcMqoEudqnyrHyP1Izrcu4X220W5mjiXnrxBAlLI4FnHbWaadFYHKOKW6Hkl5gbBa+lW
         7V6Zo6cMa4jdKRiZGysOSlRfc2RFkt2oEbpDL84EuGDWKvEFasItc030PONi02fhAVcO
         +v1ly+9UXuz+fKh0TXN8PBAwAAoEk/6fxRuwbai8kuMMHJuOZ0njEtWBpUE+4LLJGBkW
         Vyh4MGJ1CJKqfEvKKPpGPzMuYk8r6TzKIHBXGBOuNOKys72mVlcCYNb47xq5HyMG+IHh
         dlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745267062; x=1745871862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5maUrh0KQzV6aymom/1/wBhMZfCX557JEuH/6UWgEI=;
        b=beDCXfQdXvIS6+nn5J+WRhUokV6m8TMFKnfr6byrmdmkdahX15YFIdb7UEft2Rln2c
         vsOBst8QOREdyq0uAgwQmnNdMlcEGGgKzh/dv7cD+UmU45YA0MxDfqMqgBp9jJwrqbgR
         FqAQ0ESB6Oo3HOjVLU7YeonX+37MqMhwcxVOx0xDlpQGNJV4ECAPWm8PDjWz7XqElbWx
         7ES0/RLXxYDaybDzNOhkLgmFMgvKXQZZwxXoIKW+s3eFaN9Vvf71RCWx10UJAxr7qaHH
         U7YKrq7VjZIVkh8taGAdbWTTH8DHrp3hVvDcmmuopxTdyGeuFRwodw/lBQMhINJ8dDOs
         I9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUHcMaPysTVMVYhOP7Yfe6ysX9acOV1QuThgLPoT6xMnU2iTRXQC/XArMVjySJ0HNpR4+06m5eLStvSILtK@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3Gky3dp8iil9SvSVGjmHLI4PLrPuQAfwxJWiP12HfRZbRgFL
	zRbRASunTlEYBYbXKA0B6pH0uOBabsthB0BNs8dbi6WqeyVZ9btIrtJAA965qZ0=
X-Gm-Gg: ASbGncv6/vVpsN82+dr3HZrA9+rwXH/MITXG677zVpXAG/PX1lksgeKgjLwrm8VeD2k
	6c9zVvmtmKeRREWVuiE06FtbXZORAICKkWu1IcI7a+Oc6dJA5X9CYXs7bILyvDXV832vRungJm5
	kbuyziLXmkkRvoe3EvzU22qa4Qf3wrkaJvYwbVTUH7prP1tI2wGfaUS5smc2ZMiD2S/40CbwKgA
	YWJHGGzvUrbDssdhlr3XORi6gh27slRXi0odQOY6GLGnSFXShO6U/mM453Y7oYSWuzsiibHqcvl
	MVP9JjjexZMe2fGmNkGJGbNmXJ7M79PUaEGEbT1xkTMM8Yg=
X-Google-Smtp-Source: AGHT+IHcj28bFOGSxDo4d9yAdQ8hZG+yV0Gef12wOsVNjjXhehkX2IN0lP6ew3bv1S7erAzJ8u78cw==
X-Received: by 2002:a05:6e02:1b08:b0:3d8:1f87:9431 with SMTP id e9e14a558f8ab-3d88edc33f1mr125756165ab.12.1745267062043;
        Mon, 21 Apr 2025 13:24:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a383345bsm1909134173.61.2025.04.21.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:24:21 -0700 (PDT)
Message-ID: <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Date: Mon, 21 Apr 2025 14:24:20 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
To: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org
Cc: hch@lst.de, shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 11:18 AM, Darrick J. Wong wrote:
> Hi all,
> 
> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> between set_blocksize and block device pagecache manipulation; the rest
> removes XFS' usage of set_blocksize since it's unnecessary.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.

block changes look good to me - I'll tentatively queue those up.

-- 
Jens Axboe


