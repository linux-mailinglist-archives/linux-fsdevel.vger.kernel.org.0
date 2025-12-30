Return-Path: <linux-fsdevel+bounces-72223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCBCE8743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 01:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E27030155FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB32DCC03;
	Tue, 30 Dec 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEeZdAvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBBC22301
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056324; cv=none; b=kXYcaTpiVbhIfxeAxhKVzGquuGvUHbIHkbE9H0E2jNB4LtySCENbxPRmBDLq6k1mfzRzmTy4ZqOKCq+ROtGgyZKSCkCf60JOmCyuu13KQxlSB1zpHCxL1t7220C0bci++SVXfrQZEdMko7tC9PHWLavGgqc2jdeB4GpL80JuyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056324; c=relaxed/simple;
	bh=JCUgamtC/2LkxhZiSkwqw1MAxNl438r5Tsy4k5SEpDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvhV6xcWb5tMCRG2jq4hQ400mAzgl5DhjjUpxxSR7sHPLy8IEr3ZaeFS6QQ3roJssb2lspPN7xY0AKREnLUaGnBY1TwMj7BVwQXVuEK3m96fK+8n1AcbQxTVAKRLztnqSgKd1jbiDJuwcSk9SWOJeUaF1TpPlSmdJMomiLn+joU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEeZdAvc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee158187aaso104556711cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 16:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767056322; x=1767661122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vejsEe3XBQM7QjnQDzoAjpdMbeIa1bM1FgTHcrVNGxg=;
        b=FEeZdAvcNa0UUcXhEWafsfzbZdN94mbPzk2utWiV/pQvjVyUAJ9FPRhA7F3yhGUuh8
         rYqyr4Dx5Eu2Iouadtaj859eWUNy4Q0CJ47wgIlpVqocEU0lL4UArMI6xx7ktFcFFkpr
         upwL4hQGL6Ts2B2zMb8jFgdMYF/TxPUNYa0euvCPuSPh1iVtyj0zsQ+Zrq4jskSz+1kj
         gye0+FNHSpPVv1+HKw5SpC+fyucirxbB4WRSMjuaD7EsVPTylc3TRdNgqEFEW7T4YByv
         W/Zb1skykzEgBZy1BSJBkY/QMtzjCiwZJf7UxbVrhp+DxbzMBpnjNPJHW7g6ZIA5tiU9
         Fngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767056322; x=1767661122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vejsEe3XBQM7QjnQDzoAjpdMbeIa1bM1FgTHcrVNGxg=;
        b=JRvcV0as0nTBnEav4MAHYafi8/GbeHA/IX3eGHg6LuxKVeAUiq93rsW1eO71fY36+N
         k+mnsKtIh6dfW7WjfMxep/LZwenPJmYnwDupfAlc8luIhayGpUuh2tzmQaZhkkIvH3Dx
         beLFhJ1Dh1yWnth3WK4jCBb5yZStDgRjBwT83aaWjjZMqs5ViYs3Icr6z7tk5yM50NCo
         p1grDYGHe0ZD/V02ZL/tTtL3OjCAmhWTcnO7sPDkTthaGoUZ3NXYFIry3SPBZLmATdp/
         TwiXRGuqW/XOc9wPdrrDvsLbqg3L/VbFGdfWNWZfU7RWaFpLtQ23S6If3Lx47Ngtob4Z
         iXww==
X-Forwarded-Encrypted: i=1; AJvYcCUbb7YjIq7RhRqV7KyRvthpE5N12q+BF7sbxzubtYk9tCsADRKgchkkmBlcQUFv95W4hjpEO7X7Np7sHmlk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpSvnDdNcCSMhQQ9xxgCCtVg6Kuw2P6lDMJGmRJoYCxiqnluM
	Ma1d7Di8GGl+9SFXa0aeY4ZbyMM8wT7H6jEHGt6FptEM/9GigxUUFS01OOYrPsehddy1xKHvnbQ
	m/cqqWgynNlIKR3CWT6ifNErb9t/HPYo=
X-Gm-Gg: AY/fxX4nRrk2iqg393QVyfiOhFEOEqpI4G+lmwyEfYmG61mCJ8aqaV0czYw1ksSYWN3
	SN16oUuooa8YgGkCnSIKUhY9zQP3EPeqIQ/Wkar7mXOXlLUmaXHRZeQCaRAqNWLBFLOXrg/XRyH
	01Tc9ZyiLEEJjPlsUcaAfMp+y+4+p8VPd8OIM4yGMvF6BSOLgL5eP89k+IM08Lt2bTE+br/f2v8
	tLu9MivuDg8ffrj9Nu59Hww3AjIofxrAfGyeOyLd2ZaXaluGazvTIjH7ckfd9M208nh/Q==
X-Google-Smtp-Source: AGHT+IH4enBEhglOv0rx+4DmsceIazUax6qNKBSsVFr8jXf03ll7jaN7TBsQMaqnfZlLIE3CvmVRmbL1YkV3wR6R3zc=
X-Received: by 2002:ac8:5746:0:b0:4ed:dab1:8109 with SMTP id
 d75a77b69052e-4f4abcf6a35mr421688021cf.17.1767056321999; Mon, 29 Dec 2025
 16:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org> <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtLi37WQR07rJeS@casper.infradead.org> <aUwKPtahCaMipU83@laps>
 <aUwiZ0Rurc8_aUnW@casper.infradead.org> <aUxZTvH46FE9Q6qr@laps>
In-Reply-To: <aUxZTvH46FE9Q6qr@laps>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 29 Dec 2025 16:58:31 -0800
X-Gm-Features: AQt7F2rAhkudjcfJrufokZsiG93Oqqq3QG5y7Nmz-ouNfcjF-qSpAZfIoS_n1uE
Message-ID: <CAJnrk1bOE+k7xdwr3umTDxfB1wPnGgYcAFJ3JFXqQLPjyy4Qhg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
To: Sasha Levin <sashal@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 1:21=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Wed, Dec 24, 2025 at 05:27:03PM +0000, Matthew Wilcox wrote:
> >
> > WARNING: fs/iomap/buffered-io.c:254 at ifs_free+0x130/0x148, CPU#0: msy=
nc04/406
> >
> >That's this one:
> >
> >        WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=3D
> >                        folio_test_uptodate(folio));
> >
> >which would be fully explained by fuse calling folio_clear_uptodate()
> >in fuse_send_write_pages().  I have come to believe that allowing
> >filesystems to call folio_clear_uptodate() is just dangerous.  It
> >causes assertions to fire all over the place (eg if the page is mapped
> >into memory, the MM contains assertions that it must be uptodate).
> >
> >So I think the first step is simply to delete the folio_clear_uptodate()
> >calls in fuse:

Hmm... this fuse_perform_write() call path is for writethrough. In
writethrough, fuse first writes the data to the page cache and then to
the server. I think because we're doing the writes in that order (eg
first to the page cache, then the server), the clear uptodate is
needed if the server write is a short write or an error since we can't
revert the page cache data back to its original content (eg we want to
write 2 KB starting at offset 0, the folio representing that in the
page cache is uptodate, we retrieve that folio and write 2 KB to it,
then when we try writing it to the server, the server can only write
out 1 KB, where now there's a discrepancy between the page cache
contents and the disk contents, where we're unable to make these
consistent by undoing the page cache write for the chunk between 1 KB
and 2 KB). If we could switch the ordering and write it to the server
first and then to the page cache, then we could get rid of the clear
uptodates, but to switch this ordering requires a bigger change where
we'd need to add support for copying out data from a userspace iter to
the server (currently, only copying out data from folios are
supported). I'm happy to work on this though if you think we should
try our best to fully eradicate folio_clear_uptodate() from fuse.

There's also another folio_clear_uptodate() call in
fuse_try_move_folio() in fuse/dev.c when the server gifts pages to the
kernel through vmsplice. This one I think is needed else
folio_end_read() will xor uptodate state of an already uptodate folio
(commit 76a51ac ("fuse: clear PG_uptodate when using a stolen page")
says a bit more about this).

> [snip]
>
> Here's the log of a run with the change you've provided applied: https://=
qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.18-rc7-13807-g26a1547=
4eb13/testrun/30620754/suite/log-parser-test/test/exception-warning-fsiomap=
buffered-io-at-ifs_free/log

Hmm, I think this WARN_ON_ONCE is getting triggered from the
folio_mark_uptodate() call in fuse_fill_write_pages().

This is happening because iomap integration hasn't (yet) been added to
the fuse writethrough path, as it's not necessary / urgent (whereas
for buffered writes, it is in order for fuse to use large folios). imo
updating the folio uptodate/dirty state but not the bitmap is
logically fine as the worst outcome from this is that we miss being
able to skip some extra read calls that we could saved if we did add
the iomap bitmap integration. However, I didn't realize there's a
WARN_ON_ONCE checking the ifs uptodate bitmap state (but curiously no
WARN_ON_ONCE checking the ifs dirty bitmap state).

With that said, I think it makes sense to either a) do the
iomap_set_range_uptodate() / iomap_clear_folio_uptodate() bitmap
updating you proposed as a fix for this WARN_ON_ONCE for now to
unblock things, until iomap integration gets added to the fuse
writethrough path, which I'll now prioritize, or b) remove that
warning. The warning does seem otherwise useful though so it seems
like we should probably just go with a).

Thanks,
Joanne

>
> --
> Thanks,
> Sasha

