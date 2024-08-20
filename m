Return-Path: <linux-fsdevel+bounces-26393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E3958E15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 20:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B1FB22D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05A14A624;
	Tue, 20 Aug 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R070migP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1C146D6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178711; cv=none; b=l91/W/n/eQsw09jKNIpLEc8HANWebEYKx+iYUPIViCAqyAmNZeDuMmFSRYqdAszPCHwE2n6X3YMkgf4EET3DzRVd540ii8R3r5+WaZeXEfZ0hVbpiyJLj+1uK4TyWNQraBwV6H9NeFdNAHheQkXDo/FaAXI1R1nmn6mvmf7noG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178711; c=relaxed/simple;
	bh=LV3TaNG99H37v39wYbv0DwRniNXWsy4ieKIP6WxrsGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmhNKRsOUpCk44PMKt2wg7SpvSKEtFaVndBTekVlomUuHGpeh5LzgIPLGbd6KUOJOiXv0UK9kLmiSzzgT8iaI3IvmYgyMoiIL7noM2JuYRhGk9Pc6P11mncgsS7+1jxlprOIXe0UL84NLCAL/5kP9cKVBOZRA4W3oSWDOnVAHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R070migP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe58fcf29so32772781cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724178708; x=1724783508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWxT53jyejFJ9Wf/nyNtKfxmin5r77vfDoK8jvpy4KI=;
        b=R070migP2qy7PdhcbLZiaYWpWcpOa8BKzqzvQ+3/sDFGCMjf6Ob8vo44cNP5REPTWO
         1mRvExs2wFEPk5Umb6iRojN8n22nEDufmDlHTomGmJRKj8NYVLyG79M3wIzurZjMZyUt
         W1pTRlppv5tb8tH2qOvKVvB700iTbhE94nMz9pNuzysfo7sQ1pGF6kfiBeXnOrPXIdUK
         Xwx73lgk9TCSVw6LbHRZi0CUdOgOXClkjSNd2/tDv+mRCLf0cUJaSNg8ApvQZR5jwgfl
         rb2c8dxQkYf2JwF6VpQoSMJ1OU3HLVuMZHyM4eCIfr2+Fg4cMbfeNwF0AQqnGNRIcNJF
         uNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178708; x=1724783508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWxT53jyejFJ9Wf/nyNtKfxmin5r77vfDoK8jvpy4KI=;
        b=gziUXr2Tkw8dV3FQAI/pSPtJ7soCjVVVBhRoW/tvBR3nGKYRkLjLYdmlQohe7/dJQ7
         SBXPEG4rSOcLwfIJ80OvPNzZLT9Zkbt5IqP1CuQHhR7UbZrDb+9z2hQX01XK5uJJa9kt
         N5UfxjSoG+/ONFv+IBaIp5UQdk2f0onhD73mYC5YzkV10mgKEJoWGR57p9ZNomHuCOG/
         pgkeojrN90KLnznmzduCAZGRGqxM8lznSYl6dXpbpODwr/3Uqba/HXjEISZUu/akcarV
         dNduM/+snhXWatRzB0UZU2JGZwlb0lpVaIBx2D9e6V9aR/VC0pHqwNzyykP/k0Z23Y5s
         tSUg==
X-Forwarded-Encrypted: i=1; AJvYcCVv1QYjUYeBsW3NZS7nQtPoyjEHMMkOAuN9san0t630+agvF1vS0jFuF5zGM6NWgQJekljAPa0WiL2chJti@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2uA9PjpSBsBXjyALVr62mxWhP8JwYQVwt1S5/3JHy9xzTF6Q
	AktuXBBeIkm0xY/KFnkmq+kI6lRN0UoZHroxfHqH0Rlm7yM3+rI60w8phxaj7YnfklLrRoVGp8X
	cIC8Oa+5rprWOJRCial41a+cCWes=
X-Google-Smtp-Source: AGHT+IG/nNzAhTr4xSXGdavEVGd7ujQRYUefomJQc6P8cxMDX36ZepiJ7JVxn3Xf+9b3Qm502QI1fGoi8gHFcGm917w=
X-Received: by 2002:a05:622a:418f:b0:453:1eb5:dec1 with SMTP id
 d75a77b69052e-4537437645bmr229634551cf.50.1724178708499; Tue, 20 Aug 2024
 11:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-3-joannelkoong@gmail.com> <CALOAHbDt6QiUt4mzMx2DS=16u5dx1tnPBqO2kT4gh_9gBgoq1A@mail.gmail.com>
In-Reply-To: <CALOAHbDt6QiUt4mzMx2DS=16u5dx1tnPBqO2kT4gh_9gBgoq1A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Aug 2024 11:31:37 -0700
Message-ID: <CAJnrk1aVLeFTmW-zYhoFhsvQ148C1XF8a+qda48GZqqU7UiP-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:40=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Wed, Aug 14, 2024 at 7:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control timeouts on replies by the
> > server to kernel-issued fuse requests.
> >
> > "default_request_timeout" sets a timeout if no timeout is specified by
> > the fuse server on mount. 0 (default) indicates no timeout should be en=
forced.
> >
> > "max_request_timeout" sets a maximum timeout for fuse requests. If the
> > fuse server attempts to set a timeout greater than max_request_timeout,
> > the system will default to max_request_timeout. Similarly, if the max
> > default timeout is greater than the max request timeout, the system wil=
l
> > default to the max request timeout. 0 (default) indicates no timeout sh=
ould
> > be enforced.
> >
> > $ sysctl -a | grep fuse
> > fs.fuse.default_request_timeout =3D 0
> > fs.fuse.max_request_timeout =3D 0
> >
> > $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >
> > $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 0xFFFFFFFF
> >
> > $ sysctl -a | grep fuse
> > fs.fuse.default_request_timeout =3D 4294967295
> > fs.fuse.max_request_timeout =3D 0
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> >  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
> >  fs/fuse/Makefile                        |  2 +-
> >  fs/fuse/fuse_i.h                        | 16 ++++++++++
> >  fs/fuse/inode.c                         | 19 ++++++++++-
> >  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
> >  5 files changed, 94 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/fuse/sysctl.c
> >
> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/ad=
min-guide/sysctl/fs.rst
> > index 47499a1742bd..44fd495f69b4 100644
> > --- a/Documentation/admin-guide/sysctl/fs.rst
> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit ke=
rnel, and roughly 160 bytes
> >  on a 64-bit one.
> >  The current default value for ``max_user_watches`` is 4% of the
> >  available low memory, divided by the "watch" cost in bytes.
> > +
> > +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This directory contains the following configuration options for FUSE
> > +filesystems:
> > +
> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> > +setting/getting the default timeout (in seconds) for a fuse server to
> > +reply to a kernel-issued request in the event where the server did not
> > +specify a timeout at mount. 0 indicates no timeout.
>
> While testing on my servers, I observed that the timeout value appears
> to be doubled. For instance, if I set the timeout to 10 seconds, the
> "Timer expired" message occurs after 20 seconds.
>
> Is this an expected behavior, or is the doubling unavoidable? I'm okay
> with it as long as we have a functioning timeout. However, I recommend
> documenting this behavior to avoid any potential confusion for users.

Hi Yafang,

Are you testing this by running "cat hello" from the libfuse hello
example server and seeing the doubled timeout?

This is happening because cat hello sends two FUSE_READ requests. The
first FUSE_READ is a background request (called from
fuse_readahead()). I confirmed that this takes 10 seconds to time out
and then the timeout handler kicks in. Then the second FUSE_READ is a
regular request (called from fuse_read_folio() -> fuse_do_readpage()).
This second request also takes 10 seconds to time out. After this
second request times out is when the "cat hello" returns, which is why
the overall time is 20 seconds because of the 2 requests each taking
10 seconds.

Thanks,
Joanne

>
> --
> Regards
> Yafang

