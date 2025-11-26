Return-Path: <linux-fsdevel+bounces-69916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E454EC8B968
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156E24E46C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02733EAE9;
	Wed, 26 Nov 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Z7yjlulZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D829E110;
	Wed, 26 Nov 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185657; cv=none; b=rieUZ5EaF2VROmwNaNWhp5Vy5D7Ro0xu3vQUQ2B+7/IWptLL6ytnlzILOuj3keMUuG8MABCiqDvvRr9RIBhkbZq3QSe5C6WcSLIQmkjAwmu2KLgBUlTEuaTSHnEqcv+pzYN4Snp7WS4/YyTJCeDK9SmYJNSZ8H1rSy9kODp6m9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185657; c=relaxed/simple;
	bh=4BhRuK2cARu4TaSlMSax5OLmo7OXC7gGZTBRKCsr5UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBl2628c6X/KrjhPuyjLRnrZHO8g373VS5JYkqQv8KcKGWyGkOYFSyd4Ej7XRfxl2DXxmGOBteLPZjHXYm8OXSu9K9BuDGpwOsVF/PC3unDdFDDvLaKFLUl5GWctBjlqJ1ojD0aKQyzjsO+cXcJ4/JSGZS1Iu56nhltdF+FPzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Z7yjlulZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764185647; x=1764790447; i=w_armin@gmx.de;
	bh=4BhRuK2cARu4TaSlMSax5OLmo7OXC7gGZTBRKCsr5UA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z7yjlulZ0yf7HdW5skEj8OBlRp96QlyYiiZRxZBdrY3jI3q3NLMTZiXVtvlRzSQH
	 Qm/j/HTSQ2MCFIi/va8TqWaL1Cnc/A5ulbZoYilcFY0ujcpDuzVXmek99ROSZRg81
	 K/cg24v+C6eEbNstfzvyC3mYCitYoqo/hfbyfPukE+ENxBN6n5sXtXHICkJE7F62Q
	 IrHRzwTxQYsa96VhNXpf2rsHo+a0swCSnNFeb+H4xoTj9+O3J4YdSFCES3c4bhlUJ
	 c5rNjOXz4Lhrdd3USNwVReuFi1AKOAOS4TsZC8Fw7V8j6T/JDFSGPnuQeVwzvIBH6
	 5uPrkmi4wt+JC+TKPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1vLLGO0rcp-00DxIE; Wed, 26
 Nov 2025 20:34:07 +0100
Message-ID: <e44182cb-cfb0-4e6a-bdf7-77ef87be530e@gmx.de>
Date: Wed, 26 Nov 2025 20:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] fs/nls: Fix utf16 to utf8 conversion
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, superm1@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20251111131125.3379-1-W_Armin@gmx.de>
 <20251111131125.3379-2-W_Armin@gmx.de> <aScaVgVAk_tH_v-w@black.igk.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aScaVgVAk_tH_v-w@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JaBFhwSGslcsZgffORrLjd+adsWNS+XNIcGKxjAKFnABB6mC1nn
 /Q4pJgxdnyhJThgZWhKDJwZ39cxI0KZvKPHcs6Qbaivw+EOmPBBwfjOUjq+ntQIKq7A/fPC
 Ln0MrUcjyMplFMLgv/lQVSZjjYzv42Ft0a47GUH6Bsv+rQIkJutJ3POsyOnmapnzi0ZX2RB
 ldXYNlhsoVOACMo9OCqIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sb08MsiXw8A=;CGhNMWuj0hqBgqyQS3xVX1manNp
 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

Am 26.11.25 um 16:18 schrieb Andy Shevchenko:

> On Tue, Nov 11, 2025 at 02:11:22PM +0100, Armin Wolf wrote:
>> Currently the function responsible for converting between utf16 and
>> utf8 strings will ignore any characters that cannot be converted. This
>> however also includes multi-byte characters that do not fit into the
>> provided string buffer.
>>
>> This can cause problems if such a multi-byte character is followed by
>> a single-byte character. In such a case the multi-byte character might
>> be ignored when the provided string buffer is too small, but the
>> single-byte character might fit and is thus still copied into the
>> resulting string.
>>
>> Fix this by stop filling the provided string buffer once a character
>> does not fit. In order to be able to do this extend utf32_to_utf8()
>> to return useful errno codes instead of -1.
> Can you also update utf8_to_utf32() to return meaningful error codes?
> Without that done we have inconsistent APIs.
>
Sure, i will send a separate patch for that.

Thanks,
Armin Wolf


