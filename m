Return-Path: <linux-fsdevel+bounces-12440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC885F5DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962221F21D16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8283F9EA;
	Thu, 22 Feb 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP7baTmK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2103EA8A;
	Thu, 22 Feb 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598094; cv=none; b=F5X4v7Gnx+8vmv5993Fh+GmzUMBZ53HuTF8RbgB8lgsIAp4AMUJ0qwLGZ6H/0xr1LnFEkjxqV9agzc5F9RpOfh4hyQz0qck8boL3nwrs0c76TwJIhuvGSh3AZQzdVs5GzzdUTg5SNYpXDA7nZc12Mm8nfNbNO0pUCeBYIHEYxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598094; c=relaxed/simple;
	bh=pK7MNqtIrz6RTbAcX2/cQcOreinXFF3/D3zxvhKdKYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=httLVDjne3ZuptLqx0761ZpXVwCWhF9Jj+FnOEb8Vf8OiIAw4m7nuB2ASEpFKJ2+wHsU4Wu593cON0wn/cANgSK1IjYq9Z9CrdSsIwIFjoVi2RsChou5y6UH4Gm6DBz/UIYTxM4znQaADhhRCgbxjdxYaU8PosImoxaCMGzhOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP7baTmK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f4464c48dso194163666b.3;
        Thu, 22 Feb 2024 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708598091; x=1709202891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiyBBM0mU4YLjTJKqh7j2Jw2NZJ/FOZWi0wDjt2m9TE=;
        b=AP7baTmKVplC/mVW04emRjE52GO3jSUitN4q4nCuxEL5AJBgZ1hzcY4/vTYft+REay
         q05gTNhjkzFKFej9mCvpVWQVTwqcMKBIhc1ui5BEo9T3FotuhWaxd0LSmS6NbG/t/KlE
         BdaVsa+BKyPXcp3K5Pl2pRTR6l+Zp2wlGmck+lPqWeShCzIM0Sip6c4LIOmh/51XN6qI
         Jbj/mmnJBVEX1evkh2qhiPYqLVsdsRrix/8s9WxL288bAy8piNkS4pbtsltXORoJ+n9W
         oar4qGpYq8/Afllq+w8sGBZSXLnmYzE8stKBelT2HT8DyIXk9eQ9TQCJLJsfdbXVujP3
         2f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598091; x=1709202891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tiyBBM0mU4YLjTJKqh7j2Jw2NZJ/FOZWi0wDjt2m9TE=;
        b=HysrYOqGNj/3Tnt/VoRI3nMovI0YpK51beMv0Lby362dfsUoTsNrmZoKaJFWMrJz2Y
         a3e4/etoI0TYt0AkcwClbMvP3K/g5sgb+UfkndYPXStfg/4B4KiSATCGy1mji06k8Ijb
         9izHovG5GbFOuGzSxOkU/yTSlmUf04VthoKY2WvgZuJNFEkH4KiVO3ag3sndKdzLFfbW
         oZDiw6d/IKv9l0v73vWxk8icakVo9P7kmQS1QYu6glXHp+/H89AwEVz524o0eY07Z8NG
         XPH1duFvVEjUf8Zox49L1kZy802RtprvuYgQfpg43ZcjzSA9RyW/X7L9TozoSAgMyZTF
         /HiA==
X-Forwarded-Encrypted: i=1; AJvYcCXRDIdZ2DaJobH+Am2IjfxUw+eoxsfGh73/xATZkdiCVnciTmk5U90gDeBmuZAn0HPTzbShwFVxkSj5gzlrMMfG90f2hcGyisDClkOj4bDgkaKvq3616HozIUyNKpR/fMmN2RjJITfpDoRVwd0=
X-Gm-Message-State: AOJu0YyUNYonyF1NZaOoxux3wo/zngtqogBjVRcBpCN/dqbY2LoW62Hw
	Yu1VEUUSUvn5qflcEUxnpigYJMfiOCzLH2565n/nypP0wdfwSjAd
X-Google-Smtp-Source: AGHT+IHPC85/btk04ECK4SIGigjVVaNAiLY/8FmSKj226WC0hXlheI3qRWjnbrxzjADfrfHpPbTI2w==
X-Received: by 2002:a17:906:251b:b0:a3f:8968:78dd with SMTP id i27-20020a170906251b00b00a3f896878ddmr918286ejb.55.1708598091168;
        Thu, 22 Feb 2024 02:34:51 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id tz5-20020a170907c78500b00a3ce31d3ffdsm5850700ejc.93.2024.02.22.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:34:50 -0800 (PST)
Message-ID: <a0e19bdd-15b0-4b90-b27c-26ba52a72135@gmail.com>
Date: Thu, 22 Feb 2024 11:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can overlayfs follow mounts in lowerdir?
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Vivek Goyal <vgoyal@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-unionfs@vger.kernel.org, Luiz Angelo Daros de Luca
 <luizluca@gmail.com>, Enrico Mioso <mrkiko.rs@gmail.com>
References: <67bb0571-a6e0-44ea-9ab6-91c267d0642f@gmail.com>
 <20240222-verflachen-flutlicht-955cd64306f8@brauner>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240222-verflachen-flutlicht-955cd64306f8@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.02.2024 10:01, Christian Brauner wrote:
> On Thu, Feb 22, 2024 at 07:19:00AM +0100, Rafał Miłecki wrote:
>> Hi,
>>
>> I'm trying to use overlay to create temporary virtual root filesystem.
>> I need a copy of / with custom files on top of it.
>>
>> To achieve that I used a simple mount like this:
>> mount -t overlay overlay -o lowerdir=/,upperdir=/tmp/ov/upper,workdir=/tmp/ov/work /tmp/ov/virtual
>>
>> In /tmp/ov/virtual/ I can see my main filesystem and I can make temporary
>> changes to it. Almost perfect!
>>
>> The problem are mounts. I have some standard ones:
>> proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
>> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
>> tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)
>>
>> They are not visible in my virtual root:
>> # ls -l /tmp/ov/proc/
>> # ls -l /tmp/ov/sys/
>> # ls -l /tmp/ov/tmp/
>> (all empty)
>>
>> Would that be possible to make overlayfs follow such mounts in lowerdir?
> 
> No, this doesn't work:
> 
> * overlayfs does clone mounts recursively
> * procfs can't be used as a lower layer
> 
> So they would need to be bind-mounted on top of these locations.

Can I bind mount /tmp/ to my temporary virtual root and still make use
or overlay to don't touch underlaying system?

If I do:
mount -o bind /tmp /tmp/ov/virtual/tmp
then writing anything to /tmp/ov/virtual/tmp/ would affect original tmp.

