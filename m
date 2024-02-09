Return-Path: <linux-fsdevel+bounces-10918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BAB84F3EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F2B28DDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8428E0B;
	Fri,  9 Feb 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WOzy6I5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9E28DA0
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476210; cv=none; b=nDbm8YLjY+gAcxxc/aaiNzV/vOSn69qS8VhMzz6WoPMbZP7pjVEqdMFhbvNdp6rwZvS7UHZbSiKZhU/HogMOJWA0fSVmCUdFFyrvfltMGmT7sNfN88L4tBY7hPkeDhWc2+VDyh0aQDUNfxelDI53yFXqHPgH5Gp+EfvZ3hirdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476210; c=relaxed/simple;
	bh=LCP4YO2t86bZLlN1T3oyn8YafktJmm1NemidoeRVqUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAAfYXKiyib4FULKuq+OgHoHSQXGzXaSB9mHS9mjLENj5FCHiJW7xJmJkwCsdsqpn6+1sbh21rf5iIo3GBRGh6BIxQi3oAbFXK/Z7ZszSx+CkyzK/Ql3NINa2D8MxWqXP7W19GL/ahjF6T0fKgm77lVreZuz2JNoQuA2J8/qV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WOzy6I5D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2a17f3217aso96759066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 02:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707476206; x=1708081006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DSVVLVkXlnbsLtckNVzjWSyQS1lvKCWFYVfoOqOCQQ=;
        b=WOzy6I5DW0mfuapTBtj3Awpv1u4ufBpkReZddfVWHBkDfJ7d7ceM8FLT7Y9139tzMH
         XXnM0QZKFTRRcUiJm/JwFpVEQvABQtVkCi4ezqpztLEX83kZ2yPg/fjo1ANPLE2HsvRZ
         Lmxl1eP22CkklDrOC2cx+2lbYom+ufzwONuxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476206; x=1708081006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DSVVLVkXlnbsLtckNVzjWSyQS1lvKCWFYVfoOqOCQQ=;
        b=G3Iy45CSdYhpaqzsE0XbCFstK+LP1f227G2eYkGHfSexaUSPLxKeuoHFzU1VkDzF7q
         SnqiRl88bJvqNfoD0WdgSmuOUSbAqDW/VBADTbAJLdLdf6+CckUIIO3EyWN8SIEUrKfF
         BFXN7a3vZlmKM41AOEPtJp5Z1lRrebl2Vrhd1IevhuP7qNYzTXQ2hJxjVQNwvM5lTeZ6
         yKGijkEWi/HX1Dz0if4BKj5FNwkNgvKSG0SDWbKm/Re03qrjGb20kaECVfyWFIVRJIR9
         muDwVKnYKPRADMK9o/l8xmLu7TV6YCQTvq8nZDigytUlzb0gSss6mbO8dbDAHiJAq0Ot
         1baA==
X-Forwarded-Encrypted: i=1; AJvYcCWMEvUQrTEK+c1XPgwEsKGA2oIyvWRtvfj/SJXCtqw4NpAlrCdKkyfwhnspk9DHe7mRDpDUzAoxiR0lq9kZm+2f90IwJxd49kukBh6mXQ==
X-Gm-Message-State: AOJu0YzR9GQysmIhb4/mmN6uXv6IfJ6NSGL14UUDDuDR55c3PnP7tz0Z
	h5YehzwxJjqnMZy3MLZLkPL+HcjAKufO/hoziLcnYybUmIMeRM1FeEvzAY6gqA1vI3ivN4Bcxp8
	7pgLs+xAavM0hbvJ/1DNpc5fjWh5MtKWfrkvsvg==
X-Google-Smtp-Source: AGHT+IFU/mJmlEWb/boTpehjFz32f7iYg6xODPpdYuhXVRIM9EQHJBfiwruYH0HfQJbj7KOTkuu3Ye0rbSF44xqdSx0=
X-Received: by 2002:a17:906:13d2:b0:a37:2932:df1 with SMTP id
 g18-20020a17090613d200b00a3729320df1mr971089ejc.29.1707476205920; Fri, 09 Feb
 2024 02:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-9-amir73il@gmail.com>
 <CAJfpeguUBet0zCdESe7dasC7YpCEC816CMMRF_s1UYmgU=Ja=w@mail.gmail.com> <CAOQ4uxhBuSQmku70oydUxZmfACuvEqUUvtVcTSJGYOWHj5hvRg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBuSQmku70oydUxZmfACuvEqUUvtVcTSJGYOWHj5hvRg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Feb 2024 11:56:33 +0100
Message-ID: <CAJfpeguR5Gt+vcyduE+PT+8BmTOJgv+KnpoSueHVbBgFdMNfGQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fuse: introduce inode io modes
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 11:35, Amir Goldstein <amir73il@gmail.com> wrote:

> No reason apart from "symmetry" with the other io mode FOPEN flags.
> I will use an internal flag.

Okay.

Other ff->open_flags are set at open time and never changed.
FOPEN_CACHE_IO doesn't fit into that pattern.

> I added io_open to fix a bug in an earlier version where fuse_file_release()
> was called on the error path after fuse_file_io_open() failed.
>
> The simple change would be to replace FOPEN_CACHE_IO flag
> with ff->io_cache_opened bit.

Right.

>
> I assume you meant to change ff->io_opened to an enum:
> { FUSE_IO_NONE, FUSE_IO_CACHE, FUSE_IO_DIRECT,
>   FUSE_IO_PASSTHROUGH }
>
> Is that what you mean?

I just meant ff->io_cache_opened is only set when the cache counter
needs decrementing.  The logic is simpler and is trivially right.

Thanks,
Miklos

