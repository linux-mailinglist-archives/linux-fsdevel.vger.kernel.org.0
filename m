Return-Path: <linux-fsdevel+bounces-73993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D1D27ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF814300AC5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2812D73AB;
	Thu, 15 Jan 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAIBN6W2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A8261B96
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503944; cv=none; b=MtMHL7Hccuec2nU1RcJ5U9rPmFdVeLQCzgQ0LBcH+8in2buNjzROBrZ+8c0KAU51MfAtm65sSoyBw6xEgM6CYS7EjGr/ymOQf0gj8DekEYmbe0+Pqr6bRIxPDD/a+dcqodb7csN4Td6QIQM5/uLtCPBhpYTI/J5md4Iux4TnIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503944; c=relaxed/simple;
	bh=ZmsfE9sIH70MMj65vAL1gttXaQN41rB6Sxqh1EDzwOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6tQUvNsLWnrnCfFuWqS59dm+G6/3XACHVxTZtOUTfmFR4CwocOd0xzzUmi1lx+QrJRy7t16ZMvnRGCEd+EegKsSV/jqx2B/ODCsviKQZs8GoPAfrcavSu4cxkAemcWVKFuv0H93Rj1EGZRu9G5ey5MEfV2Cx5/BG32B6ZJCxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAIBN6W2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a2f2e5445so15108986d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 11:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503942; x=1769108742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v42ZGxVDIxM/ZlEkO2Jj0j/ri8KMhmEi65u2YORWkas=;
        b=bAIBN6W2yViRRpvPIO89cl0C320sIxO7WFNIz36PprwS9txmvi9t/oMxoDVNZkVZdh
         I4HSpHvW42Q8pk1V+AwVD2lKIvYDINLzCrx3DJV2qA5c4AqdIqVPbWXecJ0qk8Iz7xYf
         0BBgkOG1pY62viMk9cha0yejeTtHdB6p09rIZK7bdUPKTI6q4d5NjXglIfYY4OWbtkui
         ZT9nSFxgoN1OKO6pIc9Xn3NCR4PtoivhJ8jft/6l8VgOgSlbVg3PWyHObj1aO9qnCzTg
         d4CgazXbi2XcAqMthz/qwgu4UtJ6K72xzxUi4haI5blTfrmqwPwsqsSP0IfZw9RUm3du
         sjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503942; x=1769108742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v42ZGxVDIxM/ZlEkO2Jj0j/ri8KMhmEi65u2YORWkas=;
        b=GfgKcHjL1S4bmcK85eeQ+Us0hxwjhyNfrzqhe8vJiK0dSQTPRnvdvp36Icd9ybQCEb
         3md9EjuVdIklyPc14YGxzDRY/eSgG3zeoFOxijAXZ0T8lCVqiCPLHxt516B1WsUfFqzu
         MZxEp7pOnRkY3lUdojHLg9GSlHRJsuSY2YOddKr1OKnd59eMnD5gNdmDIkCXMixgcBGu
         UbYRu1KD6rUEYOkDFnpOcxyZsyS4nDEAKr60BWQBVj8RpYwCMiyQ8+OL1pmL06245vMg
         fvKO23e4Vmf5Pl7Qd4mtFq5DoN3Zvs6HiD3GWZqD34DQ8FjSkHr2z+J8GveNaCS4wVEO
         KC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUTuPu+N7H+YeAx8qy/+okT9dpW+TQc8R7CCHs39dejzEdGK17ff8D3fE8JM9K6AxbdzynxFgeTvVdlxKyq@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSfKSprfwIKUfC3xMWoyr8jM/BPnMGFAnslbPPPJOx7VakjPz
	YmznLoMsVntz8RtJ+dWqz+S+IKpoYSccHbpzr7rv47msOnX09yuTK8+toTgMdqAyMjsKisL6D3W
	voYXv+jV1PyABFe1z8ugEYsG2M5GEjp4=
X-Gm-Gg: AY/fxX7YPrZMpEgkSDySLolRj3xUubSx52GLwan2Wfcl1M382cv5vcVWRp+CwUXMRMJ
	RFxQDWUg8ZlVEtuzEoQr88o8WOnU+SZRzxdfYqvWNQCN4ZjvYISfpkEjBKGDotb8AqQeJ/XulMt
	5fd8upxlq6UBI29MvCO9/ESbRjB5ewnfHRKzslAIqQ9/O0fR5km00LrnM/6DPMgpn8p6AXwymUZ
	9aI/uaW2zHFjYmRP7T2XT87UDQEfHQLOxX2HKZSKlnZ/R6I6xxFtvGxat8M4pJtN2cBIw==
X-Received: by 2002:a05:6214:1c07:b0:87c:1d24:7b7f with SMTP id
 6a1803df08f44-8942e312759mr6620236d6.23.1768503941330; Thu, 15 Jan 2026
 11:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114180255.3043081-1-joannelkoong@gmail.com>
 <aWfk7T4sCjAhOVZ9@casper.infradead.org> <CAJnrk1awyskKaoSTznzwLg3bS64asPqH4c50iLKqANRe-eMK5Q@mail.gmail.com>
 <aWh0lmKBL-4A1zuX@casper.infradead.org>
In-Reply-To: <aWh0lmKBL-4A1zuX@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 15 Jan 2026 11:05:30 -0800
X-Gm-Features: AZwV_QjWp3MaoR4kB9gGb6i8Lv7Qfk0X_gqvF9UxRHrmFYg99VReOZMdGgSMPA0
Message-ID: <CAJnrk1b6t4wP5BhTbdz5FZsJbRy=5BbiMf3NC08A5KGu9c5Cfw@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:01=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 14, 2026 at 11:52:54AM -0800, Joanne Koong wrote:
> > On Wed, Jan 14, 2026 at 10:48=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 10:02:55AM -0800, Joanne Koong wrote:
> > > > readahead_folio() returns the next folio from the readahead control
> > > > (rac) but it also drops the refcount on the folio that had been hel=
d by
> > > > the rac. As such, there is only one refcount remaining on the folio
> > > > (which is held by the page cache) after this returns.
> > > >
> > > > This is problematic because this opens a race where if the folio do=
es
> > > > not have an iomap_folio_state struct attached to it and the folio g=
ets
> > > > read in by the filesystem's IO helper, folio_end_read() may have al=
ready
> > > > been called on the folio (which will unlock the folio) which allows=
 the
> > > > page cache to evict the folio (dropping the refcount and leading to=
 the
> > > > folio being freed) by the time iomap_read_end() runs.
> > > >
> > > > Switch to __readahead_folio(), which returns the folio with a refer=
ence
> > > > held for the caller, and add explicit folio_put() calls when done w=
ith
> > > > the folio.
> > >
> > > No.  The direction we're going in is that there's no refcount held at
> > > this point.  I just want to get this ANCK out before Christian applie=
s
> > > the patch; I'll send a followup with a better fix imminently.
> >
> > Sounds good, thanks for taking a look. I'll keep an eye out for your pa=
tch.
>

Hi Matthew,

> I can't quite figure out what's going on.  If things are happening as
> you describe, then with your patch we'll end up calling folio_end_read()
> twice, which is not allowed anyway (and we have debugging assertions
> to catch!)  It feels like something needs to be clearing ctx->cur_folio
> if it knows it's going to call / already has called folio_end_read().

I'm not seeing how the patch ends up calling folio_end_read() twice.
The issue is that without the patch, after the readahead folio is sent
off to be read in by the filesystem in this line in
iomap_read_folio_iter()

   ret =3D ctx->ops->read_folio_range(iter, ctx, plen);

the filesystem may have called iomap_finish_folio_read() ->
folio_end_read() on the folio, which then allows the possibility of
the folio being evicted from the page cache, whereupon it'll be freed
because only the page cache holds the reference. That problem is that
subsequent readahead logic (eg iomap_readahead_iter(),
iomap_read_end()) still accesses into that folio. This only happens
for folios that don't have ifs metadata attached, since for folios
with ifs metadata, the bias we add to ifs->read_bytes_pending prevents
this.

My thought process behind this patch was that if we still retain the
caller reference for the readahead folio, then when the folio is
evicted from the page cache, the folio won't be freed since we have a
ref on it.

Looking at this some more, I think you're right that the better
solution is to just clear ctx->cur_folio if the folio could have been
freed.
I'll submit a v2 that fixes it this way.

>
> But then I can't see anywhere in Linus' current tree that's calling
> iomap_finish_folio_read() outside of fs/iomap/bio.c.  Should I be looking
> at a different tree to see the problem you're experiencing?

Fuse is the other caller of iomap_finish_folio_read() (in
fs/fuse/file.c). The tree I'm using is Christian's vfs tree (on the
branch vfs.fixes).

Thanks for looking at this, I appreciate your thoughts.

