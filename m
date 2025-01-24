Return-Path: <linux-fsdevel+bounces-40097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECCBA1BF05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9571694C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE5B1E1022;
	Fri, 24 Jan 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmMZRxIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBF2B9BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737761481; cv=none; b=nUEwaJhbf2MC1nouj/umKNwl/UcFsxCkO3szl9tps0GfNUImfc2QT8o0IOU8NwA4smW7LDP8B3LqdU0DDPMBmL1HHCLTPdlXc+64rquSy7XAOhz3OQ+R3wL1afqlXTpU29pf2K05ftsRyC4ZCBQ1Sovq+tX0V+NU7tCct6k5Wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737761481; c=relaxed/simple;
	bh=//9HStd1AZIcoRps4s0mE7foejt390WguLwQt4Pt+xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD/jybPtihCEOChWBlA7Db81F5cYk603ecK+MfcMmTE3gpiuNInow1ya1Xqu5lQkhiFmSBxCAPyvfEBNHDxAFmpiRpLJY8KHNjJDlrmTARI+4oYZsZAF6MAREEO4jjuLX1aCIcop1QEX6xz7S72VD9bf6Ru/9sMUzwR1PoxTbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmMZRxIZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467b74a1754so35385641cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737761479; x=1738366279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXWlyY1U3okKasJxFUnxBE026k1L2IMzS7knGGfU6Xw=;
        b=EmMZRxIZbSU+ihHijAdijLeS3H1ZIG6MI3gUnG6EaL8pI8z6ex18BfKT7N14EEB5Cx
         12oMCziWousXMQfK/yCkj6kDZvvenXa0iUVDI496ZHsjFoUfIC90sgbWTKB1jfRWnYty
         Ygogsl6hhL/bmvpmTLNOT245TlIqsNIKwH0e8ScpXLqbSev+5SCBM6sBWcvt3NlwoRIO
         o5MNvrC2THO+gipRGll9sTKLzuz6oV1876BsQx9ohS6mv0k44yXchS0FsLKzGt1p69dz
         USqwQnna+Hs1pF0jl4pyKaeEdmglvRBeqDtEYiMAcswEOhhtNfxkD39SQmqKXiFmCmfF
         G+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737761479; x=1738366279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXWlyY1U3okKasJxFUnxBE026k1L2IMzS7knGGfU6Xw=;
        b=vRsnIjyS3ts7C2XBP2t7kj8EXT/TLsybSbpP7UmOIABl9XuGxZKqqfS+5gUyTBM7kv
         kBaixrmhHZnx/E8M39iR25uB43YVaJUwor9XyCoTq6rFubTE2wTEX2iPrbh0iGlm0qSz
         9MtWMc2VbDQPenB083CZv6O/pWznnTXHZG4QEy76oSwOlC66teITzcwxeXLXPFfA8D81
         C+2S/dtyAUdB2qWp/GDME7ZHK6WXnuLMGJ/CL69SaS6/tGVw5VBk9ps7AmX/LkSJTLyr
         fzqPrnRbgTK3aiVJ5pjTMYBz5wWZEZ3kWsaxa3DvI2hFTD5dB9soZnB9wcYnSX4J4KsC
         tQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwbPORKiTKtifGhyQojbOYxCAnq+WRcniAEj8u3ZLS1X3tEg3hF9FfAlx/p1JXSRQ+Eii16ePS7L4YlpMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2qDy50iDzJkb6dnknZZsWQuXza1pwzflV6ruEyOxg04+YpNW
	3UaU+6zmtLdXH0ftrhPUaX+ByT/GefZMUGWMhXwUILL9ijcViZJpwxz32SynFtJsinWpTv+YEa5
	XS6C2gAqUJ3+BHDshBGJLDgED05U=
X-Gm-Gg: ASbGncuU1Q5FgLfft8vxN8aSHRZSv/5nJOcJa7onVvSjEw/YSt0+zbkrrE81OGIw6s9
	lAJ9juyotHVEQp/5HWYr4j/HierOunI/UQ8+XLk1hMTaiwJwZ54YWsIOhdsw1S2g=
X-Google-Smtp-Source: AGHT+IHhohvG0JW1UEhCuh85bmaihFUIQuPe5ylggtMYxH8GX/Uw7VNcwNoRi3QRg6OhsfZWZbGz5xFGYfKoDZLidU0=
X-Received: by 2002:ac8:7f4b:0:b0:467:7fbf:d115 with SMTP id
 d75a77b69052e-46e12a621a8mr458541501cf.12.1737761478838; Fri, 24 Jan 2025
 15:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
 <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm> <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
 <CAJnrk1amoDyenJQcDbW_dcsHVGNY-LdhrRO=3=VK+tHWx4LxbA@mail.gmail.com> <f9e180db-59a1-4652-bf1b-2eacb0af5128@fastmail.fm>
In-Reply-To: <f9e180db-59a1-4652-bf1b-2eacb0af5128@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 15:31:08 -0800
X-Gm-Features: AWEUYZnyqY7o7PmhcSVB8cMY0szlimM6COASi00V_tdry5R-7xsKMIIntiG8apc
Message-ID: <CAJnrk1ZWyPfnXcEQoZO9bkfkcyA0ato0t4i2PrzKqc90XEyFhg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:58=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 1/24/25 23:05, Joanne Koong wrote:
> > On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 1/24/25 12:30, Bernd Schubert wrote:
> >>> Hmm, would only need to check head? Oh I see it, we need to use
> >>> list_move_tail().
> >>
> >>
> >> how about the attached updated patch, which uses
> >> list_first_entry_or_null()? It also changes from list_move()
> >> to list_move_tail() so that oldest entry is always on top.
> >> I didn't give it any testing, though.
> >
> > Woah that's cool, I didn't know you could send attachments over the
> > mailing list.
> > Ah I didn't realize list_move doesn't already by default add to the
> > tail of the list - thanks for catching that, yes those should be
> > list_move_tail() then.
> >
> > In t he attached patch, I think we still need the original
> > ent_list_request_expired() logic:
> >
> > static bool ent_list_request_expired(struct fuse_conn *fc, struct
> > list_head *list)
> > {
> >     struct fuse_ring_ent *ent;
> >     struct fuse_req *req;
> >
> >     list_for_each_entry(ent, list, list) {
> >     req =3D ent->fuse_req;
> >     if (req)
> >         return time_is_before_jiffies(req->create_time +
> >                     fc->timeout.req_timeout);
> >     }
> >
> >     return false;
> > }
>
> Could you explain why? That would be super expensive if lists
> have many entries? Due to fg and bg queues it might not be
> perfectly ordered, but that it actually also true for
> fuse_req_queue and also without io-uring. Server might process
> requests in different order, so ent_commit_queue might also not
> be perfectly sorted. But then I'm not even sure if we need to
> process that queue, as it has entries that are already processed - at
> best that would catch fuse client/kernel bugs.
> Though, if there is some kind if req processing issue, either
> everything times out, or the head will eventually get the older
> requests. So I don't understand why would need to go over all entries.
>

I don't think this in most cases goes over all entries. For
ent_w_req_queue and ent_in_userspace queues, I think this is
equivalent to just checking the head of the list since every entry on
it will have a non-NULL request attached. But I think we need this
"list_for_each_entry() { ... if (req) ... }" logic in order to
properly handle the ent_commit_queue cases where an entry is on that
queue but has a NULL request (eg the condition where
fuse_uring_commit() has finished being called on the entry but a new
request hasn't yet been attached to that entry).

I think another option is if we move the fuse_uring_ent_avail() call
from fuse_uring_next_fuse_req() to be in fuse_uring_req_end() within
the scope of the queue->lock instead, then that ensures all entries on
the committed queue have valid requests.


> >
> > and we can't assume req is non-NULL. For entries that have been

sorry, this should have been "because we can't assume req is
non-NULL", not "and".

> > committed, their ->req is set to NULL but they are still on the
> > ent_commit_queue.
>
> Yeah sorry, right, though I wonder if we can just avoid checking
> that queue.
>

I like the idea of skipping the ent_commit_queue! We pretty much know
the request is being responded to right now if it's being committed,
so even if it has technically timed out, we can skip aborting it.
Timeouts are kind of fuzzy right now anyways given the
FUSE_TIMEOUT_TIMER_FREQ periodic check, so I don't see why this would
be a problem.


Thanks,
Joanne
>
> Thanks,
> Bernd

