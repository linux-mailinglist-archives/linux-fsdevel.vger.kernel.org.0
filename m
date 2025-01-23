Return-Path: <linux-fsdevel+bounces-40017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BACA1AD35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CAF163A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28401D516B;
	Thu, 23 Jan 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH37YvQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509041D5142
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674439; cv=none; b=dxYaHImnx9hLhBPBdoqcRC8V3hJgEtKjInQyfyDnyy3B136hPYgw1h6yVrfDwn2WRWVn34RgYVSBmlKmCfC/7zeBpVIf+bEyxV4HCPgr4V+q55ekeQGJO16qbEPwbZigt7GXGS9ukP0jpuxOZr4OD8HJQLwMET7nD15UF4eoHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674439; c=relaxed/simple;
	bh=qNGuRRUK5OgvpegBdhb7SNkEJrTFpThhCwMAD7NRoDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cchu5GjGzjSMJc64Ge5BaReR6s9tmEnjPZ6gZlQ5glTpJ/qBuJN9c3EX4DWoZLk+dOIce1w4TXv+Mg7fZuN+B46WSHtHFBR2vmYRkcwSfu6uZdcyPFTvKTH9yJQB91ZEEO8rkzRXRe3bgGGiCIdk8kXWuqE172JewnU+NmFB2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH37YvQP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679ea3b13bso12150611cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737674436; x=1738279236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FUySE3lQxtjsiJPpTz8jo5CEF6fsTzaXBveBfNfk1k=;
        b=mH37YvQPQ3okxdGmu1NOC7gwWCQgEJX1BSqtLAUgUFO5Psfa1sq79T92skqi5qC5rj
         qNfYmgIPiHpGclynEDQZLBkMUbjBW4cRb6zUGVg7YWyvOAQnh5z53kNDC4T/R8HFMDRd
         RtYmg0ORv5zDwIpOhBsxAAwt91y6UqI8nAP2EcPu2PdHhhw7sVO7iDJQYPwv4Wa2jzGw
         tGXJJx89Z/FseLGdgV/lI5hXH23zKpjbh213TTsWXmlgp22c7miH10UlD7nptCfiqbdm
         gc5V0Nx19a6z9mVWLTjxhxKLL6XV4ArUtNGtPbuFT3OtcbrZ2Ca1c5egZvELtDjzCeOp
         3j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737674436; x=1738279236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FUySE3lQxtjsiJPpTz8jo5CEF6fsTzaXBveBfNfk1k=;
        b=oyoI8DHgWebGDKiyLjZv8T0Ui18+mcL+FhJ/IFz3aXiTLVbRAntsnq7ZWmtGAvP6Co
         TBHfqFGTm7MqG2xs434PK82UOBharjpRKhKfWSVvxIgn9T2vsTk9caOzav2ZIHP3nep7
         JL295nZ+Jhe/PYKgcRXO4cxpmQbsd65FkVGA2U8fGsoA2enFPtu8ycz6qn7ZLPU6pWts
         r9bHvgY7cEdCroy244TKfryM321FIgxIScuyTnfpYKJtybOEt0gE7qvUbvIBq7eG6/AB
         2ued2QhhJnSj0M2ODgxg/N7KRo3vjd/tNUh+tuvzHecB/VzP2qI4BOmWkCguQNQKp32C
         6Qfg==
X-Forwarded-Encrypted: i=1; AJvYcCXAWUDmSalTqwBLYS7DIVJ62+JgwrzEz6j1zXrlaHiqjV/Qc92BDa1pXYTlSb2Joc/s5cROqH6MZHe++CUU@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNeoC0HbnVrqD+Xxq57WhOQ+mnGgXfVuLri6QVk/LVaM+mhu4
	QR1TP5cz6YjHqRZzAmd9s8Q/hJBBubVZ+tLVarNefmZBDpD+GwZrylQxcGR254tH5b5e3DW9Qas
	QHSalqT2CwYO8qiJu0YBESIp0u1c=
X-Gm-Gg: ASbGncu8smdbbrgwLGRBzALKNVLMhpbhYftrmaQuqMyNA1kHr5pfOTQzyh5iLNZpdgi
	2ImUOKdU603MyMi/r9rYfYjYjFHKJSZqLqWKltMvFcNkRPI1b3ACu0B5pWggNFZtMvK72nFTY9B
	Qufw==
X-Google-Smtp-Source: AGHT+IGBvtE5jXzj02pO4yCz36qJj9kIxQCFM3cIeT8YkXpM2DlPINQLFhqdjWf/zIdYIi/aqxdmkfragShSGBTtY20=
X-Received: by 2002:a05:622a:1986:b0:466:b2c9:fb00 with SMTP id
 d75a77b69052e-46e12a1fd6bmr461577131cf.3.1737674435964; Thu, 23 Jan 2025
 15:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com> <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
 <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm> <CAJnrk1YDFcF5GPR23GPuWnxt2WeGzf8_bc4cJG8Z-DHvbRNkFA@mail.gmail.com>
 <325b214c-4c7b-4826-a1b9-382f5a988286@fastmail.fm> <CAJnrk1YGK7Oe5Hbz3ci_-mgVUR761MJfg7qQoWCNGxmbTH4ESg@mail.gmail.com>
 <b24caa0a-d431-4254-80ab-672c1e014bd3@fastmail.fm>
In-Reply-To: <b24caa0a-d431-4254-80ab-672c1e014bd3@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 15:20:25 -0800
X-Gm-Features: AbW1kvY_uQcVzIugdIHjKQUjFsONzaNTtBcnjtycubYH8M9tCNpyI5TDzzpMFQM
Message-ID: <CAJnrk1YmWnYRUdLEQ016M3ibnU1xmJcfZgOk7NHuOePTo3c8uQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, jlayton@kernel.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com, 
	Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:40=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 1/23/25 19:32, Joanne Koong wrote:
> > On Thu, Jan 23, 2025 at 10:06=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 1/23/25 18:48, Joanne Koong wrote:
> >>> On Thu, Jan 23, 2025 at 9:19=E2=80=AFAM Bernd Schubert
> >>> <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> Hi Joanne,
> >>>>
> >>>>>>> Thanks, applied and pushed with some cleanups including Luis's cl=
amp idea.
> >>>>>>
> >>>>>> Hi Miklos,
> >>>>>>
> >>>>>> I don't think the timeouts do work with io-uring yet, I'm not sure
> >>>>>> yet if I have time to work on that today or tomorrow (on something
> >>>>>> else right now, I can try, but no promises).
> >>>>>
> >>>>> Hi Bernd,
> >>>>>
> >>>>> What are your thoughts on what is missing on the io-uring side for
> >>>>> timeouts? If a request times out, it will abort the connection and
> >>>>> AFAICT, the abort logic should already be fine for io-uring, as use=
rs
> >>>>> can currently abort the connection through the sysfs interface and
> >>>>> there's no internal difference in aborting through sysfs vs timeout=
s.
> >>>>>
> >>>>
> >>>> in fuse_check_timeout() it iterates over each fud and then fpq.
> >>>> In dev_uring.c fpq is is per queue but unrelated to fud. In current
> >>>> fuse-io-uring fud is not cloned anymore - using fud won't work.
> >>>> And Requests are also not queued at all on the other list
> >>>> fuse_check_timeout() is currently checking.
> >>>
> >>> In the io-uring case, there still can be fuds and their associated
> >>> fpqs given that /dev/fuse can be used still, no? So wouldn't the
> >>> io-uring case still need this logic in fuse_check_timeout() for
> >>> checking requests going through /dev/fuse?
> >>
> >> Yes, these need to be additionally checked.
> >>
> >>>
> >>>>
> >>>> Also, with a ring per core, maybe better to use
> >>>> a per queue check that is core bound? I.e. zero locking overhead?
> >>>
> >>> How do you envision a queue check that bypasses grabbing the
> >>> queue->lock? The timeout handler could be triggered on any core, so
> >>> I'm not seeing how it could be core bound.
> >>
> >> I don't want to bypass it, but maybe each queue could have its own
> >> workq and timeout checker? And then use queue_delayed_work_on()?
> >>
> >>
> >>>
> >>>> And I think we can also avoid iterating over hash lists (queue->fpq)=
,
> >>>> but can use the 'ent_in_userspace' list.
> >>>>
> >>>> We need to iterate over these other entry queues anyway:
> >>>>
> >>>> ent_w_req_queue
> >>>> fuse_req_bg_queue
> >>>> ent_commit_queue
> >>>>
> >>>
> >>> Why do we need to iterate through the ent lists (ent_w_req_queue and
> >>> ent_commit_queue)? AFAICT, in io-uring a request is either on the
> >>> fuse_req_queue/fuse_req_bg_queue or on the fpq->processing list. Even
> >>> when an entry has been queued to ent_w_req_queue or ent_commit_queue,
> >>> the request itself is still queued on
> >>> fuse_req_queue/fuse_req_bg_queue/fpq->processing. I'm not sure I
> >>> understand why we still need to look at the ent lists?
> >>
> >> Yeah you are right, we could avoid ent_w_req_queue and ent_commit_queu=
e
> >> if we use fpq->processing, but processing consists of 256 lists -
> >> overhead is much smaller by using the entry lists?
> >>
> >>
> >>>
> >>>>
> >>>> And we also need to iterate over
> >>>>
> >>>> fuse_req_queue
> >>>> fuse_req_bg_queue
> >>>
> >>> Why do we need to iterate through fuse_req_queue and
> >>> fuse_req_bg_queue? fuse_uring_request_expired() checks the head of
> >>> fuse_req_queue and fuse_req_bg_queue and given that requests are adde=
d
> >>> to fuse_req_queue/fuse_req_bg_queue sequentially (eg added to the tai=
l
> >>> of these lists), why isn't this enough?
> >>
> >> I admit I'm a bit lost with that question. Aren't you pointing out
> >> the same lists as I do?
> >>
> >
> > Oh, I thought your comment was saying that we need to "iterate" over
> > it (eg go through every request on the lists)? It currently already
> > checks the fuse_req_queue and fuse_req_bg_queue lists (in
> > fuse_uring_request_expired() which gets invoked in the
> > fuse_check_timeout() timeout handler).
> >
> > Maybe the  fuse_uring_request_expired() addition got missed - I tried
> > to call this out in the cover letter changelog, as I had to rebase
> > this patchset on top of the io-uring patches, so I added this function
> > in to make it work for io-uring. I believe this suffices for now for
> > the io uring case (with future optimizations that can be added)?
>
>
> Ah sorry, that is me, I had missed you had already rebased it to
> io-uring.
>
> So we are good to land this version.
> Just would be good if we could optimize this soon - our test systems
> have 96 cores - 24576 list heads to check... I won't manage to work
> on it today and probably also not tomorrow, but by Monday I should
> have an optimized version ready.
>

Oh wow, 96 cores!! I'll submit an optimized version of this today or
tomorrow then, if that makes things easier for you.

Thanks,
Joanne

> Thanks,
> Bernd
>

