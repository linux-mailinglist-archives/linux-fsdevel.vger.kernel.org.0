Return-Path: <linux-fsdevel+bounces-9855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9E845552
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99001F214B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0215B965;
	Thu,  1 Feb 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nbKmx9Kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29204DA1D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783346; cv=none; b=QbjzYw8w2WDe+O7GjPW7508YnLIcI5HsTbrDeLRlpayMxJPKW3ybcXlolCCZDsJ9ElVFatgrED7DmWpu0JUEQ2Yp1R5fC/7cklCCQsmzQ4G09eWuYzZ/r8jQDtjbN+spyf9gYPj0D0pcBZaThAJux1RinXPLc5E8wSZv89lMQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783346; c=relaxed/simple;
	bh=4bY7UZC6F0iEcfCyio2JtneQgLqFyahA1E9s4ohixvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxskGaC2j1qL0xo9m6wzYH89DQzE7dxLPcjg/YuzaE2m9zUTAmjRlYzT0MHVNwDi0qr2ACdzcaV9pdL2t7LmNCBzRKwZBwHRCzWycRYmQ+eEGbIDyLDROnfpHYPiHrGuw6pFajXx1Zll7M6p/iCu3Uf13Lcxbu9mIfXZ0qDPGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nbKmx9Kh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30f7c9574eso96941266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706783342; x=1707388142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bY7UZC6F0iEcfCyio2JtneQgLqFyahA1E9s4ohixvo=;
        b=nbKmx9Kh6v2/fqKd4ByL/LJSAT5heGjOTp7kmlbmwe4wjdx0SMnletoqJ6cCZLfsPw
         AIOI+GHAO2vUdv9pjL2fzcICFhoKvCbevTMvT/wiKfzfFtc3OmRE3otexPIeQO5riR0g
         X4EVorIZNHG8mtMfoX8lRFl7N9FjmyA1HZD7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783342; x=1707388142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bY7UZC6F0iEcfCyio2JtneQgLqFyahA1E9s4ohixvo=;
        b=mLDvZJBYRL17Sa5IfXcEWA4gvCWbWiZRZi59GkG140LJhRt1w4k7A6OpG6QGC/gBaU
         7k7xeV4Qb/32+/GcuvOz3Gcqebh+vh/h59v3Uj7kM8HZ37/1qLE/2yBWS5WyYMdRlTUI
         ArX6bC/HArcPm94oDhOr8c8VoFegKexOMVALiq303YYZDv7pks+K70A1+jyvGL6F9W2W
         tjPWoGgn2nFCDrBWbHiSXBlrMnvLH5v6cuG7xolsB6UZndbxDUzZv6QdJpIJs31Ai9Do
         Hl7IT9h0vXFD1d6z/rVTKxVh8xSzSf3KNVHZVux5sz8Kn12Vi30ue1z61HIrTBuGoGU/
         wBuw==
X-Gm-Message-State: AOJu0Yz0chgqPl7uw0R/xio0SmmUNkC9sI4En6zvNCD8iWnbBpwDQWnV
	cy84v+48UJM2OLD4Fl4OKWP5jp2tXDDOOwSoE9o2I9S0Re4fou2EiEPBzSlcN+D9Qz7huNmekmv
	MfKKZftLvBcxNaHJ+QHmA1y4fqWZAEhWXg/6u+VrLrWfi+/8P
X-Google-Smtp-Source: AGHT+IGQNyzPfdZqwV1VHVDTGA8DodGSPCrKNI3shQclFWGP3eVv1dR9+y5P5eVEXUDdGNYr0bflkF417WfkKeHu0vo=
X-Received: by 2002:a17:906:46d4:b0:a35:78e1:2d1f with SMTP id
 k20-20020a17090646d400b00a3578e12d1fmr1386879ejs.71.1706783341958; Thu, 01
 Feb 2024 02:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com> <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 11:28:50 +0100
Message-ID: <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 11:16, Amir Goldstein <amir73il@gmail.com> wrote:

> I can look into it, but for now the fix to fuse_sync_release() is a simple
> one liner, so I would rather limit the changes in this series.

Not urgent, but it might be a good idea to add a cleanup patch as a
prep, which would make this patch just that one line less complex.

> Is fuse_finish_open() supposed to be called after clearing O_TRUNC
> in fuse_create_open()?

This will invalidate size/modification time, which we've just updated
with the correct post open values.

> I realize that this is what the code is doing in upstream, but it does not
> look correct.

I think it's correct, because it deals with the effect of
FUSE_OPEN/O_TRUNC on attributes that weren't refreshed in contrast to
fuse_create_open() where the attributes were refreshed.

Thanks,
Miklos

