Return-Path: <linux-fsdevel+bounces-38867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5608AA092AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266DE3A7EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADE320FA84;
	Fri, 10 Jan 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="f5ikW0OO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA920D4FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517392; cv=none; b=gjpPZtRVY0ORWMm8sYOR32/A6gnKrEf+Hv9hmq/RT2Vf56gV8hpvIuV0TCR/bYzFJ+tzPI6/FgjBudu7ejPbhzYYOq1tki7tlwTH/d9YZ/g3sB4wKGJmVypo/QIu2D86MuLioGPqUyb+RYWEIyUYRIu9inFhDJT7VP2SUiJAwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517392; c=relaxed/simple;
	bh=IZr4/Uc3d4Cl2OPjAps5HDzQ8eAGVucHpAG3of/7Th8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jknGVfrLrX6G6bTdhJxx9+oCDVxnB8kJxTBruIDQ/lI9K1ink5NdCX3SuU11VjScDbf4Fn485457gS5VqCSSbdCQRTl3sIWwl2t4oT1tlmgpz+AvN8O6B4C3AJTJWgQZtS1CYRCzoDX5WRpIt2IkgkN8u+RtAvHaM8NQ3TUxLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=f5ikW0OO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679d366adeso18634091cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736517387; x=1737122187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1igwlXsE0AVNUWUM05YRhBuk+SX2vhOznyCi2mC8/Y=;
        b=f5ikW0OOZsat4IfdDgfr90c7NHamxvqemdY2KZKs8MY0VVIWOlWfenr4GD22ZkuV9L
         6YzDkJaArDE7h8fg/X6lPK7eNaxpADRmRIxGNeL099rW/tCQoDEQWbwFIJYsh3nm+H8A
         YAt3WWpoJncV2x3yfRODTsuso9xkfGTWfUEbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517387; x=1737122187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1igwlXsE0AVNUWUM05YRhBuk+SX2vhOznyCi2mC8/Y=;
        b=TOWcSfV7rIn1JUV+g73A5E2e/FJ1mvYC4+Tgs1Tnf4LkD1OXK4kL986RtLrICTPmSk
         6WvEmfT8Z2etPkwCcprL96vfuufjZf8o8WSvM/RX1Uoq0P13Lm/00Z8f8RpgFJQk9RQs
         CPj0q8WgDO5H+CheF64N6yiS7H6OEaAh+BgJXPWwu8PV+DBFtHoCi42+BzWByTc8FKtM
         59azEK5Vk7VIosf4LvxPe6PNRZPFARcVkWq23kcDEMB2jprB7ivnII+fC0zsRDBnjpP5
         u3DEETwooCXITagnfyrcu7F3m6AZQOxrw4Ce7DRVHmecwLwpsIzmxKjkEc7WSgxbOiRo
         8twA==
X-Gm-Message-State: AOJu0YzIs23ewpDrrgJAXfEJeyhGqP0aTlpJFQa9rO43M1JP5R+5dxdg
	CyFZs+NLqUw3QgP4ewsNLFLs6HopvmLngQisO5Ha3z8eCQ5cZ6P8R3hPpByLKMyMr4TapJVrlEP
	RZTF5h0tR3/i5XQWgYMiUGV9L43m198Ri+XlBH35BNVRkSCP1S13R5g==
X-Gm-Gg: ASbGncv7V7J7fhuGWH3vVARb4UsjqBdF5MTe7daLVdIMcbE8/GZRmIgBR4IFDE/xqNa
	/L9ml0Xjer5rVNnZvlhOCmpAk05u0slQud0KkFQ==
X-Google-Smtp-Source: AGHT+IFB2nNZ6W4Mi/aqG82NXk3+I4KZ20b1PL5pDhUMUsYCTX22ziwVprpaihhp26QWwtGH25eTJXZBo+uUu3607jE=
X-Received: by 2002:ac8:6908:0:b0:467:5cd2:4001 with SMTP id
 d75a77b69052e-46c7afe34aamr108738371cf.3.1736517387429; Fri, 10 Jan 2025
 05:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NahYr5vyu74oPTp_+W2X8mOzP9GYZ8QkMtgk4xTKLwzzHA@mail.gmail.com>
In-Reply-To: <CAHB1NahYr5vyu74oPTp_+W2X8mOzP9GYZ8QkMtgk4xTKLwzzHA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 Jan 2025 14:56:16 +0100
X-Gm-Features: AbW1kvbaQX97O9_iSGaFKFK4w7ChECBTJMUNN6FN38E9hoo1m-tgB6C_slQe_5c
Message-ID: <CAJfpegtGG38y+WC6TAe808fXWtYNtyeOuQq3pcie2y8AK7-==w@mail.gmail.com>
Subject: Re: Inquiry regarding FUSE filesystem behavior with mount bind in docker
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 10:32, Julian Sun <sunjunchao2870@gmail.com> wrote:
>
> Dear Respected Maintainers,
>
> I hope this email finds you well.
>
> Recently, one of our customers encountered the following issue:
> A directory from a FUSE filesystem(a local union fs) on the host
> machine was shared inside a Docker container using mount bind. After
> updating the FUSE filesystem (by killing the existing FUSE process,
> replacing the binary, and starting a new FUSE process), any operation
> on the shared directory inside the Docker container failed with the
> error 'Transport endpoint is not connected'.

Restarting a fuse server is possible by storing the "/dev/fuse" fd and
passing it to the new instance.  This obviously needs support from the
server.  See some related discussions here:

  https://lore.kernel.org/all/20240524064030.4944-1-jefflexu@linux.alibaba.com/

I'm not interested in a solution that bypasses the server completely.

Thanks,
Miklos

