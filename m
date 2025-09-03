Return-Path: <linux-fsdevel+bounces-60220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB34B42D2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 01:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F116C322
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6C2E8E14;
	Wed,  3 Sep 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz1REse9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C82D5C92
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940721; cv=none; b=ZM72/OLSUTHHugRwxbTCvraxwm8sH/yjw1iGWcK1endleznuRMHkpjEjXvM/GSp1mN1oHsrDQLIabf5mx/DGprqjwyYbaCsqvb0wMENAG5LphhLATZVtkpCxJc7tp9VpHjmMuGAjVYhbZtCCcqjbuks25oOeFrAnYpH826WaN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940721; c=relaxed/simple;
	bh=AVqN7b9iBjGfJKngz0eTXZt3bBh3ZPBeMWq5RTasFyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYFusS3lpwCeaScEokODlmfQ2hwHuQKC8yMg8FvBYkb7wtFNObrYOv5AdBeYOldfqJ1i6KsigOpwRE4cxADVL1RBDaph3UD+I3kQKePf+BpIW/VO4uOwH9321/Db3UirTUvDeI0PCETC4xpr781DB363T6WaWJ/DpOC4rlnmFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz1REse9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b32384ce83so2909931cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756940718; x=1757545518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNxSR4b0XV6FF5iu9xV6/cqgqwQlAlVJ4+TbwhDp0VE=;
        b=iz1REse9nig1ZoCEgh/9SdrnyGzzdCEtn6gteKH4MkAE0eNz5NdpOKaGUo8zlVhroU
         7SaC9/GUQHAPNL+dzKdzpU3/3odSKHGs+bd3yVLQSaAK8prJbnK8eM2zHt8T1pS+YMfk
         4jBYelMPzFJgYTCE9DgwJX43tSeRvbiJZ7aHJpC+6gYKTOeyrajs+Ftu2WDPnYgYEsnN
         fuu2MD1FDTnbAQmL2IADZ3oilT/qkEc1wvgFncdnlJ9J4zEXiAmVWfSxx49zCRKKlg/Z
         GWBXE3pL43gZ2WxFt7GdBhrvfC9tj/20cUwGBzCZHNmeZtm6/o/dMnsRCx2u5RTLWevp
         YcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756940718; x=1757545518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNxSR4b0XV6FF5iu9xV6/cqgqwQlAlVJ4+TbwhDp0VE=;
        b=cnhpQjL2RNybs8pw/vi3m9ZJbfQrajaOcYk5qWtc8HF7D5N/4raNCImcOX2MPsEkvR
         jtoTl6dfir5OEWA0B77s2sNhSf5sFiYYdYSEkwAlu3ZchXz8xDvmw51axicdH/4puFDQ
         jN9yp69LbB8Rqug7y1M/ipbVK8zF8M4LzgN0wXsENFQz+oc6JmmX5OQpLsZz1/GgxdFa
         5reR94zegs7BdOYwENdBldqN3r1oUbrymn59uWytbZwdFGsWP+AcpvBnGtKdrDLltS73
         u1e6rYatCK4WW4xOf8oPfAgpT0HUdzl1Wi7vo/e2uGRef20by6sIRK4lURs42T2itFJn
         p/rg==
X-Forwarded-Encrypted: i=1; AJvYcCUTxbE7QGQo+V8il1yHkcfJbDhkcjutzZW5nRASDLX1HMMa0t37gHauz2oNyLNZ2NmbcI8yuSF2Xsbku/dy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyva6tvq1P1fKDn+GuEf2aoLJl9VXnqmZsryJFo+BCyGSyDQ6Xm
	UzPUwgzKdVfh8PHkdL3PnxGmkdgXJPv1RZfJIb7R7yHtWqhpg5Eg8VsnHA564dBH8fdDh4bw5dO
	RwLmHuaoiederfPkO4mw0P0lf8W7QTmbrxCziJS8=
X-Gm-Gg: ASbGncs/W1nEU56f9KxtMP/97RoZDouICLlN8kvDvqjmyxvMc+SgaVPvbaYfcaYlLut
	s65AVmwrdIoD9H93PMGRTsyRk48XBrpqA6UoUjgSgD9kaseNMejeK8I1C/oJgc1SGTivviYyqKh
	rDcQleKhqlA8qHQ4xWK7yEaE7GvTmLdzO4I5tIRx85xIXoWNpdK8Mygi+evn6YFhV9ZJNk9E+XQ
	yFXMXPu
X-Google-Smtp-Source: AGHT+IEo+yUHfOMUAZyBia3k9bbc2WS6yqxGuU4IeFnj7qpm6FfsJLgXLWeisRpLQYw3VKRpgxWEBJsaqOaNWvCXpeI=
X-Received: by 2002:a05:622a:8c9:b0:4b0:ad2d:ab84 with SMTP id
 d75a77b69052e-4b31dcd66d3mr257014331cf.52.1756940718405; Wed, 03 Sep 2025
 16:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
 <20250826185201.GA19809@frogsfrogsfrogs> <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>
 <20250903155405.GE1587915@frogsfrogsfrogs> <20250903184722.GH1587915@frogsfrogsfrogs>
In-Reply-To: <20250903184722.GH1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 16:05:06 -0700
X-Gm-Features: Ac12FXzJaU11mhV97g11zoE26c5qqM4MIO7WfjyDvasIJkqJZEGT91RzgPOZ5KA
Message-ID: <CAJnrk1aUN32CcXyXN_K4r1hOkTHptM5bmwmL2avP+j2sx5bFhA@mail.gmail.com>
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:47=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Sep 03, 2025 at 08:54:05AM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 03, 2025 at 05:48:46PM +0200, Miklos Szeredi wrote:
> > > On Tue, 26 Aug 2025 at 20:52, Darrick J. Wong <djwong@kernel.org> wro=
te:
> > >

Sorry for the late reply on this.

> > > > Hrmm.  I was thinking that it would be very nice to have
> > > > fuse_request_{send,end} bracket the start and end of a fuse request=
,
> > > > even if we kill it immediately.

Oh interesting, I didn't realize there was a trace_fuse_request_end().
I get now why you wanted the trace_fuse_request_send() for the
!fiq->connected case, for symmetry. I was thinking of it from the
client userspace side (one idea I have, which idk if it is actually
that useful or not, is building some sort of observability "wireshark
for fuse" tool that gives more visibility into the requests being sent
to/from the server like their associated kernel vs libfuse timestamps
to know where the latency is happening. this issue has come up in prod
a few times when debugging slow requests); from this perspective, it
seemed confusing to see requests show up that were never in good faith
attempted to be sent to the server.

If you want to preserve the symmetry, maybe one idea is only doing the
trace_fuse_request_end() if the req.in.h.unique code is valid? That
would skip doing the trace for the !fiq->connected case.

Thanks,
Joanne
> > >
> > > I'm fine with that, and would possibly simplify some code that checks
> > > for an error and calls ->end manually.  But that makes it a
> > > non-trivial change unfortunately.
> >
> > Yes, and then you have to poke the idr structure for a request id even
> > if that caller already knows that the connection's dead.  That seems
> > like a waste of cycles, but OTOH maybe we just don't care?
> >
> > (Though I suppose seeing more than one request id of zero in the trace
> > output implies very strongly that the connection is really dead)
>
> Well.... given the fuse_iqueue::reqctr usage, the first request gets a
> unique id of 2 and increments by two thereafter.  So it's a pretty safe
> bet that unique=3D=3D0 means the request isn't actually being sent, or th=
at
> your very lucky in that your fuse server has been running for a /very/
> long time.
>
> I think I just won't call trace_fuse_request_send for requests that are
> immediately ended; and I'll refactor the req->in.h.unique assignment
> into a helper so that virtiofs and friends can call the helper and get
> the tracepoint automatically.
>
> For example, fuse_dev_queue_req now becomes:
>
>
> static inline void fuse_request_assign_unique_locked(struct fuse_iqueue *=
fiq,
>                                                      struct fuse_req *req=
)
> {
>         if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
>                 req->in.h.unique =3D fuse_get_unique_locked(fiq);
>
>         /* tracepoint captures in.h.unique and in.h.len */
>         trace_fuse_request_send(req);
> }
>
> static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *=
req)
> {
>         spin_lock(&fiq->lock);
>         if (fiq->connected) {
>                 fuse_request_assign_unique_locked(fiq, req);
>                 list_add_tail(&req->list, &fiq->pending);
>                 fuse_dev_wake_and_unlock(fiq);
>         } else {
>                 spin_unlock(&fiq->lock);
>                 req->out.h.error =3D -ENOTCONN;
>                 clear_bit(FR_PENDING, &req->flags);
>                 fuse_request_end(req);
>         }
> }
>
> --D

