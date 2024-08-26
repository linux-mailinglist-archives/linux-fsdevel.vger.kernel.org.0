Return-Path: <linux-fsdevel+bounces-27073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B5D95E5FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 02:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6573128116E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D5139D;
	Mon, 26 Aug 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WM1G3Dvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A1623;
	Mon, 26 Aug 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631440; cv=none; b=n175UNmTHo7+As2grC7vTY0xIKSKeS7zXD1gpNor4NCDasZXU9dnPxIyc2twv5ogwk4JvB7dhSHTiEwpfbTOGHDGr8qAX8SBthlrwYXb3BHSc8gQ1i4KOiqWU8HlfUv+38VrZuGFrgYty2zFvqBJYKm0mBUT5Qv6qNmz3ZgFTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631440; c=relaxed/simple;
	bh=lRz0/Fvx1diucd4fbKQdcJLUSbUGkJTWzOiVsLEyqig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5WcVpj6eG7DNALQaAMYGOWBlj6UbUxso2aZD7pFfAkbTxTFZHfRWV9IcBUbylPIqI2gtgVrVUATLmifq2slIc/EtgJElIyizYhYKXz/aaBTSvEMJV+15ctrcFES/3oS8218OK317EiGBR5+BWj1Cvbn96LudMYRr47BoV90Br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WM1G3Dvb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FwvxtT60b9OTEs/qolqlJrRCGUKpIxxoKqbYPPagouU=; b=WM1G3DvbbGLXa7D3ivoBXq61rv
	AHrtB3x/P+k+AUO80bVkZkeQ5rDRnxSVbJRyZpaC8UyytM9+Lu+wB+MzJJQWl9gqP4Qw07fKBn9kh
	9/SOTw5upF/AdK2hg09gVsacYDfhK31LZ53lxT4eX5Ks7/JHOBCt7lum65tOC+E5rJ9nWJa1aAXDU
	pHXoWawveGFObWeqaOKZ1JOD5frujeyrwg9q3xh6qTfFURSYFfv5SydVLTfECZuif/JBlVlk71yhW
	B1OZ+g/DiMoYSLokacnLvAsSzPxeKlNJThsyfA9EQoMORawVEG7n4ld603fintIbclB0pW4t2+WCO
	M7avvxiQ==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1siNQ3-0053UG-Ky; Mon, 26 Aug 2024 02:17:15 +0200
Message-ID: <87bcaf5a-f5dd-fa0d-1936-665516cee100@igalia.com>
Date: Sun, 25 Aug 2024 21:17:09 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
References: <20240823180635.86163-1-gpiccoli@igalia.com>
 <6f303c9f-7180-45ef-961e-6f235ed57553@kernel.dk>
 <20240823184225.GA6082@frogsfrogsfrogs>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240823184225.GA6082@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2024 15:42, Darrick J. Wong wrote:
> [...]
>> Since we're nit picking...
>>
>> Control the ability to directly write [...]
>>
>> The directly may be a bit confusing ("does it mean O_DIRECT?"), so maybe
>> just
>>
>> Control the ability to write [...]
>>
>> would be better and more clear.
> 
> "Control the ability to open a block device for writing."
> 
> Since that's what it actually does, right?
> 
> --D
> 
>>> +			devices, i.e., allow / disallow writes that bypasses the
>>
>> Since we're nit picking, s/bypasses/bypass
>>

Thank you both! Just sent the V4

