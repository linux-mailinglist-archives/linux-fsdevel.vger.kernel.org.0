Return-Path: <linux-fsdevel+bounces-28604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CD96C563
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82732B22AB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434B7E563;
	Wed,  4 Sep 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5dO4C6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EE1CF7D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470651; cv=none; b=dA3C6p+nvoo0G4bF+sVlmyBvPvK5rKSgUu+8tqsjV0UjbCAriqWV3M5sqdjPsmUBU5h8WSYrQgT5HyQV+qBcmjtFpay1qkfrtfKEga3OpVlLG8GBH/4X3hktfEseYTf5xPmnDkVOAgcxBxBafs7zn5zHaOz6GUActJmbGAVC70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470651; c=relaxed/simple;
	bh=hYWIFTCWPDOOcyHVcqr7xdbiotAas5n45rzLtwedOGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPQyNzi1BkH1zGQ1UCW6wxMbLmoC8GuZLFqaLVuclFRC6e2PlUnOHFlk0n3YBBWEMx2hgx6Fv9NDwiB37fQeWWabcySORmp1EW6mRUbJ2UEVyKD7zbYmFp66WVupjobO3TQadbt9TDjE1L3ckdj/6NVsnUA0Ru47HNR5XgRq9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5dO4C6/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-456768fb0a6so38646541cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725470648; x=1726075448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9luyBQMCTCizbzMdVQtQhjTYZ5KShL11WBJv/dco4N8=;
        b=T5dO4C6/UMNUiOcGj7dh6p7Z2vqZ+9lRnRfU6qbv1kEACXZzi2jmS/BTCjMy9enHIa
         EZ4qS7v31OUuFOPvwaXxu2axRIRTiq2/sJwxTOnrGFUQsPIjEH9HuYAw+UODOznD4eJU
         0FEYN+7XriUbjdInxRTzjnPZxeDfW/1kdk+4pM+YpY1rgmk2CFnqQeiMm2krIaxhh2Ah
         3qxFL9kXK7ed/Bks1jOlYAmmYCu065RraKB0QXEqpt7ZEuFcPvsN18javt5AyRnCcYwm
         Ac55t7WbqrvSqdOzRIZm4V5Kn+aT0Meg+2YtGhL1n/TGePWy6NBJhhSZpC9Nk6VQjUyV
         BTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725470648; x=1726075448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9luyBQMCTCizbzMdVQtQhjTYZ5KShL11WBJv/dco4N8=;
        b=CtXxs3/aB6FQjxnF4/PZq3uUlzklyOYUZAGJdK33frW+acqAD+aYyK6Z/c4cDMjPGw
         DVJdWfVX9sI6p865P2z/v5aq4s4Cgg0J9pBMeUgWqW9W9Nz3qNZAW88Bq5cNdjCrjB56
         PB4Kd+AA4UkWj/qhLisEGSctJZpJNC6peejGGKBKhkDvSIhBgRZoKZuepheXSM9Y0LnQ
         ihgnZspPqF5wGWA9PUJ0mGIMRFZHP9gRVu38wpWVCL2D8OMauzQTcfCJxzwWjA8wdXyb
         HmwiuZAV7dvgUceiQIUPL+QpE7+i0f/prDsbOzRMienAslYbLtQMCigZ/p//+qDnTh/j
         TEFg==
X-Forwarded-Encrypted: i=1; AJvYcCWn8rlnvFCpKCAIyh4cSV38jhkkVcy/+ENxkqyp1/fBI2S4oD5prQNAWSEMLXnGeb02aXtevOIn0UnX6To9@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbcZpK4gUmDwpEePkVk8PLZ3nv/eniLGptsDAelX2WsyeMQpE
	pjAwdzFKy0/va0yE6sISTjUR71mEjaC+o7sxL+4M58b8sWqNMLQ59AeHFN2toMLd/gAaThPNn43
	o2UPLY5fBvTETR9hvoTnXwuI1EyY=
X-Google-Smtp-Source: AGHT+IFH/ixQkYVsCUEVwrAFhbB0xDrnxVfS9IMDtgXcED1Ny/hiNaIhNeK64mkKmls53jaf6lw80tIeMbak39PeKow=
X-Received: by 2002:a05:622a:510d:b0:457:d461:73ed with SMTP id
 d75a77b69052e-457e2dc484bmr112523311cf.32.1725470648091; Wed, 04 Sep 2024
 10:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com> <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm>
In-Reply-To: <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 4 Sep 2024 10:23:57 -0700
Message-ID: <CAJnrk1ZSp97F3Y2=C-pLe_=0D+2ja5N3572yiY+4SGd=rz1m=Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:38=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 9/3/24 19:25, Joanne Koong wrote:
> > On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >>
> >> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wr=
ote:
> >>>
> >>> There are situations where fuse servers can become unresponsive or
> >>> stuck, for example if the server is in a deadlock. Currently, there's
> >>> no good way to detect if a server is stuck and needs to be killed
> >>> manually.
> >>>
> >>> This commit adds an option for enforcing a timeout (in seconds) on
> >>> requests where if the timeout elapses without a reply from the server=
,
> >>> the connection will be automatically aborted.
> >>
> >> Okay.
> >>
> >> I'm not sure what the overhead (scheduling and memory) of timers, but
> >> starting one for each request seems excessive.
> >>
> >> Can we make the timeout per-connection instead of per request?
> >>
> >> I.e. When the first request is sent, the timer is started. When a
> >> reply is received but there are still outstanding requests, the timer
> >> is reset.  When the last reply is received, the timer is stopped.
> >>
> >> This should handle the frozen server case just as well.  It may not
> >> perfectly handle the case when the server is still alive but for some
> >> reason one or more requests get stuck, while others are still being
> >> processed.   The latter case is unlikely to be an issue in practice,
> >> IMO.
> >
> > In that case, if the timeout is per-connection instead of per-request
> > and we're not stringent about some requests getting stuck, maybe it
> > makes more sense to just do this in userspace (libfuse) then? That
> > seems pretty simple with having a watchdog thread that periodically
> > (according to whatever specified timeout) checks if the number of
> > requests serviced is increasing when
> > /sys/fs/fuse/connections/*/waiting is non-zero.
> >
> > If there are multiple server threads (eg libfuse's fuse_loop_mt
> > interface) and say, all of them are deadlocked except for 1 that is
> > actively servicing requests, then this wouldn't catch that case, but
> > even if this per-connection timeout was enforced in the kernel
> > instead, it wouldn't catch that case either.
> >
> > So maybe this logic should just be moved to libfuse then? For this
> > we'd need to pass the connection's device id (fc->dev) to userspace
> > which i don't think we currently do, but that seems pretty simple. The
> > one downside I see is that this doesn't let sysadmins enforce an
> > automatic system-wide "max timeout" against malicious fuse servers but
> > if we are having the timeout be per-connection instead of per-request,
> > then a malicious server could still be malicious anyways (eg
> > deadlocking all threads except for 1).
> >
> > Curious to hear what your and Bernrd's thoughts on this are.
>
>
> I have question here, does it need to be an exact timeout or could it be
> an interval/epoch? Let's say you timeout based on epoch lists? Example
>
> 1) epoch-a starts, requests are added to epoch-a list.
> 2) epoch-b starts, epoch-a list should get empty
> 3) epoch-c starts, epoch-b list should get empty, kill the connection if
> epoch-a list is not empty (epoch-c list should not be needed, as epoch-a
> list can be used, once confirmed it is empty.)
>
>
> Here timeout would be epoch-a + epoch-b, i.e.
> max-timeout <=3D 2 * epoch-time.
> We could have more epochs/list-heads to make it more fine grained.
>
>
> From my point of view that should be a rather cheap, as it just
> adding/removing requests from list and checking for timeout if a list is
> empty. With the caveat that it is not precise anymore.

I like this idea a lot. I like that it enforces per-request behavior
and guarantees that any stalled request will abort the connection. I
think it's fine for the timeout to be an interval/epoch so long as the
documentation explicitly makes that clear. I think this would need to
be done in the kernel instead of libfuse because if the server is in a
deadlock when there are no pending requests in the lists and then the
kernel sends requests to the server, none of the requests will make it
to the list for the timer handler to detect any issues.

Before I make this change for v7, Miklos what are your thoughts on
this direction?

Thanks,
Joanne

>
> That could be implemented in kernel and/or libfuse?
>
>
> Thanks,
> Bernd

