Return-Path: <linux-fsdevel+bounces-51184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E367AD41DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC218848DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCE24728D;
	Tue, 10 Jun 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCoqZLNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2E23C4EF;
	Tue, 10 Jun 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579820; cv=none; b=D9CS2iFzaCUysHxzNGZCUjnwiDp0SES86IeKtSzqPdTA/tdu1owdVz905Blw0gNKA5Pt6Z5cXa/mDSRqwh+yZaMzOuGvvIbo3lCbT6hXIqLzFDSh3o9ucMohSVTEFUcgniEVziZGdvQFBFAS9VaRChe/S/2HiwDQjFzdQ8AIR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579820; c=relaxed/simple;
	bh=uQZoxzYSth33BnmkE45ZDt6ZPClPdhTaR/PGsOF7uiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeD0h/6A3P5x+67zIRqh2IixrCtDwZEw1zdP6hn4fgs0inOrSwixzUNHw6tCgalI61gTlvgFKVvSV2a4mSGu7XfGSOy16wpLt6P7Q8uyRczVYqi0m4o0gwDqq2UUKTpmGu0ecwMFxVSzJ8YZnWG1eu3wCc+CGkqBbhfqeSsqgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCoqZLNQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a440a72584so56070101cf.2;
        Tue, 10 Jun 2025 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749579818; x=1750184618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiRm4t4AM7VbG6wN3v+DdecKLe5PKVDc48RK3s1Gcrg=;
        b=bCoqZLNQDiSeKMWEmTbfstG5xKgf9+ZFSE3pRB8fa2vpFgnIVBPZY7Yuxv/6SdfTyW
         /e0j++ai5S0ULNAwb8O4KVUY1If0Nge31RRyq4EULwzaFBASO6E3jsvsSNVK41rB1NtB
         Y7Jz0AzRL/3Lr5sSdfJjk11hNR91ohkE3CWu30S6K8jcknaqv1JfvUf4QUp4Vj/W3wv8
         lb9XwvGlfcl2gp9OYfpRFIdLQ8US92jMvmJ9WDBZY/2F+IoCh15PHDOUVTaDdhe6jLdR
         5IqujydRzjrNeQT7EKrZnbhigNZ3xmGuk/8+t2QlI3m2Mxjq7QWffTig0H8rwrAWrVCa
         gQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749579818; x=1750184618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiRm4t4AM7VbG6wN3v+DdecKLe5PKVDc48RK3s1Gcrg=;
        b=UI4Q0QSIce7Kf9+EsUXGNu/4/tkm3TE/h5xsBiWMe/0xaNrFZFrWvrD5AX+JDEvDxX
         zy5UPbsH+2MQYN+4lH2W1gQ8xmpL6hxe2VQDCgFrnFxI8kfHoLg9L5e3Rahm81d0IaCU
         KNbudKYDdM1yoMN1/WWQtimomjm1227qKceS3edUawjFR20zAhNKl6Si3SsuM9uTr5XS
         Ke6HemVtdR+F42EU9FxFAeFWs8JByYmyj9BD6g1GqTlCLxJYv8f2ZyXTdlzAWpH52EWV
         O9/L1uKWVw3EFZaggdMkUecJXbqCUbvMOKqmtegri0hYKVQU7tM7JV5DlSqTwYtjYSAk
         pvvA==
X-Forwarded-Encrypted: i=1; AJvYcCUkOykj+pfkbDi0ifot/fVop+25vN/b1ctfPZ3r+G8MCMiXKe65YAGg+gY7zokmPdj1nEvCTCC0UdHJ@vger.kernel.org, AJvYcCWHzJmCHFVGuWVNzDLAFI8woGejlPJ0fi/H9D+3T+vvCtnIzpu4RCrej28cbqM0U1FkKE1gToNShYxvVfPh@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHct6UBy747IiQeAret6koNgV4d+WnNS4JsMr9ifjAm91NYgZ
	J+jAc088S4DZfk/dup/b1LCxmwARgV4+eBsVs5rQQXFWkaVIMg3ZPeIp/IfGMnE+mDUDGcqzxX4
	uz7SQvFp+5hhNTPOUE7k7fzO9V1WFCts=
X-Gm-Gg: ASbGncvI7Kiicp0HGKeJS58eTyB+uNd3w13/ZkpJdzUVtq5wLTaPd9vViiy+iV9lhuV
	oovPqrgFe9ilL2Dfe1e6ygX1WnqdRp8aufy5sHVhQfHkU8Dpmech2CLK0R1rTw+I7dopK2vU8vl
	Iaqz+z5zvdiXVSaVLcPIt+RfMt+SqySY8uNVgaTJV4A/s=
X-Google-Smtp-Source: AGHT+IHf4MkTMbi/8CYy9QTIahRBNLGpy5Sbm1LdA8X7WP51xKJmnbQOCgdE0UblPTXZEpsYZ30W0zz6EW4a6r7YJJY=
X-Received: by 2002:a05:622a:261b:b0:4a6:f074:cb3e with SMTP id
 d75a77b69052e-4a713c4ec2emr8436021cf.44.1749579818037; Tue, 10 Jun 2025
 11:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com> <aEZx5FKK13v36wRv@infradead.org>
 <CAJnrk1ZuuE9HKa0OWRjrt6qaPvP5R4DTPBA90PV8M3ke+zqNnw@mail.gmail.com> <aEetTojb-DbXpllw@infradead.org>
In-Reply-To: <aEetTojb-DbXpllw@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Jun 2025 11:23:27 -0700
X-Gm-Features: AX0GCFucB-00LNCD_lCw41lPgC5bN8X84llMfzp-ULHBAFYrZrw4YjI_sm6Bx8U
Message-ID: <CAJnrk1YNM5fotdoRmmHi3ZTig_3GDb-kcSce9haZDxG97insKw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM iomaps
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:58=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Mon, Jun 09, 2025 at 04:15:27PM -0700, Joanne Koong wrote:
> > ioends are used in fuse for cleaning up state. fuse implements a
> > ->submit_ioend() callback in fuse_iomap_submit_ioend() (in patch 7/8).
>
> But do you use struct iomap_ioend at all?  (Sorry, still don't have a
> whole tree with the patches applied in front of me).

I don't use struct iomap_ioend at all and I'm realizing now that I
should just have fuse manually do the end-of-io submission after it
calls iomap_writepages() / iomap_writeback_dirty_folio() instead of
defining a ->submit_ioend(). Then, we can get rid of this

 int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 {
+    if (wpc->iomap.type =3D=3D IOMAP_IN_MEM) {
+       if (wpc->ops->submit_ioend)
+          error =3D wpc->ops->submit_ioend(wpc, error);
+       return error;
+    }

that was added and leave the iomap_submit_ioend() logic untouched.

>
> > > Given that the patch that moved things around already wrapped the
> > > error propagation to the bio into a helpr, how does this differ
> > > from the main path in the function now?
> > >
> >
> > If we don't add this special casing for IOMAP_IN_MEM here, then in
> > this function it'll hit the "if (!wpc->ioend)" case right in the
> > beginning and return error without calling the ->submit_ioend()
>
> So this suggests you don't use struct iomap_ioend at all.  Given that
> you add a private field to iomap_writepage_ctx I guess that is where
> you chain the fuse requests?
>
> Either way I think we should clean this up one way or another.  If the
> non-block iomap writeback code doesn't use ioends we should probably move
> the ioend chain into the private field, and hide everything using it (or
> even the ioend name) in proper abstraction.  In this case this means
> finding another way to check for a non-empty wpc.  One way would be to
> check nr_folios as any non-empty wbc must have a number of folios
> attached to it, the other would be to move the check into the
> ->submit_ioend method including the block fallback.  For a proper split
> the method should probably be renamed, and we'd probably want to require
> every use to provide the submit method, even if the trivial block
> users set it to the default one provided.
>
> > > > -             if (!count)
> > > > +             /*
> > > > +              * If wpc->ops->writeback_folio is set, then it is re=
sponsible
> > > > +              * for ending the writeback itself.
> > > > +              */
> > > > +             if (!count && !wpc->ops->writeback_folio)
> > > >                       folio_end_writeback(folio);
> > >
> > > This fails to explain why writeback_folio does the unlocking itself.
> >
> > writeback_folio needs to do the unlocking itself because the writeback
> > may be done asynchronously (as in the case for fuse). I'll add that as
> > a comment in v2.
>
> So how do you end up with a zero count here and still want
> the fuse code to unlock?
>

count is unused by ->writeback_folio(), so it's always just zero. But
I see what you're saying now. I should just increment count after
doing the ->writeback_folio() call and then we could just leave the
"if (!count)" check untouched. I like this suggestion a lot, i'll make
this change in v2.

