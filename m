Return-Path: <linux-fsdevel+bounces-58754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A75B31396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1021D20D69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6B2F1FC4;
	Fri, 22 Aug 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNFc+wEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F302F28ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855073; cv=none; b=RKkFcpVf5Tu03eRJClUjfkzJyvt9bCYR547+Hd8cwB2b8EVw8KJt9D/vOzr5duzLz+iozCo3e/D2qtgGKiQsLn+tS9wUGP+9koK/uRan1m30r5n6XgXanSCtITxo5nxt9P3fN9D9WfS7SOtTKq8PISNPN096HNSo9/M8JM/SEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855073; c=relaxed/simple;
	bh=0208ISyKu10cUE7W9YgFPUpUsfgz36ubVskvnrbBoYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JduARQ4nXHr7BPk/hojALQTnWvfb4K8xpf+HHJBS4VsuYM7EM/KwbFv81joQpn6l0MEjY+50Nkazp6aDF+5tAWcdzv+l3RNnIVswvOwEq327SFz9SriFkoE3VmcD8KLyCk9YPF0SMvZnaOE0ob9P4hda7LT/6PdL5Q2LgYxs+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNFc+wEr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9dc5c8ee7so1709161f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855065; x=1756459865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=rNFc+wEr/fsbRkz67OsdEajGw6jjOXw3VflRwkTLgv6k/n5SIIjfOwyTaphWDuM+5a
         lbdtpXzIZflwbqnFv5bj5dx2lsIukjcdAaGIjJsC9k0ItbHhD7qS1zgif+0ZOSZoG98d
         wTncx7mtA2GuuvmG3roiJW0/quoI0P66YeuS97CPAPkzYPyY/Mo/3tywcztd/dSDEUaK
         z5AbbP3gjmk2y3AjLLc+jJx+v8bYJOllxbgHGmZYAFZ/CJJUWpVXemUaktux5AVeqt1D
         HySCfOPBDVyj4hXf1F9ogBjKTsKZyOKzQAREk5ImrFS53hFpli/4MNLRyfZfdIQUbwGk
         kO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855065; x=1756459865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg8+uWPzi2Mjr9MpPBcmahRsPpi30DI4NUSUxz6VBQs=;
        b=wEYtJR+1V/lMU6RHYD0fYaV4RYwb6coME1WejAzRH/iTIuXzKbOJ72/8ipAFWwtEX8
         qPdzsGy7mk8mbWju4P5R/PehnLT8WYMv3oYrRyVkC3Mu/NWRBE8FuUDBgMv+su2+SiJ2
         5ZaAK5n64i0oE3c/tfspI6jCAuc7cmSKE8ufnjMe+/YzcebmFECj90toDGJ2OK8M55uX
         65wyHKSpnj78bdGkYqmq8mK8GkJM7KSrhiDZMrfQtiR7X9Vk6R3NXAbaoRJn5adrnlAs
         WJAuEt3fQF82jNGQpJZbYsr1Gdcf0aIFHOdzvaR5pViKEglcke3kBEwGmRZfy2Dw6Ugm
         cFqw==
X-Forwarded-Encrypted: i=1; AJvYcCU7oimxgnZtLb7yd87H6ix8QU8oU42yeRZ0Y5oxnZgO7dOfdZC5zK6dy4t0yBA4g0gklGRUTi6rAtYxZEmC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39spVPjrcgj3o50M8duKzUgfskGhl25YeOCzkPuB2cWWFVT19
	QGNe0Yy5S4TPZD/X7oNcNzP6G7e47BstSdFAuqMhmxMZ2mIp5DtqWSXI2D1WvwHKKog=
X-Gm-Gg: ASbGncv8gjfqW+Bie8CA07MxyQwhsahDkj5LuvEF69cnevUefUPzIPCq6h8I/8qqaGM
	vpHLTdV15vWMOOZxnSe68qxDdYUdBMzBW9tpuweFQlOU7/wFoVcaY4ZF2IIZRhURb+Y1aJLshDY
	k2zv1VnnkAL11pBNcrvxE/JN7DYq2WJmoyqgbULv4dr81xSE3zu8RnbgquUwvdiANamPp5r7TGu
	F/pm4DKSeRxkbYCElMcPkb5MTh+9Vesnf8iRvlazBP6DNbKdd3uX3B9j9FfT1NfK1legrAORFef
	PqxF49mGb0st2tA41rWLMSe+xMD7Ut5PWNGWuNohjWIl8M6zaJ02lrcaPjMo6ne0TEjXBcW2Yzb
	czjdGdJ4Z5DoC0NaBAXfs8lQEpTE=
X-Google-Smtp-Source: AGHT+IETQifX60xNpED57w605gzuRtVMT1h5myncjmf4CiJxMRcoa/HpI34Al4mQ3T46Kr36eWGX/Q==
X-Received: by 2002:a05:6000:18ad:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3c5dc6385e1mr1345579f8f.34.1755855065462;
        Fri, 22 Aug 2025 02:31:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c598e067b1sm3192314f8f.59.2025.08.22.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:31:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:31:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <aKg41GMffk9t1p56@stanley.mountain>
References: <20250819122844.483737955@linuxfoundation.org>
 <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 08:06:01PM +0530, Naresh Kamboju wrote:
> On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.16.2 release.
> > There are 564 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> As I have reported last week on 6.16.1-rc1 as regression is
> still noticed on 6.16.2-rc2.
> 
> WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334 start_this_handle
> 
> Full test log:
> ------------[ cut here ]------------
> [  153.965287] WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334
> start_this_handle+0x4df/0x500

The problem is that we only applied the last two patches in:
https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/

Naresh is on vacation until Monday, but he tested the patchset on
linux-next and it fixed the issues.  So we need to cherry-pick the
following commits.

1bfe6354e097 ext4: process folios writeback in bytes
f922c8c2461b ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
ded2d726a304 ext4: fix stale data if it bail out of the extents mapping loop
2bddafea3d0d ext4: refactor the block allocation process of ext4_page_mkwrite()
e2c4c49dee64 ext4: restart handle if credits are insufficient during allocating blocks
6b132759b0fe ext4: enhance tracepoints during the folios writeback
95ad8ee45cdb ext4: correct the reserved credits for extent conversion
bbbf150f3f85 ext4: reserved credits for one extent during the folio writeback
57661f28756c ext4: replace ext4_writepage_trans_blocks()

They all apply cleanly to 6.16.3-rc1.

regards,
dan carpenter



