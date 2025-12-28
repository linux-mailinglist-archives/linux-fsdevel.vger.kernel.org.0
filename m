Return-Path: <linux-fsdevel+bounces-72146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A2CE0364
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 01:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88EEC3026871
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Dec 2025 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2254262;
	Sun, 28 Dec 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngo8rijB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PguR7RVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F207F4FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Dec 2025 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881121; cv=none; b=BBBqswc5o+n4JMpglgDzG2/CkoT66Yb01T42IspI0STffK/1uh8inWZT+oD9PboumAduU2ljnzFurFYkpQ2fhb04r5Hp0gvvmrPvviRfCTEdMykyPhk7kqg+GgbNWJP2VehuwaExG43RBcdV8XIz7DYKGMQz6IncVsB79+DZaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881121; c=relaxed/simple;
	bh=mA4xZkh+IOnROo9dYqtZQB8RfI56qce5+TX4AgzD1wM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PfzxpRhKYwCG73wg3++Rv5LiOcJ1KIpP+UMczE6yuT4rnWzuGgI9Wjlh7LMLRcSdJ0gJKgcINfCOEHyRJkYtXTZk8Tf9GDddnZLWpQHQPABE9ormd1l3j1H2Qp8Vpxdq7rZLvFOfIiX7f0ujooRKoAKfy39u68ehTEpHLXONpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ngo8rijB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PguR7RVL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766881118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqR5WHFE7nfIedlDLTwqJJFi0bNQgjEyNOznlTwzMF8=;
	b=Ngo8rijBYCGsJgZgJaCz9qHSr60zJ7mQsZa/yxXzF/CYTvTK+RAzWjkuI4sPh7JhkQU90r
	IUpvJF4WxLinxQrvPSEMYJ/YIEjnYd4vmAjrTjPQyp5EW5Rnzv4oAa5MOWGwmVC/aw/vV4
	PXA7/7FQxuHb17H9ZhLzECg3qxn3dnY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-pe8G3W5JMPWyMxLlTCMszA-1; Sat, 27 Dec 2025 19:18:36 -0500
X-MC-Unique: pe8G3W5JMPWyMxLlTCMszA-1
X-Mimecast-MFC-AGG-ID: pe8G3W5JMPWyMxLlTCMszA_1766881116
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6ff3de05so225340591cf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766881116; x=1767485916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wqR5WHFE7nfIedlDLTwqJJFi0bNQgjEyNOznlTwzMF8=;
        b=PguR7RVLE5JckiN+14NI9GPZQ5Pjjf04DE8514XGXgd1zcZZsVm7QZTUNz8oypV8zg
         o9NHfcS8tHd+XKRZ9C7Ojxk1CiX6o42sPeGOYVSAAgRrFn+jkLDRCIuj/oAAFOL3IY57
         I1xZEcowhLLHMmGhx7pw+IbtDOPgtFhok4/K0J4dLk51BlAtvpjz6bmPkxfeI6tMRYBg
         3X8kW2ctg15yj9Cr5rDlIALHQpkmcHriMaCJQTlld3zkLTD+tGcAZUCaXssD5W5Sqt56
         r/PR848zXW/1W4r1KtjFi200D1bptsKSGjvnMS1+YuG7WJuH3AWcDApT4nlC9r6WJUOF
         IDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881116; x=1767485916;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqR5WHFE7nfIedlDLTwqJJFi0bNQgjEyNOznlTwzMF8=;
        b=cVMN/nC+COibCTutL5YeNjdWyXdS6ca/j1mfo91CfH7jlZSIYfGUeHS+9Xq0tpgPSc
         Dh5iUz/P1InjkZW0WABuvP8QjBxZ2I8k3Nac4wDDRq0WWVO9/i7hNhzw4VTzJPWOLnLO
         E93CbJshtTLj8aTn1HQTxjQrjWduubi6ldZ3krXUSvkm6JlYYEaiTO2MoOMLiLa7MWZI
         GpX0HCFEat81POneYYc8dV/MM5Ory0+hxcs3mr1YtYKAfNpRlebcaVwhn316iYAKKEG8
         lWIRW8Z035oD/JofoJLTzWUrPZOgm9nNwyzYJJbb3ubgH7j6/yuRWfQyoulBuwB68XsK
         9O8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTu4DFON6E1ujTQCAK6M5IBxpgTpJ3c7aTs8ngGHM2N5G71PGXWWicfwImwo8K1gZjEpRYMPOgGBHrQibG@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKtQK6356XiwA7OYLJd/qgqUAFFHqUMUiyS+ZTRMH64rUpq58
	AoiDehlj+MAmBpKMpv9/OvqUG1/6zw27ETKLRMGjI6C4M2W75rulwkYnUEgy17BR5wdCJ5aAaMX
	AAkT/A/DXRxCzYibIExv3EV40GS3w2HFwn2S1U/l5ywPfUWnQ1Hm274epc9ywXdAC7FQ=
X-Gm-Gg: AY/fxX7JSyu62GU3DlNXUnRZS+sFtVAPbG1JWSjQ4l9EISvz5OFQKzDWKna7zxfIpzM
	p7SyRy2Ymmoevbwrx8xpRV9PwGbCGPeVh3t0JiAUiAwT6l1RG50RRjRVPobqf2zBmNFZt09Bu1H
	C32V/on26jtJPSIMDEZ5j637UyS6VxJfSuHIKK9EsDsnmmnz20mUETT+I+I0UJbMRSZdT7hhqYl
	uiXxOTb1XuQo30tDYuz0cclLUFDze7uCtC+mVWx4OoMWQx/NMofyS70OurIRKRta1dsDTUY7D3i
	q8NP2CQHXkYws32mi6oB78ZZbF5jowIe/OIoeBN8fUghzFpI18yMWC91p3BpRkQAiAHYbfNT/oN
	KaPJr1hYIGpgHtHoVWtW1CY8CGlByhZ5VtZj0rSxSlB9b2P9iDvk=
X-Received: by 2002:ac8:6681:0:b0:4f6:fe06:6cf5 with SMTP id d75a77b69052e-4f81a80489emr7949631cf.28.1766881116252;
        Sat, 27 Dec 2025 16:18:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdcNz3k8Zcw6evwj0qQEpbP+CQXVPF3z7KIXIQn98bZQezQtwjFGuO/GyEM7uNUQswQYVdPw==
X-Received: by 2002:ac8:6681:0:b0:4f6:fe06:6cf5 with SMTP id d75a77b69052e-4f81a80489emr7949451cf.28.1766881115900;
        Sat, 27 Dec 2025 16:18:35 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac563f66sm186020801cf.15.2025.12.27.16.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 16:18:35 -0800 (PST)
Message-ID: <1db851cc-f1a8-4de6-a01e-37ec091094ce@redhat.com>
Date: Sat, 27 Dec 2025 18:18:34 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [fs] 51a146e059:
 BUG:kernel_hang_in_boot_stage
From: Eric Sandeen <sandeen@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202512230315.1717476b-lkp@intel.com>
 <fb920248-a0fc-432f-926f-c27b1760de58@redhat.com>
Content-Language: en-US
In-Reply-To: <fb920248-a0fc-432f-926f-c27b1760de58@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/25 2:01 PM, Eric Sandeen wrote:
> On 12/22/25 8:36 PM, kernel test robot wrote:
>>
>>
>> Hello,
>>
>>
>> we don't have enough knowledge to analyze the connection between the issue and
>> this change. just observed the issue is quite persistent on 51a146e059 and
>> clean on its parent.
> 
> Odd. Not much to go on, and I don't see any obvious connection either, but
> I'll see if i can reproduce.

I can more or less reproduce, I think, though I am not getting the hung task
warning.

Oddly if I just put the 

	struct dentry *(*mount) ...

member back in struct file_system_type it seems to resolve the problem.
Even if I give it a different symbol name (like mount_foo).

I'm confused.

-Eric


