Return-Path: <linux-fsdevel+bounces-63187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADC7BB0957
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7412A2A37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6A2FD1D6;
	Wed,  1 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1LKbfYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45192FC899
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327102; cv=none; b=DkYrSpewnDO9YmVnppvd0wc8MHjdMWEtsSVpT7lpxmEDPMSPgHccvHm2mqUAtLfti+zlZdXuTquaJuXI0qTH+aP6hr0WgSWK2/8NSqAyKi931LdjYS2AGaXt2aZyDFnIUXpjboEC06GBQpLWgfNLT78UO2oSC7EnVy4mXjUPEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327102; c=relaxed/simple;
	bh=AErz9DRE4zvoV1QAhCMy5Ce5EIwMk6a2u/GPbn+LmQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrXM99WYgK/78zOWbQV1FGINg1lGFR9AjBFffFq+NE3KVsmwdraR1aDTJHOiRGbpz469IhLGPORahbwsW5nT9A7mksG1k+Vq6xULgMDYhgPpskKfDTwUAMOmsnmVplFQ7IJAGocJQIP+I+MpzaErWuL7hLtFSTsxM39xeX5cDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1LKbfYf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so7445904b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759327099; x=1759931899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=K1LKbfYfUGXFWYvfX9kmYN4cWonxTWwRsQHoZ/jqJmu2PUT3AZ+tIn6EUVgftXh8tB
         4WXSJ2H2fGyw4k2cz5iknj4W9+t4WvIgkeQAZChB4l+giybjKfJDerXnTOpfPNbAglXC
         tj82md1n4DRn171jFJGeQs6jGmklWW4Rlg3Gy0dViy+sW44/D0J862hcZaf6X+V6ysu3
         /6e1ag5aAFU+CM4J3aewn6HBL74th60oJYAGw2MiR7R6jLXlkQE+UzN2Ptj9lcCX1JvD
         uc5cFR9Efhdo1E+n0KB9ZzUz9vPQ6CHBWFSUY4ttEqc7yeeEeEIHvmkVNPrh64/CGTNt
         z51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327099; x=1759931899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHICQ9kYf8w+w6O3p0zJJOxecrN+M89vOZ1OdrVwWEc=;
        b=nBVwTnTBPtRF1/RR69dlQhzELi229IRfRlwmST+hTTKtKL52tzj9YPqIIuXZuNpNfe
         X1DiW02zkpRLhYFjZQ3QSnjmW1WoFAqyCdlgxVabYQBbej95cBatV54Z0f2UXy/c5mn/
         yq4dIHOpwzT1EKYumX1gHs/7ejYIgSb4PP4WXg+3ZBm2lJNFVt5haK5Pwia5LMlh9+Th
         ovH4qywKW2qPYdTP43y4b0Or+uaG1KkZYkpZqjTEV7OE2si40rmY/+9C6LP+qCPK7aKd
         OyPJw0oJ2+Dr0u4UPxKWYJbogyb1etk+b3fVMBGGoZzLLFlV/hwpgkuHsOxzOnky5Gbv
         RVlg==
X-Forwarded-Encrypted: i=1; AJvYcCWYxaeXKWhqIn9/yXmU1OUsUV2nlgVVX/6EYFTur5aybNoVCKGOVoqE8iXvkGrrSnPCkH/1uDme5tyC18gZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVVd02+yK91X5Dkp67yuujDhhTkhwaoaGdk78XCavjdezL8dW
	BLW7d86nQDrFHzOQ7Kc3B8dYO6V/YAo5xWwRgiOhQ7NZBtphlutxZucI
X-Gm-Gg: ASbGncsnhf+gNHF1vgl6sT92LSb/x1/pAXZVCpVi7BYRWUwFoJA5qOdPBXQR6Sqv11f
	561q2bedxvIZ/xbH1T4lUG2jASFDqwmS9xUz0X5g7onT4rwAiBWWgz3ngSKzHk04tLvfRX4JSTF
	JZbE9J9hn6hZS+QUQzuYFiPn/NWrsYVEUPZ0m9Iu+a1sZfGWJHtDDFD4wvJc9H5tF7LE51OZhE8
	FaMjMg6M0dp0AJqIShmHQ9xHuuPnfe+dtrBxtH35g6x9fFkC+rz/a0pFIWDFQQ3ue/ululGj8us
	CuHD1Yxm7A/FR7SiKqKZRNgRAOtGkvLz16KnWqVG3NBOvMRjzqh2DcuT5ssi1yCMQ4FJ0KcbpyA
	XbZZfdEfRBbrcQNPV4YpwfSqk5S94x/WXbo/Tfat+hj4qH2GUEUAAURvn6ANfLs13JKQglQ==
X-Google-Smtp-Source: AGHT+IEVrUrSHnJxKWleti3ip/7ssnZbESbu792noCsfEcKl9fEdE1xbBALgSKgo50vIeSR68LO4xQ==
X-Received: by 2002:a17:90b:2249:b0:330:852e:2bcc with SMTP id 98e67ed59e1d1-339a6f38013mr4558738a91.21.1759327099110;
        Wed, 01 Oct 2025 06:58:19 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.95.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399be87425sm2129797a91.1.2025.10.01.06.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:58:18 -0700 (PDT)
Message-ID: <425ef7bd-011c-4b05-99fe-2b0e3313c3ce@gmail.com>
Date: Wed, 1 Oct 2025 19:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: doc: Fix typos
To: Carlos Maiolino <cem@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
 <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 17:32, Carlos Maiolino wrote:
> On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> Fix typos in doc comments
>>
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> 
> Perhaps would be better to split this into subsystem-specific patches?
> 
> This probably needs to be re-sent anyway as bcachefs was removed from
> mainline.
> 
I just did a google search and understood about frozen state of bcachefs
in linux kernel since 6.17 release onward. It is going to be maintained 
externally. 

Thanks for your comment. I will resend the patch excluding bcachefs.

Thanks.



