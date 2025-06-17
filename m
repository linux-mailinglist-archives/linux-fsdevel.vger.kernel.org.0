Return-Path: <linux-fsdevel+bounces-51972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21004ADDC71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6AD1940FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065528B503;
	Tue, 17 Jun 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqlQaUcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE8238D54;
	Tue, 17 Jun 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188938; cv=none; b=RAwAli8e3srzmxy5Hqw9Wed3yQ0+J+/ec+K3ztiuSb5rNTjrkmuzEebG66wCNVJhxVfTJMDxMIzZ2d3cWXNoJljMnx7Nd02PxNfapUKqN5X0JHEg5QIxeAyQI2rXQuBKhdqnpMIPwI7pgRwMv5lt/vhX5SEDWBi30eyGwnlWIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188938; c=relaxed/simple;
	bh=aHeR5TvY2TOMqEvpw3v/Isa3CBFokUQe/mc7hD6LOfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqv5wn2p2/hMJvW86rZV36vNejeaT/j10l0aEhjW4O5KWjZjylwhYErhpVJ2MpqIWZbshW53toZX1JLf/iIlBilHQni8oth50KY4IAzQBuEecoIDM2F2JPi1Wy4ZCBLjGhRHPFn98fJcMllTouv2o7dWtMWkMJj8w9Ja9HLtYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqlQaUcD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a42cb03673so72853211cf.3;
        Tue, 17 Jun 2025 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188935; x=1750793735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/9a3nTLF3crPDcU7zdTz0aCFqms9P7e0P7pfzgojxs=;
        b=TqlQaUcDClw92FhctarI0h5c3+IPkTn4FMPeUXlDXvhde3v5pMBsUJQkmNHenP3qXu
         tKhshr3/LHJ8r0RSIjiu1Gj5j4W+UQtgDTzdcfBGpD4JRP/6ko6V9IbAnFG98suJPDGQ
         qteEh24Ws6EXhoNSHeyGkf6vpBrAj7nXEtnpQXGebVbB3KyQ+CyiARIz7ZvzIt9p12+6
         3VenRtpoORBJ26LwmZLLe8k5mLces+JOHFM0TwsPuT0B++gKOVphguyS6XEAjt5ZUJk+
         FSVlUvRiu2pK9PPnURnjFOkwOpeqMGSDeYQBpPwT9nyBJCoQK+tyt5eJDVQXiXjcmhjX
         5/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188935; x=1750793735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/9a3nTLF3crPDcU7zdTz0aCFqms9P7e0P7pfzgojxs=;
        b=nhC/X+RlIYBhf8x6oRaXgzPFVU0Rg/sCCX8xG2iWyAYCa3Glmen1i9Pz2C/E248s0b
         1K/rl7wbv1OyGm+A+GKReZWymbDLPNStHiqpA0MDi8r2B1Sb5Il3G0D26ZB0KO+6VajZ
         xrS1uXTPyVu7F23f05nrV8+l3Q8oXBL4se0ohclD3guiBUZ/zDjAnY8fkU6bcX3Vdqdo
         kq4+KmrSRX2FYJalxfDPxPX43RROrfdEB+0oI/ZzvGn0b/yACFnM+qvZAagwxJe1NHi4
         fcofci6FNqbDwWLfQE1cGdFDo7yfVCvnMHRhvfQRu2zYcO8unzwQ/NzFdEo3+8pl3giX
         jPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVDcERrNcfYAbLBaa3kqnWkCNW73IXMuqJpOMOcb344dkDaqbL0E4o8wdsMP/zgVh3LDCyngr51LVaUmw==@vger.kernel.org, AJvYcCWVyhmu7AQGkvLQAEAqglWlda85LZvvG2DZTXj7+77iJMEEDcCJu/HLEiiL6xvqPQku1CtUlZKmqxjI@vger.kernel.org, AJvYcCWX72Plp+X/KMYfjYP7N6XmhwjZH/khYdlGhZfWhu3UUHRfpkK8sz24jN91hI33NkgeXJZmUxgPrmQ1+epMCA==@vger.kernel.org, AJvYcCWhY1qyxn/9mUelZn5r3RToY6QGOi7+fxRGvVceKb3njv87qhHlpgtTTxpgz0Jo7bBw0bWkSRrpmKDP@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+xl0eXfzO8bAW69UFLTv+3kDOijPS8+ZGt+a+/UASUqHK1TJ
	48lAISKJDYuUB0iCX65oEoFM+pvYhdqscEFPdy+R2wbgwYWsmFKd5ERNy75iZXhxAQY/+GnF+hQ
	5Dz4c/n3zEU5vtnasDAcwRNeuSwgQ05eEwUhK
X-Gm-Gg: ASbGncuAI4TI3CJqSXvXPVY8Nv+g30G1LAXWYMu2f1C67lQzkSNB5cLQhKgE6+JZUA1
	SRKVj8UevHfhArP/BFs1dRnyKPzYn6Ebu9A88zgq0fmE18HhsAhb9GtGTr5+GgH9YRete1m5/L8
	cV2JOZ6p08cK5YlsomzUXvvriXXB4SLWkuiMyZMXruHavwd9wJZMZhY3AbGEoeYQT0mB/R2g==
X-Google-Smtp-Source: AGHT+IGNWRrg78f2AdGVRIQIV7dWobH96xkUMSYd2uhj7HCCB8qHyFk4aKVijp1u4DOGWFfSZF3McIhV6rZZcXgCPlY=
X-Received: by 2002:a05:622a:11c1:b0:4a3:96b7:2a73 with SMTP id
 d75a77b69052e-4a73c533a1cmr231209081cf.16.1750188934744; Tue, 17 Jun 2025
 12:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-7-hch@lst.de>
In-Reply-To: <20250617105514.3393938-7-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:35:23 -0700
X-Gm-Features: AX0GCFtb7h0lrcd8zlSxCJeX_oEZLGvjTqKxxkACd5AlnwnZgcq3jlm-zucC95I
Message-ID: <CAJnrk1a8xkwwLthOrs3o+Jn8tqSCyEpOnomXL3+ONopFxd7QTA@mail.gmail.com>
Subject: Re: [PATCH 06/11] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in ioend.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
>

