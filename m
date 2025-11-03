Return-Path: <linux-fsdevel+bounces-66826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB2C2D063
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A077461F12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF483148C8;
	Mon,  3 Nov 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dFwaQpX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13E312825
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185596; cv=none; b=O20Pb0W/fmKLQ2LdMwlwW6nra6BZSsBedO/qqrJZ0KubiZ+0nVDc4DjcXd0R5D5YwW4IryzADRHIKj8146Zwtp/eBd4qfLrnFdY/H78YLR5+JC+Sql4RnMGUDX+/1oC7s2xoFE+oRdIfnp0tTfsQMa0nYx5wo7vl0OFVgrldtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185596; c=relaxed/simple;
	bh=OmMLchAeUeySgwhNaGcYu4r3ZEqXxE+MViOzf2cqMVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLVTWn4tNvcBiO0YFShHMgY5V1agi3kWgDfRk+1+CWUtR+j3Oq2b8z9rs88RsjeN5GH5Qev6TrpMbtMPV4xxalakd2dhtap0gIKAsCvQP1GddtXkUOgVJPOPymNzC6WOembbKNunJ9Yvzh80sufbBDM18scwDiCVOU8ybYWDms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dFwaQpX8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-945a33e0d55so194287239f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762185592; x=1762790392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KVTIa+dOzj0V3NHrOXqsCxCiYIvaXVpSTfeWllBoew=;
        b=dFwaQpX8EUQUc+4KUj8ARxBrY3doGCtQPfHhwn2rD5BPjToob3JDfD5cbzzZuVePTJ
         XzzrD7/n8Lx5eqCkFol0gvFAgnPsSbDHKUryKhoKzpKtXC/oTTM17LZZGW1HIWzC+pYV
         19WpkrYAY8VTY+fd5N8dvTodrGkoUnbLGVdtnVx4jifY50z/Azy0Kk4ezYCuMVFAQkCW
         Fqs8aFzD0o1wXWdwW6/wM9HpBbxkZ9y38iTCwxI+XmM0Uuva90WlsJIoPe39UK9egaLf
         MRx7iMo09Q2vkUNaY4U8DNJEtuHZdNHK1k+hyPK1aOSDCE1PiD43Rfzy+9M+mFzGZ1bT
         0PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185592; x=1762790392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KVTIa+dOzj0V3NHrOXqsCxCiYIvaXVpSTfeWllBoew=;
        b=RgqookfesbElg61OsHOdWJ2zjxrI9y6xHcBf+t+eAWOSPsyDo/GTBOeivwuLCG6/8N
         kQ3TNBMbwpZumZZMDHjWSeT68CapddFgzKk9Fnj4JwPX5DkRp19YcPSL89RiAOe02STw
         I+HhPvuhINgmxUZwwlBBuyfAU8UNl2TN+scuMwGljiUA49BQBaKtI/P31W7MI7uJxoZQ
         dcpXOG3GUCJ8mKM9ZWHnolf0+YU+xZedlz8TRIf6vuvaP3/jn2VXciwflK1y6PIAZdde
         gC214wF0VPIaPP9YYdOWtZYhUUkiMcaZDDhWzzLYPwxR+rswiE6Maz+UOok1oX3K9ncP
         Ldhw==
X-Forwarded-Encrypted: i=1; AJvYcCUfW+iosNrtLsR4gyTZ+Z3TcHvt9vBwSaT+yksKLsVPdtdiVL3FbRo8H1FJNPiewSF96i2Hq2fLs3ILUuvu@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCe950yeQkaYpK+VZZ6MhrFSa7PBL5rstAJ3OuSo53/hg1fGd
	1bbMDbTnYKnx99dYHJ903X7eIZwPTG29H3b0DiSyYEp1zUI2jbRvVNA3r9UQXfrKL7Q=
X-Gm-Gg: ASbGncu4k9xlISLNaiNkboZFMk39B9FYV3M+Nhskn9bQktDcX6jASCA5tb4xmta4UXQ
	5r6BhyxSWeMs4O95jk7tATe8qJQ9vkbXbTxEc3dsKT6XYzBqxIR3fHg1ncT0XpXxqo7sUyS5Hsj
	fGSXd3XdFRoozUgmO8/Jt5Zz3jybEwBow7IjPjMa5fGxUKyeI2E1CFwLvgEfvcqr0mrkQub4afU
	5nDhHiD0U8tqq6dBDyNzaO86ovdpUwgvWl2RZMvmZ0fg1I8xmqnEPl8sxxNqmWU47+Z/pgY5hlr
	4QMAjaRrLiDpY5itUrKf87NmRbuWnTQhSU6oXMG6pQJ2QAFk0Q1jaCua8coZEJh6N1G0B+SiuMI
	psX0b2N7KWo2q+a1A6hed1jhyMH2zeon6Dgevu7ptRNxd1D+KN6LFStuYh+K4R+g5AaHt/wTQpd
	QfPF+6kgM=
X-Google-Smtp-Source: AGHT+IHeXwTU86jvQEounNr5wea3NvcMebFpU966CMiAJWXRdJYK+Hd/OBHUo1KPbvA9CtwHSCTOvA==
X-Received: by 2002:a05:6602:48e:b0:938:9f22:ed34 with SMTP id ca18e2360f4ac-94822a37960mr1887920539f.16.1762185592385;
        Mon, 03 Nov 2025 07:59:52 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7225ad8a9sm290152173.15.2025.11.03.07.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:59:50 -0800 (PST)
Message-ID: <d7b57146-9703-461d-97d3-232cba3f8191@kernel.dk>
Date: Mon, 3 Nov 2025 08:59:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] creds: add {scoped_}with_kernel_creds()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 4:12 PM, Christian Brauner wrote:
> Hey,
> 
> A few months ago I did work to make override_creds()/revert_creds()
> completely reference count free - mostly for the sake of
> overlayfs but it has been beneficial to everyone using this.
> 
> In a recent pull request from Jens that introduced another round of
> override_creds()/revert_creds() for nbd Linus asked whether we could
> avoide the prepare_kernel_creds() calls that duplicate the kernel
> credentials and then drop them again later.
> 
> Yes, we can actually. We can use the guard infrastructure to completely
> avoid the allocation and then also to never expose the temporary
> variable to hold the kernel credentials anywhere in the callers.
> 
> So add with_kernel_creds() and scoped_with_kernel_creds() for this
> purpose. Also take the opportunity to fixup the scoped_class() macro I
> introduced two cycles ago.
> 
> I've put this into kernel-6.19.cred now. Linus, not sure if you're
> paying attention but if you want you can give this a final look.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       cleanup: fix scoped_class()
>       cred: add kernel_cred() helper
>       cred: make init_cred static
>       cred: add {scoped_}with_kernel_creds
>       firmware: don't copy kernel creds
>       nbd: don't copy kernel creds
>       target: don't copy kernel creds
>       unix: don't copy creds
> 
>  drivers/base/firmware_loader/main.c   | 59 +++++++++++++++--------------------
>  drivers/block/nbd.c                   | 17 ++--------
>  drivers/target/target_core_configfs.c | 14 ++-------
>  include/linux/cleanup.h               | 15 ++++-----
>  include/linux/cred.h                  | 18 +++++++++++
>  include/linux/init_task.h             |  1 -
>  init/init_task.c                      | 27 ++++++++++++++++
>  kernel/cred.c                         | 27 ----------------
>  net/unix/af_unix.c                    | 17 +++-------
>  security/keys/process_keys.c          |  2 +-
>  10 files changed, 87 insertions(+), 110 deletions(-)

Looks good to me, and love diffstats like that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

