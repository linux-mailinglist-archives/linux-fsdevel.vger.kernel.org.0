Return-Path: <linux-fsdevel+bounces-22887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0291E464
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBBD1C234C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547716D31A;
	Mon,  1 Jul 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NX9sB5CZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7616CD3B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848616; cv=none; b=YvfyDPAI1M2mEgjKmLzh5MB2FVs/NcslrIGuTVsTm6R5GV3LcgJxdxjyQHyHe8ZedtQx+LmDcY6rlTUvfNAu1ieuO4Mqhh6tDf7oWw3QjVAiWqqk9QGPwlkcW2CLkxqH4voGqQwIPYvfPw14bhe7FuvBeOipYtvhn0Xn7LHL4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848616; c=relaxed/simple;
	bh=Pszroelfb6fseP7TsvUcmdaT+1/eal5bduQrxlKvvp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEN+Yo2dE9DxEwm/SWA8ZyMjXOyN2O25ZjElDFM/ajFxxsJGMbC6beTpc52QIfYQ6QwV8Ikyb/4Lh+p5ZwnHyiaiYHSqaCxrSiI9SMe4b2J9XNuIhFpHg+BpCdDVXuy7x9m808ngfG88WR9Wd2Fa+OYU5z+XA38BoTCuvwhgeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NX9sB5CZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so35105671fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719848612; x=1720453412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D4MaGdhz46XaQWXk2gMo9aiUSV0Gt3CUatckOrYrQs=;
        b=NX9sB5CZLXdF0YjtEw5IBq680/CP75pFGSQNLxIbZWB4cK6EsXIqbfP5n6APLDGoaH
         FyaYrbEvd2LIRu3zejsYuGeR5sUkB6viTulA993MX8QosUZYcid6hvUuMreKe1oCyG+N
         Tg1sEX1kYSLFLPWzw9OlVqKvA83AiCeEAPCZcuMF0OSfK9CcXEDKmp0TVmG9bedLytVP
         9t/4xAd3zgw9/uyxO5ctvG23ffP7zPN1NyGMAO4iaFD/yMaYMbjBIEiRrtx9SbfnEcxa
         +s0SHNUIXbj3qcbAMz22F/WNaM+SX7yaw5nwcvvt6qSEwMr9XoTWMB+U+zilXZl0f08R
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848612; x=1720453412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D4MaGdhz46XaQWXk2gMo9aiUSV0Gt3CUatckOrYrQs=;
        b=l4pcMxgWJFIDogqOWjSFeqdOnUoAJXplDs/yzVhYrJZN2Oru6F7dj6q34tBKPrfCJJ
         Islx34IGK9pBLL6xonoP4hmAeD81YrhXVYYW4PebbJg5ZdgOetjKPJbeKs/VuJ58p8IP
         iQ4mtsxZgo9WXxyPENDQ+rORGSdpUX8fJdrItFdLrtx+8B94F2vfA/cSWcXO4ymJHGS/
         /3qdVcQkzzbPdrj3EQKBJF5INcj0ls6CE5kQaYJgRHbJsDZDHAEMu6YmVMUJ1Ruy8V4a
         yzax+ONScnqTrNCNuWjhtWJhs2u8zIIMtdMKsLT4XowDlxBS41jRuBRBBDrSj+i+noxb
         IF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRA4YiDGQTCCtQTsYDmnD0vtWn2JphRZljfl9GiM90t2EbjHzybLMmWFmTB2aygGBm9hn0zNXsY1uyFccm1jCAJvADzKJmmMY/dp75Xw==
X-Gm-Message-State: AOJu0YyniBedLg9CsCon+9bSihp4FFVRG2e6n5o1nWfRpXLfioFpgl/S
	JQEKVlb7AuaB7eTCi4WrLqr4yTB9+/NcZ/Upbwr4BWEfYF7fuCjSb4eOAxVx7c/sjbjru2HWvAr
	z
X-Google-Smtp-Source: AGHT+IHqnS0iuOO5oSlDGzivmCogKfrh/0LmHwl8kBjepSMtzVO7Sp6lxsTXVyT/1MEMjmB+cf5TsA==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5032 with SMTP id 38308e7fff4ca-2ee72555309mr5638471fa.34.1719848612020;
        Mon, 01 Jul 2024 08:43:32 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801f5a2e3sm6664712b3a.21.2024.07.01.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:43:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:43:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 13/18] proc: consoles: Add notation to
 c_start/c_stop
Message-ID: <ZoLOmYR_pbXmD49q@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-14-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:48, John Ogness wrote:
> fs/proc/consoles.c:78:13: warning: context imbalance in 'c_start'
> 	- wrong count at exit
> fs/proc/consoles.c:104:13: warning: context imbalance in 'c_stop'
> 	- unexpected unlock
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

