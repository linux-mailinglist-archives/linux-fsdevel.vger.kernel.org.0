Return-Path: <linux-fsdevel+bounces-74201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D3D38471
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4D6303B7E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4207347FDE;
	Fri, 16 Jan 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc+am34J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A392040B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588599; cv=none; b=G7FkQ9dlMqGI0EsTK9hDlUxIQmQMF8gf1F8W4LvHvNFec4nFxLH527sz1TcJNJSUBRLj7E1OTIWf+8+P5/fgnjwhztrIgnG7HsB5vJ5bCtFWTIZEHNfoBJF6PFNsvSHWBDSxi7OR1Hz9UyonZegaDQlkcL7xOsInDTYro1YJN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588599; c=relaxed/simple;
	bh=gPvyYa14EC4tF4cy9CrJLGbVVxkTIRT6bu42ANYP+fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhW7wwd3CQVXG/qlfwEnXX9w2KXYh9fasIF1mtdR3G7jy0+pA53CHjQtJFRUSVIa3ClhEXwsTNNW4YxlVBTFSJ5g+AnSJQ/Z1z2C3rhcQCGhdGSy2eu586JULN5hOnVZXNxe+1v5Af2ztafG+9A3vbEtQaAetEqwqCR/9ASUX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc+am34J; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-502a789834fso6137831cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768588597; x=1769193397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxz+FIbS2kiUPNZm17oq+0DoruflHlTPP8rpEzxMgB8=;
        b=Bc+am34JAjpmxqdJfSo2Kriz1bkbMTTCOrt7kk1PYyEXPyidlLo4l/8/fNcOOsjBUU
         UCs6kYuMnqKaXEgFAUm+OFLDTMSIfQSrFFnsYYcdfiAK0T7FjACqg67Cqpj8iLDHtxFe
         G8wtbaBEqQabredP3Knz6VxKozK60OhNApRpzMKTmg9Zs+iJcwjLP7gu8wsx3c/iRyRz
         InXW6bCHsxUS5RB5N2lSLgT/zQl2AUwpVrbdJW/7XyPuCVWCmWU0eDqDFSurBj3Tilah
         HdGwAKse0mciFAMrMQ+DBgsZoIMg4nqyMzQ1vi6xASxVovNY42H2fLUZHgsCDbwuBCo2
         o6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768588597; x=1769193397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cxz+FIbS2kiUPNZm17oq+0DoruflHlTPP8rpEzxMgB8=;
        b=uGeWivEIoHdnYgV6dSLc7bDBVbmrTkRmJ/PopD3186HYi+PY3PWb1TQJt3J6HBgk5A
         jiCJgKy71aM+BCECzY9TbTpxFo0Xj4ExDov57zMGAfqmODPPTS3RdlDswiaa96JNLwts
         JE6B+/IKNgmSfEFmo8D37PkXZxnGpYmwsuwLff3okVVpLsDA6hbUcS+CksRjvO4yGDgk
         njbrEYdnWHGm7AWD1UwSjvr9Bv6VrQ94KpQT0BIAWHWg3dvOGBGUAThzW4FrvwRjftwS
         1i8X+8jJUbvYzViv6EnVmzrjfeydTCtP4Jm9rIcAVTJ0eZGj6b1dXiZlWiLIG2OZyPOI
         RijA==
X-Forwarded-Encrypted: i=1; AJvYcCXUxCg/qxO10MxsWjMQZzxCLAX2zeedwnX0sqaA5SaFaD8jJqf1MpT0n8fvZl8anZXByWqxMl5xDmwu4JLu@vger.kernel.org
X-Gm-Message-State: AOJu0YyyR9allnlwXHe9nUoXSYYm8wjQsAAqVXU1imFq5tIPI96dJQmO
	42tEFxEOsx5h0SbGcz+IGJgU7Zy2qY6wW7hl9/bJxebdSwK69nw1J2+HgvfZbrSKJmCKEYeCoNz
	m2+7B+dCI5P8dufh4+tl4rMRx2pawW1MdBuV9
X-Gm-Gg: AY/fxX4eCXhCYpCTY6agw0Boyq+lxNCf+PIjIS5X+ZaW6NFqHOM65XqzpRZGxB524sO
	POIu7SyyKI9Y+ZI1xP8kUhq/uqgiRERZTWhEZjp3GengiMbPFX0s5Vtui4TV22nQYdI268nzyUj
	Fi0IlO6BjfxpeP9nJoKLA8gdV4oF9Sw4+w8UD6FXMmkxOgFA+kbooL/dUT2aDZkDb3VxtU1vbV6
	g8Et7e/ETYGN17bNIWg2PW62JZ5Jh2i5PP1ApvUuWPm2hJZpbH1a+76buWrwPU42L8gQA==
X-Received: by 2002:ac8:588f:0:b0:4f3:5816:bd8d with SMTP id
 d75a77b69052e-502a179ca4fmr59558941cf.62.1768588596702; Fri, 16 Jan 2026
 10:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com> <aWmn2FympQXOMst-@casper.infradead.org>
In-Reply-To: <aWmn2FympQXOMst-@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 16 Jan 2026 10:36:25 -0800
X-Gm-Features: AZwV_QicbvE4GgVFyex86LT71V1DCglpcJvQBZrW6tPWcAq8-5YCEW7UnYEDJJA
Message-ID: <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:52=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jan 15, 2026 at 05:54:52PM -0800, Joanne Koong wrote:
> > readahead_folio() returns the next folio from the readahead control
> > (rac) but it also drops the refcount on the folio that had been held by
> > the rac. As such, there is only one refcount remaining on the folio
> > (which is held by the page cache) after this returns.
> >
> > This is problematic because this opens a race where if the folio does
> > not have an iomap_folio_state struct attached to it and the folio gets
> > read in by the filesystem's IO helper, folio_end_read() may have alread=
y
> > been called on the folio (which will unlock the folio) which allows the
> > page cache to evict the folio (dropping the refcount and leading to the
> > folio being freed), which leads to use-after-free issues when
> > subsequent logic in iomap_readahead_iter() or iomap_read_end() accesses
> > that folio.
>
> This explanation is overly complex to the point of being misleading.
> If it reflects your current thinking (as opposed to being copied over
> from the previous version), it explains why you're having trouble.
>
> The rule is simple.  Once you call folio_end_read(), the folio is
> not yours any more.  You can't touch it again; you can't call
> folio_size(), you can't call folio_end_read() again.

Oh I see, I was under the assumption the folio can still be accessed
afterwards so long as you hold a refcount on it. Thanks for clearing
this up.

>
> This discourse about refcounts and descriptions of how the page cache
> currently behaves is unnecessary and confusing; it's something that's
> going to change in the future and it's not relevant to filesystem authors=
.
>
> So let's write something simple:
>
> If the folio does not have an iomap_folio_state struct attached to it and
> the folio gets read in by the filesystem's IO helper, folio_end_read()
> may have already been called on the folio
>
> Fix this by invalidating ctx->cur_folio when a folio without
> iomap_folio_state metadata attached to it has been handed to the
> filesystem's IO helper.
>
> Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and r=
eadahead")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I'll send v3 with this commit message.

>
> > +                     if (!ifs) {
> > +                             ctx->cur_folio =3D NULL;
> > +                             if (unlikely(plen !=3D folio_len))
> > +                                 return -EIO;
>
> This should be indented with a tab, not four spaces.  Can it even
> happen?  If we didn't attach an ifs, can we do a short read?

The short read can happen if the filesystem sets the iomap length to a
size that's less than the folio size. plen is determined by
iomap_length() (which returns the minimum of the iter->len and the
iomap length value the filesystem set).

Thanks,
Joanne

