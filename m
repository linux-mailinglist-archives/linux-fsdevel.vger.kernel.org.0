Return-Path: <linux-fsdevel+bounces-67355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33804C3CC1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 626864F4667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7F34D4D9;
	Thu,  6 Nov 2025 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtw8K5jJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051032BF3DF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448940; cv=none; b=aHa6C3ywqSdvSCGPrbGFyqnlpaWiLCMHoaIgBttbS+vq5KjGLI37F6zGBGMk7P1W2VKnD1dMcoNBn/EwW2W42WyOtMV2+RMoV4oRNM7K6/ymhyYybaU7MyrLbrlJyuhZhQnTQZyQiWOAWVaU120PP4d5bWpyFCzaR5FIhYheffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448940; c=relaxed/simple;
	bh=6o9ZZrR37mutIKNjC6NLcl4zABgGFKhlrWYgRdVJHGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl8BkRKNSxUewRr/ghjoSDgbkB102dZbIdAjYHPrCpeIVBmZIi7T+rCw9qiS+tQLKEY3kekeSwjztRX9dxY4WP/YKqmcPNd3yokW4yVVIWpQJfoRrJxvxfw9BLAH2Pl0nLaHyi7CT7QHt8hcM8pHj03mvUkQ8CiPjqMCUClBX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtw8K5jJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8804650ca32so12679326d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448938; x=1763053738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xdFLs99TCG7hmbukBiXpA5iRmK/dJWsEcsNp3DpC+k=;
        b=Xtw8K5jJnkO7dnx19SMo+S1iNRY2K2o+WyRJPp18beKWXGGRKNaLF4e/2iJ1X13PM0
         i4X08qXj9fN4aG+ehvJZA5LnmA2v0DdnWylOoyHRYGmQeLAuL+OtduJ+jDP+K5WO+j/C
         Kx1MewHZypakp+jvHSSgfd45yUIik0eqkUQgg9gzOcwJ/pNacyyS005rUnNjfzBXx/CU
         9rTdvwO3HLUwHn16rh+NAGpDmxdx2oTstlXUoETQM+vi/OwGUstFoY0yOybZKJy6mmMe
         VXVepbt6nh1nTefj0TFez80UyLkUh98lQzBXCX7FI//K49xsU3/UXeaCBF5QbsRAjZHl
         Ubtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448938; x=1763053738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xdFLs99TCG7hmbukBiXpA5iRmK/dJWsEcsNp3DpC+k=;
        b=HYj0Jm4wre5u577H4pt2WWhVh+6fA36zBQn01/Zqd9WUZ/6lyq+5LS4sGlqFs7N/zW
         YeyFxdfTaPZNZga+v36sRgfjqHpmVA+VFUOSfZDWtQHxR/Mz86bGlvXC5jeREC726AD7
         oUhNQdnzkXE2Os0LdcC0ktz4+WA0oDsEkfil+QEYz1N/WeIlSvyVR0jagoQd/y2dsmME
         vaHUm2IwjYx27Jt8sJP8J3i98sFYWXwkiiyEOLtMr4GNO0wdXkGxKDNgAoryJPZ4oPaU
         Ula7ZMoLUFTmUWEegC6N1y7AGDxffHV4x6t609HWa11YXl+369oolRm8SFGiydaTJrIp
         KZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHLyao3lubuzn1ky5aDnIUGgMy1JIHhd8xYIDXWdUO49fyXjSeDV6gdnyYGKOWuVWdto2u/0JUcIJPzEtt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rcE+apySA5w0YT2WjN4IJtn5dcE1FpOUd+q71Pcd/EFUj6Bi
	VvnNXosf0DtbsqSrLIyidSDlwyIfGyEF7gA3h4P29osfEoGETWK06hyuXI76yQHEfmqBxKBWvGp
	ZthvOzyS61zVNNeurQtyI3OQzvQeq8dc=
X-Gm-Gg: ASbGnctOzVjXUuYyM3S8pBD+K5i3jQUKhM4Pf9o+aijTAgfpBHAxV1CAwgoh9x1TgdI
	xwmL3rzIRpOXNcWYOPcj3i54eyeSc/7s+SRMLRS+g+c3TtogOxganr6zIOf1TzJmH3Cxpa6tvLY
	5gLdRy1xIYF+Xp7zwD1k5EkflFkOQl+GmOgsiCNB6qAHrS+T+IOomHWRFlZBYaPzV1e65PiBvvf
	0puIme+jRmDpyS1wvw+AjrcZuGABas3sYpohEGGj4ZNyOCeDV2jsPgn7ooQMZSjPNPiAU+PK0C0
	vEUeG5ompYMQ5Os=
X-Google-Smtp-Source: AGHT+IH24ttaP2ND8ABZ0MYk5pOjGlaX5NgLsJcV/IWJbwhZ1Xjjjsah+KDhvAD8/Fu9J4YERkA9nI8Tt09A3jCUwg4=
X-Received: by 2002:ac8:5ac6:0:b0:4e8:9a7d:90eb with SMTP id
 d75a77b69052e-4ed72609594mr96852481cf.38.1762448937852; Thu, 06 Nov 2025
 09:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-2-joannelkoong@gmail.com> <20251105012721.GD196362@frogsfrogsfrogs>
In-Reply-To: <20251105012721.GD196362@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 09:08:47 -0800
X-Gm-Features: AWmQ_bnZlXgnVWVptbwNrOcCWOTSqkqTg5f7xMtR_VvuX6pbHkHwsNowc6K8RKw
Message-ID: <CAJnrk1aMZPoRKgPA39pqjHvH8zPsu0vhqpoVmPdyHYEo8Nszww@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iomap: account for unaligned end offsets when
 truncating read range
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:27=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Nov 04, 2025 at 12:51:12PM -0800, Joanne Koong wrote:
> > The end position to start truncating from may be at an offset into a
> > block, which under the current logic would result in overtruncation.
> >
> > Adjust the calculation to account for unaligned end offsets.
>
> When would the read offset be in the middle of a block?  My guess is
> that happens when fuse reads some unaligned number of bytes into a folio
> and then stops?  Can this also happen with inlinedata mappings?  I think
> those are the only two conditions where iomap isn't dealing with
> fsblock-aligned mappings and/or IOs.
>

The end offset may be in the middle of a block if the filesystem sets
an unaligned mapping size (the length of the read used is derived from
iomap_length(), which considers iter->iomap.length which is set by the
filesystem's ->iomap_begin() handler). This is what we saw on erofs
for inline mappings for example in this syzbot report [1].

[1] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE=
@google.com/

Thanks,
Joanne

> (Obviously the pagecache copies themselves aren't required to be
> aligned)
>
> --D

