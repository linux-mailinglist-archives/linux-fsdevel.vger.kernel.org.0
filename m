Return-Path: <linux-fsdevel+bounces-29266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC99775DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9FE1F2444A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC33945A;
	Fri, 13 Sep 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTrBP5cN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2B391;
	Fri, 13 Sep 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185635; cv=none; b=gxMqxnGJKvlBbFzAywtqRPxLnxPCkKKkMgDePaWNRRduZL5v4435E+sG80+Wm1YPVJztc2Z+STJR+ToDezsuYd2olDfj+zYXRzXJKxZCv+UUibq0/vjKK7AiAjsdAUOahFPzjGMx3AJMMxAwm8o/8XrHHUaijTyY3L3o6o6HUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185635; c=relaxed/simple;
	bh=EcWYGwOIr7pQ5IsfEaxzIIxg5uEbARMWxrehmH9juZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBtQMhQMjNrCuHAbkYHLF171w4aiEG7+6MfWqa7Yn6EdDrbTnQHCZDZFlH1E2ATjAkoc5fo5TJuXZN7/jBlj/YpHJrt7EY73o+6KwH4F5UFxqHGj9NeKCMIv6Ey88sKZrF3AUnG2g09dlH1Exsx4RN/T221Ju69HWG53Q0DPxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTrBP5cN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4585e25f42bso3054881cf.2;
        Thu, 12 Sep 2024 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726185633; x=1726790433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1nLXWhZuleCIwXmkpJzmdAmIhj4G5OIwq8lV7kYTlw=;
        b=jTrBP5cNPmmXqMoEXTxSv/Kp+jt6ndCam5VXWVbavkJ2kEGc3C6yZ0GGeQ57TDBZ09
         isuX4cIyOPAZdRY09jjQyoUL8FIrRdjxfRyGN3Vl6fA+sX/0kBDUexw4+/WqZG6clqZF
         pxuSvdN5gdmm+b8FUKmi6G20sQIpxroxz6C4R6ZxK+h+tIKPPx33+jqZxTpHBaMQX+ng
         wnvDYvVi1WDvjyJeyeqJUZ77G8TR5VSvHJEEO2OCVwsg0IFSf8OVa2+hv60Yl9bzcW/3
         BFvRGcTTFtCO9jyndzVKnqjqurMKCUKFRnjobImCDCSsGtiEj9uZY+pW38X96/VZy2Mo
         GgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726185633; x=1726790433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1nLXWhZuleCIwXmkpJzmdAmIhj4G5OIwq8lV7kYTlw=;
        b=wd2BiFU71hr9Tf58b13fDgEGEV4VQb2WncKQHBDGTcv9ewPFaIggWOYCWrvMY5UO7h
         F+Yw1jaIHjLKF7JMG6eO1F0LTbHwCJaung61isgJtpVSqQ+h399yDESMozAjAGHvTywk
         LvyQYTyjmyOBdPgCC9biOnAxyny9w1WKRzxF1CM6KuAcZ98iMWLjhcpLVyn/jtgyOTAH
         w5tv+Y6bGjz0gSxoL65ueILmbniJHF2mQAnGeN4K+JlP5RjnM8Jl5eqvKP8t9dvhqX0l
         +gmvXLFfvdaji+nmN4IhGotrNfHI8NFmw5rJMnXxZhlxL0PbeDm4TRuTeNtBEme2REkP
         YIpw==
X-Forwarded-Encrypted: i=1; AJvYcCWayvnpURCN6mQmdXnxoQICcOWhRXLGfTF9/s90ipJvZmXBh4RJEyjTkhOLMK9NARKIgZGR19zeVmoW+2jS@vger.kernel.org, AJvYcCX3QaeKQZrZK4norX3uxbwzQ34gVysaBTqzXeAG5uLW8nZ322583fCy9pa+hb2dmdlTN1BPyXfuzExpfCvO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/H8Vk1xE2X84nqvVlTGlNh2EvvfVLhFmBX4yBk+5KeadxLoE
	UhsToPtctQChOL4Db4U42Zz4lD9eoYYEB3K4fsPsE0opbpxExqovcababeWDC/GvNFQDESKAVaa
	f3AhTCDMg3t6FJUO7hkV/kNvlX78=
X-Google-Smtp-Source: AGHT+IEKAWiNgMeY++F/YiLcNTqKSLVPf5Rl+tNUD0+piqIYBmOwvXMm5o2/00gvd5wyiiEcfRbvCFeRpIDemVPNS3Y=
X-Received: by 2002:ac8:5795:0:b0:458:3e20:65bf with SMTP id
 d75a77b69052e-4599d225663mr15667671cf.7.1726185633070; Thu, 12 Sep 2024
 17:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com> <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com> <e7a54ce3-7905-4e70-a824-f48a112c1924@linux.alibaba.com>
In-Reply-To: <e7a54ce3-7905-4e70-a824-f48a112c1924@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Sep 2024 17:00:22 -0700
Message-ID: <CAJnrk1bTt7r1hfkp6oA3-_x3ixEd_qKb8Kkxrugv8XOOJz7U4Q@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:34=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 6/4/24 6:02 PM, Miklos Szeredi wrote:
> > On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm=
> wrote:
> >
> >> Back to the background for the copy, so it copies pages to avoid
> >> blocking on memory reclaim. With that allocation it in fact increases
> >> memory pressure even more. Isn't the right solution to mark those page=
s
> >> as not reclaimable and to avoid blocking on it? Which is what the tmp
> >> pages do, just not in beautiful way.
> >
> > Copying to the tmp page is the same as marking the pages as
> > non-reclaimable and non-syncable.
> >
> > Conceptually it would be nice to only copy when there's something
> > actually waiting for writeback on the page.
> >
> > Note: normally the WRITE request would be copied to userspace along
> > with the contents of the pages very soon after starting writeback.
> > After this the contents of the page no longer matter, and we can just
> > clear writeback without doing the copy.
>
> OK this really deviates from my previous understanding of the deadlock
> issue.  Previously I thought *after* the server has received the WRITE
> request, i.e. has copied the request and page content to userspace, the
> server needs to allocate some memory to handle the WRITE request, e.g.
> make the data persistent on disk, or send the data to the remote
> storage.  It is the memory allocation at this point that actually
> triggers a memory direct reclaim (on the FUSE dirty page) and causes a
> deadlock.  It seems that I misunderstand it.

I think your previous understanding is correct (or if not, then my
understanding of this is incorrect too lol).
The first write request makes it to userspace and when the server is
in the middle of handling it, a memory reclaim is triggered where
pages need to be written back. This leads to a SECOND write request
(eg writing back the pages that are reclaimed) but this second write
request will never be copied out to userspace because the server is
stuck handling the first write request and waiting for the page
reclaim bits of the reclaimed pages to be unset, but those reclaim
bits can only be unset when the pages have been copied out to
userspace, which only happens when the server reads /dev/fuse for the
next request.

>
> If that's true, we can clear PF_writeback as long as the whole request
> along with the page content has already been copied to userspace, and
> thus eliminate the tmp page copying.
>

I think the problem is that on a single-threaded server,  the pages
will not be copied out to userspace for the second request (aka
writing back the dirty reclaimed pages) since the server is stuck on
the first request.

> >
> > But if the request gets stuck in the input queue before being copied
> > to userspace, then deadlock can still happen if the server blocks on
> > direct reclaim and won't continue with processing the queue.   And
> > sync(2) will also block in that case.
> >
>
> Hi, Miklos,
>
> Would you please give more details on how "the request can get stuck in
> the input queue before being copied userspace"?  Do you mean the WRITE
> requests (submitted from writeback) are still pending in the
> background/pending list, waiting to be processed by the server, while at
> the same time the server gets blocked from processing the queue, either
> due to the server is blocked on direct reclaim (when handling *another*
> request), or it's a malicious server and refuses to process any request?
>
>
> --
> Thanks,
> Jingbo
>

