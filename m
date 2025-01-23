Return-Path: <linux-fsdevel+bounces-39992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E3A1A9AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E327A37F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761E15625A;
	Thu, 23 Jan 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFBaeLxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B9C2F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657188; cv=none; b=aKBeL5gMOKqSD5lyLAcm+a2PjFuya/yPvqGvBbZAgAgaq3fVadkjJDcdj21Tox1/Q/MyqhNpGIizQeMJRdDk2AvXYM6iQERiXXnV9l5BsSkmTWK2tbWs8froGbRKzuIZLMPT6EJtz0qAgJabZ75sMY5ZbeCzTVeMrGZpuEk8d3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657188; c=relaxed/simple;
	bh=cgkVq+zVVj0fNotw4SCQsEBeWFD9IWxNf0sfwyIhV4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGSkd5Cs3q4roOgSJSI6RskHsgYd+iITxB0ih8R9ll6DwEvo0cYQPlZpMYyDrmayld9joL9cT4mZITewUcoBSdtIuuMfJ24/1jw+1emjfE8vtGAgYyPyqlzcD9qiQUYSYdwuLvnxleFPQ8otfe5iR6T0hbSAnrrM4SCUdaAfy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFBaeLxK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dccccd429eso13068196d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 10:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737657186; x=1738261986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c/gwR5A1J7asFFeg1Z48X3dKtTdM2XaLGvZdGPIpkw=;
        b=NFBaeLxKoVFvUj14rRG/0hRiV9XoWIrW7rjhQAjnSmn7AgC/VzG8+njf5jW6Go8SMY
         nfu8iLr5zqCIhmAl1Ufjt0ivW+Sax7ajSZGk5q+FjlGKMP/pO0dHFLXxY+ue5BNiKsZZ
         dZXe5Aa/cwZ8j9IcX4TsUPbYYt3qE0mjyH5JSg2MlxXbm+Cny+44j+l35mXP2q7DUvyf
         aD7KvfZK7vNzSA7QKLG30r9Z0NxUpyd8v1sVW4txCdZLBn/yUtA2vyhaqHqTe6q8BwLR
         ZScPBvAk2utrRo9+sgluzu5QlbZ0BS3OVZqS4QSxZozY/uf1nItuGM0/3SUevj7KQQhw
         m6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737657186; x=1738261986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c/gwR5A1J7asFFeg1Z48X3dKtTdM2XaLGvZdGPIpkw=;
        b=RsCHuQm1EMAeGZckbuQIAlKKm4UtyZ5LaJoHjPa/e77AVBxdFlXQa9LVEGc0R/cWvp
         j4FK1zTv2T5PZn8v7xQwPHlZYNWPpnRSPI84MHS2XFY5Ro+TvaHB4eVYJpGOr/NdIcRA
         zP3NtrMIX4KWv6WzQUw+XE2GPTB60RFAW7ZMrpF2XDlZLACHe5ihRS2QSBq+hd6zgXkN
         p9D8qG+BgV5p1i4mMyDa2u4Z368RpX39O2pH4XUjdc+nI1hYXodOmGZFkHzCGn/dgkkV
         wRzCmb/+Vh/xfIiWoa70qKAm8fKrMvTUQHT5KiBCGi0obClVcyw9eBow+zBEWxhni4RU
         /YfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrYIvJXngspflvnxgJxMk4NX+MYYlqQ7mCOxleqLEDLusdlf5FA/0Pk0UGM1i/xEvTBC1mDD6lPKKk7E7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iyi2+d0o0TVb4eYekR+koOMQrzVIm8Byk/Ocasg8AUcjLosa
	zcPVthNJmTpjC31h8/Trhrtoe0rIPTw7ox73cDDuyjTZNwEuh561yZkbtUH2czOr29tgPcRRdUI
	PGH+cwizGS3XbwnOBC1n5PxGynQM=
X-Gm-Gg: ASbGncu6HKdNZpCNpih7baUN/c499D1FOeQEdAK22sOeLihDISQjoX2l5tSUnWJut4P
	+4B4QYd2QCs6d1vLsT4vN5EgdvrZP5M2x9wTwX/CEsh23FgYwT8xlppl6j2bDnSzx7hLf+NBjO1
	wfLvZxDlNH33/s
X-Google-Smtp-Source: AGHT+IFrhUwlR25qCJGd29Y81QxcQfvgFpZKbgpCWCsyodG0nJ7Fqg9umIrR8i0Gwt3VWeIoxuck+zV2bnp1YcEx6zM=
X-Received: by 2002:ad4:5ec5:0:b0:6d8:aa04:9a5d with SMTP id
 6a1803df08f44-6e1b21786cfmr370572116d6.4.1737657185832; Thu, 23 Jan 2025
 10:33:05 -0800 (PST)
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
 <325b214c-4c7b-4826-a1b9-382f5a988286@fastmail.fm>
In-Reply-To: <325b214c-4c7b-4826-a1b9-382f5a988286@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 10:32:55 -0800
X-Gm-Features: AbW1kvaSDgPRWTa8Qu1MQct_EXelrrSpPxdmCxZiJ-W-6UfXcVugpv2BpEdPNXc
Message-ID: <CAJnrk1YGK7Oe5Hbz3ci_-mgVUR761MJfg7qQoWCNGxmbTH4ESg@mail.gmail.com>
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

On Thu, Jan 23, 2025 at 10:06=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 1/23/25 18:48, Joanne Koong wrote:
> > On Thu, Jan 23, 2025 at 9:19=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Joanne,
> >>
> >>>>> Thanks, applied and pushed with some cleanups including Luis's clam=
p idea.
> >>>>
> >>>> Hi Miklos,
> >>>>
> >>>> I don't think the timeouts do work with io-uring yet, I'm not sure
> >>>> yet if I have time to work on that today or tomorrow (on something
> >>>> else right now, I can try, but no promises).
> >>>
> >>> Hi Bernd,
> >>>
> >>> What are your thoughts on what is missing on the io-uring side for
> >>> timeouts? If a request times out, it will abort the connection and
> >>> AFAICT, the abort logic should already be fine for io-uring, as users
> >>> can currently abort the connection through the sysfs interface and
> >>> there's no internal difference in aborting through sysfs vs timeouts.
> >>>
> >>
> >> in fuse_check_timeout() it iterates over each fud and then fpq.
> >> In dev_uring.c fpq is is per queue but unrelated to fud. In current
> >> fuse-io-uring fud is not cloned anymore - using fud won't work.
> >> And Requests are also not queued at all on the other list
> >> fuse_check_timeout() is currently checking.
> >
> > In the io-uring case, there still can be fuds and their associated
> > fpqs given that /dev/fuse can be used still, no? So wouldn't the
> > io-uring case still need this logic in fuse_check_timeout() for
> > checking requests going through /dev/fuse?
>
> Yes, these need to be additionally checked.
>
> >
> >>
> >> Also, with a ring per core, maybe better to use
> >> a per queue check that is core bound? I.e. zero locking overhead?
> >
> > How do you envision a queue check that bypasses grabbing the
> > queue->lock? The timeout handler could be triggered on any core, so
> > I'm not seeing how it could be core bound.
>
> I don't want to bypass it, but maybe each queue could have its own
> workq and timeout checker? And then use queue_delayed_work_on()?
>
>
> >
> >> And I think we can also avoid iterating over hash lists (queue->fpq),
> >> but can use the 'ent_in_userspace' list.
> >>
> >> We need to iterate over these other entry queues anyway:
> >>
> >> ent_w_req_queue
> >> fuse_req_bg_queue
> >> ent_commit_queue
> >>
> >
> > Why do we need to iterate through the ent lists (ent_w_req_queue and
> > ent_commit_queue)? AFAICT, in io-uring a request is either on the
> > fuse_req_queue/fuse_req_bg_queue or on the fpq->processing list. Even
> > when an entry has been queued to ent_w_req_queue or ent_commit_queue,
> > the request itself is still queued on
> > fuse_req_queue/fuse_req_bg_queue/fpq->processing. I'm not sure I
> > understand why we still need to look at the ent lists?
>
> Yeah you are right, we could avoid ent_w_req_queue and ent_commit_queue
> if we use fpq->processing, but processing consists of 256 lists -
> overhead is much smaller by using the entry lists?
>
>
> >
> >>
> >> And we also need to iterate over
> >>
> >> fuse_req_queue
> >> fuse_req_bg_queue
> >
> > Why do we need to iterate through fuse_req_queue and
> > fuse_req_bg_queue? fuse_uring_request_expired() checks the head of
> > fuse_req_queue and fuse_req_bg_queue and given that requests are added
> > to fuse_req_queue/fuse_req_bg_queue sequentially (eg added to the tail
> > of these lists), why isn't this enough?
>
> I admit I'm a bit lost with that question. Aren't you pointing out
> the same lists as I do?
>

Oh, I thought your comment was saying that we need to "iterate" over
it (eg go through every request on the lists)? It currently already
checks the fuse_req_queue and fuse_req_bg_queue lists (in
fuse_uring_request_expired() which gets invoked in the
fuse_check_timeout() timeout handler).

Maybe the  fuse_uring_request_expired() addition got missed - I tried
to call this out in the cover letter changelog, as I had to rebase
this patchset on top of the io-uring patches, so I added this function
in to make it work for io-uring. I believe this suffices for now for
the io uring case (with future optimizations that can be added)?


Thanks,
Joanne

> >
> >
> > If it's helpful, I can resubmit this patch series so that the io-uring
> > changes are isolated to its own patch (eg have patch 1 and 2 from the
> > original series and then have patch 3 be the io-uring changes).
>
> Sounds good to me.
>
>
> Thanks,
> Bernd

