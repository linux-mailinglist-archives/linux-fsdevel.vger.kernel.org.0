Return-Path: <linux-fsdevel+bounces-64141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCCBDA933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0760A3B0F87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C96302750;
	Tue, 14 Oct 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gN3+XUfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C830217F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458261; cv=none; b=SXr7DcIOqYdPHYum1LCCE+Wd+HWkpz0/vKKchKjtZ/NseXPA7jpgPF7HU7ncD7jcQM8H/O2kcLJ2zzN5o65gxDwsflrqhDwnN9IFdIEE9F8gRBfS6TFt5AeibPFK41O+63ODOMe+P1c1+OKOlCDOzkaaNQ+1qYV41KJD3gRB2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458261; c=relaxed/simple;
	bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZjl8MOGF7HJD7TI00QaPCQCWQXTQbZ3nYbysSEvq1MEwpsAp7C8uYx9obtSbe7zsB0GpBZr3sO/HyyFbhHVKz1zJmRqdaQnt0/DhQYcISXjOgSd3s3/fPEXCGmCBtUPtBonCQ11XQLPcLFPtm+mV1SYzQzgnGMBDWCwMRA9cYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gN3+XUfN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-863fa984ef5so920435885a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760458258; x=1761063058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
        b=gN3+XUfNl5I+bNisuheUReVqm65hJFnW6xxQP+JdUGFN+EF7bWcJUVmZZ3KQep3rPs
         Y6GupbvMVOwuTq4TkAQ0a4SYLAtNs6GYP4HJxi3h7SsckIRqpY9iEWuU/QIhmIxoOqQZ
         As6yVfZQU6YbehwvQbAq904tCpzeHsYsrfzIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458258; x=1761063058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
        b=COKQAG+q+vsfs9kjtQcgv9N8F4HBtPxj8FT3Q27Zzc01TCkKdkcXfqLS48njdeSIFT
         8fksei9/QOlUNvLqyhkGEL7D5XE7PfeCbzhiOQ5t/qeRuzg23e100GZ00O6T+SjTKPVX
         2t3nEQHi1QQI2IeadC/BRx+a0skzUAhlTmixYIILXn7HWAFglauPg7/bdFR4O+EOiAEL
         qXKsV+0xR4/B2qVZt33fuZCIhs/Hyzf6innwrNBto1iD/2/O6DphOLsdl+X+m1rPX7sS
         9KyEfbil3Rcv9vuIWjAHaLzGGVOANIXSEjxsBzHqL3mqB9K+VDNhRxzv8JqRH2ivVVoq
         Tg9A==
X-Forwarded-Encrypted: i=1; AJvYcCWI0Xbgn2UOR/+2SYULmiQd5pShxFo/WWzMNRV4WmxijrCHJ92MuRLSJuTTd/fEUdlZn7vqKheJuLbLtjs0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ps9JiU9IBTFqf8qbswfdNg+AEkU4StiuBFif/8hQVmQSFa1n
	vNUZy/lUmhRzctvzDkYW/utL+dEOFvXxDZ0+OYScLTP1eUcbg1IkM05KBwtt4BC9/UtabIS7v8S
	ylGaAQ3opxNJrZfExeR5V551mDH8fDO/IDdEe1bwbLw==
X-Gm-Gg: ASbGncvjHXbW8FkVpzZgUmklcLLGbhKH1tBPFjGAc8ESvwAdXZlNajQMB4C3ZPn88yd
	kgp8fxLkar4RN/mn0ekYj3+iS9f/QrnM6DQPxEqjGTo/v0i9vBMbXZmuBlxfQmbQgt3pCw4lIAM
	BAFzwn3Bbk7pwCI0XNWadTq/QoqJww1M9OCpBR6mA6q2Sg5tCQeHvHmdfJbyunt6pYdK1zrpUUl
	JCrvGU4dbSBC+6A6KqG1yQLWU+QnLcwBzPegViu1n81wIjmBy+OGJH5jEQ1/ejsiOtrtA==
X-Google-Smtp-Source: AGHT+IFQRjAKAJYbp6V1WiZeFCyECjXuO5jrrPa49DgUlI1WAPf13+vaPEkcaT2yeshZtbmjCqkb6pcUiXEcfb2su+M=
X-Received: by 2002:a05:622a:11d5:b0:4e2:f1b3:3462 with SMTP id
 d75a77b69052e-4e6ead4c89cmr348585611cf.52.1760458257727; Tue, 14 Oct 2025
 09:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <aO5XvcuhEpw6BmiV@bfoster>
In-Reply-To: <aO5XvcuhEpw6BmiV@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 18:10:45 +0200
X-Gm-Features: AS18NWAdgN8KhodM1ygh5h7LAeZnHjtur6SOKA5u8RJBQMjsBZqEVkdui4mizyA
Message-ID: <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 15:57, Brian Foster <bfoster@redhat.com> wrote:

> But TBH, if the writeback thing or something similarly simple works for
> resolving the immediate bug, I wouldnt worry too much about it
> until/unless there are userspace fs' explicitly looking for that sort of
> behavior. Just my .02.

Agreed.

I just feel it unfortunate that this is default in libfuse and so many
filesystems will have auto_inval_data enabled which don't even need
it, and some mixed read-write workloads suffering badly as a
consequence.

Thanks,
Miklos

