Return-Path: <linux-fsdevel+bounces-36092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F89DB9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B735AB21C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9FE1B0F3C;
	Thu, 28 Nov 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXGSmblK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C1B6D00
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804475; cv=none; b=rZIe98B1Q9KMIQRz4Som/E64bgOC/O72QF2WX7P38Sc7iWIGDbW6Iju3y8FIZQZuNvhH1t472N+AsYc5bi50w8dtcXsd4XfBpJ1ZWwQjp8SKYZ1oxwuXfmwL0kUBkDZw8DsQOtWHajueqC7xzAR7YvYj/8dIWkMo3VK+jq7FT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804475; c=relaxed/simple;
	bh=7KPz62CoyCnubw//MjNY5rlBFMuli0IbAEVpxXA1+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIb+Hjmch+Oc2lzpKNdSIwhb92/g62T57kdgcVKpmMhgvI+jYIpjrvA62qoLQKV55xao31DUuVda8Yy/CHTWopPvrFPJOTvkhK1t5Y/Q2XitRddXcQ8uK0424z6XiAtRMdInQ/jKz9VcnfTS8HeBSIFTETAv8aK89hDH3z88yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXGSmblK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso1074039e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732804472; x=1733409272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tViyKVMgPcg6GKrNjnJrnuTDrCNWHcVIcxSbxGDL+Ig=;
        b=HXGSmblKcjEh5uO/9jXY7GauwyXSgGTriFMXauci6ZOUm+T2KF+otZFUIMvzmdBhB5
         E/OgVajrQPTGiyZvtmRPVNJfXTCHGFh1gHvcD3Q80jQqU90ZvwKpDb9rT3P5b+HwSJHZ
         jCH5viQf7ubH/lwg5iHCgu1NoBxwd2fcIKTHr4OmpBbOhjghQLny1lGZ7rsBMKeqlrJT
         XNfSnT1MEW/7RVCp1/H8bbAHvOvCHBjMMbheGpkr3JKodcd9VyoDvf2TryP998KRnLt1
         EBqfA1idgM3bMMDazgJeil0XTlneE6yaTL5xJ+HZZLzIdSREdLbCZJHiOPC38tQPYEgF
         6DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804472; x=1733409272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tViyKVMgPcg6GKrNjnJrnuTDrCNWHcVIcxSbxGDL+Ig=;
        b=vjlMV8TJawbFkrKjw+KTq6z12jf+G9yvylD0iAuLhBNvT1ZWU/yxRd6P3+NY2iT+BG
         jFGb/SBAb0GynrbekBYeS6akc4v/vDghdmhryIe0n2MMoiTmvKnW4lH6nDXuunlIa13g
         lnBumZAbKqqnvZkDYzsdX5WfNpnw4coWejaALkVAkPx2ZwLhuqcKyiXygNy7fnaljw8g
         ZHEVGv6x3yYTz5P2cgfZ0szLvi+nJpvKnooEaHIj8ptrOz7/wGvJ7OHUHiTokw6KjQvm
         o0V60VaO5CqbsQDTCym0jrfQU4gzHzkVs87hDdpGkz8BXMsjWZ8DHa5ofkgnj40O59Tb
         W5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUa1yF/laQwjhtjMjUl7VwtboKvHGbm/3KWsepCaDl2qcOaY8aNXKkJ99WAHPzvNesyt/ve3aN+TQJJkgLi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qWtqN6seZDyoXiOMGZvMH485Lr6KF3vGNI7kPLhUJ8suYwNW
	x5iViXMCu5fAXX+gWzc7S6jHKf4NP/PLnFXAjF2uCliqKj4gFlNP
X-Gm-Gg: ASbGncunQghpFHlyqSGnjwszug5zezZsq1aoyibIvegtd9mSt5sCazCJ7xhRfSWuTUN
	p1TZW0PDMXYsthsLo7G3Wof71TUVVRRTRGbVr8Vxs48DmTsDO399CTlLLVj7mMk2ysUaaGkFkBL
	RCMsvB9G9gyzKgBLaa6qwmNtrQHVfx7px/hE9OAxGknKogEhaY+mSHp02fpjNVpaa9WwrIMWkpR
	qziDWqq5bBTM1S2rVpNJ97pUpfor5Bg/TDZKkm0VpywbD5iBD19tFBF7r3xIueedQ==
X-Google-Smtp-Source: AGHT+IGRefjt2SUfOqoqmQF4tOFkT+zJoon7jIJI8bqW34Si7/pKXUeDJE9/RkWQ5+sni7ButMA5qg==
X-Received: by 2002:a05:6512:124f:b0:53d:ed2f:fab0 with SMTP id 2adb3069b0e04-53df00aa023mr4732879e87.9.1732804471578;
        Thu, 28 Nov 2024 06:34:31 -0800 (PST)
Received: from f (cst-prg-87-220.cust.vodafone.cz. [46.135.87.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599943614sm72421766b.175.2024.11.28.06.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:34:30 -0800 (PST)
Date: Thu, 28 Nov 2024 15:34:24 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
References: <20241128142532.465176-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128142532.465176-1-amir73il@gmail.com>

On Thu, Nov 28, 2024 at 03:25:32PM +0100, Amir Goldstein wrote:
> Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
> the legacy behavior of getting ETXTBSY on attempt to open and executable
> file for write while it is being executed.
> 
> This commit was reverted because an application that depends on this
> legacy behavior was broken by the change.
> 
> We need to allow HSM writing into executable files while executed to
> fill their content on-the-fly.
> 
> To that end, disable the ETXTBSY legacy behavior for files that are
> watched by pre-content events.
> 
> This change is not expected to cause regressions with existing systems
> which do not have any pre-content event listeners.
> 
> +
> +/*
> + * Do not prevent write to executable file when watched by pre-content events.
> + */
> +static inline int exe_file_deny_write_access(struct file *exe_file)
> +{
> +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> +		return 0;
> +	return deny_write_access(exe_file);
> +}
> +static inline void exe_file_allow_write_access(struct file *exe_file)
> +{
> +	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
> +		return;
> +	allow_write_access(exe_file);
> +}
> +

so this depends on FMODE_FSNOTIFY_HSM showing up on the file before any
of the above calls and staying there for its lifetime -- does that hold?

I think it would be less error prone down the road to maintain the
counters, except not return the error if HSM is on.

