Return-Path: <linux-fsdevel+bounces-8599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63378392BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9016429341A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BD5FEF3;
	Tue, 23 Jan 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIczFLLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803A5FDCC;
	Tue, 23 Jan 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023905; cv=none; b=uMGTkS/rmnceTwxKTZYSvWBwcQWTm7IQrK8vizQQ2KioddCOS8nP9Gyv61tahPoZgMRyg0ifPxUEVzT+mo+QYFTqI253RopITErcfmFGNKtuKvsdDVvLwexrlf0fI4Ta/a5hY7qb8Id3JNY0cF3Nk6BqgrmOYwBDcWsskMy96jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023905; c=relaxed/simple;
	bh=KDaoRV0eKV7wZbluaMRluVN/vPekXj0tkeALmiOmmgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbISaTwYHPZpR6IrdjG/nmge0nGaN29euQm5D2xn5w5bHju37QO9d1O22OX/ne7EdBk0CcGSuJPUzXnXtdU/0ytO8hZ0J50EPEeSujjfBJmkmta4oibY+QprbwQSmvzhFHMVoZDIioQtBfTsH3gVD8Gn1KpXSdZNIas0mrrG0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIczFLLD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7354ba334so24482615ad.1;
        Tue, 23 Jan 2024 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023903; x=1706628703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gVQYuY1wAsb0lZkdDLo7ZZwqO8C1mBLFz+bqzd2EPWU=;
        b=DIczFLLDT5lCISHZZM81NRkJch1CDPVDBu6qfgZ7m0i4sq99FRvipnbxYlOVRxl56k
         IvOf9CUpMb79uy6oXRD23+BNhmzEeEJIuup5+T8PxPjGUOZY6q8J6CT4khxL6DZ5cZ3X
         umw4Gi2GGjkiIS9/HIpkHJ3L7HW8X7+q0hl7tfu2OGEiTyaLp87DgzkEAQG0dDXwjM9t
         TLhoy2MUG8j/C1IehGYssLpt0I3y0764v1vl2wxSg+JFBYMhyxVab8JJNPdPCMkjsOwe
         l6DJb+h2Fj+jRqHDrbX4RcQihOI5Hl37xtll9np/F+YuhYrjBdOC98xr2tac0e+Ow/zm
         2HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023903; x=1706628703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVQYuY1wAsb0lZkdDLo7ZZwqO8C1mBLFz+bqzd2EPWU=;
        b=GQ0INk00tdjozFjvSIYxf5mASIh9hRaofC1Tv/AaKBW5Owv9ysoUCp51xAmRHYaOsh
         4chzpTJWzLB7QZ8KKIaOZH/Vqx5YGKp7JfMSsj5sfpH6iOfwY5Ml3Y+OWET9tVocHXM5
         9Ne+PI5a/ATgvi+ORYXYflvvjef43EjC8Jdxc5sf3nUP1pW0mxKvdkiYsBjAQbdp3CAm
         6N7aTaad2yUcTGamgwp7iRShe+ABMytP2wcXzFWs48SdyuGD5RRWWg6o/i2nNs2iA/Au
         KVqiYmwyOr5HFafmJ8PhAx3ZPuOYfsYmiyMnLod2F4qM4j3F72UZfjCVL9iVqkDn2ETO
         kGww==
X-Gm-Message-State: AOJu0YwBSyAB9vKhf40cPGPjJLVOwvWFIdum8bIPaQnxVG5tGiu3PQk6
	icDkmXi14qhLyxy1GKGa8UwvIpPu70m2dCw75n7z4BnbKR8T/e1e
X-Google-Smtp-Source: AGHT+IH4M3Di3WKbSkQ3C933j91CVk8PGOYnHYhEF3dzeKYP+s23xUhxWCkK2+1PnBqw/qwl4u3cUA==
X-Received: by 2002:a17:903:248:b0:1d4:e0e:fa1b with SMTP id j8-20020a170903024800b001d40e0efa1bmr8050423plh.57.1706023902809;
        Tue, 23 Jan 2024 07:31:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001d70ea12485sm8420465plb.209.2024.01.23.07.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:31:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8989437-f862-44e0-834f-8eded025ef5d@roeck-us.net>
Date: Tue, 23 Jan 2024 07:31:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: amir73il@gmail.com, arnd@arndb.de, christian@brauner.io,
 dhowells@redhat.com, fweimer@redhat.com, kzak@redhat.com,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
 linux-security-module@vger.kernel.org, mattlloydhouse@gmail.com,
 mszeredi@redhat.com, raven@themaw.net, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, inux-sh@vger.kernel.org
References: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
 <20240123141408.3756120-1-glaubitz@physik.fu-berlin.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240123141408.3756120-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 06:14, John Paul Adrian Glaubitz wrote:
> Hi Guenter,
> 
>> with this patch in the tree, all sh4 builds fail with ICE.
>>
>> during RTL pass: final
>> In file included from fs/namespace.c:11:
>> fs/namespace.c: In function '__se_sys_listmount':
>> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
>>
>> I tested with gcc 8.2, 11.3, 11.4, and 12.3. The compiler version
>> does not make a difference. Has anyone else seen the same problem ?
>> If so, any idea what to do about it ?
> 
> I'm not seeing any problems building the SH kernel except some -Werror=missing-prototypes warnings.
> 

The problem has been fixed thanks to some guidance from Linus. I did disable
CONFIG_WERROR for sh (and a few other architectures) because it now always
results in pointless build failures on test builds due to commit 0fcb70851fbf
("Makefile.extrawarn: turn on missing-prototypes globally").

> I'm using gcc 11.1 from here [1].
> 
> Adrian
> 
> PS: Please always CC linux-sh and the SH maintainers when reporting issues.
> 

When reporting anything in the linux kernel, it is always a tight rope between
copying too few or too many people or mailing lists. I have been scolded for both.
Replying to the original patch historically results in the fewest complaints,
so I think I'll stick to that.

Guenter


