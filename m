Return-Path: <linux-fsdevel+bounces-66857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F48C2DF4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 20:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA6A189517C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D42BDC09;
	Mon,  3 Nov 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJjJmrtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FF284690
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199941; cv=none; b=AK+UORumqadYXa5nHtuTkjNYckAX6C8D2OLANPxgrVpr+HuYelNIsuBhz2QRfXVLF13f9KJLsCKAZpZX1qZ2WUZ/rE9woLXU/VBZccT3UU1x1T6/Miu7NwMk1j0WM6phSiZMPn2Xs7amWOBX71RRl4rccO7A6/iT0VI3nDWQUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199941; c=relaxed/simple;
	bh=7q4pM3Xb7E1uNd//nS8BqYRs4/PU+D3Ma23uRkfg0Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwBF6mDVYeB2JDdnNqaeynV+nAZK43pnpyjqqWC2A+/2y92vV8NRDYeCiwbae+lTANvuxBv7qkn5edI07xSQEEBuv5aaMwlIcI8cMJ0W4jYbV0XcmRBplrolTUfVK4alp5kxgvfOJ9xiM9fDz8xn8v9cYhCDCBNrZwyr8/s7Mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJjJmrtX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29555415c5fso31308535ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199939; x=1762804739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRL3ScLiWS5r2MDUzg9ClFfrht8FkZln8Q5mKnzs+ZY=;
        b=hJjJmrtXfAO5RnnrqKxRmCEJb5XsH8sXVpS2BB0HfVhCvV5WavuAeT9m0RTKh4jk8O
         KmadhoNk/YMIJQZXN7V6yA3qN4XZZWp6xM/8fBOGphD5OCTVp3e5AZ+F1RRZeYhqKHXs
         8hWYiiBuYni4I4AVym95sZXwbKk4dCFudWOUFOa/d17NVnXBhCF0hSQE7lKMBq8EeMOS
         zCYd333qzcLd8VRPQ08iKQLopfxfW/S79U4DpaBBvNeJJJ69nYLOlvJHtvt9YWztxhIb
         w6alCALOKyxFGFYZj4f3rRVeL/UyLjImLWaESIxYfVHjXnBhdvcIe4XNvSZianxDh/yI
         YiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199939; x=1762804739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRL3ScLiWS5r2MDUzg9ClFfrht8FkZln8Q5mKnzs+ZY=;
        b=iz3XX8B8Gt3fA5zsX7uwDNeXGmT7eujk7AQsR8ZF8l5mldaAcvAT/xgxC+ME0/pWyk
         0YRTIUK3QMiAA4YJSoW8geGGDTKvYdX5B1uF0FQFi6JcOGrD8EO5QSPz0VU230sl7DLo
         Rh9yRHvFE3tbXinZqGmq7wqbpOQL6aI3LjPpt3FhIJOKH76sGYZmyr4tr74XNdptjPRS
         dXBTc5T9ROHEYjbIMsmXWEBdRz81xDpg4mOpNn3XlCTZvKxsb9BbZFwYq4Ge2xEGaEyV
         /0fKJYlNRVz83o/gv0jtqcvMhKvNNUlK6iXLOEIM1KWavrVgMtrcnmRVP7UJWAoFTIee
         ltQA==
X-Forwarded-Encrypted: i=1; AJvYcCW9BNWGW3b3QClh6uM/wVnOu/sBLSn+WiwyLErRJX/rsGNdfLqJTV9ZDI4OnO/SFZhPBM/96hw3lJiFzlxa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Jj53fPtW3fDcIIGHTTn2VRNyDYju80hgWDGn5E3XUKQZKaGX
	yLiMq6OLy6QMZQJadla87v53gPXgRCjR72KXfriAs1qYBETF7zQdzNP3SgMsTlMpfuRxoS6VSX6
	8KwFHK+cSJhnfzJ9jH2/OjBS+2p/sxUo=
X-Gm-Gg: ASbGncv9cJWfHuXR0jbdnsXSCM+T+cQFzZiG3D3OoTYVPFv0fb7faquNn7UlYqTYko0
	/UYuPyQjNC865m56dNOtbyINoMRXEPRtqM6t6THmuNzSz+YR70Alvtt6F8xuQR2tEGJQAjXyLvF
	3s7dchdfCs5h5tQdMWqddlZeHjE5S12IiGG3CcGBGSiLP5vuQx8zY+lqQqry3UkPSVika2Dx0q4
	sGgn0EFnWQ5cIV5kC9caT9VbIdRFRqxFOZYuV2OMyDuegeEYQtica5DXClUc4aeN5v3wEk=
X-Google-Smtp-Source: AGHT+IEWuX3dlSNA9ptTfOP60ilI+6QAg2Djc7tFHPEdSqDQ1aelp6YGIUK+BS3UC2DkdnTMWkra+ckpLt644WkgiX8=
X-Received: by 2002:a17:902:d2cb:b0:293:e5f:85b7 with SMTP id
 d9443c01a7336-2951a38de8cmr213138925ad.11.1762199939277; Mon, 03 Nov 2025
 11:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821225147.37125-2-slava@dubeyko.com> <CAOi1vP_ELOunNHzg5LgDPPAye-hYviMPNED0NQ-f9bGaHiEy8A@mail.gmail.com>
 <5e6418fa61bce3f165ffe3b6b3a2ea5a9323b2c7.camel@ibm.com>
In-Reply-To: <5e6418fa61bce3f165ffe3b6b3a2ea5a9323b2c7.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 3 Nov 2025 20:58:46 +0100
X-Gm-Features: AWmQ_bkKhOiN2NGdFGlTH3aQyYQWzzHYQk5yIUTRkWhwqBe7QGKP9d4W7lmsgYE
Message-ID: <CAOi1vP8PCByY3dKu9cSDWo8B9QMaqRT23BYzkd1Q2H0Vs=YjxA@mail.gmail.com>
Subject: Re: [PATCH v8] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:34=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi Ilya,
>
> On Sun, 2025-10-12 at 22:37 +0200, Ilya Dryomov wrote:
> > On Fri, Aug 22, 2025 at 12:52=E2=80=AFAM Viacheslav Dubeyko <slava@dube=
yko.com> wrote:
> > >
> > >
>
> <skipped>
>
> > >
> > > v8
> > > Ilya Dryomov has pointed out that __ceph_open_session()
> > > has incorrect logic of two nested loops and checking of
> > > client->auth_err could be missed because of it.
> > > The logic of __ceph_open_session() has been reworked.
> >
> > Hi Slava,
> >
> > I was confused for a good bit because the testing branch still had v7.
> > I went ahead and dropped it from there.
> >
>
> I decided to finish our discussion before changing anything in testing br=
anch.
>
> > >
> > > Reported-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  net/ceph/ceph_common.c | 43 +++++++++++++++++++++++++++++++++++-----=
--
> > >  net/ceph/debugfs.c     | 17 +++++++++++++----
> > >  net/ceph/mon_client.c  |  2 ++
> > >  net/ceph/osd_client.c  |  2 ++
> > >  4 files changed, 53 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > > index 4c6441536d55..2a7ca942bc2f 100644
> > > --- a/net/ceph/ceph_common.c
> > > +++ b/net/ceph/ceph_common.c
> > > @@ -790,8 +790,18 @@ EXPORT_SYMBOL(ceph_reset_client_addr);
> > >   */
> > >  static bool have_mon_and_osd_map(struct ceph_client *client)
> > >  {
> > > -       return client->monc.monmap && client->monc.monmap->epoch &&
> > > -              client->osdc.osdmap && client->osdc.osdmap->epoch;
> > > +       bool have_mon_map =3D false;
> > > +       bool have_osd_map =3D false;
> > > +
> > > +       mutex_lock(&client->monc.mutex);
> > > +       have_mon_map =3D client->monc.monmap && client->monc.monmap->=
epoch;
> > > +       mutex_unlock(&client->monc.mutex);
> > > +
> > > +       down_read(&client->osdc.lock);
> > > +       have_osd_map =3D client->osdc.osdmap && client->osdc.osdmap->=
epoch;
> > > +       up_read(&client->osdc.lock);
> > > +
> > > +       return have_mon_map && have_osd_map;
> > >  }
> > >
> > >  /*
> > > @@ -800,6 +810,7 @@ static bool have_mon_and_osd_map(struct ceph_clie=
nt *client)
> > >  int __ceph_open_session(struct ceph_client *client, unsigned long st=
arted)
> > >  {
> > >         unsigned long timeout =3D client->options->mount_timeout;
> > > +       int auth_err =3D 0;
> > >         long err;
> > >
> > >         /* open session, and wait for mon and osd maps */
> > > @@ -813,13 +824,31 @@ int __ceph_open_session(struct ceph_client *cli=
ent, unsigned long started)
> > >
> > >                 /* wait */
> > >                 dout("mount waiting for mon_map\n");
> > > -               err =3D wait_event_interruptible_timeout(client->auth=
_wq,
> > > -                       have_mon_and_osd_map(client) || (client->auth=
_err < 0),
> > > -                       ceph_timeout_jiffies(timeout));
> > > +
> > > +               DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > > +
> > > +               add_wait_queue(&client->auth_wq, &wait);
> > > +
> > > +               if (!have_mon_and_osd_map(client)) {
> >
> > Only half of the original
> >
> >     have_mon_and_osd_map(client) || (client->auth_err < 0)
> >
> > condition is checked here.  This means that if finish_auth() sets
> > client->auth_err and wakes up client->auth_wq before the entry is added
> > to the wait queue by add_wait_queue(), that wakeup would be missed.
> > The entire condition needs to be checked between add_wait_queue() and
> > remove_wait_queue() calls -- anything else is prone to various race
> > conditions that lead to hangs.
> >
> > > +                       if (signal_pending(current)) {
> > > +                               err =3D -ERESTARTSYS;
> > > +                               break;
> >
> > If this break is hit, remove_wait_queue() is never called and on top of
> > that __ceph_open_session() returns success.  ERESTARTSYS gets suppresse=
d
> > and so instead of aborting the opening of the session the code proceeds
> > with setting up the debugfs directory and further steps, all with no
> > monmap or osdmap received or even potentially in spite of a failure to
> > authenticate.
> >
>
> As far as I can see, we are stuck in the discussion. I think it will be m=
ore
> productive if you can write your own vision of this piece of code. We are=
 still
> not on the same page and we can continue this hide and seek game for a lo=
ng time
> yet. Could you please write your vision of this piece of modification?

Hi Slava,

Sure, I can take over and offer my own patch.

Thanks,

                Ilya

