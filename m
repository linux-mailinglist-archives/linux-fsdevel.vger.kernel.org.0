Return-Path: <linux-fsdevel+bounces-59327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D30B374C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E6175AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5E284678;
	Tue, 26 Aug 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZUD85KF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545632820B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246063; cv=none; b=XQDtzzRLskZKwTOOG93uO79HCfXhdzrSXWBFAYcEQWC3G7vUR3asv8rdHMk7baHljSlrVt3lFYnLhoM1c6f4fTr87PKsYAS4uV/56qNZm5JkZCw60X8w6961hA6BrzoZchfZwRcs6tA9NTOuPcgqQmb7xjVbm8/RWP3Qy6iDFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246063; c=relaxed/simple;
	bh=n7zXgjcLhnPzrWKb5yedpchxg+JfpAdPJER60UT7yqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgFWpeSWiNmSWoLTMfl3tNLhXOGfVE1V6P2QB7JBbcOY974OcWNmDiP4tYwV+UExu2Xaz+Zf+XNYTaVlYWGSyBVO9UOAEWSAr1BBTXLl9vxgsEuStIQDk/S5VfilrmPH4NyTzkhPG5vIPW/RzEVgWcKyf5zBgEzi48vWe0fOOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZUD85KF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b132f943a3so61818751cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756246061; x=1756850861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRsPBPFbG3ing/EKqKR1eOWIL41t2hmBJKvVxEIVgOg=;
        b=YZUD85KF5VzlZJhvdBV9FKspU8/w5cplR/+PI8tbaxLTvLzVEUPd7IEWNOa75+FPUs
         BdYnlXUFXoOTOYqEdxQAs+AUxr+qOu7/ZD+OjrXLHXX4z6G0th5NRhdnjnj99sFZDzSn
         QMOKFJXsADDk/6LHSwo7hrBlURbK5LPkWIo90NhWwLZbo1OjTp1IeeIOjC9igsWZxGxb
         EGGNI5rVzPT8Qg3s5HnMhEzCHQfxaNipPKzzDkKFGE3dKDoHgWUb4y5ea3lPvkIQIkWL
         toirrtFlBzUqpwg0M9l7116I0YWPqZHQnRLXvjZwxYrDJFW/7K/INDwkDL5nXxFl+/G2
         pD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756246061; x=1756850861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRsPBPFbG3ing/EKqKR1eOWIL41t2hmBJKvVxEIVgOg=;
        b=XZiuoo/Pbb2+ZKBtVkFpFBHWXVPIy8oQpSP5WPaR9vQYZi1pGWX/Va5ytodJOwF5jt
         8tMw9IwxsWdqNSRT+RgI7+Jd5qskML8WFQLu0e6vFnL1JwOVKdu7NVPYeEJONB9Q+0Wg
         iLkEXzN96YfcmqSi+x7ad6YqxboAZBisxUs9nQXuDV8UP6gDhKGAFrMEk/IKvi96yyOi
         QCOXs92IVstFSbyx4l7XfwPLCXnsp1NaR5cRcoJEeP0xGWmgjyVUU/qRRcQS1rb8PRWI
         nr02qI0jLz9f64E+u+dYvNASJjihAFLKXNO6Em4j95fW9bfk7K2gMXA0sR6BCW3vqSZD
         ZHcg==
X-Forwarded-Encrypted: i=1; AJvYcCWb0zCblnDnFXqR7OKgfDjZJvf2Ve/kWQH0CVnDJyXZGXA9NoqOkOGA/bAgInGeX2ZU5l7/07hDbeBAnAkW@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3RHo68oZd6mS1PlnwWcP0CA+vKhsLCA1tTyLMePdGMVVEXPb
	Ab5HytME5jEq11gHF9bOMIItppXovZXIXjHOJC2Ba79OuBkTy1O+bp0t8yLHDOojcV3KjlfPgfg
	kcFi4R+Im63cifpttMRZPLGf9GuDM050=
X-Gm-Gg: ASbGncsjn9xZi23+kL5pS5Jx4yKlsxmYbdpAImDskIVoleoRr1SZt1jO8ANZphCQ7E/
	h8AE9cr5yBSmOCS1LMhynPyxQ48EWkkvxw3U4jfYd5Wsbjbh2Bhh8p0/DeBMA6vMET8w9WPU2fU
	Qcq2r2kRMGSEVBuxwCMlSPblwktFUunJpEmPxhyW/uYM5PchcKLzC0rwwgtIz8hoBW6RnnHokXA
	klsnHK38Niw0/U0v3U=
X-Google-Smtp-Source: AGHT+IHSIlQ1v9323gTUKYDm0o9hGYxylYcJ8t4IpzD3ztvnWZaduYGpFg/y0gpwmHYT4RDaWhXoCqNtvN0zDvXHNng=
X-Received: by 2002:ac8:590a:0:b0:4b0:6a0d:bbde with SMTP id
 d75a77b69052e-4b2aab666d5mr221335601cf.55.1756246060982; Tue, 26 Aug 2025
 15:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com> <20250826193154.GE19809@frogsfrogsfrogs>
In-Reply-To: <20250826193154.GE19809@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 26 Aug 2025 15:07:27 -0700
X-Gm-Features: Ac12FXyQIfOcQ7HAqiJ5R65vTBHFQE7iZfPWO0ATzzDyvU75Y7FRKNswnGX0mdA
Message-ID: <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: synarete@gmail.com, Bernd Schubert <bernd@bsbernd.com>, miklos@szeredi.hu, 
	neal@gompa.dev, John@groves.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Aug 22, 2025 at 10:21:44AM -0700, Joanne Koong wrote:
> > On Fri, Aug 22, 2025 at 4:32=E2=80=AFAM Shachar Sharon <synarete@gmail.=
com> wrote:
> > >
> > > To the best of my understanding, there are two code paths which may
> > > yield FUSE_SYNCFS: one from user-space syscall syncfs(2) and the othe=
r
> > > from within the kernel itself. Unfortunately, there is no way to
> > > distinguish between the two at sb->s_op->sync_fs level, and the DoS
> > > argument refers to the second (kernel) case. If we could somehow
> > > propagate this info all the way down to the fuse layer then I see no
> > > reason for preventing (non-privileged) user-space programs from
> > > calling syncfs(2) over FUSE mounted file-systems.
> >
> > I interpreted the DoS comment as referring to the scenario where a
> > userspace program calls generic sync()  and if an untrusted fuse
> > server deliberately hangs on servicing that request then it'll hang
> > sync forever. I think if this only affected the syncfs() syscall then
> > it wouldn't be a problem since the caller is directly invoking it on a
> > fuse fd, but if it affects generic sync() that seems like a big issue
> > to me. Or at least that's my understanding of the code with
> > ksys_sync() -> iterate_supers(sync_fs_one_sb, &wait).
>
> <shrug> I think you can already DoS sync() (and by extension any other
> place in the kernel where we try to flush out all filesystems in one go)
> by dropping a FUSE_SETATTR call on the floor, because that's how we
> flush dirty inodes to disk?  Or by doing the same for an FUSE_FSYNC
> call?

Isn't the sync() in fuse right now gated by fc->sync_fs (which is only
set to true for virtiofsd)? I don't see where FUSE_SETATTR or
FUSE_FSYNC get sent in the sync() path to untrusted servers.


Thanks,
Joanne
>
> --D
>

