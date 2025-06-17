Return-Path: <linux-fsdevel+bounces-51948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2CCADDA8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F051787A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3ED23B619;
	Tue, 17 Jun 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBWie/c4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1222FA639;
	Tue, 17 Jun 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180852; cv=none; b=JQZ8fQWgC8PXEg4PlJlniUY+LMXfeqoO/9CP6hwTL4ZyqM96GLvUSBhQENOhS1L3gQF2LZ14I0sJ4T13fluAjz0Wv4lOR+eiss7OdUOODVlmWpwh0nVSPyXt6wc4Tf83Nrh69+dg0LEzdV7hFicVvxzhY2PWhDX7We2XCOCcNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180852; c=relaxed/simple;
	bh=yc99Q5MSzh214Vd2aZbM6WGTOX8W8YwMc6wcaJQmWnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzsTNCuL46bZY46q6Wy7Lk0h8+oQ3XZBFNYrxJxm/ActX3CXOtzvNnGrUOCEiObXCy8RB4m1TEMjlqbdMiHB5TUaPghAKL1TgtaviFFTg/XTxoZpoKpYK4ZTIqCqfNm+wr5PGyrB5LHzICWu/2pazOXsguAM3nuPCOih35LOqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBWie/c4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b0ed780so87320431cf.3;
        Tue, 17 Jun 2025 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750180850; x=1750785650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5lJGHUY+1rIbhPyeGzOiHVVI8jhjzNNTkhIRfyAa9k=;
        b=fBWie/c4jskGPDHwfjBT/CPIXIDGMEsw1YdZs4CiHFuwPkM3BR+CV0+Zu2w+C3LAP8
         qpnYcguNm1aMYDuWIuUO6B8e04o/UPQMq6PzBhLpNDBId/XTeGvIcdhc2dioiQlYDNGf
         a2TXgujcnxGWblhxck1nRyFUJfj02frBpXFxJpwNlHImhTCCJeJVMsgDznksSkTU/QS2
         SH2vqCkiPKY4r0IXrrEXoEsODoKVCz7jfGR0oW8zOxBJovTkYdzZj2J4Ce6CnG+HgR8I
         F/Ok/rVI2dqJaixpxCvnHqdhTC5THYEHE9x0wphDjxF12SS7c5pReFzRdmWLMXmkiaCo
         TDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750180850; x=1750785650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5lJGHUY+1rIbhPyeGzOiHVVI8jhjzNNTkhIRfyAa9k=;
        b=tEizswzecagQIxu2CcU3kk/qxTG3URK+3x+wLC0ioG9Mu02IpxUk9tM2yjbiCxKS8Y
         2TJRO/xgdJZ+0oxgQp49ovZ1bFcjfBDNi8QX/GdE+Kt8uJ0CLVhrX7poMybWTr5XvNrW
         4XdZPYCynqKCiSNkli2I6xAiLY5OvPkhFv9+lj3A/Hzjxbf35nEF4ZQzBcT9Aj9guWJf
         JSgtZ64K4HOJ6es+3wVtNU8Q+/lzqmTV66df2/+WdKFema/nbgfJRDuYn5YOR1OFuZ6b
         J9iac8sgtId0+lGXUuyi29qh+d/oVGj03OgpcLYHHEjlOxXyaKn8GUGsDm836LEPSIVw
         6vyg==
X-Forwarded-Encrypted: i=1; AJvYcCWmrMwPtTLToFp3UusPAWqturEYZGC5Dvq5dEzsrm4zT2rCgnt3zTgcwQbxZWRQtPijdXdPAyvhuXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7r8wg2ek4pNWZEIX8Ce/pO741Bl5iL/29jGGwrBm7jlYV2Mc
	e6LrOi4spxzNLdhQSgJ34cKg6sH4K7bPKzSTjWxk3F4aoZfJWwm1Qw0HT8y7ylHYaWEyKZlbEme
	0u/cDMgY7LlDLFS0Yyzg4AIPFRFSfZVM=
X-Gm-Gg: ASbGncvtVQqVROMaZuaa9RDeHjOo5tsjQwVaIe2KnHQqQjczahiiIFgfiCh22kRm/y9
	d6dT0iLe6cpBk0mCYRDkXBW+mXt+h0l9CNAxr/C+d9njef2S7LbkXYTJNPBkbLqN2ICGPiu8Ajh
	32QdK3Zz2QTJB2wjMt2hWcyIQ68d9gYGUSxlUefu17ioMBENROxGN+m1kXsAAVFduGo5WBvA==
X-Google-Smtp-Source: AGHT+IFCiTiLVDo2mTyrA48tPlQBJUICp6nsth1j18DO7SopLQjlZteQhNTafcsqpUvS/YRRbQux0XhfAOMxtuYKZns=
X-Received: by 2002:ac8:5707:0:b0:4a6:f8aa:3a15 with SMTP id
 d75a77b69052e-4a73c5d00bbmr244842481cf.30.1750180849581; Tue, 17 Jun 2025
 10:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com> <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com> <aFDxNWQtInriqLU8@infradead.org>
In-Reply-To: <aFDxNWQtInriqLU8@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 10:20:38 -0700
X-Gm-Features: AX0GCFuxtebyCJR4Gk4JMABRGxrh5mq4FAjEjwrPT2dsKL5IdnU1fH9k49Q0no4
Message-ID: <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, djwong@kernel.org, anuj1072538@gmail.com, 
	miklos@szeredi.hu, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:38=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Jun 16, 2025 at 12:18:21PM -0700, Joanne Koong wrote:
> > Nothing in this series uses the iomap read path, but fuse might be
> > used in environments where CONFIG_BLOCK isn't set. What I'm trying to
> > do with this patch is move the logic in iomap readpage that's block /
> > bio dependent out of buffered-io.c and gate that behind a #ifdef
> > CONFIG_BLOCK check so that fuse can use buffered-io.c without breaking
> > compilation for non-CONFIG_BLOCK environments
>
> Ah, ok.  Are you fine with getting something that works for fuse first,
> and then we look into !CONFIG_BLOCK environments as a next step?

I think the fuse iomap work has a hard dependency on the CONFIG_BLOCK
work else it would break backwards compatibility for fuse (eg
non-CONFIG_BLOCK environments wouldn't be able to compile/use fuse
anymore)

