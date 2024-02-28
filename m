Return-Path: <linux-fsdevel+bounces-13096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A986B2AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E0728B44D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2115AAAC;
	Wed, 28 Feb 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n5oKSiFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9B12E1DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132734; cv=none; b=RmpmjqjLPAMvnLaSdiC1L9G+BByjdquOtexEMR1bPB5Pujss2w/hWEkzSQf5Gl6SbZGjfoIZeLK7NzJe1XAZrhsxSaCXdxN0KF+0mjIgXViYcJYtVovKO1vbZ7VVwLkxEAM8Vpa1RNbkTon54sJF9fzMg0OAN/SjCIkVFQceMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132734; c=relaxed/simple;
	bh=u4CE5u6+ib0rR6s8f7lml+39r8enebA98MkrC57Wilw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+5+fziqGRleMmM1Iqjd1Z8Pr98U+tQZrAogSVmdQD+NhZ0H3ymbhtf+Y/wZLA0v8eLwzEgBbeNtTyPSs3qwdzAsmdHHaEKxqCUJMm1rVXNr3VVBKwQFZxSXJy44ObEDXxG1N6pfq9fRxr07whb5KpbQy9JIw8t6CFCEkgBoyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n5oKSiFV; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so54424339f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709132730; x=1709737530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2lErHt/RwxLzL9QypHevB3dyy79exc3J82aL7i8zcE=;
        b=n5oKSiFVMJbRRoYLqIXWu8KVN0B4gIzXyajgUeSdOBAlIqBzSOFe76Nh490JtNvAWa
         Nymv2+ZZ2D1sU+FwBcWDTiLKAr/4Z8GKEAc4cOtppGtjW41WYAIHgCe8Dd2krq1elD8J
         syeNynabhG4Ib3Z35pZSV9dgQbqXGDHYr3jQmyEzGErSwER+xRnCx0AzP4sjrQdhLUl+
         ku/lUKVNtHzk/aNE55RyTDh7z9+csLkAsbQRoRr1rKuCfF61bBCj/4cEERScheXaklTo
         0J3vueMhW8x8zJGAmxHsVvPIKsN6RJFli4dLxVe3rRqpCUAneN3J/tWUk19UpYWTS+B/
         O5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132730; x=1709737530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2lErHt/RwxLzL9QypHevB3dyy79exc3J82aL7i8zcE=;
        b=iIFti1wlpyRjmHmleKaIJmjfVZVm0SD0ix1Dwt02Sosc/oWkxBJgyC2soi1y2lbON2
         6iUfWw9PKj6GXlspj75q5wl8H0DNIe+huz8tzlNd+vzpWtEaxTg7yZVdIQylBpKXZ2Df
         mkyDqU2IMNYJuOH6p0T1e87r0WBw1auwPSnHDm4DMI8S597b4o6eIiHRjw6xfldHjsyy
         0iziRrlcpvRLgclnq7qcNIdg+svrIVCNbuDtgi36z3RuARpeIeMCbBUUdG0bU4w7V9Zr
         hnKh+oVAjw6+KSWMdXHktiRxusP3bIgaFMoewYCF3VdlzPERQ5ZqGfnshDLwXe4UDmNc
         oJnA==
X-Forwarded-Encrypted: i=1; AJvYcCVl9FGpyz2ZsV5q8R685YCK6M+r4ody24npqD57spU3zB7vzaobjoxS68Dv23otUcDzsckJWYqJ6YemTL96VeehM4SIa1O+MQDmTSTzfQ==
X-Gm-Message-State: AOJu0Yygmg7YTG1CguDlth3rs6vY/bTG5zMVTILsYGI+nDQbBFew8AD9
	teChJBbSRDMqCFnOHl5C9BQQby8QC9R5WfjlVE7XFZNisqUruNm5W4duIWel0+F0PB1cKrHoONH
	K
X-Google-Smtp-Source: AGHT+IEP6MKJldpg0B+LE4QUEpw9DZZvhya/UiGfgEjdPUnZfsO58gOJz9CBevTLve0x9ryZuY+wMw==
X-Received: by 2002:a05:6e02:1c43:b0:365:25a2:1896 with SMTP id d3-20020a056e021c4300b0036525a21896mr13204189ilg.0.1709132730553;
        Wed, 28 Feb 2024 07:05:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b006e506ff670fsm6944008pfn.147.2024.02.28.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:05:29 -0800 (PST)
Message-ID: <a422ee1e-a9c6-4b74-8dfe-174d0a2a54d1@kernel.dk>
Date: Wed, 28 Feb 2024 08:05:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org,
 Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
 <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
 <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
 <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/24 8:01 AM, Miklos Szeredi wrote:
> On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/28/24 4:28 AM, Amir Goldstein wrote:
> 
>>> Are fixed files visible to lsof?
>>
>> lsof won't show them, but you can read the fdinfo of the io_uring fd to
>> see them. Would probably be possible to make lsof find and show them
>> too, but haven't looked into that.
> 
> Okay, that approach could be used with fuse as well.  This isn't
> perfect, but we can think improving the interface for both.

Yeah agree, would be nice to either patch lsof to show them, or come up
with an alternative way to expose it so it just works.

>>> Do they get accounted in rlimit? of which user?
>>
>> The fixed file table is limited in size by RLIMIT_NOFILE by the user
>> that registers it.
> 
> That's different for fuse as the server wouldn't register the whole
> file table in one go.  The number of used slots could be limited by
> RLIMIT_NOFILE, I think.

A normal use cases is to register an empty table of that size, which
is just the table itself. And then the table gets filled out as direct
descriptors are opened (and closed, etc).

-- 
Jens Axboe



