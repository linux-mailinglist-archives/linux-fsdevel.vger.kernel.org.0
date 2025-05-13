Return-Path: <linux-fsdevel+bounces-48799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79322AB4A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9619E7C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF61DFD96;
	Tue, 13 May 2025 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnZ4g3PJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261901C8601;
	Tue, 13 May 2025 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747109610; cv=none; b=akqyr9MWUAOOhrB/lR5wYWb+eCmZ236odiYEai8xwKmgYuSbxRQ0KX0w0BUo5FuuQuFEPuA14Te3dXVymEzJf18VF3NS9XG5jegA3GaZomdkjPesrmQLoZjgCkwrIcinlCbHyb/OVCQ4uaW3jnw0UU3tfuTVM8kDJrJ/BglDXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747109610; c=relaxed/simple;
	bh=KHjKIBGHL4wjWHdIdm73DojxepCxwvz5ASk6vdDbV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0sgLnSP+V7qbxDofjd0n5yhEYi43DdVGEL7vtTP+c5v7SZipcvDKSIhUY/fVa2NRamCdIxKSe6VyKrSiy6EhBv5GUTR4m9+SzTqTXVP2S9nHgRGgOrTVVuT5h2IPw1jjNwDWb2aPr/lgcYQFRbNllGXxeWnthcnUa5FvgFavoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnZ4g3PJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1f7357b5b6so3246500a12.0;
        Mon, 12 May 2025 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747109608; x=1747714408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHjKIBGHL4wjWHdIdm73DojxepCxwvz5ASk6vdDbV9Y=;
        b=NnZ4g3PJOPcbpDNE+hgGo6SA9SDzNFa+qCwfHdePiITVVyk0KnO+mWKZaZkoefW0Zi
         8bo8GIC1949HEh33lOa1eC9lllZTRlD4yAn6t/tMhlhf2I2d6q3CF2AhMCrW+cTQqusQ
         pKOFq3pB2ov3ywuJ3V6aPSWS2CJ06KJEIGN0mpfTkPZY2aHUTGCg/Apz9JeJm+b8RX7d
         4VIQsuueaOhqiMRAaocUx+rTpLUtoh2iO3YaC3c3C5Ep96szNbCCIXcE/GBWkw6r5QWI
         RfWkokRg0MJP25N/SdXQhUvKUYw5Zf+3/7HHWSb4EiScbIMirB9CFiF3cdss18arRhD5
         PLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747109608; x=1747714408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHjKIBGHL4wjWHdIdm73DojxepCxwvz5ASk6vdDbV9Y=;
        b=KimE460u3dqi7eJERIvGM95EKEyHcs4hlsZd4+FwBn8dwvaHXgihGFaTp9I4yGcGJq
         6xHdZhq6iQRp6FDOcfLHH1Qpgu+SnA4GHsu+QJZl7cXXLvhkJMho3OQ+aDj6gXpbTqtq
         PDBLABFDUtgPyEgJZjzfyZre8/z/dcJ2yDP7/r/etZxrdoVFxJLOXA6k3CQCKnVxX9Ui
         BNV00nZoI5ew0FLXJZniWQx42CYqg4L6inwYyU4wn6qTQbhdY34TmwsgszANhsClkXRu
         g8WKLolaRLF5K2E5Gb12ymZxtYlNCOG8SGeYwUOkAd+n5FW70tWxyOHOzRFEWbSjSGnW
         v2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVMaplOWSWxwF/WURXEMnhUbJ0cKYifS7VeOjbfRm92ZohchRyiP0+/G/t08CSEbPG5w5J5Ywcp77H+SihY@vger.kernel.org, AJvYcCXR5rZhyFbQumTWkeoiMWOjmViCVltObBATWAsN8OAJ22Tq9d2g+/GaqHH8/+Z9JmdYAyObt3s7DSGhElU1@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRhcZ4ss6XWn2XzFOu085z389kClt9rKdEvFVoGpU2ob1WUDa
	DNV5rnRaoNngDhxSNz5tbn2/B0OdCYPJRA5A5GWlaNCgMUc2BbcW
X-Gm-Gg: ASbGncuRnrwee2U+OMn913V8cK49xi8MT8wMw5bYM8zQJUsew8hbuV13+jKSuga2fn+
	kTib1Ucj2nLUVvsI11ngaIR/T9XrFRvuQq3EAkJe3CDrLw/ytDlWEMC/KcgtD6rmWiX1qyeCayP
	htpFYd1GcSp/v1kxqQJbU2U191nNaTV1mrnw0pXZkW6kHqISXtwSkmG/a5ZMHgze65VplcEZz0k
	60Ds+xX3vjknihje+qd0DbIz+dFg1Wq71TqThScApSVDbOL6v72CGTJ6iHV/vipuiVC3wrNte93
	jdjt+oRdyfxoGlyj1o+ovufxptKWZVfjQIs5B0Zj5Em+AN2Gbf+6yB3ZtxzAAxnO0hPH2/e7pvY
	PRNRMXamnjw==
X-Google-Smtp-Source: AGHT+IF//IySUWtF5x77D5Y817BbS9vkvkGU6if72KKsO3a3004HV8sEsb3ehsXq7IQ9p9jDXcxGeQ==
X-Received: by 2002:a17:902:ce92:b0:223:47d9:1964 with SMTP id d9443c01a7336-22fc918e49bmr261778865ad.34.1747109608308;
        Mon, 12 May 2025 21:13:28 -0700 (PDT)
Received: from [192.168.0.123] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7549112sm71143995ad.38.2025.05.12.21.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 21:13:27 -0700 (PDT)
Message-ID: <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com>
Date: Tue, 13 May 2025 12:13:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
To: =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?=
 <ernesto.mnd.fernandez@gmail.com>, Yangtao Li <frank.li@vivo.com>
Cc: ethan@ethancedwards.com, asahi@lists.linux.dev, brauner@kernel.org,
 dan.carpenter@linaro.org, ernesto@corellium.com, gargaditya08@live.com,
 gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 sven@svenpeter.dev, tytso@mit.edu, viro@zeniv.linux.org.uk,
 willy@infradead.org, slava@dubeyko.com, glaubitz@physik.fu-berlin.de
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com> <20250512234024.GA19326@eaf>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250512234024.GA19326@eaf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Ernesto A. Fernández 於 2025/5/13 清晨7:40 寫道:
> Hi Yangtao,
>
> On Mon, May 12, 2025 at 04:11:22AM -0600, Yangtao Li wrote:
>> I'm interested in bringing apfs upstream to the community, and perhaps
>> slava and adrian too.
> Do you have any particular use case in mind here? I don't mind putting in
> the work to get the driver upstream, but I don't want to be fighting people
> to convince them that it's needed. I'm not even sure about it myself.

These are the use cases I can think of:


1. When running Linux on Apple Silicon Mac, accessing the xART APFS volume is required for enabling some SEP
functionalities.

2. When running Linux on iPhone, iPad, iPod touch, Apple TV (currently there are Apple A7-A11 SoC support in
upstream), resizing the main APFS volume is not feasible especially on A11 due to shenanigans with the encrypted
data volume. So the safe ish way to store a file system on the disk becomes a using linux-apfs-rw on a (possibly
fixed size) volume that only has one file and that file is used as a loopback device.

(do note that the main storage do not currently work upstream and I only have storage working on A11 downstream)

3. Obviously, accessing Mac files from Linux too, not sure how big of a use case that is but apparently it is
big enough for hfsplus to continue receive patches here and there.
>
> Ernesto
>
Nick Chan

