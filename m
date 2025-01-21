Return-Path: <linux-fsdevel+bounces-39759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF1A1794D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 09:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D28E1883774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062FB1B4254;
	Tue, 21 Jan 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChO0zs8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36821B218E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737448471; cv=none; b=GtTy9mCxmDP1YQ8DAT3ubY+Kw+TuRBcbxo/iowL00lVmivpaLHsx3wbttZGTMzlClq60iyYQ+4PsMw9kMBuT1z9dJfnaZd+KeP+KIeiERotoeajm7E6y4y3Dlwb9imegrgT4I0ctm+7mSfd0G7bNRRlfoUn33PHUgCia1A75Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737448471; c=relaxed/simple;
	bh=RLj3KDpzEkIKVoREDIAcTxJZGFfNW+lrgjUBjnV8FPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2k72WLLD2tNKbXh+wCCwRR7xcYnfjH3PTE062u/NLAFyJrfTMVkh+r+/DSx1Tbsj24sRf5w9q9PhX09wVBvVvdBrDZwBwkrrcRBFIUNtg1r81V59b3T85ssP5TErwq+0HmBgk9hIo1C3U/71pPRIiDEyBthu3qaUIAwbKAsh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChO0zs8g; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso904724566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737448468; x=1738053268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhEQMgRYYWKKMo0WUZ3tRkc2rCn0CcPE8FBKYD1eaJw=;
        b=ChO0zs8g0UoXWT3u41/KfbMm9FpEicl65weuwWT3cMb5UcjDU0v152FB78gdYWaF/L
         ah9dzmbG9QbaJu//OhRnQxvSozSpFdxM1nan9fzVAu4zK4hd00oqkcJyLE3++bMyG74j
         vzWVry+HILyllLo+73sYz+QJ1UhOGFY6vnLCClxCeHs8CIiS46tM3hEB7oblT2/sQmMM
         MeZxF4pi5jNiXhfES90HaXB9qtemnm4cSWUU21QRH8taBReSXLU4L1wX/Tqn5S6alFVO
         dYH/jdzhiJ9iqIocyJThuTbmpVHnWsgA+PrJRsB5uD5ni4NvqC2X9LWjoy773t4apAos
         9vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737448468; x=1738053268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhEQMgRYYWKKMo0WUZ3tRkc2rCn0CcPE8FBKYD1eaJw=;
        b=CBUtTI6JcVzhe45sexN2xc/Jy4Ygrbz+k34oUNrjDcCLB1crpa2R1l2UnN0otr+TZZ
         iUutunHLhJ8/1cfoYkjKpZKwnZRQUTrCAmAxq4Vb3j9s3tGk03t183nIa4YbCxkdfLMo
         6tP0qdLtogi8lpjG6P/qskGC3L5Q8LKAc50xNoCZ4R7iILvkPBmxgXmTJ/O1j8uHiIgV
         AjZk5QnoI35l9jYPeSd2dJel8WThOMvhypOOujf8dBA9tTso9vJ9ldesamB+jYEEQzZ9
         Qqxd3FLiC5Rr5iYbckeMkS/jYvgqMIy/wZHF0O8z7MVEiv7HZpMxxYWV4YfI0Q2IWh3B
         jsOg==
X-Gm-Message-State: AOJu0Ywl9yZRgwAaxhjlK00fuNcLXfeVIwK2FYHquq5rwTF0+5tY8XWr
	1a+v9uGcBNHc6Y3fxyPJqDZFx02/HrOMrNVlS2tRuPB1ulJQ1pLZ
X-Gm-Gg: ASbGncupVrXrj1RQ2KsmtzuMOpdNhfeAHj9VRSbqLw4wjj8QQZ7wK3QkBySIPY7ogZa
	sDUEsF8+REPICYRiI6vN+teJywQKQ47v6eXDxjMkQ+/zhbj9hsGvMkG17Vg5nYGDAnzMmaEx2Nm
	6bLsDETG5zdE1HIMV6kHIrXeuubW4dXIVorEgt9EEMwi5k9l15fDyIcm+lMcF6xhn80FTihS+/A
	UNZOma6iJ/BFwLJ114gsrWgrN0Z0dhW/uCbEwa7Ccv4OtKfxrw0b6MESkTmQZhGPZXUbvoJBGrY
	P4l79dAgwY0L6vMt8Dek
X-Google-Smtp-Source: AGHT+IFgPidBCkTVImKo6n+6h3U2ss4G7Rdd10FTJGAWy7j/+zdwVe8NuaWhaqjeChIY6rQmbTpIhA==
X-Received: by 2002:a17:907:d0f:b0:aa6:a9fe:46dd with SMTP id a640c23a62f3a-ab38b3aff9fmr1727563466b.38.1737448467687;
        Tue, 21 Jan 2025 00:34:27 -0800 (PST)
Received: from f (cst-prg-69-191.cust.vodafone.cz. [46.135.69.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8d3a0sm718133066b.158.2025.01.21.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:34:26 -0800 (PST)
Date: Tue, 21 Jan 2025 09:34:17 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Nick Renner <nr2185@nyu.edu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Mutex free Pipes
Message-ID: <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>

On Mon, Jan 20, 2025 at 07:08:43PM -0500, Nick Renner wrote:
> I've been conducting research using a libraryOS that I've designed
> that uses a mutex free FIFO to implement pipes while adhering to
> Linux's API. I found that this can increase throughput by close to 3X,
> and that most of the overhead is due to the pipe's mutex preventing
> concurrent writes and reads. I see that there is a similar
> implementation to this used in the kernel provided in kfifo.h which
> could possibly be used to improve this.
> 

Most of the time when something was done it is either because it's a bad
idea or (more likely) nobody sat down to do it.

Note that pipes allow for an arbitrary number of readers and writers.
This is used in practice by make for example.

kfifo code you are mentioning explicitly requires locking for that to
work.

Also note that consumers are allowed to perform arbitrarily sized ops.

Maybe some hackery could be done to speed things up on this front
(per-buffer locking or somehow detecting there can't be more than one
reader and writer?), but I don't see a good way here.

There is definitely performance left on the table, I just doubt
something can be done to parallelize this in a sensible manner which
helps in the real-world. Happy to be proven wrong. :)

Can you show your code?

That's my non-maintainer $0,03.

