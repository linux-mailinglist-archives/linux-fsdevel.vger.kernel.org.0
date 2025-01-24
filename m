Return-Path: <linux-fsdevel+bounces-40098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81122A1BF09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DF53AE20A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B61E7C29;
	Fri, 24 Jan 2025 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/+Wd9sV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2641D0F46
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737761632; cv=none; b=JvPaw0Nqz583qARwgsEIT8Vtbr5D4zm7GNnf18ndYOIXi1g5SJj1fYU/zBSmkO33XtD6j+KJjXFZMBD3BLzznMBUOb46rVlkRNwCPbYLs7jhsJFpBDVEFwdsdukN+atOyJtHgBcz5VY9fl7mWG2B+fC5tZ/2ub3gHN9bhcUZa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737761632; c=relaxed/simple;
	bh=aTbNjBL3BdneK3mxgvhkGNpiZ50M2h1pbdJ411e9PKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+xVWmeVWNCGq5G1Ak/f7t2eJ+4O1B49BnwHcMCt4nG6JTPmcP8VEtl0zBs39ih2XG53R6RCbIWkhkaobyMzWzlR/70hsrxoGlvar0+Mv+gwd91O40+j24J6y1Bk6B9m93+zWGaPFBKDh11KYro/yMjNxWnC+oHs/0gafzJ8hY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/+Wd9sV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46788c32a69so34758341cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737761629; x=1738366429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh5TywFpQkNFqssc/Gz5kiDae6FFMNhjZ/h3qA/y4H4=;
        b=Y/+Wd9sVCxuNS0EQ6A7TaPZwicktdfWB/GRrry9oZp1hFQdwbi3jZHql64KOBKmfA9
         a84MxbXbRlBBIW5kxH0hwiXvgGxCG5IEGUGgk0rWPX3aChxDydZYzsH8+hnyrdCde4U+
         t5NbHklzhyeZ8b4Hrctf/rNFKZZZFpWkxSPvvtZAzM/rsr6m4xzPvjdl3UnBicDo/b0m
         YLFCaVYKP9cXZOc3UKYHPJ+GN+jf7eRCwgIxxMcwcT4AB8SlFqKe8Q/v34rMTXP1r8fS
         N1nW90Bxi3fxQb1hTAhzN0l68mdtmTN1Ht73grgk4pj3MUWkodyZ7Poa09eMcWo7Ld52
         HsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737761629; x=1738366429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh5TywFpQkNFqssc/Gz5kiDae6FFMNhjZ/h3qA/y4H4=;
        b=uLHbqAmdILqDsKCQfQw+fryAgHJd4f3E0jf1YxYqnLW34+pA5WsYKdZQr6KJ3c285d
         g1qGslbfP+zbnpLIeaNBGJJYRhWvwFS45G2pEjjKnWPgvSalSopCXFXQ8P7y3s4d2syc
         YKJY2l9rcae6C1vDRk+pWCiWAQSCTIQJT1HcuLpQkWj8E0IEriTfxBLwihDqyJyeUPUT
         NlcS7zEGahe4bRXaSf0+LfvYrapECaa/uovX4Ost4M8DPCGPhwSYc8I8I2W4xbqVDFld
         CRDPz3lYyxptCp8OHzSEN4z9RLjPQx6CvGroN52i8pFxYHuVQMQyWxzM2zvs7YNYLUjt
         kAZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6p1IX3PtniF6u+qQEZVUrsAyAloqZJ7XqznB1kWWjcyP1sxgNvsC0LaFSnfVoZJNuuS0d+0O4qfHe3vJl@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK3dhA4dR2z62v/nbFmzcn9eTteF2guEI6sHiSmdIU4Z9dubB
	GtAhet9aOeB/uoPki1grVJYVCAD44/LP+SHZUTNDduV656LAd+b88Sz/glEPyybgfsDXNtnqxn6
	ekxF+l6pp+p9TOxtVcLvVDy140iMClRafwq4=
X-Gm-Gg: ASbGncsJ+uCO68Rk4+JluvESSOHmi6kBeYg8JxkZif0z7Tn3A/D9cJUGT6WiW9iaikx
	spuHVJMvWHrIHqSA+IEMm7gVS2/9dcllQ6rzsgkwiEz2+QoDKTX1cYI+kUAkZ15Y=
X-Google-Smtp-Source: AGHT+IEKlundLmu9LmJyurzA9stmqoR1YD6K87ybkzyfbCrt6Ch80qww+Y9v8XF8xq4huH56piIHMdGnPhNX6F9XJ+U=
X-Received: by 2002:a05:622a:292:b0:467:b7de:da8a with SMTP id
 d75a77b69052e-46e12a2c4e7mr491525561cf.6.1737761629222; Fri, 24 Jan 2025
 15:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
 <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm> <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
 <CAJnrk1amoDyenJQcDbW_dcsHVGNY-LdhrRO=3=VK+tHWx4LxbA@mail.gmail.com>
 <f9e180db-59a1-4652-bf1b-2eacb0af5128@fastmail.fm> <CAJnrk1ZWyPfnXcEQoZO9bkfkcyA0ato0t4i2PrzKqc90XEyFhg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZWyPfnXcEQoZO9bkfkcyA0ato0t4i2PrzKqc90XEyFhg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 15:33:38 -0800
X-Gm-Features: AWEUYZn_bCCfdQyAbcv4hMxU9IEQAdmNCnAjh29g-p77NMya2w_poZm9ihZ0Shk
Message-ID: <CAJnrk1YKfZYEre8RoSGNzVWG0k7R7JjD9GTFy0q0CgjsrL2cdQ@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 3:31=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, Jan 24, 2025 at 2:58=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 1/24/25 23:05, Joanne Koong wrote:
> > > On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Bernd Schubert
> > > <bernd.schubert@fastmail.fm> wrote:
> > >>
> > >> Hi Joanne,
> > >>
> > >> On 1/24/25 12:30, Bernd Schubert wrote:
> > >>> Hmm, would only need to check head? Oh I see it, we need to use
> > >>> list_move_tail().
> > >>
> > >>
> > >> how about the attached updated patch, which uses
> > >> list_first_entry_or_null()? It also changes from list_move()
> > >> to list_move_tail() so that oldest entry is always on top.
> > >> I didn't give it any testing, though.

I think this attached patch looks good, except with the
"ent_list_request_expired(fc, &queue->ent_commit_queue))" line in it
removed.

Thanks,
Joanne

> > >
> > > Woah that's cool, I didn't know you could send attachments over the
> > > mailing list.
> > > Ah I didn't realize list_move doesn't already by default add to the
> > > tail of the list - thanks for catching that, yes those should be
> > > list_move_tail() then.
> > >
> > > In t he attached patch, I think we still need the original
> > > ent_list_request_expired() logic:
> > >
> > > static bool ent_list_request_expired(struct fuse_conn *fc, struct
> > > list_head *list)
> > > {
> > >     struct fuse_ring_ent *ent;
> > >     struct fuse_req *req;
> > >
> > >     list_for_each_entry(ent, list, list) {
> > >     req =3D ent->fuse_req;
> > >     if (req)
> > >         return time_is_before_jiffies(req->create_time +
> > >                     fc->timeout.req_timeout);
> > >     }
> > >
> > >     return false;
> > > }
> >
> > Could you explain why? That would be super expensive if lists
> > have many entries? Due to fg and bg queues it might not be
> > perfectly ordered, but that it actually also true for
> > fuse_req_queue and also without io-uring. Server might process
> > requests in different order, so ent_commit_queue might also not
> > be perfectly sorted. But then I'm not even sure if we need to
> > process that queue, as it has entries that are already processed - at
> > best that would catch fuse client/kernel bugs.
> > Though, if there is some kind if req processing issue, either
> > everything times out, or the head will eventually get the older
> > requests. So I don't understand why would need to go over all entries.
> >
>
> I don't think this in most cases goes over all entries. For
> ent_w_req_queue and ent_in_userspace queues, I think this is
> equivalent to just checking the head of the list since every entry on
> it will have a non-NULL request attached. But I think we need this
> "list_for_each_entry() { ... if (req) ... }" logic in order to
> properly handle the ent_commit_queue cases where an entry is on that
> queue but has a NULL request (eg the condition where
> fuse_uring_commit() has finished being called on the entry but a new
> request hasn't yet been attached to that entry).
>
> I think another option is if we move the fuse_uring_ent_avail() call
> from fuse_uring_next_fuse_req() to be in fuse_uring_req_end() within
> the scope of the queue->lock instead, then that ensures all entries on
> the committed queue have valid requests.
>
>
> > >
> > > and we can't assume req is non-NULL. For entries that have been
>
> sorry, this should have been "because we can't assume req is
> non-NULL", not "and".
>
> > > committed, their ->req is set to NULL but they are still on the
> > > ent_commit_queue.
> >
> > Yeah sorry, right, though I wonder if we can just avoid checking
> > that queue.
> >
>
> I like the idea of skipping the ent_commit_queue! We pretty much know
> the request is being responded to right now if it's being committed,
> so even if it has technically timed out, we can skip aborting it.
> Timeouts are kind of fuzzy right now anyways given the
> FUSE_TIMEOUT_TIMER_FREQ periodic check, so I don't see why this would
> be a problem.
>
>
> Thanks,
> Joanne
> >
> > Thanks,
> > Bernd

