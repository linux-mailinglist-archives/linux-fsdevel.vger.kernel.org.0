Return-Path: <linux-fsdevel+bounces-44114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AEA62A5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E747A3648
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC31F5843;
	Sat, 15 Mar 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJPX27IV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F1C84C9
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031712; cv=none; b=bXwQEU73H4+boMLF+UwEpHofxoW3hOdkbokZVNMXMCs/adG+bN/H0/55bFHvQUxM8F3V/DM7UpBXt1TP8LKUbEjh0VIwzKGYUt+RCwrjkPjIhtpPs5SgC6OBuFOQ5gv8Hb7xU0FQ/YvV2bAZvVAHxsN/r2ziolj2AZsgdrB1NdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031712; c=relaxed/simple;
	bh=6F4ZEjbDcZiLLIYSt3jmgj2GxNFjQ0Yxwp2I4wxrw9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjYkB4t+GhYBZWfjQuN22AgpbTEB24crsDALz6PINph3W3N3ByXXkVdddiQgkqNqOKXVYZyUuQhK6UQS3G6FXXwu5gVlZilWZN1XdtSpnal003p9e2ZAKsS5g8VvTuCEAgeLzFEJx/Zc1rPkvbBWv/zCkZjO588HUsgdd2bJ0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJPX27IV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1836125f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742031709; x=1742636509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzNAXBvMCkEVkeIQmxTZZJktEMMoSHZ3SJ4jiX/ukqc=;
        b=mJPX27IV+GefqvryDnkya5DcMWUIOKxMqhyylA3q6rBIZlMEsa2mVYxQMlgUCcZnNj
         81P0n87kgu9MwgwrSa3PBnHe+Go3r3MSqg6nRzHgm7722clkK0002mWdMzTsvWH+Y1P8
         qqZlqCGGyg2WaBgB69p8EzteAdvRpb5f7ejTnxnd80pgSEH4Ee2GF+m8I7rcGreB/IOI
         NkxLDKC8zNMgMWk05u0k9WygiFwmldhS4lxceQz/vNNvsjlQz2kSAgiMb0COkc4x+MOO
         m/tiUE6jcf1xl/vi3I9W3ZZT1AQ5MMFucks/Dxna0ZjfkvexyuyE5V5N4g2OanHBd60Q
         I0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742031709; x=1742636509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzNAXBvMCkEVkeIQmxTZZJktEMMoSHZ3SJ4jiX/ukqc=;
        b=I3kLd5PGYR6gZvZQGt5k+PTNMvIjUFzFL3GcNVzR8KPvObPJhG9PpRY6C4JXsKDiIj
         xwtrRzKsTHt9CMcAelFv6W56l/AAe3nN/Xf25CkFDf/vJQ8Kwbpk7So5oUhz2eAq8ofC
         OidhzJIAGbjNNNTjeeVj3uOBhj4DiwTNxHorLtbu9C7CrtvHtktGeaedTaAuVSisKrj3
         DkjdGt1jHd1bjqfkERXSDIf8t4kpY5nwpPBsXPxkrWB+6RWB647L2rk4JrPQRrHOZM8P
         Um3vsWx/koyqUwOoKrkV68HTsGFPU23cASNSsZkEc/CRKp6blRJ1HsTBh6fxj3Op6YyK
         QqWg==
X-Forwarded-Encrypted: i=1; AJvYcCWCSbDZNaV9FpjTCajtGAX0C5mE5FB/AWRYbiBU6F1zgO+9AXQtHKrFokyGFGhXAsq0HnQMmxr3dxwNRUjO@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD5IlXi7GFfZh5uP/QmSCT3/xe4toFxJvbuxEa+7MLJ9lJM4S
	iUmPYSKZuTm40c+cVd2TsBTAboADXZjMi5d5A8wZz3ZanH8zni6KQsK0LBS1GaE=
X-Gm-Gg: ASbGncu10zKw58dUWBvQ3lbHsNBEdJuKK/JslwFjM/+6N/hZvrqMlT5QfSnT79xAaxY
	kqd3akQKe6lpQMKNmQnuDW7ZXYE+8Ag2wJAbAxdvQInZBB9cPYZtRj0y3zdv2O+e08WNV/nX+lp
	tuApf+2htcafTMfiDpgF8Jb3bRE0vIVxU81c/s5/gA1bd21IwdHcvL+xY5i/aPt0T9SvDlcRMl4
	W/9rh3NQfQfy0IrFZ1kUCxgxp1V7+MocZl7k0JUwID7VWers7G0sN0ZPbB+GFH68NfqwKSTxEAe
	ejeaX8rw0z2R2f0D4QSGnYnw0+/Z+OQjLZIyPonB4hdGy85ULQ==
X-Google-Smtp-Source: AGHT+IFTBJSfFex7i2l1+nA+IaHmXgFH0CMrehfzJSLe3f4uOTcDt6OJFbpTBxUtCAJY/pAU7os+/A==
X-Received: by 2002:a05:6000:186b:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-3971ffb1eccmr6108911f8f.45.1742031708881;
        Sat, 15 Mar 2025 02:41:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318a3dsm8398500f8f.74.2025.03.15.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 02:41:48 -0700 (PDT)
Date: Sat, 15 Mar 2025 12:41:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu,
	ernesto.mnd.fernandez@gmail.com, sven@svenpeter.dev,
	ernesto@corellium.com, gargaditya08@live.com, willy@infradead.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RFC 1/8] staging: apfs: init lzfse compression library
 for APFS
Message-ID: <51af0391-4dcf-434b-8c10-8682ab4a6179@stanley.mountain>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <20250314-apfs-v1-1-ddfaa6836b5c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-apfs-v1-1-ddfaa6836b5c@ethancedwards.com>

On Fri, Mar 14, 2025 at 05:57:47PM -0400, Ethan Carter Edwards wrote:
> +static size_t lzfse_decode_buffer_with_scratch(uint8_t *__restrict dst_buffer,
> +                         size_t dst_size, const uint8_t *__restrict src_buffer,
> +                         size_t src_size, void *__restrict scratch_buffer) {
> +  int status;
> +  lzfse_decoder_state *s = (lzfse_decoder_state *)scratch_buffer;
> +  memset(s, 0x00, sizeof(*s));
> +
> +  // Initialize state
> +  s->src = src_buffer;
> +  s->src_begin = src_buffer;
> +  s->src_end = s->src + src_size;
> +  s->dst = dst_buffer;
> +  s->dst_begin = dst_buffer;
> +  s->dst_end = dst_buffer + dst_size;
> +
> +  // Decode
> +  status = lzfse_decode(s);
> +  if (status == LZFSE_STATUS_DST_FULL)
> +    return dst_size;
> +  if (status != LZFSE_STATUS_OK)
> +    return 0;                           // failed
> +  return (size_t)(s->dst - dst_buffer); // bytes written
> +}

You'd be better off doing a reformat of the white space before sending
the driver.  The really basic stuff.

regards,
dan carpenter


