Return-Path: <linux-fsdevel+bounces-51067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E65BCAD271E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 22:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2649E18936FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB929220F33;
	Mon,  9 Jun 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agiFzT7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208F220694;
	Mon,  9 Jun 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499283; cv=none; b=LPUORcix5mur8s4LKzIRakOkaaZ2RHBHJGYG45oUbi6zvvCZ8LbPWBD2YY0a0AkLXQmXJ183LKMmyHJTUpOchMy39KrEbMQioFYBWKmtr7HltmklYCkdaZ7Bi0Ixsi6PW33VMUn/LXA1+M+yikDb83K7zdfajtCsXg0edvwPSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499283; c=relaxed/simple;
	bh=Mpxyqx9hF6RL/Eo2K6tROLv1Rp5Oxf8q7H+5goQBC4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEaMRaAXdEu1/9GdHP5Ob13FjTAGNWs38ednOTF8L3PFwGLzwJnzEbUrIhKJDnWRmhVVU7zGn5FFKl/CkJKlvcQ7/fiSqegaKblldHo6wIfqeGh62hySFsCDuMNt2Fq+NSvU1sLK+d/SPrYlPH8g9UoK2+FIwqq2DpPv6O89wro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agiFzT7X; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a6f6d07bb5so21521641cf.2;
        Mon, 09 Jun 2025 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749499279; x=1750104079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIUG3H8qMNX6C/rOEBFhcFpeSt8y5PAReSCVkHoetqU=;
        b=agiFzT7XieE+QQRg7SkwpNn5K5Zz8/qPRHw9bd3iCj3iO9s+yfpOiSwXh77lgNsEc4
         6QoiQMqzxV9L6cE952pSzHgqIj4iTP338xkXSEzco8ehqIL3SSZBtt5G3A+AW+MWFHYb
         h4qEGQvnxL4KxRv2xXt+Z++4l13sNpEyBKuc/Z4u1+4Ig2FT7oBx1BGsboxdHvcimfT/
         RUsCSOcZ+p0fHSZONFsdXpeKlIe9XA9iS7RS5BqoHl7GZNDU9oA5qyWIMxF3XMZh3uqc
         xe4OCHM4xEXmZIPlUqwC8ha0Gw0NOPMYcLCSJX/1QCeNRqfig/LP8zC5vgKM78u2hHuQ
         +78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749499279; x=1750104079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIUG3H8qMNX6C/rOEBFhcFpeSt8y5PAReSCVkHoetqU=;
        b=SsnQrjgoZ6fJdiq7GnfwicXRNvGburvr1IjXju/cDtL32UF/FCf5uCZvqGRENbOOYQ
         2/cuZEZn57aoo68CDgvdE1KR0aC3Ba/Q8WpsUcMFnUx9Z5H+riUeae37i4WyLvNb4zt2
         lFc60hIxY+h0PEMb000x5Wo30hOp4Ps4KgFmYC+y4WNXUFGRamPhBvt6soOlRKluhN84
         qePyZcwJiHAljQApZw6RWpMe0XcZP6AfJhpTqyTvX/guS3woNvAgUUqqg8dPTEsBZNOd
         qz8KOqjuiR/Duzr7thN07gL4N5Ui8SuxZTE4sY7JGg7BnKoddMNK/EcoXkRMj27v+stI
         sl3w==
X-Forwarded-Encrypted: i=1; AJvYcCWHYtYvG/sYgWHguoNmRAXrzaDynaTX79LN9zdofSgqPArH0GeHivCfX1sCf1Via4rfFjl7AYumOzRn@vger.kernel.org, AJvYcCWYSpUO2MEkCJ/T8fHGOLZoVFfljpTIr7niOBMshK1AcDSkmnJ/aaVWviyRPXpx9KqcgAUMd5etDW4LWvDi@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaXhKV1nuMnaB18Q1GVDi5aZ77aKaCIFHDSa+ktv7VMI2ygtv
	RJBs8XMDfOCjD3MK0rT5fV0+LVVa6Yk78WRPdfeQDcFRjM95d/tj8SaEXiEKB6ayPlb3iacjHlD
	MHkRTwQ3d8izJgVJ9jih9fD+oENTHgS8=
X-Gm-Gg: ASbGncuptTGDGUU+8UZu+kuqD+kFcuL6GMQ6PFdaRQUJq+fTeXqD7YDTWG1puJ0AaaJ
	fvxCO6FMtRJvVBYOFokIQOacXhBlGknQRHwOTXKj/h7WdoRke3/lZhQOAfgonXwGkOZTYSvKAMq
	zgptvrjBztYmb3rSehXIphKNq+NWMGsZd9xE1r2q0+8bM=
X-Google-Smtp-Source: AGHT+IEGEAkzPQrrz6u36pv4BSRbZVQeLz1NLcfLmuXFPoDfz+bAEQ3/NIXSIIa0SJOHVfjqElfn5YXbt9yjYvdXsDg=
X-Received: by 2002:a05:622a:551b:b0:4a4:33d8:5716 with SMTP id
 d75a77b69052e-4a5b9e00d8cmr285169861cf.3.1749499279519; Mon, 09 Jun 2025
 13:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-2-joannelkoong@gmail.com> <aEZmtI1Hqj5I2F8d@infradead.org>
In-Reply-To: <aEZmtI1Hqj5I2F8d@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 13:01:08 -0700
X-Gm-Features: AX0GCFvkBD5r_3j4GiqhodQhZBJgoqZEgZmdCwbSkxXjyatWL7xvxpT34qRKHnY
Message-ID: <CAJnrk1at0M-0S0tg-g-nVKito=Lsyh3-Ua5dx6K4m_-Oz-e17A@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] iomap: move buffered io bio logic into separate file
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:44=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> > +++ b/fs/iomap/buffered-io-bio.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bio.h>
>
> Please keep the copyrights from the original file.
>
> From a quick look the split looks a bit odd.  But I'll wait for
> a version that I can apply and look at the result before juding
> it.
>
> > +void iomap_submit_bio(struct bio *bio)
> > +{
> > +     submit_bio(bio);
> > +}
>
> This is an entirely new function and not just a code movement.
>
> Please add new abstractions independent of code movement.
>

I'll fix both of these in v2.

