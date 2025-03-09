Return-Path: <linux-fsdevel+bounces-43557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E4A588A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 22:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E68D169DC8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA921C182;
	Sun,  9 Mar 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjinMXda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DF1EF368
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557228; cv=none; b=J/DbTa8t8LNUnF4ykRO548kvBh3eOIq8l2UTsI88f0utNJTYS6GFcHhVAPdZLNREgdpBfm/TErAe74ILg8Emb4WeN/i3xdvH8/r8cuai6dahYTRCCF9UWmUHfOUoby2EpQXRSd5v0zv7HdoEbL7dKqNbxUN5VvhbmTU/QqJM9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557228; c=relaxed/simple;
	bh=Dfxxt+r0hXdbzrzqUEkehywoLzPDKnxD4DYdZYfs86Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srMzsxQDksuLGePfgNnRR3EhXNL7LBH59VAy9hrwRNxLBjWmzbLnNTJd3kk4t7CddtQR4W3nufYgL5A4FNgGkfm6WAual+W/bi8T7s3K77yXdh/8wiIIOqRZdPrw6Dfxs+eqbTZSwdBKjbwuXjHwqWeMf+uIw/KFuXsPQNmm0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjinMXda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741557224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D220kPRAxAKpv4Rtv81ljc15cpNzLUp1Nc2zaYhL/50=;
	b=TjinMXdaqGtqgwyJudxFhcLmfqFgEIV4PIeqOQodo+Qsx8ZNsygkkUvHuETZOe8AxDsKSg
	XutZfSPEAhH6shEHRoVvg20zM7WbXGSO7NJBtwRH0aKKQeeNI7SN7xc1LfaL00eUZL0tyJ
	k20kI/p242/SflJIrklGF3ykt8oIBPc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-VB0sjvj3M76ZacRzEcecmg-1; Sun, 09 Mar 2025 17:53:43 -0400
X-MC-Unique: VB0sjvj3M76ZacRzEcecmg-1
X-Mimecast-MFC-AGG-ID: VB0sjvj3M76ZacRzEcecmg_1741557222
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224191d9228so73592825ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 14:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557221; x=1742162021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D220kPRAxAKpv4Rtv81ljc15cpNzLUp1Nc2zaYhL/50=;
        b=krq4FDyPQaYeU1jbSijvTrd4LP38fZVvZ7Z3LsR716Hel4559hpW/j3kX9ZH/N7/NW
         qPzdUjIfm/EZuzyf6JmAo6xe3na/7Zw9w4Rkex0FeGYB3mQlOVzB75DUxgdMrQeEjXCc
         3Y2BPLrr+bdeXcKRb6/GfPde0rusKJGiLJS2VG/hrY5AC0oOJKt94R6IWShfxtI+nClw
         HLw3OPQ0KtQrkrPpXKIqqjFfp/z+c5RAC7ZYvOMX58ldGE4iSqtAU9adUuOAAZPI1psx
         Q/M+rL2JVRWLXNxT6zkJO4yEY5CMDxchVXk1PBlVNrJEvyPDwRk84CXxGWLwn+5trt3v
         aerQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhm4sf6Fp2c+C3s/zShDH52oqbkSqvqe309L4PG5g2BJLD2OAzXEclIpwKWLZQI0gek++537VSoHuc3xYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YJ+PV7L16tbcYIW6frfWSE3fParE0iZnKAQPCLjwYPe98orq
	afcDel/8UPeF1emfB2T2Q0npopPh/yjfwB8hkilSq7TMSuNPTyaqEIjbRSXxUmVJaaNeYqMX1RB
	do4UwTLSpac10tOuOQ7dnn3DuOpp98an9Li5D9sairc6h38GB9VkQQYpl2Jm7/EfOuTf7F1BDdE
	Nt9IDH7GPGbJWiFVKiOD3I0o6XKsUN9q+epMDmgUpPCgA9iw==
X-Gm-Gg: ASbGncvVRIA3C0xI5AFfmjEZx4Be1yGzLdPbumzy3PeHwzU/XBVKVVfHtZPULANCrEi
	26tCkEYUN43GGDVlc8H142KeA+dVebdhn5k8TtEI8sAUoKx4ffXeQqzzQr5/Uq610fKEnmnY=
X-Received: by 2002:a17:902:ce0a:b0:223:6436:72bf with SMTP id d9443c01a7336-22428bf7a47mr226700635ad.44.1741557221370;
        Sun, 09 Mar 2025 14:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy9eE/lJnK++FzwDyZZSQiP5YzqAdsEQu3UOj6KaHPde6EDa8B27QxjD2epfAPECN1Prg+sTjecJjnf3Rfl00=
X-Received: by 2002:a17:902:ce0a:b0:223:6436:72bf with SMTP id
 d9443c01a7336-22428bf7a47mr226700545ad.44.1741557221113; Sun, 09 Mar 2025
 14:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com> <Z84Ay7gj2JQMUuRE@casper.infradead.org>
In-Reply-To: <Z84Ay7gj2JQMUuRE@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 22:53:29 +0100
X-Gm-Features: AQ5f1JomwYAykhQyueBbfb5N9kGOjotRXW86-ojxbejCwBBL59wTO0IoKuKhxZ4
Message-ID: <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> > On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > gfs2_end_log_write() has to handle bios which consist of both pages
> > > which belong to folios and pages which were allocated from a mempool =
and
> > > do not belong to a folio.  It would be cleaner to have separate endio
> > > handlers which handle each type, but it's not clear to me whether tha=
t's
> > > even possible.
> > >
> > > This patch is slightly forward-looking in that page_folio() cannot
> > > currently return NULL, but it will return NULL in the future for page=
s
> > > which do not belong to a folio.
> > >
> > > This was the last user of page_has_buffers(), so remove it.
> >
> > Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
> > going to skip this part.
>
> How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
> 414ae0a44033 and all of those commits are in 6.14-rc1.
>
> $ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
> (no output)

Hmm, you're right, it's only that automatic test that's based on an
older kernel. Sorry for the confusion.

Andreas


