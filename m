Return-Path: <linux-fsdevel+bounces-61109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD45B5547F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B3E1D669E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D13164A3;
	Fri, 12 Sep 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUnvxo3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8422A4D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693448; cv=none; b=T9Yxz2imvKgMN0SAXafM2WIve/oFMicmpYtI0qSN7XwYZgz5ACV+I75Dq7BVM8lsmHpQuMXbQaZgrmCSZqkmgqBz44nZYfO+hAJofBkuC5Dt9pSv2uiFa1QYzal3a8c7bSdUaJfjlPbtjLhpse5HYe0eRfZZp9zv9AI/fl/s/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693448; c=relaxed/simple;
	bh=0RHe6bpoJIZwIozT53G/9zPYXo1UJgO60j6sIrqFoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNVUY2rA424kQsfSMkTKp/WfiYsODpdbRoplBQHXytOmeoZqjkRbcM2oMdekGKx/3wnlhDn/S0FPj5x950nnpTNKqXZJBL/E96vWgH2nA6V3b60Ckj7FP/Oqzii1DCwJJRQ+dHhubc5lSnoOhDpDg88crRhOulx5Z1r8s3fiWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUnvxo3j; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b600575a54so14244081cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757693446; x=1758298246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=GUnvxo3jTjQ98TYJtZYmV9Kp3cDyGCUaOA8obOqxRXsEfPttuobJObbWJInysARuej
         kLjLgS0Etct9lsAEpxFyFyYWAwSTNhCtVG2HV0uK5nmlk6gS9U/CYggSvD901gFcFaY+
         OiUX5S6iphlgsZOM65rHSx+SDdyhFb7TLmYID66oBiuc0HcegU4oHiLkS89B6pmtCFNu
         GJ/+hpZCA7fjF427b2mXBJ9Ab0gEDtB+IH1trHtrwAtXH4RLDoOFKgGGXpkNRrtjOUf9
         QhRPL1EXYlcYdKLAMZfm+5r3FvzL1gjFl2H8KCHnoKDaldP8pVyzzMpIdjbl7kGIOmnx
         ghyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693446; x=1758298246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=hjAyuFLlCR3FKWE/jOSZSNrD500BHTbi3nh2eB9bQ0OWCHgIvzVM7aAWgMlyqGQtWj
         sZ4B6m7jUjjGIwgxrR7eZKvI/bqJ8aXYEALoZaFcnrJObXCHVIKQbJP1iMMnZtCokbcK
         9dbV/TwJkD6ncq5K7gXafUtaXGjZQqsgWYbXs7iwcNPWwyyWmhiNXnk5AJTehBWKxRn+
         fYdsBw+9v9CpwWnoNcoGDf4GgDHuTIZg/gyMmlO7lmYAXlP7qTaDrGdh5ZO88jZ7BI8N
         Vt/cEThyC8VvM8xOo7uFnzFtAuA+vfxOkTihO0B0bMlgoDYGdlJPPmWWUcOm7RGyw1Qy
         /Acg==
X-Forwarded-Encrypted: i=1; AJvYcCXWYJwtHa52rIH+UAfiyHCMh5t9rfvHJCbd0S6jjVjkDY53ZdNFH6k+62qaC4CoEY6s/Jvkecfi1G2qPlzn@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbnumOV+awh6kvvI7OKf6GdAaWiMf6DT53BoxeDxHxLM1o/yd
	HoY19K2XKyt/25Phurhw1B58t1mGD+0/M3Ltx3NEtoiuTu2oGe8smHCAs6tPIjj1iKE2Itm16sM
	T3ePGf5LBQ6gtI2xwcbd1u9UbW7i9ec0=
X-Gm-Gg: ASbGncvP1UiitXiZ+fM77ggFV+xFzelYabl1oaYhouBBeFUZ6OeDcxo+FHZX5Y7mJDn
	vlz00r35EtTHg74BmOfiYDkFPfehB99n349p5yOvhDeCCh6ckgnAjyY14G5ufL9Xn7IvKh6tEzL
	Eyk37OLcW290XvUHVLiCjLiMDrWnrJkDmhMw1uwB5FJUaHzaASZzWA0FJmoQ0TPg0oh2/aZBEeM
	UDnTeyGKYMUiD+rL5HQZ3+HRMFpbmPh9ie7Ut/Rt4C7N76rPIqa
X-Google-Smtp-Source: AGHT+IEW7Q+2d2hor5P3hr9ksasgPpy8ttcb/zSz69+p8aktjcDEYkFuq3rxTSdGTnR+6WW44n0sCoS+JUh7Itaiy9s=
X-Received: by 2002:a05:622a:4cb:b0:4b2:eeed:6a17 with SMTP id
 d75a77b69052e-4b77d12a30bmr47218771cf.46.1757693446130; Fri, 12 Sep 2025
 09:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-5-joannelkoong@gmail.com> <aMKudxVnwafaoqmm@infradead.org>
In-Reply-To: <aMKudxVnwafaoqmm@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:10:34 -0400
X-Gm-Features: Ac12FXytydEpN3AbZfB7NDTCU5MSfYzu7GMuXUcwO8TmZQQa1qHB0P4yWy0TUqQ
Message-ID: <CAJnrk1Y6VZUA0g8223cPvmO_FjnKmemVGQck0_9DVcZkw-yGxg@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: store read/readahead bio generically
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +     void                    *private;
>
> private is always a bit annoying to grep for.  Maybe fsprivate or
> read_ctx instead?
>

I'll change this to read_ctx. It'll match the "wb_ctx" in struct
iomap_writepage_ctx.

Thanks,
Joanne

