Return-Path: <linux-fsdevel+bounces-60135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC85B419AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC540178CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7522F0C64;
	Wed,  3 Sep 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ZN/Xai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E52750FB;
	Wed,  3 Sep 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890766; cv=none; b=U2CQ9PPwGej0X+3wyXA0ZLCLREJWo8szrM+201g/uKlzk0iU7XzrVBdNRM8aWsqEQ/d9VBqujXRVvdovtKIXBPoihQEEJ9m6tj3czjevFjSowFjzHXhKWdkwO7zfyUr+7xx8R5CC98VnyM5FF8A0zfZBwHcYeYV2/j1kG06YDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890766; c=relaxed/simple;
	bh=+glFduAWUwmDlkTPqNVlgdJlQ8XcOblvWP9ZWTbnSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C5xfIl03h+VPW8mqMUaPBKmDtj+a67SHjEklNxAEHOS/vT+yf3kKMaOozV253cu83q/lISwqq5Vy4P2V7YszlQpnYydFTWTgkei+fxv7AqO8bYJSoZxeLMNIt3xHOKb8EGxzDcxGYOxZPacNNOI1mdhUE34Fz6v+MDBp99YXzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/ZN/Xai; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so4093898e87.1;
        Wed, 03 Sep 2025 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756890763; x=1757495563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfWJvVu+lMxgUSVTziwE9HcaeMXDr9NnCCkw+M+7Z/s=;
        b=T/ZN/XaiTDDL7VodqViIBgf4SE7VfqbyMZ8iwhRrAR0wXAVmG5HnDIk52aUo16ZpGd
         vZbTujOzXdQ5nXop0xzBlZK6F1Y0HdBcCOcyCJrfzkPWG8ch9u8rKDMG2yu6bNp4ldOu
         HvBU/sm+2NsUZHHVg/I34AEuigjVWXs8lxQSdAR48nUD0msvK/5sYilNjDl6gj9l8vzh
         1s+GwMZhvmAuAdV38SII05dsbEv56AkFxwmInsiiyQN/pnznMY1A0TVEO+r6x3BrcD1K
         P7RQxpSBRWBKMytRRAyqI1em7Az71M/RfZN50U3D/u5lmHDdUV/T6aCDzWMDeIvBLas1
         NO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756890763; x=1757495563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfWJvVu+lMxgUSVTziwE9HcaeMXDr9NnCCkw+M+7Z/s=;
        b=a6jyOf9QSRWl1Az0S7n/bczgoce1TjJIDwyd1GTT9HvT+kZXxYJ00GsJbDsxllIHbD
         26QB5mc79AxaWTaJxQouGkbWa85bMhXFUvJp5cg2jbI1mX7kXVpxslQHKmhmADkS6ogP
         bs/j6mOy/ASUl/EMDfuKFT0Z2JKIKAVOXeSSEeF+upE0MCgP2LKvx7fYz2KsvIto76U/
         J3YxT4qpkLfQa4V6g6QLNuvj3T1wv6U6XdfwoYxCf2kgRblxSZD0WQou2Gv505xOFMQA
         EvzRwdvqlFrXAIPwrzaq89wBTmirrvnJclWCVcmP/hW42utHvhpchs6HvL7umqSFRcrW
         YO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVuGQFscFuXtO5aUvkempGfL9Y9/PHkN5g4t1vNhFjeN7OthQiaE33iFceOygxWzo021DPgNNOiv/ICUciv@vger.kernel.org, AJvYcCWqZL7JNuccAhI4Ri0PsO9Gwc4UXZRYwOQponPbMaMGqWKA0O+4oWFqZUvb6QV3hD5HfKUc/f3Gpy0MhPH4@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEEDOqd6xg7ZEMZdhlytLWpkeJPyV656pxGFlt6LFuPkvxwCf
	UeY+4q3R0zKc/rFDjYlepT+vZ4NfnToGjlL5qGa+ZwoPwuMHXuSGY64mt6XB
X-Gm-Gg: ASbGncvrJJdwnbiJ437An7EGRTegcYEwpZ/Y7i5PB+4pj0hpADKAxdH/OwLjVZix/+v
	LwkS8cLigDqqvM2n4HwJnKLUkNDX3mXaZMtta05bdfoSHa5O1xqNtAv0EWhgcSTXcwo5Nr9666w
	j44Z70eidseH4CSUTCj90jQb+EFIDKIE8YSjURi/GddB7cJW1lb9o7gav3TeP29x+goeOLsUm6c
	iDM61L3nUNef/ZyiuhGLVPZD8DdZuSh95UESxdjoNdV6JRlo5eezK9uWZM4NJw6G54p67ZWFB5x
	68D00oEwuDixUk8Ghxci7Jw49P8EASoT+SKPJx7N6QZrUMbKdJOMLB1kkCkP41VOz8c5GHQaWi6
	RRYbUAxbkMQ8LJieXThPJ
X-Google-Smtp-Source: AGHT+IHTqE1Jvi/eop3BhXHBqQzhh8YWtRvPXLLl1ePgYd5EZnn8hZeB0aq359Ob/HRYHtVdI46SUQ==
X-Received: by 2002:a05:6512:3b20:b0:553:518d:8494 with SMTP id 2adb3069b0e04-55f709b7a33mr4516315e87.54.1756890762956;
        Wed, 03 Sep 2025 02:12:42 -0700 (PDT)
Received: from p183 ([46.53.254.161])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e680sm377397e87.150.2025.09.03.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:12:42 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:13:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/base.c: Fix the wrong format specifier
Message-ID: <454cb73e-a1f8-4824-9fe1-2b55a4dd99e3@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

>-		len = snprintf(name, sizeof(name), "%u", tid);
> +		len = snprintf(name, sizeof(name), "%d", tid);

Ehh, no.

%u is correct because "tid" can't be negative.

	%alexey

