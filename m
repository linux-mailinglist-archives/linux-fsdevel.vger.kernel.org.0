Return-Path: <linux-fsdevel+bounces-60331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63328B44E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3062518920C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96485202961;
	Fri,  5 Sep 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Fgg9mwvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9532F76C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055740; cv=none; b=mB1dJ2kyekqhkUc4iSaQ1Uonp2fC2lzoFoGXoSx9WbXNhiHumCpCg08p/eOVxBitL66vMtg5rFSSPzgK28PTcfpWvua3j4jaPAWvC2DxcLGOe7vQ/3u0w+lCG5eHpeYfzBRHc8Z0yi8Pp79zRT8VS8XUaU1o/dSxnubjZgGIRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055740; c=relaxed/simple;
	bh=5bMq2mvJbw4I6jW/yXMG6FU70uaIUcEuG2d718VNuTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9l9XGSWvPP8PRwiSKOij0DhPCSEOigQ1I4ZTFbMr4oQZOJpz1DPyVXBW5pV9mT/tx6wt0N+DxZ7vc6fubeulBFvs9NhHHYQrRXQZJVzj7uLRHLarBOcbC6/AgPtLotEzDFrvugmcadSFiRsvq4MAUyYiOtj0anUM2Mj24OETs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Fgg9mwvt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c6b9fcso15567451cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757055737; x=1757660537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbUCF83GVvjOC3eVo/KP6tFEeF50f+8z0W1B1r3la+s=;
        b=Fgg9mwvt0/sb2O60VL4FnAwd//JVWqb2a+dLZaLYQRuW6ttlUptfSMD8T14qPS146j
         TdoMZuthAiMoN/TkU24bpgiL0LsYvAUbW0OU4e8bY85hM88G2O5Riqokr7TX39cNQQid
         fWV5ixR8OGAYTmZWtNQzsBFjEXB384hue4Y1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757055737; x=1757660537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbUCF83GVvjOC3eVo/KP6tFEeF50f+8z0W1B1r3la+s=;
        b=SsCA78KPUVtYx15Zo9dks+Rbk8Q6unIynq8B6pVYCIdPNw3adL6qRzQ8eAWEGusbgO
         TFgQmLzmYXsebu0yeYFON8tTd/hkWvWXvEUfdDDLoeQYLeQk36eZfFBeXgudp9PtDsFx
         9DKOr/gdr25gkrect2HPCgB5btnfnQUdRZeoO2d1LHrcHls7Ca7NwXNn512FvkCQSlVe
         FhQe7fFOF1v7tyDajYFTO93/7+hMYu15DQLTMEg1QpFdjdEZIrvPlDXDMAX4XRBzfryz
         f+X9Ul4mOO3KtHRIhGcUF7Piy9Q7NLA//r1U2v4shsQnUREinAbdSGsgchqi53/7YB1j
         McIA==
X-Forwarded-Encrypted: i=1; AJvYcCV18d+VCGmvH8p1HAUd+GghzCG+2oHST8BKtAK8cHqP0TZi0tvWweVK7OsK5OotoMTEiyIXkDRQjRYlAjew@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZk0ayPo7Wa/tBnPSuDdJUwjjdG7EDpKxZwr85GBQzsFdKj6/
	6ORuLzlkQbP6uQVXM8ynVGvvKjKCeLQ5J9GqPJD6vmU4GtnUjcfXZIEVhTxw6JhtH0AfKjH9cpF
	gxVakIuJrMsYGTGxG/79Y2wTEqFfyQxgSSvpASikmrg==
X-Gm-Gg: ASbGncvsYD8F6SdLkskk+Hl6UDIA8dNRrGWPCSTPBx/ugBuK42Q59mFcUzVPnF6fpt3
	ihaPWfnPdzXmv/HWWH8wL6Sh6sDCN1t8E2lwdbhPBWzzEvmtoAH60NPXxQPAyneTmhBF86s9U77
	TjU9bS7bLzuTtxNBdTDubiK0caxDj4XY7zoB6AV9mKbD+x31YWWBle9GH0F7/ZKam5J7R+uTc/s
	WSHRgqi3OPYfNuODAbkpUPbb/VrGqYDn3MuKX8arPpcZ9L+gd3w
X-Google-Smtp-Source: AGHT+IEaD1f+f01g0dYxBn3YUSLh+qnW/vy/BrNr9EXtLuKyGdztl7IJykIIeEyEfuSyRGW41c2+XMgXW1a+4izDKpQ=
X-Received: by 2002:a05:622a:540f:b0:4b5:f01b:d997 with SMTP id
 d75a77b69052e-4b5f01bea13mr2805631cf.71.1757055736818; Fri, 05 Sep 2025
 00:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs> <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs> <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
 <20250903154955.GD1587915@frogsfrogsfrogs> <CAJfpegu6Ec=nFPPD8nFXHPF+b1DxvWVEFnKHNHgmeJeo9xX7Nw@mail.gmail.com>
 <20250905012854.GA1587915@frogsfrogsfrogs>
In-Reply-To: <20250905012854.GA1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 5 Sep 2025 09:02:05 +0200
X-Gm-Features: Ac12FXyqplgv8V5tnx2HyVXAEjQ-d2wFt5_p0DHwVA0fzrDK9knsr8Nuk2At2uo
Message-ID: <CAJfpegubFsCjWJyJhv_9HE_9_htL3Z7-r_AMFszxA-982dC-Jw@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 03:28, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Sep 04, 2025 at 01:26:36PM +0200, Miklos Szeredi wrote:
> > On Wed, 3 Sept 2025 at 17:49, Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 11:55:25AM +0200, Miklos Szeredi wrote:
> >
> > > > Agree?
> > >
> > > I think we do, except maybe the difficult first point. :)
> >
> > Let's then defer the LOOKUPX thing ;)   I'm fine with adding IMMUTABLE
> > and APPEND to fuse_attr::flags.
>
> OK.  Should I hide that behind the fuse mount having iomap turned on?
> Or fc->is_local_fs == true?  Or let any server set those bits?
>
> One thing occurred to me -- for a plain old fuse server that is the
> client for some network filesystem, the other end might have its own
> immutable/append bits, in which case we actually *do* want to let those
> bits through from the FUSE_STATX replies.

Right, as I said this might have worked without VFS help, but having
it consistently in the VFS as well would be nicer.

In that spirit, putting those bits in the inode is safe only in the
local fs case, so I guess that's what we should do.  And for
consistency, in the local fs case inode->flags should be the
authoritative source and all the userspace API's should be looking at
that, instead of what the server sent in the IOCTL or STATX replies.

Thanks,
Miklos

