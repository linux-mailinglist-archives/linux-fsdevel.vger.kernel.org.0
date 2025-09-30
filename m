Return-Path: <linux-fsdevel+bounces-63123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF381BAE713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 21:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4F1C1FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17828726B;
	Tue, 30 Sep 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPjRbwDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254292857CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260462; cv=none; b=s59KL+nXSWUarvbTVXXHLu52/LlR6aGG8/GROhDpvNMS2xUoj0pedCcXq7tuzDL6jUpykfupXpepzdQNFsE7I39R/0P1OCMMuY43ZOBX9+0rSwOFQPFEOJZ6gM9vC5BRJ5OHTnXV/o/OROwIvdfQkVUSkdoH/9hqir3ZaFW7s0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260462; c=relaxed/simple;
	bh=0kyHnmwQ/a13Xmqwsp8Z7wPblzDgblhkclYLzTai/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAt+3zgD1J7whtFWaOn6b0QGsx5OrSqPdiczVZL0TORzXvg73z4gmov6kIT/pFo2NkWFsBemXhcmHx4kbHPpLS216AB7oHV600N4VY8vrw0/qTJyw0jeg66YyOCKUR6bqB/1VTT8XElhd1UKkvA5CzhMZwUUs4PW/CXgy0vSYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UPjRbwDh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26e68904f0eso64652855ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759260459; x=1759865259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQxDxajR/Sam1KSYzGdudBRiapg5rl5sWBWoYDLBG+c=;
        b=UPjRbwDh6KxNGp15PjjdQQaYVL5h0zXwAw+E3mJDn9R6fg0YjiFnuTZQ7BB3eo9NgU
         D9L/hYBbYAn3YRQYAsU4qBouX5pQDZ54ODYvVl3kzCrY11XugqMXjSb7MZA8mUYUjkZC
         eHJxn1NYUDKXyHVhWrfwG8l0/E1KoCE4nrbG4w2zrMOdaptypRallQsLa8XVWkYc/1yk
         09NcSTePFbC0qBvdn35+jB+rLwAYkD7Ev2geG92iz462cHSLZRwKYDpADaS6NPOSvEYF
         27Oykzk2hAv+0PB3EgadHR3GCzEHOxqg6VYlJPQr5ud0QbMyIcPyNEyEGySJXKQYY+4c
         a4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759260459; x=1759865259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQxDxajR/Sam1KSYzGdudBRiapg5rl5sWBWoYDLBG+c=;
        b=sDA1dQ3VX2I+MldMWFpSchcWkqAyM6CiN/3hlqLyzy9jmWgb+F+HXTkvaUsicZcmPI
         GGSbBgezYnx5zIAPL5DeUtjMo5/1Hll2uRANQjKLgOYMOf2Tawe6rxXHgkIi3MWUtK16
         qFDcZ2McaRjG7dXNM+Brmu246Vc6uMcnkXndLfsS2xpJVJisBXREcPGsi+nTN9zfuL4y
         rw4aZHgSaK5wSLGimVd30uKA/5sMovAjdR4Ri0JqbXgy5UVxBH953Gmc1mHmF68YSSEC
         yduD6BUFhvmL2zi/hW59abSlbxEV/NmimY9ZgaHLv7Cl+osL20aS23pDyV40Y/ot2aAz
         DXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI3DEtpvWkDOfB+3EM9qGf8JYC3AcZD5RLmHpRG2avvWSYqoBkodV1N+jIboE16vsiVb1sdiOrVM0N+0zO@vger.kernel.org
X-Gm-Message-State: AOJu0YyMl/ln3fEIqn+4VF3JxK0onJHzO8nHCjpYSw0wbBkXGx5nhlqm
	J96mJRdj2X7Cuhz3Ng2fHEjMSPM3Nhx4M1RpH1znpHAoZuufwc5BTHQ4eDIKF+49PlsVi5jF0wr
	EiWcFFHPr5fnsTiJ21cffMLa2r5lZt8otnXPRPnJGWg==
X-Gm-Gg: ASbGncsMv3SB6DIXDIjpEatxtgksZHfJoT+qz9mw/W8lASF1W/8z5L2hk51I37lppDm
	5MISJzeKVV+qCEvWPj1yxQ+pFrT2lzYo4qnvBCzIdBf3JYSA3riH1U5vcD0JJ4jEQqJTE7my/pY
	j8iO9uuK8byovKW8krSlRrEIdk48UbEMwdsCpfFJfCsFbPfN/+z4SEbDhha+id8Co3CJ8+StJzJ
	5VpHV1GJtozqqJRqoAkf0jn07bg9XKYEU58THo0L72ccq/OhqkOmgDJP8ok/G7PoIP9Kf7BVI4U
	ZZbMaD24zK7N4rb9sqE0INYZvPghjKk=
X-Google-Smtp-Source: AGHT+IFaFh/dbgGIksQ/VwhgUOF+6SoIM70lxC8KuMuId9DIvXVuvWGEyxJOxgnRTVPkkVHSTJPrNd0WRWY/7Oxyd88=
X-Received: by 2002:a17:903:2f08:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-28e7f2a3ba2mr10180705ad.24.1759260459391; Tue, 30 Sep 2025
 12:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143822.939301999@linuxfoundation.org>
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 00:57:27 +0530
X-Gm-Features: AS18NWAq2VDGjJYBroUXlLCPyC3gOIxToosJNMH6IsWUcf3ow_eF-wBXPZYh-6E
Message-ID: <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-block <linux-block@vger.kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.245 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following LTP syscalls failed on stable-rc 5.10.
Noticed on both 5.10.243-rc1 and 5.10.245-rc1

First seen on 5.10.243-rc1.

 ltp-syscalls
  - fanotify13
  - fanotify14
  - fanotify15
  - fanotify16
  - fanotify21
  - landlock04
  - ioctl_ficlone02

Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
failed with exit code 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We are investigating and running bisections.

### Test log
tst_test.c:1888: TINFO: === Testing on vfat ===
tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
making filesystem (use -I to override)
tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1
HINT: You _MAY_ be missing kernel fixes:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c285a2f01d69
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc2473c90fca
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c45beebfde34a
Summary:
passed   72
failed   0
broken   1
skipped  0
warnings 0
<8>[  868.434017] <LAVA_SIGNAL_ENDTC fanotify13>

## Build logs
 * Test details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.244-123-g9abf794d1d5c/ltp-syscalls/fanotify13/
 * Test log:  https://qa-reports.linaro.org/api/testruns/30062041/log_file/

--
Linaro LKFT

