Return-Path: <linux-fsdevel+bounces-57942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C733B26DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693FE7A9A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4931077D;
	Thu, 14 Aug 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMqCJfnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545F1DE8B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194051; cv=none; b=tr7esupVr9TbG1/dP5j+MiHFkw2CegNhxCBIYidWWKkcJ8mOWDbTMBumtEvJrlU7MscNab5ugAz2Lb3cJwk4TwpSwqrepGFjUE3x7kKWtr0u7eAMhdhDF11GAXZ2a5w2bY5AdBjNsM+b64XzYFsAnBNbQwFbnS2FNbTGE28k15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194051; c=relaxed/simple;
	bh=Uh0bFpns+1Rgj+c15jFS/ZJt4z+WS/nsy2pUTvwNs4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzFvvpWZPayZKZ2uWjjuziPdSuPdeIes/VcXfrBI3CtDj+cscaR77u9zHay8OuD7ryu+UDYMCobYEoS/cacV4Bt5YbIUV50qfkQBrWOY3IqRl6Bk8CQ/Lar6k5/qFB69UdexLRNLw+pZ57+JgzyJpcQWeenMa/cJ9iJWyeKNo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMqCJfnJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109ae67fdso16033961cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755194048; x=1755798848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yShu0wnupLjHzmlxEsVI6C41XoFMfVK9fKU48jbRyTA=;
        b=KMqCJfnJ7NGcuPXh8BDS4myrievzuaC77pwIoaJEP1UgUnBqdI7gEEy7d/OQd9qrtQ
         KtdMx6PFQa2vuBAdSXbEWB98sI2XswIKIAd2U+Dex16MEh+SuQIv5CntsHRB29h566ff
         AiRGQ3LIsltywCylowrPSZHnafCWoEMtHE0fZOXygFWl7XonMQ5Gl/hzXRaEBla5/qyK
         YqXm6L/9aHljc8ZGc7a6wn+UT4qd9DYc0eYrKHkBx1ENKlGiohHuSxbyIva6bDnwLmF4
         4/fbmYsza3BBtmCj/pvpgjjpr+bgxvDOVz2rJza1O5GITs6h0Wdd7X10AsNrDfCGtb9N
         wBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194048; x=1755798848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yShu0wnupLjHzmlxEsVI6C41XoFMfVK9fKU48jbRyTA=;
        b=K5bxiZpgaNJlzk3DEuZuDXnxByKxyE/1lBEvlMs+LnnRJ8UpQoMeG1/X2C1icFYC47
         HA44Mv7Kmvqo3TE5ySdS4UhzKBGCqrkb2UQng8nQhC3NZIgQZqMP4cO7Vg+lyWCZzSiJ
         W8OM55LI71YddnELWawn/QmBzI+dPJDoUGxB4kknspHo7U2awV4V7E/EObQOhWIEBhJS
         cavyI9xqibmlt+lX4aovNoLbzu/85qS3LFe711Pw+UxGNG8xD/SWeXcWrGpyNCJjhbXF
         vhTMGEfFHXsP+c1LwzQL2iCFd6isg7yiyj3rI0ySYDgJ03HYR7UHQnjOIkfGqKQAoyPu
         4BjA==
X-Forwarded-Encrypted: i=1; AJvYcCXwVp3lgDHZXBY0A/cz5YWWS3vlG0mRy5+d5NiYVnpURIFz3ksJb96AXaownSf3KuQ8HV3ol4TpWTmC+SDa@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjiY7X8HwZH+FeLDFzU3PmvZLsm+IFtSU873AGqqA7axfqQ2r
	xKBzq6ehhTElaQCsKoG5ZIF86YxZ7GRNcqJIo/wzsAgrah9N1sL8P31NkuXsxj20XC2m/sRbrX0
	u3JJ+j6zxZsuTQ5aJzZBcDUjYcAVpwIc=
X-Gm-Gg: ASbGncuHI6o0Q74ToE011J06riwjPwSlYs3Z7cSSXPMfg20WBG0FVm+qYNgWYdooNXg
	jc/2W3b9W7Nfloqo4HL4br1pJqPvhojazCg/Zu9z4yNQzyUZ4tquvrnrhKJJ7Zv6rx3jQj0Hdug
	+YoMXywerZxQjgs8FGc5YxeuMbvmst/JpwugMVBpHUdl3wrBmFWM8YUb4tlda6lf2p/9dZSuOnE
	tnORD+9
X-Google-Smtp-Source: AGHT+IF+KZMsaSr1UdOYb+EhaaTdo4amWspPcrDFUONwp3xEoMcDHqd+slYmnFxRlqRANQapA9/t0f+WgvgL0/ydsU8=
X-Received: by 2002:a05:622a:5e0a:b0:4b0:a130:4777 with SMTP id
 d75a77b69052e-4b115d16066mr16672531cf.30.1755194048075; Thu, 14 Aug 2025
 10:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152014.100048-1-mszeredi@redhat.com> <20250813152014.100048-4-mszeredi@redhat.com>
 <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com> <20250814170459.GS7942@frogsfrogsfrogs>
In-Reply-To: <20250814170459.GS7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 14 Aug 2025 10:53:56 -0700
X-Gm-Features: Ac12FXzs2mCHCpS5PqSS8NOH3KLJpeZcF6uHpQXNgMRDyRs8Pr6HBucAxtEbuQ8
Message-ID: <CAJnrk1bxfmTw118bxcaa1Avr4xN0DamPFoyqtKHnR=8Ks6FJwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large copies
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, 
	Chunsheng Luo <luochunsheng@ustc.edu>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:05=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Aug 13, 2025 at 10:03:17AM -0700, Joanne Koong wrote:
> > On Wed, Aug 13, 2025 at 8:24=E2=80=AFAM Miklos Szeredi <mszeredi@redhat=
.com> wrote:
> > >
> > > The FUSE protocol uses struct fuse_write_out to convey the return val=
ue of
> > > copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_=
RANGE
> > > interface supports a 64-bit size copies and there's no reason why cop=
ies
> > > should be limited to 32-bit.
> > >
> > > Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> > > number of bytes copied is returned in a 64-bit value.
> > >
> > > If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> > > COPY_FILE_RANGE.
> >
> > Is it unacceptable to add a union in struct fuse_write_out that
> > accepts a uint64_t bytes_copied?
> > struct fuse_write_out {
> >     union {
> >         struct {
> >             uint32_t size;
> >             uint32_t padding;
> >         };
> >         uint64_t bytes_copied;
> >     };
> > };
> >
> > Maybe a little ugly but that seems backwards-compatible to me and
> > would prevent needing a new FUSE_COPY_FILE_RANGE64.
>
> I wonder, does fuse_args::out_argvar=3D=3D1 imply that you could create a
> new 64-bit fuse_write64_out:
>
> struct fuse_write64_out {
>         uint64_t size;
>         uint64_t padding;
> };
>
> and then fuse_copy_file_range declares a union:
>
> union fuse_cfr_out {
>         struct fuse_write_out out;
>         struct fuse_write64_out out64;
> };
>
> passes that into fuse_args:
>
>         union fuse_cfr_out outarg;
>
>         args.out_argvar =3D 1;
>         args.out_numargs =3D 1;
>         args.out_args[0].size =3D sizeof(outarg);
>         args.out_args[0].value =3D &outarg;
>
> and then we can switch on the results:
>
>         if (args.out_args[0].size =3D=3D sizeof(fuse_write64_out))
>                 /* 64-bit return */
>         else if (args.out_args[0].size =3D=3D sizeof(fuse_write_out))
>                 /* 32-bit return */
>         else
>                 /* error */
>
> I guess the problem is that userspace has to know that the kernel will
> accept a fuse_write64_out, because on an old kernel it'll get -EINVAL
> and ... then what?  I think an error return ends the request and the
> fuse server can't just try again with fuse_write_out.
>

I think this would also need the feature flag sent in the init call
which Miklos didn't like


> <shrug> Maybe I'm speculating stupi^Wwildly. ;)
>
> --D
>

