Return-Path: <linux-fsdevel+bounces-9812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE584529F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D63A1F261C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E01158D9D;
	Thu,  1 Feb 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IGIvhzm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF6158D8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775839; cv=none; b=ZI1Z/94MXU4TlOr9xxm9ebDDpwSUGX0fmufXae7+8TI5hkfYFQiOHb4uTLPcGQtxZz8TNYDnRxs9zD0L1v5rtgbRbf8/J2/i58uRlEYwQPbiZFZLv6LwbTp6Fp7QZR/0Q6+3NdyeJDGK3Wk8wkkCacS+oqfwlSkXIn7WV3naNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775839; c=relaxed/simple;
	bh=dUMtkr8qKaifrH7Gk3MYoRUtYf4rG/FG8mYlXbIIck8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3SyeglT9yLrbY7g82VHbeyc/JqhFK/f9z8tvv2j5edIi233Efc1d0rPSAHcIQLuPScEDD+1I9UQIR1nQQhwnCkkwfTBWjIT7BiK059duSyzLzIChYvojV9rHp6vWdy5evi/HvZDK7VvXxEQnP9near6MdDt8ylG8eAYo3FyKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IGIvhzm1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so75879466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706775835; x=1707380635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSioIBr+5QXx6swWLeyhwTFF3UDD51st5fBW6mANAIU=;
        b=IGIvhzm1j7kbTPGY9ah4hTFofeolN+4jXS0KuAqhvgfP0Q1y9lffIwFKM7Uz1sqakP
         cjA54q1lXualmQAdsRJZedxzZL9nwvU+3tMlCIbTZLIep3aCFrHvFG3N0rtFsRJsCoV4
         Wjp3fZheIIGxqGNae+VGiVRIIWFBlVEEZINTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775835; x=1707380635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSioIBr+5QXx6swWLeyhwTFF3UDD51st5fBW6mANAIU=;
        b=rpDOvo1syNxjVmqKtikUM8vGjkQ8KuTfhoW7vQTZagxa9Z/5BvyqCEy6VHe/f7YuHg
         6o11izuTLncYm0lu1WMJw1VaFKpBxK7IsFQN4hkNZ9i+4ImhlOoJC98mcOafzctem+sr
         GVqcW7+K/kI/1zwGyhzOFPuWynUp7lUCeicklgc4GHU8ECciCSps6r+j4rkN34rfH3oV
         c8UOsx7f7K/sqE3ZdWfmFcvFP2FMsG6MZmY8kUQmMaQZ3n9PCILPinn2ico+V61YrlES
         zVpFNURkZcfHM+cybXbu1hF+ThIVGrXng1sILiVyjvszLlKWr3Ke7w4Oirht8gb7Zdso
         31yg==
X-Gm-Message-State: AOJu0YxCwPOWTlHZipYdEGZgQnvpdYgdtsKNK4WX0BFvxD/t8He0VOTc
	T1NSMzc+xQu5Ajj5epe9vxrP9ZzLgxX3BL7AF9lu6WNsgJxrAvgSAFYxyz8BierabwTJAio+co9
	+aGS8Uil05P6GCD/zDHeHiDN4gUxuFlXGMSrQiw==
X-Google-Smtp-Source: AGHT+IFVGV1xVwRgNOpwZp3Z/mFdV95YyBXvk+yIVnanaYeFhb0E6hv1gJdvfh0b/hudkj0Uymz5hr9OPqkiEYxC4zk=
X-Received: by 2002:a17:906:4556:b0:a2d:7fb5:fc83 with SMTP id
 s22-20020a170906455600b00a2d7fb5fc83mr3220107ejq.71.1706775835119; Thu, 01
 Feb 2024 00:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com> <VI1PR08MB3101A133BDF889B35F14D28882432@VI1PR08MB3101.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB3101A133BDF889B35F14D28882432@VI1PR08MB3101.eurprd08.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 09:23:43 +0100
Message-ID: <CAJfpegup8_Xm7rqbNgbxoZ0+5KnrJiiR05KLO3W4=mmQaRi+qg@mail.gmail.com>
Subject: Re: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
To: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Matthew Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones <Brandon.Jones@arm.com>, nd <nd@arm.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 09:01, Lukasz Okraszewski
<Lukasz.Okraszewski@arm.com> wrote:
>
> > So this is a FUSE_IOCTL/FS_IOC_GETFLAGS request for which the server
> > replies with EOVERFLOW.  This looks like a server issue, but it would
> > be good to see the logs and/or strace related to this particular
> > request.
> >
> > Thanks,
> > Miklos
>
> Thanks for having a look!
>
> I have attached the logs. I am running two lower dirs but I don't think it should matter.
> For clarify the steps were:

What kernel are you running?

uname -r

Thanks,
Miklos

