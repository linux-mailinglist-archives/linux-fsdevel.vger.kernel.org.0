Return-Path: <linux-fsdevel+bounces-22171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F7912FB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 23:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E85EB252B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72A17C234;
	Fri, 21 Jun 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chUzra0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DB208C4;
	Fri, 21 Jun 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719006250; cv=none; b=Hy5LbbgYxH/y+fK6V5vfX7E573EnFznaNBgbNc5fL3l72WPZqnHsOERZbGcyLqJJ9lGOyRaimSuXmzeD/ZotcBOn91PC8mIvXwvgbJ2KrgyeMYaX8O/dMN5yDvzVAldODEQ8HA681nuJN9QN33QpWEV/Nm3HYsm8n8HsxGLsyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719006250; c=relaxed/simple;
	bh=VUzDAAK6GFik0XBjGl6e9QRuf1214D2TxhMu4wYt0r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E606LZdV5c4OzRJWEN+Tg5+HCW7SpOtdOti82ELTvfvlCE5gcE3G72RYCRRz3VilbNYtLo78j47tPQnFvIBL9L6GzZTXwmUXfycDfzA15KY5MvlXONVyNo48KldTy+27l6yrAO4GgNv9nVJ/GG4X6OJKL8yVZFvEHp7IpNNjs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chUzra0E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso21165925ad.1;
        Fri, 21 Jun 2024 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719006248; x=1719611048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QUHHwAbdrLTUi0g/5VmqKnU7X9HO1Kx5UX3u51CGi8k=;
        b=chUzra0EOmkrBTnBQ7qAQtz9EwPTocysCGXsNNzMrwYZb/1QKW3EJc4FKSF1pDwhx8
         zGy6LwdWPn3MzzprH6m3g5Mqg6ydjLfDZ28jag6I+ZmXHGHiZL7VE3ue2QxF+xyay0oL
         aAhr3sFPROJFWZhGnGtKmbFZxV0MqYXgdjcxHo+2eBH4m95FH/5kiqELtzJqxoBzXSKh
         ILHl2ng260mgiBEIxVzQ+L4/N6d26+LyYFF5u6zFLg8JGsf7RasGLjM7I+3j+0wbDnnX
         WTp4B/9vx8keJ+cTS9msrWErYVpXpUx/DpM5dGMFjOEI5Ag8Y+EPqLHIKrU0ZQ1FZXX8
         Sb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719006248; x=1719611048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUHHwAbdrLTUi0g/5VmqKnU7X9HO1Kx5UX3u51CGi8k=;
        b=NnP46bC8NAqFnvh+abecSyn2hh/V6iaciI6ibWzM010BYdrqa3qVX0j8kv3HRsp6Hc
         LfnKdW7Ryg6e99o8ULdAKO8dS+sys/n4lMySJsDPbXEI2RIUDdfWDV9FLs33Hgpcj15l
         4yUT+MHrjPf11m88W7pZQtUEDrGhvSvjc2D751yRWAdnrRtQE2xdEhMi1dWiBhwlOxj5
         du9hK431oOtQylrD06N5lHwtqLS7oOplE8iqBNtAdA2OIeMDzo/eve1jptIycDTe01Wi
         mj3fVi+unaNVD1ewG+mexx0bMpf3iYNUMv3bd9xgaKwQyBa9IOtSandB3SUQnvTrZmI7
         JR4A==
X-Forwarded-Encrypted: i=1; AJvYcCV195rcj/aY3Lq7h225yOKMok9qK2nPxWyegscUfiCjdAGmRVd5SXuZWc5I/NU6caO/a6a5rWLnIsElJMxJdjBhGfWMLCSO+BaiXKvfvL52WPh6epFlJrYG0/zSw3JoHY7vjJMp1QZOdK6IVZ6eTFy26GWiaJNEWej+R1YT89K6rr8xayMBA2oot8W/Kw==
X-Gm-Message-State: AOJu0YwK7tWx51xYV+RyKQYuj3xqrq86okMqPlkG37uV/ySpvrNP7KHg
	4ipGkIndJgezGgNAiE049sFn444MM4m6T7YuYC3eWxtf1dV0ci9A
X-Google-Smtp-Source: AGHT+IEkPqGaSmAOoRmgWX7VTz3gHwh+ygyiQth7iBCxHdKkHeQfXgHqb/6lwVRZX2/cq6xT0cKHkg==
X-Received: by 2002:a17:902:d486:b0:1f6:f984:f759 with SMTP id d9443c01a7336-1f9aa40fa43mr109396265ad.15.1719006247858;
        Fri, 21 Jun 2024 14:44:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb321720sm18965715ad.84.2024.06.21.14.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:44:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <674c2009-4c55-421c-ba57-10463e00fd62@roeck-us.net>
Date: Fri, 21 Jun 2024 14:44:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] exec: Avoid pathological argc, envc, and bprm->p
 values
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexey Dobriyan <adobriyan@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20240621204729.it.434-kees@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240621204729.it.434-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 13:50, Kees Cook wrote:
> Hi,
> 
> This pair of patches replaces the last patch in this[1] series.
> 
> Perform bprm argument overflow checking but only do argmin checks for MMU
> systems. To avoid tripping over this again, argmin is explicitly defined
> only for CONFIG_MMU. Thank you to Guenter Roeck for finding this issue
> (again)!
> 

That does make me wonder: Is anyone but me testing, much less running,
the nommu code in the kernel ?

mps2-an385 trips over the same problem, and xtensa:nommu_kc705_defconfig
doesn't even build in linux-next right now (spoiler alert: I suspect that
the problem is caused by "kunit: test: Add vm_mmap() allocation resource
manager", but I did not have time to bisect it).

I am kind of tired keeping those tests alive, and I would not exactly
shed tears if nommu support would just be dropped entirely.

Guenter


