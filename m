Return-Path: <linux-fsdevel+bounces-51191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F70AD43ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B74A3A63CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DC26772E;
	Tue, 10 Jun 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IemQsh3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF290266582;
	Tue, 10 Jun 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587633; cv=none; b=Yt/8N3zdzcXPK17rw2LzAx9n2+YYBOE90Pa9nXbqSYXvi+vNowjieYrS7jdz4OqFssnMRYLlX8jhDxoasJdGK1A7acZkjAI3oCkits/xEFir1SHsb91CxVH8ZBPypvKnkX+fUhqEtOUGAOYdpWgb0Uc43IyFBR8NDzwn3qlSsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587633; c=relaxed/simple;
	bh=Sqi/29luQn9ao85k4phSXiaf/UkTaGrwo2oIDzSgcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZjNR2bFiobsJ7h1EQ/LY31tb82g8F0edkR3b4UGfBDdZKySqKte/5K4sEVMul+IeaNx9NsAiIYkDwvuCDmnaj1UL9GBf/HctPp+1SSxCr3FsKhYlbuIIHv3ghHzqVqZft3zq3bCHf6WwYBtqg21FgqSkf5uFljsDqigwZGE+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IemQsh3O; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso2690851cf.0;
        Tue, 10 Jun 2025 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749587631; x=1750192431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbAqsneQhfeedfVnvXcHUYrbCwPo5eftbbe8/WWQoTw=;
        b=IemQsh3OBNOpcZZ/e6UkRdSinS4uRQdqATClj+cut8wYt7s3BEEZXJpdX7KLVnWNEv
         cNa87FDN7U+GDhQkJkEN2Xv6/+SG8/RTCzsJp/idp4sDFEHIIPDYh6IPuhDIPNanA1CS
         eTPCZEx5W4rryAAPCtP8nhPQeA3pJo+TyJwBvEQQejLzMKs5GNum1Uqh3Bi2p+IPyM3H
         SNdRzkZiSPgC94Cq1jIuaV6Ad79gbzuMPKE9M1c5gRsm3+/NqwEVQdDP1xdqclRoDr1h
         u5zggFEywlV226cbF5OBBMT+Yz2YrBFLLOh5PgVeIuE9eOtgYXSXtx9lQmcmwUrjJktF
         hzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749587631; x=1750192431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbAqsneQhfeedfVnvXcHUYrbCwPo5eftbbe8/WWQoTw=;
        b=ZGryevCcwH4SNh2c8eine7rAWtQ+hyS46MQaKDozGQWYPl0d0qiDU41U4HDa5m9Wgn
         0qNKc2ujO6ujkOSt45/DDIkAYzKqZHebIn5baWkYZKwNcZzRcE+jyxRrVfwD2ckpgnXo
         MdRttX686c+xrpY45xuEqWSoiLOmgHqN8cE1HGnsSL0iu72XtOIkkkblkvaoMdvXK0yC
         PcRCDpeiEhVGqGzIXXGWX5qkvruNQA614RupzGhJTrFBN/uAHaI+za3kgDbA7PaXjeia
         5RB6oeBx5dHHDGwPaimXzlpZtgxCufqohG7PjIuWMDGA0loaqKtwtp7S4UbpwrIYnwlw
         R+YA==
X-Forwarded-Encrypted: i=1; AJvYcCVqz0VAx92Q+L99YfIDv5K4f8IICsgf8n4WDx2sZx5ScQO4vg280g//dNBq1HaPfvW6Rfhe4EleFsp3@vger.kernel.org, AJvYcCXa5qqVVSmMuZJVQR/3FLS09E2E31sObwo932o0Y2ncWwMZlYYXcEq+QmgpTVP+orhXiBuI0+EmDObrm8yi@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPbuaaHE2DA8YPR1HazDDTKAlhH3OMOV830xo2MZtO4lEaIgD
	bvoQddEPBxrJ2xSYwCpDnmPiXLXokzyrK0QgMFkvgPnpN9H7k68ebvUyZTeyO/HKsn9N8GZoRXO
	B4LLrJ8mAkzNWOIT10H1BGhiDi6cR+xTbFhVG
X-Gm-Gg: ASbGnct3u+VxWSBfASLBGCJq9gW7WkYrHw0kFA+/3fmk3i5pTZGTmEa+8kAZ26HE29i
	+6EB9TYu426hfA2UQpZghHZjMb0GWBTVqvhgxy3UCki59h0Pc1dx9OnVKkYzqncPLYh0KhIWXwI
	UyUjidWajOq79q1zNKVxY/B5w/PR5SqHutaLKKwiczvlo=
X-Google-Smtp-Source: AGHT+IGMhWXhozFNlOLEAUKMRi2qEBhBs+3fWLo66PVoMngSQGTMlXcFe2qvEJ5jrMdqq8j7gE2dWmreOrCcQXZHS5k=
X-Received: by 2002:a05:622a:2304:b0:4a3:5ba8:4973 with SMTP id
 d75a77b69052e-4a713c3bca1mr14972991cf.5.1749587630660; Tue, 10 Jun 2025
 13:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com> <aEeAqxUfFxepmQle@dread.disaster.area>
In-Reply-To: <aEeAqxUfFxepmQle@dread.disaster.area>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Jun 2025 13:33:39 -0700
X-Gm-Features: AX0GCFtQ414l-GX_sp86KHWk6WpIb2mXxZUH6N2G-45XQ3weQCqZ7wCXfwr6Ing
Message-ID: <CAJnrk1YvFDOFpQaAapFr+Kit2Y0rzCv3iJxTDCqa2H-XB0a7+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Dave Chinner <david@fromorbit.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:47=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Fri, Jun 06, 2025 at 04:37:55PM -0700, Joanne Koong wrote:
> > This series adds fuse iomap support for buffered writes and dirty folio
> > writeback. This is needed so that granular dirty tracking can be used i=
n
> > fuse when large folios are enabled so that if only a few bytes in a lar=
ge
> > folio are dirty, only a smaller portion is written out instead of the e=
ntire
> > folio.
> >
> > In order to do so, a new iomap type, IOMAP_IN_MEM, is added that is mor=
e
> > generic and does not depend on the block layer. The parts of iomap buff=
er io
> > that depend on bios and CONFIG_BLOCK is moved to a separate file,
> > buffered-io-bio.c, in order to allow filesystems that do not have CONFI=
G_BLOCK
> > set to use IOMAP_IN_MEM buffered io.
> >
> > This series was run through fstests with large folios enabled and throu=
gh
> > some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB=
 chunks
> > and then going back and dirtying a few bytes in each chunk and b) writi=
ng 50 MB
> > in 1 MB chunks and going through dirtying the entire chunk for several =
runs.
> > a) showed about a 40% speedup increase with iomap support added and b) =
showed
> > roughly the same performance.
> >
> > This patchset does not enable large folios yet. That will be sent out i=
n a
> > separate future patchset.
> >
> >
> > Thanks,
> > Joanne
> >
> > Joanne Koong (8):
> >   iomap: move buffered io bio logic into separate file
> >   iomap: add IOMAP_IN_MEM iomap type
> >   iomap: add buffered write support for IOMAP_IN_MEM iomaps
> >   iomap: add writepages support for IOMAP_IN_MEM iomaps
>
> AFAICT, this is just adding a synchronous "read folio" and "write
> folio" hooks into iomapi that bypass the existing "map and pack"
> bio-based infrastructure. i.e. there is no actual "iomapping" being
> done, it's adding special case IO hooks into the IO back end
> iomap bio interfaces.
>
> Is that a fair summary of what this is doing?
>
> If so, given that FUSE is actually a request/response protocol,
> why wasn't netfs chosen as the back end infrastructure to support
> large folios in the FUSE pagecache?
>
> It's specifically designed for request/response IO interfaces that
> are not block IO based, and it has infrastructure such as local file
> caching built into it for optimising performance on high latency/low
> bandwidth network based filesystems.
>
> Hence it seems like this patchset is trying to duplicate
> functionality that netfs already provides request/response
> protocol-based filesystems, but with much less generic functionality
> than netfs already provides....
>
> Hence I'm not seeing why this IO patch was chosen for FUSE. Was
> netfs considered as a candidate infrastructure large folio support
> for FUSE? If so, why was iomap chosen over netfs? If not, would FUSE
> be better suited to netfs integration than hacking fuse specific "no
> block mapping" IO paths into infrastructure specifically optimised
> for block based filesystems?

Hi Dave,

The main reason I chose iomap was because it has granular dirty and
uptodate tracking for large folios, which I didn't see that netfs has
(yet?). That's the main thing fuse needs. When I took a look at it, it
didnt' seem to me that fuse mapped that neatly to netfs - for example
it wouldn't use netfs_io_requests or netfs_io_streams or rolling
buffers. Netfs seemed to have a bunch of extra stuff that would have
made it messier for fuse to be integrated into, whereas the iomap
library (except for the bio dependency) seemed more
generic/minimalistic


>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

