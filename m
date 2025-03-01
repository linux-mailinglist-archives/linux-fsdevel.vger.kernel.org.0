Return-Path: <linux-fsdevel+bounces-42871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D31A4A73E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 01:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9317810C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 00:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFED1CA84;
	Sat,  1 Mar 2025 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI/VAJly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74A70808;
	Sat,  1 Mar 2025 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790508; cv=none; b=tD2XBhtaDP33KLOzKrLM5N2jsqxedw+tnUsqKC5X7JYJ3Tn8JIHQmFAU2VjYyAdc0LSGmzknhl5mnmTW/LyaSSvO1mfvuvUe8Vp19sEwGHt07NNTwl6OWm9rLUbitOkMwoqUWq2hOkcdLi+5/a299uaAcPbTH8+Q72lq8MwTTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790508; c=relaxed/simple;
	bh=3FoZOvTBwt9MqRNEV8L9QF54pvSeq7iiX7+LkWBYvxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEoZ7GcPqSDQjWayyDDt30Tod0P0i2iYP7+GCkjedKgZoMrjA9CdQg0GWFg4lcsQaSzDtr9b2OJ0Y7QtexTPbQ88s/dS+Qy3GwpNOL/Ato3GXEPiCEyA9xqrkQyOZnyGr5aLTbRjC3KoyJogRo4lK2BNudBLMKj5xjf1cui8kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI/VAJly; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2810950e87.3;
        Fri, 28 Feb 2025 16:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740790505; x=1741395305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sprwftPaK8bnJWe55CjWfHUR1fUrCBkvZCI+DKsADHg=;
        b=LI/VAJlyGFnFc+eMSMu/z5qQMCndshcHcdOkTl7T0P9xb+dYL6SHdgvO7KCGNJwiVS
         Tq1wwS0l09cOcYH7fmX8M/kPs92kV1MtiLYSIt1ZgKX+J1EL68OsMii9BpPNbk098aad
         /b293t3xaZhX5ybbfLJ4D5n4cyMgBVRb8d52MbOeK+9mf+5VPwPlnFkapSqmC7iTD5/j
         uTRyTpSuqIXdh0hIY1kh7MVifJUXquz99JWAauTj4FAThlqjt/DB8vMMWKM4Jr09d5mq
         UiovaCbWrQPeN0+t7sNC+S+LZDKRXYeRB7hDnVv/Q7NUokFNR55PcsbK8B1xRxoIRr20
         W6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740790505; x=1741395305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sprwftPaK8bnJWe55CjWfHUR1fUrCBkvZCI+DKsADHg=;
        b=S8O4BMS6Kw2Zallt7wxFCtvTUs/UgT2FtzbEC4N+Xiq9PhPtbUVpsmEB2N33mf5yeg
         TwKJMdf0sEkxHggvhAVHVfl9uayMgLLeY9L95LrlkPM8Ay7a547NFxnR+Y8A0Aqj/cqx
         oYc0rTOtwGLpQbGXYu5b2KXfRf8i1R7lGMdV4yqq5L5FHYv60e0gkqnE8Yxk/DV7sU6C
         C/XPt3S7e9yrIZHdhBxgQ66YwnjSnTIWtLsF9LWqOitdde+UmVjJeaqD6tGvlu+FwuH5
         wFYJF9zKiXsV7qnse5jHNVjBO084YqD4wJ400oHbTJ2MaCDLrU47LFYC2eY1VxAPWUYZ
         EhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPk9ZiAIOLNx/tjMCYcgUv0qXEKFYjYcBrLyThQjgoncyigfVnKwHFHicSGd5CxSvdFFFFsUdlWcfNd4hJ@vger.kernel.org, AJvYcCUyUyqsFGNkE/YRydJOu+Il0i1S/SKPaXloM0avKlPpPLEhSuHZRmvNVt46cOblkDFw6eFZfC7OsiTb@vger.kernel.org, AJvYcCWBY1QmlWYQgbQfIW5HzZtqz9K/QEVe90si5JAmrj6Hpt+x4YFCOX5L6sSRbhssee6Fq3VQV6OVja/U0qi0JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hL6WOyFm2amO0YyDU2m0GnjlHRqNIhrWKHq13hysQpGrHtQn
	NjEND6damrvmkzKdX2e5rerJ3thGjQ7xDe9a9N6TFUCkg9lqZwX4L7yhDTXIm2iVPFgLZctM9KJ
	1A/fTMFXVpfzS3WLSALpvpI4tMjg=
X-Gm-Gg: ASbGncszu7TTcT7oyEOrTz+bjQCT77cp2ZdsY6L+dpLc6yR34cLIVfLNwDBWFEwxPTb
	+H2NoH1oD+9/aNAvY2GPxpKKlT2P506VXg55KrtLRb1nS6bcuME1jB0lVPzLZL+2eZGWZ2XPNWW
	yXR4a3MdTMZ9/DDwvnQ5sigUJYeC3L4lAGmThWJtWLKTLGyMaiH5IS9pRtmdk6
X-Google-Smtp-Source: AGHT+IHasULvzr6B7U4Upg+LWLLBexoCp44DyPdSPr89MzEo775rgHSkb2PdpFFLnM6x/nmZMvWiKvdDQoOUjK3LOkE=
X-Received: by 2002:a05:6512:3405:b0:545:746:f36a with SMTP id
 2adb3069b0e04-5494c32fac4mr2277268e87.34.1740790504591; Fri, 28 Feb 2025
 16:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3431541.1740763345@warthog.procyon.org.uk>
In-Reply-To: <3431541.1740763345@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Fri, 28 Feb 2025 18:54:53 -0600
X-Gm-Features: AQ5f1Jq1RjqOGjIbPeaUziZPzZ5R67gITUoR5QKVQ8qxJA12twJdkCZSGGMTfgg
Message-ID: <CAH2r5mvidbjFykpwyhicaz2nk+-Vbau2RRXqcD4u4u5qT71xUg@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix collection of results during pause when
 collection offloaded
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am testing this fix now (especially with multichannel scenarios which
were failing before)

On Fri, Feb 28, 2025 at 11:22=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
>
> A netfs read request can run in one of two modes: for synchronous reads
> writes, the app thread does the collection of results and for asynchronou=
s
> reads, this is offloaded to a worker thread.  This is controlled by the
> NETFS_RREQ_OFFLOAD_COLLECTION flag.
>
> Now, if a subrequest incurs an error, the NETFS_RREQ_PAUSE flag is set to
> stop the issuing loop temporarily from issuing more subrequests until a
> retry is successful or the request is abandoned.
>
> When the issuing loop sees NETFS_RREQ_PAUSE, it jumps to
> netfs_wait_for_pause() which will wait for the PAUSE flag to be cleared -
> and whilst it is waiting, it will call out to the collector as more resul=
ts
> acrue...  But this is the wrong thing to do if OFFLOAD_COLLECTION is set =
as
> we can then end up with both the app thread and the work item collecting
> results simultaneously.
>
> This manifests itself occasionally when running the generic/323 xfstest
> against multichannel cifs as an oops that's a bit random but frequently
> involving io_submit() (the test does lots of simultaneous async DIO reads=
).
>
> Fix this by only doing the collection in netfs_wait_for_pause() if the
> NETFS_RREQ_OFFLOAD_COLLECTION is not set.
>
> Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use=
 one work item")
> Reported-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/read_collect.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index 636cc5a98ef5..23c75755ad4e 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -682,14 +682,16 @@ void netfs_wait_for_pause(struct netfs_io_request *=
rreq)
>                 trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
>                 prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIB=
LE);
>
> -               subreq =3D list_first_entry_or_null(&stream->subrequests,
> -                                                 struct netfs_io_subrequ=
est, rreq_link);
> -               if (subreq &&
> -                   (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
> -                    test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)))=
 {
> -                       __set_current_state(TASK_RUNNING);
> -                       netfs_read_collection(rreq);
> -                       continue;
> +               if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags=
)) {
> +                       subreq =3D list_first_entry_or_null(&stream->subr=
equests,
> +                                                         struct netfs_io=
_subrequest, rreq_link);
> +                       if (subreq &&
> +                           (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->f=
lags) ||
> +                            test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->=
flags))) {
> +                               __set_current_state(TASK_RUNNING);
> +                               netfs_read_collection(rreq);
> +                               continue;
> +                       }
>                 }
>
>                 if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
>
>


--=20
Thanks,

Steve

