Return-Path: <linux-fsdevel+bounces-64172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AEBDBDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 02:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03D204F4B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A92AE78;
	Wed, 15 Oct 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVdbzEPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0858645
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486732; cv=none; b=E0ylnGoBzWVzc1skLZO3FNe3OLznkoKB1Nzx/H0yQ9Bs+0LGOJ/MJi0lfAtvLrcYSlccpfhibsimu8bkM/zGFfvdgjlZF3vjwvkIq0FUsFnxEgGfp6BQPkzE498loP7qG6+hrKoGg9Yz3XQNiY7X7wv2HcOtIYHjNC3YuZ8CUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486732; c=relaxed/simple;
	bh=bhnzTueuY9Gq7RbeymuowpcCUw7aDx4IVKdkM/S0EJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz9+e6i+cqeSVs7ftfQdsfWmn/gy6Ul3InT1DCIKJ+o3tZWxmBrvClP7lAajs6dGMnH4VZoQJXNJQWHPVDJqk+SyojbyQTkS5Rrqxcrhd5e5QroYSJmW5LARBhTWgiEf67ER/n7hFuNiD6BOD9DjyoqQYp9L3rMLQ+5IT08kBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVdbzEPf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7841da939deso5332736b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760486730; x=1761091530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLMiaX+vGO2HaVidLde0Mqzeld2XbAlMOu6TCSUhVYg=;
        b=DVdbzEPfR8oPa8wp19Vt55fFpqpHac2QakEIjwKe+Q8Lh9lPo+k9e6du8vrsB5Btx+
         Zai7dz4U+wGfjMkzXHM+HFPDv0rd4D2S4a1vX/VDfay+eXiV0mVi0sj78vRtO4PQLqdB
         skiVzI7wwBqJ5f4CVVrI9NT2XhZM66X/cOYPXWp6R8+kzR89/eUABhZjklr3XFjvbiA9
         521F2LdCkhdmpmuRskSbSMTlveIeVf94kiMncJOnq3lhpkkmK3twiTIj5r1sMM+4ZwZS
         7/noZVrXEo5x6CcI69mrDqOxEOU/pxWmqIjhBF0Uf/R8XUVBObN2c2MTuYwgroFQZl53
         yN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486730; x=1761091530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLMiaX+vGO2HaVidLde0Mqzeld2XbAlMOu6TCSUhVYg=;
        b=v/mGW8FU3rL7dM/B8HWHibRc/bsqbUG2vTBXFO7C5FMHajstqTUHNqMs4YbicQAOlO
         tQJ+kQ/SlUxd1MHi+dyLrpamNWGeyCeNSKlKdPZRBLMF+TRFlF7YXXYVwR6aHWTtmhsX
         IY+gTYtZlNvIiMjNCUTt34dzcxB8/2/QaGIm4+4xyNM4TNYItHH1sUDWn8a8dG5Ppqfp
         dfebDjRYuLCpyt+z+UY17rt5tgwiNWsTsiJwuXr02i+US4xACRfw8Z53eB9MnFqsUYgF
         Qs2nnSUdwOzUVygoaC4pDX2+pnlITEly/cPgupMzowTVc2z09V2wjEq2QesvtaCRdlJa
         8LFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtfTsL05EndYDrsA4nJ9bD8LRJTAZoNYPFRDQJPPR15sVDg7bBODujZOgWmU8S0Rqd6+95tFkF5Lptjcpl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9EdfL/tfjx28JZeYVSShBhA2oJZ+ResEsnUdGX3bmRGOrygC
	zvCgDqA0XmAerwFNn0CmN2LsB1XR9v7sB6pdJ4P09w9m7OHW7sN9ysP7
X-Gm-Gg: ASbGncvhitxjyofuR6UqPrSan7+bPADkvKlnOfoKE4bRc6Zku+ub6vs8MQ6ylWIa7kW
	NUmxQWDSiVY6aWavphid5zbPbn11uXdgecuD0jPDrdb0CZo3eePAj5mcatE92glxEu3bWi0Ff3u
	caTsD2QVO4cydND/xccAw2vC3+YfJaOUdPh3jKgdgkcvzsplBmtWc9EM96yjU/spqBdY1j5PWSM
	9GQaA0SQhGUNXDt2QGFcgLDT0PzYXJlw9wDvWKzn4hrSwfhmpdG+ATUvUZYLD/k21lWjkyiwz+k
	yfFDVsywIs5CZoNjZD/ZiwpguPiwDVNcLhKR8fMdqW/aN6OeJuZ6s3zwLIyHtpvLpobu4XFOrEE
	WrCG96jxoBc2jENANZ0fJX5fVd7V7kpjUQvdc06vOn5RQPqhAylaR/M1fK6OUiwugZNyPqhI2Ys
	c6YqH6sR1daUGwVeTXwhJBSg==
X-Google-Smtp-Source: AGHT+IEmH0JRxtSGkPWZTbk0rg2sw6ciOa1Kwmx4Jh+5sWSakKPuSbl1aN4xzbqjjVDaexMRPuJucg==
X-Received: by 2002:a17:903:fa7:b0:275:f156:965c with SMTP id d9443c01a7336-2902741e441mr320016835ad.52.1760486730094;
        Tue, 14 Oct 2025 17:05:30 -0700 (PDT)
Received: from [10.130.1.37] ([118.200.221.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290766cc2a1sm42161035ad.95.2025.10.14.17.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 17:05:29 -0700 (PDT)
Message-ID: <0791edfb-6985-45d7-bb3e-08ab7a341dab@gmail.com>
Date: Wed, 15 Oct 2025 08:05:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, dsterba@suse.cz,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014182414.GD13776@twin.jikos.cz>
 <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15-Oct-25 5:08 AM, Qu Wenruo wrote:
> 
> 
> 在 2025/10/15 04:54, David Sterba 写道:
>> On Mon, Oct 13, 2025 at 10:57:06PM -0300, André Almeida wrote:
>>> Hi everyone,
>>>
>>> When using overlayfs with the mount option index=on, the first time a 
>>> directory is
>>> used as upper dir, overlayfs stores in a xattr "overlay.origin" the 
>>> UUID of the
>>> filesystem being used in the layers. If the upper dir is reused, 
>>> overlayfs
>>> refuses to mount for a different filesystem, by comparing the UUID 
>>> with what's
>>> stored at overlay.origin, and it fails with "failed to verify upper 
>>> root origin"
>>> on dmesg. Remounting with the very same fs is supported and works fine.
>>>
>>> However, btrfs mounts may have volatiles UUIDs. When mounting the 
>>> exact same
>>> disk image with btrfs, a random UUID is assigned for the following 
>>> disks each
>>> time they are mounted, stored at temp_fsid and used across the kernel 
>>> as the
>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() 
>>> however shows
>>> the original (and duplicated) UUID for all disks.
>>>
>>> This feature doesn't work well with overlayfs with index=on, as when 
>>> the image
>>> is mounted a second time, will get a different UUID and ovl will 
>>> refuse to
>>> mount, breaking the user expectation that using the same image should 
>>> work. A
>>> small script can be find in the end of this cover letter that 
>>> illustrates this.
>>>
>>> >From this, I can think of some options:
>>>
>>> - Use statfs() internally to always get the fsid, that is persistent. 
>>> The patch
>>> here illustrates that approach, but doesn't fully implement it.
>>> - Create a new sb op, called get_uuid() so the filesystem returns what's
>>> appropriated.
>>> - Have a workaround in ovl for btrfs.
>>> - Document this as unsupported, and userland needs to erase 
>>> overlay.origin each
>>> time it wants to remount.
>>> - If ovl detects that temp_fsid and index are being used at the same 
>>> time,
>>> refuses to mount.
>>>
>>> I'm not sure which one would be better here, so I would like to hear 
>>> some ideas
>>> on this.
>>
>> I haven't looked deeper if there's a workable solution, but the feature
>> combination should be refused. I don't think this will affect many
>> users.
>>
> 
> I believe the root problem is that we're not fully implementing the 
> proper handling just like other single-device fses.
> 
> We do not use on-disk flags which means at least one fsid is registered 
> into btrfs, thus we have to use different temp-fsid.
> 
> If fully single-device feature flag is properly implemented, we should 
> be able to return the same uuid without extra hacks thus solve the problem.

I had looked into this some time ago. Some libs, like libblkid,
don't handle multi-device filesystems or cloned devices with
temp FSIDs very well. I'm aware of it.

I've been making some progress on fixing those cases, but it's
a bit extensive since we first need enough test coverage,
and recent reappear-device inline with that.

Let's see how we can support use cases with identical devices
(where changing the UUID isn't an option) and keep things
compatible with systemd and library tools.


