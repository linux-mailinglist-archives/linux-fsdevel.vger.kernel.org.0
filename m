Return-Path: <linux-fsdevel+bounces-35477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E69D52A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B33928160B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB91BDAA5;
	Thu, 21 Nov 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llHUo7XR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AF6F06B;
	Thu, 21 Nov 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214278; cv=none; b=ikbV5fnCEFSbQQrkUhRpnedw3GLaX9NKr6/mdNoZ4+2JQYpf77DNWrHRgdVHdoyAFUxtLxtf6Mr6dnYTW3INnb3fylqPpjV+2ptUXLGNMA7N2mNZDbxTpg9Sgw38vagPTlS+j1BdZBZTxXTF+3lwjdU7gRZYuOd6fd3usfxkWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214278; c=relaxed/simple;
	bh=B/qr5jKGysPKImWjNbDNluNM2rS5nL4lHYsUmU1QBfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQiuWRaILmS7WEZq7uWwPUorp0mdAqo0SmZQxtk0WcG7aG7XhCLtdsLLnzispH2fwXRggJCGWZTpxLTHC0BAu3B6XiZeNlNvZgkGkToEVVg3YkdA1Rx9DPPSgd1maDG4DycOxKAFrObFjCa/6WnrFmlNs4fQF+zh/c/nwT4/QUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llHUo7XR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa4cb5fcc06so228343066b.0;
        Thu, 21 Nov 2024 10:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732214275; x=1732819075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7o6YG1r7Hvwm2rqRHDEPpPeTuZqrDtGk2bZdDwk4Qk=;
        b=llHUo7XRpAVmNOkfPah5YdpT5F4wbY+8uPGSWeOhB4oJIdCVhw+LvGrUHOcI6jzk76
         2udy2suuE+JlYzMMz801L9g0JFuvQsCkZLCWZNp+3g3pL8KEgqkiwBW8BfaUQhR9gEfn
         DeWpSUrHqaNmkfbLzk+V2kF7PuaQXSS+kmC/oStauBw7f8dUZYqK7Xkantw2dZXl/OoE
         if6/hcSirhsPQKKRvdzhWw+3DcI7byFxxNYlE4vuzVsT905QGz2Wcfwsb0i4iMGyQdVW
         osPMb+v2qi7wn1NpoNYheLo6ZmLRWhuok+sOL4l0rOawnJd06/O1CwicbjJnhj8Z7lUK
         K1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214275; x=1732819075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7o6YG1r7Hvwm2rqRHDEPpPeTuZqrDtGk2bZdDwk4Qk=;
        b=uH5kZkjg2PgevuhrHLvgVmZ1nPT8wO9HufJ806hjSyivcjl/blUuSKM+UxCR0O56l8
         wGG3MP4H+0w8O99uNbjgCRAg1nN6g1OJCPSBCupJ7t7dYECQ+89H8txpIWhAxmWOWgyL
         TX4nCTJ5UjFpm/qjB6YOybGM+xnP17tn7i0Cuko5P7UDkIszt0Pgiur0ao/UwyalZy/y
         /1BYUxO0iV9DzwRKuarOIv+jpQxa53+0xitjQYMDgTq77pQXRg/MBaxr7MkcUCLQj9Ed
         igvR93onNZvBQsxKbnZdFxm6sPDz1S+w5nREhyXP/CmxQwKfvgVUVq6M7EWMoFL8DPPn
         gaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUhCaScpeAHrMZt8wn9d0FrjOmCaH5D594vatQ7REswKY3BljY59QJGvPyfMXbhcaltLyQj9G9aL9IV0A==@vger.kernel.org, AJvYcCV6ZWB+vPuMJNw13vmeL4QobbAie35U7wDUmvEWnOumnkNoO4QCjXJJuNByBA0DFE7KYkGUg4ycqPMsIA==@vger.kernel.org, AJvYcCVBS+DvZLmFSul8qBvO+OE665/Eee9SezJTZkQbSzCH+yEsqvZ+T3LuCEr+Wba3D0pKXE1V/dXJ+RWU@vger.kernel.org, AJvYcCW5Lw2PcGYeD+dKayebUMYvVX0VnEyA3gC5N6txf66EVW8cuNs3mqHcKcH2q0Kf6c1wmwmeXIUaLeb/66MFyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GVZA2ZeVpePgFh3U/yMEpz8+rz9GTohY6LykIRxE6nbL7x3W
	jv/+TdI1UzR5D+NZaDeupEAnL6LriKMUXzSvA5c/b4tV6XfPL2exiufRiW+EJeCeSTfrZn/Bsr0
	RHUkKyP0RowdpLUhH9gEPGKRD5D4=
X-Gm-Gg: ASbGncung/ExkCTfT73Zjlgqo+5B9KFPb6GI9yPwV+k4SlTPCo862RJp85mj5cqMDti
	s8g2kPURqIjHpFcOGOxGCMO0F/iozEng=
X-Google-Smtp-Source: AGHT+IEorAjckwDToOujNx0EuXDqrQ9VD8gBqiBM+3DSRRW1VXzYujlBwDfZLVLYJiWoKbQslITNjSKdF77KCW19lgQ=
X-Received: by 2002:a17:907:3f9b:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-aa509d0a2afmr21791666b.50.1732214274751; Thu, 21 Nov 2024
 10:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3> <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3> <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 19:37:43 +0100
Message-ID: <CAOQ4uxgsjKwX7eoYcjU8SRWjRw39MNv=CMjjO1mQGr9Cd4iafQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 21, 2024 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > > On Thu, Nov 21, 2024 at 11:44=E2=80=AFAM Jan Kara <jack@suse.cz> wrot=
e:
> > > >
> > > > On Fri 15-11-24 10:30:23, Josef Bacik wrote:
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > Similar to FAN_ACCESS_PERM permission event, but it is only allow=
ed with
> > > > > class FAN_CLASS_PRE_CONTENT and only allowed on regular files and=
 dirs.
> > > > >
> > > > > Unlike FAN_ACCESS_PERM, it is safe to write to the file being acc=
essed
> > > > > in the context of the event handler.
> > > > >
> > > > > This pre-content event is meant to be used by hierarchical storag=
e
> > > > > managers that want to fill the content of files on first read acc=
ess.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Here I was wondering about one thing:
> > > >
> > > > > +     /*
> > > > > +      * Filesystems need to opt-into pre-content evnets (a.k.a H=
SM)
> > > > > +      * and they are only supported on regular files and directo=
ries.
> > > > > +      */
> > > > > +     if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> > > > > +             if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM)=
)
> > > > > +                     return -EINVAL;
> > > > > +             if (!is_dir && !d_is_reg(path->dentry))
> > > > > +                     return -EINVAL;
> > > > > +     }
> > > >
> > > > AFAICS, currently no pre-content events are generated for directori=
es. So
> > > > perhaps we should refuse directories here as well for now? I'd like=
 to
> > >
> > > readdir() does emit PRE_ACCESS (without a range)
> >
> > Ah, right.
> >
> > > and also always emitted ACCESS_PERM.
> >
> > I know that and it's one of those mostly useless events AFAICT.
> >
> > > my POC is using that PRE_ACCESS to populate
> > > directories on-demand, although the functionality is incomplete witho=
ut the
> > > "populate on lookup" event.
> >
> > Exactly. Without "populate on lookup" doing "populate on readdir" is ok=
 for
> > a demo but not really usable in practice because you can get spurious
> > ENOENT from a lookup.
> >
> > > > avoid the mistake of original fanotify which had some events availa=
ble on
> > > > directories but they did nothing and then you have to ponder hard w=
hether
> > > > you're going to break userspace if you actually start emitting them=
...
> > >
> > > But in any case, the FAN_ONDIR built-in filter is applicable to PRE_A=
CCESS.
> >
> > Well, I'm not so concerned about filtering out uninteresting events. I'=
m
> > more concerned about emitting the event now and figuring out later that=
 we
> > need to emit it in different places or with some other info when actual
> > production users appear.
> >
> > But I've realized we must allow pre-content marks to be placed on dirs =
so
> > that such marks can be placed on parents watching children. What we'd n=
eed
> > to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn't we=
?
>
> Yes, I think that can work well for now.
>

Only it does not require only check at API time that both flags are not
set, because FAN_ONDIR can be set earlier and then FAN_PRE_ACCESS
can be added later and vice versa, so need to do this in
fanotify_may_update_existing_mark() AFAICT.

Thanks,
Amir.

