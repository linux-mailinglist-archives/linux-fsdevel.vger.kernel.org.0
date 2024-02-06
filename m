Return-Path: <linux-fsdevel+bounces-10460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8584B5F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFFE28618C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7112FF97;
	Tue,  6 Feb 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8+a47vO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB412D15B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224853; cv=none; b=jXJX1Ah2BS3RS4TKZ+UrmTwCdssKIZegjOZ1wQkJgY0MfJNNLmK4RZXjXrlNTr3+VikcsO2WNy9DEiY3AOl9u/PnWkiK69opd1YKkJD/JBaPwR3rhKVKEFhuyxjcyb4khWK5Gbxyju0mEAag0jvTGshVIrclo4NatTVoIF+84+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224853; c=relaxed/simple;
	bh=qw2mxOK7Guv+vjw9UHRU/UCz7/uG93Z7MjjeZ/cY7Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oibLv/7yjZwuj21buZyV6SEMsl+Xr3qBiGm+jZ+2wLIBTT7E3Z7z70+RHVCj5TymzST2uEFLOckGurcAdx0bigrVazjAql/imIAmHbGpUs6pNeNY0REqL+JFIqGY6FN8RV6nYSM/GNibdqEGKBArKOe7Ohl9+wlikVqa8bg5HjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8+a47vO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f3d27bfbso305742785a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707224851; x=1707829651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBttz6chzTT4VQUfv5nUC1imGW6Nqw838xbVGvEna8=;
        b=X8+a47vODdrVdNCbF/Q8CyVUBfK5aP49UxRAA9kBBsueVq+21rYF8gJlqMo/ie1Fl/
         kVlq6Kb4Sprnx27C+RfsJVjkxUNr+xL3/o0glKgRw1SMNBRS8bwkylHNGv/8lbnkmZTD
         9+CVR0+NLD6d6w12pvm1x+ZfXc3AaZBGX99DOsaTkarauwvxQOqXaStlUctGe2iqNBnS
         /UJEbuzGq/Gz+Tzh6MfxuRjQWqhR7gTtJfDCVrZZb+OpGMxUslq13bsy+uWe+mTMm6fj
         VGzrMCmijQILjxzF5/SzpvHzFEY/N3yINOAwt6PJgzufygU52iF1Xoib1TMmtECHDCmH
         IaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224851; x=1707829651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBttz6chzTT4VQUfv5nUC1imGW6Nqw838xbVGvEna8=;
        b=KrZxSKryyb5mqoaQmetGo7OLWgePof3/Fh5aq7M1jJOFfTnUV6lIcu9QoYPnLQHI5z
         BaN2Q4ZlN/A8c+4h9PT4hm8p75+p+FVDWmdli+PRXBwqxyRiVsp353a8ewxUNb9awABg
         P0iPnNdi7bdSuSFrJYQ381y3V7VTXLji0u2AWZXWsRb8fdCfG1/ocxBcOSSbmyc1zyTN
         Ws/eu9g5d/eMvvh5lb/sG2j6Q8lprv4yQWvtbngQ3Jc+G08mUvjMqXsSje0hmRs0D0TY
         JMTWEAIr1fXisHCt35902ir5dxASW54lav/7r09yqjhEezn/fQwPGQxyOt00psJNwUgo
         o4WA==
X-Gm-Message-State: AOJu0Ywr/ntze6YpdrXHhAFYeHsbYpPLSKUl6Y6HEYID8ZZ1xmamqpE8
	2CirwDhlT5b8PK/UW7N+TzXzL12lLOo60zqlCCz/0fX41kj5hX3V3qwHEpvxgAuBPwGSpdagEHL
	5iYk5p9OhLDN9QZGnSMpxu2h+3TNs+TlMJ94=
X-Google-Smtp-Source: AGHT+IHWeYvekneOd6TqjE289dyOlfl1mDr0QTWKUw7eyEsZ7CjuRBzA9L1cJ6LpRNafkBUo+xSfxhyi49ZxC2jyyPY=
X-Received: by 2002:a05:6214:e6b:b0:68c:9d40:d1c with SMTP id
 jz11-20020a0562140e6b00b0068c9d400d1cmr2640064qvb.0.1707224851048; Tue, 06
 Feb 2024 05:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-6-bschubert@ddn.com>
 <CAJfpegvUfQw4TF7Vz_=GMO9Ta=6Yb8zUfRaGMm4AzCXOTdYEAA@mail.gmail.com>
 <CAOQ4uxjVqCAYhn07Bnk6HsXB21t4FFQk91ywS3S8A8u=+B9A=w@mail.gmail.com>
 <CAOQ4uxjnrZngNcthc9M5U_SBM+267LMEkYxtoR6uZ8J8YNRvng@mail.gmail.com> <CAJfpegvPCkj-r1m1ndSzNzT2i_oZQUM2PARDTov0vwhqC5JrvA@mail.gmail.com>
In-Reply-To: <CAJfpegvPCkj-r1m1ndSzNzT2i_oZQUM2PARDTov0vwhqC5JrvA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 15:07:19 +0200
Message-ID: <CAOQ4uxiSQ9zemPATYPOi1sR1eVPB4jqH1eqLBGGJP+3bgZH1Zg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fuse: introduce inode io modes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:53=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 6 Feb 2024 at 13:39, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I have played with this rebranding of
> > FOPEN_CACHE_IO =3D> FOPEN_NO_PARALLEL_DIO_WRITES
> >
> > The meaning of the rebranded flag is:
> > Prevent parallel dio on inode for as long as this file is kept open.
> >
> > The io modes code sets this flag implicitly on the first shared mmap.
> >
> > Let me know if this makes the external flag easier to swallow.
> > Of course I can make this flag internal and not and FOPEN_ flag
> > at all, but IMO, the code is easier to understand when the type of
> > iocachectl refcount held by any file is specified by its FOPEN_ flags.
>
> If there's no clear use case that would benefit from having this flag
> on the userspace interface, then I'd recommend not to export it for
> now.
>
> I understand the need for clarifying the various states that the
> kernel can be, but I think that's a bigger project involving e.g. data
> and metadata cache validity, where the current rules are pretty
> convoluted.
>
> So for now I'd just stick with the implicit state change by mmap.
>

Understood.
Do you object to reserving the flag in uapi, but disallowing the
server to set it?
This is how it is in my branch after addressing you other review comments:

https://github.com/amir73il/linux/commits/fuse_io_mode-030224

  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on
the same inode
+ * FOPEN_CACHE_IO: internal flag for mmap of direct_io (reserved for
future use)
  */

> BTW, I started looking at the fuse-backing-fd branch and really hope
> we can get this into shape for the next merge window.
>

As far as I am concerned, those patches are good to go.
I was only waiting for fuse_io_mode to stabilize, in case you wanted
bigger changes there.

I will post the FUSE_PASSTHROUGH patches, based on fuse_io_mode OTM
so you could review them on-list as well.

Thanks,
Amir.

