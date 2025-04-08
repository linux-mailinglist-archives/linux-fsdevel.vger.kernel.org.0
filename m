Return-Path: <linux-fsdevel+bounces-45978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D925A80440
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5821887F8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6B269B0E;
	Tue,  8 Apr 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic1LVhfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EB26B080;
	Tue,  8 Apr 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113609; cv=none; b=NqF/skm86sSJjrkavOpFLOOOIDcVAfirtqF5/BvT/RyWeLoMEBMXfnPfn1fjQO3njuANzW16Iby7371i9QSZEuu0qznJBvLmQB31bHA3O79Ckqmr5jbtL5k1codKHcYXjQSkSEWXPmr7BHebmH473TfcTJgwTrJeaZOlHtGyFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113609; c=relaxed/simple;
	bh=dUWKfjDqnRfQ8UmOMYbbmq/7pli/zMe8OAjslWmSiwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bagY4gIFb6OBrpl26vSYeMqzkFRhdeizIgzFoQEoeezuqk1gg5P287tesEByEuU/6D6zujuxv1vg1Yu9yiNBu9XRv5RXAImpkr63YhIcCM9ytbQndQ5Tpoa4wucuNK4cNm3/yjO2+OpcgAnffMhdjyxSP7439cUu5dVkyXcUHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic1LVhfK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so25032825e9.0;
        Tue, 08 Apr 2025 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744113606; x=1744718406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L4iQychx1uy7jgHj1WvD41sEY0IgZaWGgrNA0ppE3A=;
        b=Ic1LVhfKauWrhUhWCyzsOBkLRI/NwRSi+/RRy1ksEPZo1eT5VNm5Y96rBi9adE0Ip8
         WvRAOzQrZZEOd1vs6EOD3Vt8r0+hqNU1m16TqcCDGIzZKCY6Vu4Dy2xj8wle1GGOB4gJ
         1p2Ng0mKKUMiONJ1M4CwLwBV0FcZGmaRPZhH3pt7Bnkkh/QgwXi4SNtJS4j5ZYCimo+B
         VTmMt+EDvxpIDZnG85bBivCsAOhmNQ6PR2fSdRCxRDGJnesSvKoCV5rBoo1bNmyK1WCM
         PhSVSXLKDKRu8nN2OILyIDJxOZ3JcZbrG67dw4pER3Xl+DzMRsIZFbMLrrolgGx89Yid
         3L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113606; x=1744718406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L4iQychx1uy7jgHj1WvD41sEY0IgZaWGgrNA0ppE3A=;
        b=ZiqBMFP8t8IgsQYKp1x/BlbRNnNZ6Ir8zBBMn8se0UhRj7X6fTZxe1lAuqGBZFFcZu
         8hDIJ8OJJ31LBjnPZd64db9SmlnfdeI5F0UWxlsdgD+rQnZwOoeI62YfPmwUfNoNRtIq
         TP3RKavmB2gb9RcyZwckkuOrzdJKjUcTu2Iqri29OFKm79YL/GEEq+tiPXVR47zgkCEi
         A2gVKuOPh7kMskDx0SKufc4oXW3oXPF6+cPICjCkHpxYZJ2XHejs7sTChGmayv/PDH9B
         DRcwJps8XaNDBwj3zCbrRDoweUujngvOiujeDQgigRPwvVLtlSkPG4AboZ7SDzdnhuOh
         hG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4BhOURwsXuIyK8XjjzTrpSe0DOp5k50tafQYMUqZ5d8cEtauKlZsdHyOMR61mwIdGzlI6K+qhObNEy94n@vger.kernel.org, AJvYcCVcdrlZIIzusDaiBD2qYijaQbmgmmhoMGY8EzIyFanuNO58x21wsws+UUvKe6jGlh/Rb7OIr2k1@vger.kernel.org, AJvYcCWPW3Xa4l/sPav041lNUeqyDTOmp9jEeYB3uSMdOuvxMuNgazwMTYz4enimUQPv3/sN90Tjn9ZlUBVCWRcN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HHsje2/ghw/nut7G1Hftf/GOnwAWFzjmqwkrxcHSZURmlTxl
	7KTA08GjcicLJSr01vnI5kh1dTe/YJzTlB0oW83C4Z2scIZpei4o
X-Gm-Gg: ASbGnctl54rdYZSwUxmfxXQvOcDW3D3Hn1IkKCe76zOY5evuBzT2d2ez6/02J5pydcl
	nBixtfB5mj43y3OUpJFben1Q9jCBi6w05QjP5IT3RZhnHYJWC58q2Xba54DzR6C1/KsAUIOALcE
	A8CcLmNJGp3zf/nW54RDZdoSEFhZmBftvZbbJcT9RG9dGc4xDr/nCPyRCoOGk0w6JvD1LJlBLHa
	cJ8zvLrxQ5NdLVS+czxBmzNO9XTeMJKoxVhkSJVrW9p+EiIMn+4BxBmoSeWnnQBIZlovuFAHtKL
	zsj/Sa0mcZgv8mUSPuQ2z7FewIje+w6JfE2W73rlBLPstmWHpWYsaWwHRqN8Xo7YUq2ddQSDZUs
	UxVX6yX62Yg==
X-Google-Smtp-Source: AGHT+IFWUl6RnxQjdIwM81eDxBsClW9ge0wo/OtuxlY8w+xK//1FoFjcr6BLnTvk1k+o61j8H//cpQ==
X-Received: by 2002:a05:6000:1445:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-39cb35a6bd8mr13264113f8f.25.1744113605890;
        Tue, 08 Apr 2025 05:00:05 -0700 (PDT)
Received: from [192.168.0.33] (85.219.19.182.dyn.user.ono.com. [85.219.19.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301ba17csm14843955f8f.58.2025.04.08.05.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:00:05 -0700 (PDT)
Message-ID: <e678b85e-efc3-491b-8cfa-72d33d769d25@gmail.com>
Date: Tue, 8 Apr 2025 14:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
To: Greg KH <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, cve@kernel.org
Cc: Cengiz Can <cengiz.can@canonical.com>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
 dutyrok@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
 <2025040801-finalize-headlock-669d@gregkh>
Content-Language: en-US
From: Attila Szasz <szasza.contact@gmail.com>
In-Reply-To: <2025040801-finalize-headlock-669d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I’m not sure what you're doing with CVEs at the moment, but it doesn’t 
matter too much for me personally, though it can be a bit worrisome for 
others. Post-CRA, things will likely change again anyway.

Distros should probably consider guestmounting, as Richard suggested, or 
disabling the feature altogether once edge cases are worked out.

https://github.com/torvalds/linux/commit/25efb2ffdf991177e740b2f63e92b4ec7d310a92

Looking at other unpatched syzkaller reports and older commits, it seems 
plausible that the HFS+ driver was—and possibly still is—unstable in how 
it manipulates B-trees. One could potentially mount a valid, empty image 
and cause corruption through normal, unprivileged operations, leading to 
a memory corruption primitive that could root the box.

I’m not working on this right now, but it might be the case that 
syzkaller might uncover stuff similar to whatever was /*formerly 
referred to by*/ CVE-2025-0927. People tend to view these things as 
either abuse or contribution, depending on their sentiment toward 
information security, anyway.

Still, it might be worth keeping in mind for the distros and taking 
lessons from this to improve whatever implicit threat models the 
involved parties are working with.

Thanks for the fix upstream! It was probably a good call after all, all 
things considered.

On 4/8/25 10:03, Greg KH wrote:
> On Mon, Apr 07, 2025 at 12:59:18PM +0200, Christian Brauner wrote:
>> On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
>>> On 24-03-25 11:53:51, Greg KH wrote:
>>>> On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
>>>>> In the meantime, can we get this fix applied?
>>>> Please work with the filesystem maintainers to do so.
>>> Hello Christian, hello Alexander
>>>
>>> Can you help us with this?
>>>
>>> Thanks in advance!
>> Filesystem bugs due to corrupt images are not considered a CVE for any
>> filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
>> namespace. That includes delegated mounting.
> Thank you for the concise summary of this.  We (i.e. the kernel CVE
> team) will try to not assign CVEs going forward that can only be
> triggered in this way.
>
>> The blogpost is aware that the VFS maintainers don't accept CVEs like
>> this. Yet a CVE was still filed against the upstream kernel. IOW,
>> someone abused the fact that a distro chose to allow mounting arbitrary
>> filesystems including orphaned ones by unprivileged user as an argument
>> to gain a kernel CVE.
> Yes, Canonical abused their role as a CNA and created this CVE without
> going through the proper processes.  kernel.org is now in charge of this
> CVE, and:
>
>> Revoke that CVE against the upstream kernel. This is a CVE against a
>> distro. There's zero reason for us to hurry with any fix.
> I will go reject this now.
>
> Note, there might be some older CVEs that we have accidentally assigned
> that can only be triggered by hand-crafted filesystem images.  If anyone
> wants to dig through the 5000+ different ones we have, we will be glad
> to reject them as well.
>
> thanks,
>
> greg k-h

