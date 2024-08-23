Return-Path: <linux-fsdevel+bounces-26979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF1895D537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36DB1F215D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C38191F64;
	Fri, 23 Aug 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GfUlYxIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D81922F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437079; cv=none; b=ZzAFMwssISEvH8LFvwHl5bd2mpFOxzLGqaBvBP6iEhGMvxqzBe5YmL3w+g/m88SrKR+1sSsLkEkTuZdj0N926oDc+0VHySgqGamPAki0N1LwW9GdI12ZjJrekYKcOnG30AtdBFi066V9UKr+f+iaRCsisDYNWtUhjHiIPtMiz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437079; c=relaxed/simple;
	bh=us2rdXys21oFgrc3lIMa0w1LdWVH/OnjI7GaLqu0mi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKag1ekzlEFc2g4ePyTfxyRVCa2Xt9MTGrqdNDADISCx93BZt4uvFwcEMVYz2JBqsv9PyXSTwfOmtVrdYMRPxX6UJkU5asb/DQic2e1GfU+GucRg9DoPZR/6OpSS7WQ2xCoLD556nijaEEUqU4Wc7WwIzbkR60clB8PdGr/naoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GfUlYxIh; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81f8f0197abso111188339f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724437076; x=1725041876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L2UbMyeA6ZtpjTTf28qzgxKAoNSjMt5tsfvJ8hB874=;
        b=GfUlYxIhh/Nu/xAZbJn7bjXK45QogWB3VoLR+TZC+3pATI157oIPXO8X3vTwdJxnHL
         BmGfP+/t72P3wS6LqhmF/CwYlYMHr8dQFd21VuAy+G3vwbFEDPCH2HhugdSVh3ujiwIL
         YZzwdemqMNuONPNjwvmCnbAKS2GZkLCbKSmLKbIGy6GW2SL6jMgOfjzsBKFd8npRfhKv
         PzOXjb7H5oBvThdjJk9SLZgXOr0Y7dTujowLcl48jPu3grKS+ME7iU6um/f1jXd/nYEq
         +cdx1KQDBcEUbCookwApuOVBqlyB/owwidnlJwE0lMu+gssQP7IOBOf6H94BiesIL7S0
         Q8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437076; x=1725041876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L2UbMyeA6ZtpjTTf28qzgxKAoNSjMt5tsfvJ8hB874=;
        b=wigqufpnqIQMxRag4noXAgpnS8ZTHo+zvd0x7dCZcwHSPQ5tSaoKMeRf5VG4mf/BlN
         zGkd+qEl7zMyENfpsbdQ9BWXFquu+w2iRSaPwJPcg7w97FjuRzdqVo16G/jrxVwRkMJm
         2ZoGlZTuhd65PDOqn48tMq+eb6P8f14e+TEhIDJmz9Y6Gfgctvlu2OxkudOkH/nz94z6
         WVLDMMG06gJHMD9ilE5xLX9TNumWrJ1gH7N/+YjQhQ7HF2CWMXdGgSjDYfJqmQo9zjIu
         oInYYXwiQxEVsuz4lqW0EZjVADHMftpBMsHunuLtVkYiDJJQutCZCrI2Z6czgBHECjPD
         Qj6w==
X-Forwarded-Encrypted: i=1; AJvYcCURBQu2H0h7mQUqcOjxtPx2MMCOCq2XMvp/2fTPTVKwmiWszZJXWFFM15TB1Y0PPeePd0xOjqP1i35lVl82@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Dp/i1Excat0kucAceFdTu9yAyFnhm71dhqfLw8mtAcd6I+NI
	slbGQBhICJMnIT80EvO7e773TQpHCmD5L0Isnt+SE9RGQ5OJrlyKGKeDpAbn3dw=
X-Google-Smtp-Source: AGHT+IE/2G50xW++565D0QEbsbBjpVPhWGeJ2rBDoGBZkDXHAPhG03bCJzSak3QpcUe2p4QHftCocw==
X-Received: by 2002:a92:ca4c:0:b0:374:aa87:bcaa with SMTP id e9e14a558f8ab-39e3c98c6fcmr38850175ab.14.1724437076349;
        Fri, 23 Aug 2024 11:17:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f5c54dsm1036027173.55.2024.08.23.11.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 11:17:55 -0700 (PDT)
Message-ID: <6f303c9f-7180-45ef-961e-6f235ed57553@kernel.dk>
Date: Fri, 23 Aug 2024 12:17:54 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] Documentation: Document the kernel flag
 bdev_allow_write_mounted
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-doc@vger.kernel.org
Cc: corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Bart Van Assche <bvanassche@acm.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Jan Kara <jack@suse.cz>
References: <20240823180635.86163-1-gpiccoli@igalia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240823180635.86163-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/24 12:05 PM, Guilherme G. Piccoli wrote:
> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> 
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> V3: Dropped reference to page cache (thanks Bart!).
> 
> V2 link: https://lore.kernel.org/r/20240823142840.63234-1-gpiccoli@igalia.com
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..58b9455baf4a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -517,6 +517,18 @@
>  			Format: <io>,<irq>,<mode>
>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>  
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability of directly writing to mounted block

Since we're nit picking...

Control the ability to directly write [...]

The directly may be a bit confusing ("does it mean O_DIRECT?"), so maybe
just

Control the ability to write [...]

would be better and more clear.

> +			devices, i.e., allow / disallow writes that bypasses the

Since we're nit picking, s/bypasses/bypass

> +			FS. This was implemented as a means to prevent fuzzers
> +			from crashing the kernel by overwriting the metadata
> +			underneath a mounted FS without its awareness. This
> +			also prevents destructive formatting of mounted
> +			filesystems by naive storage tooling that don't use
> +			O_EXCL. Default is Y and can be changed through the
> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> +
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.

-- 
Jens Axboe


