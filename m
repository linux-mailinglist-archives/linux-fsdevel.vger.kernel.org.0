Return-Path: <linux-fsdevel+bounces-30562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F698C442
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45AF1F20F95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC321CBE8A;
	Tue,  1 Oct 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO2TiGT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901B1CB50F
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802738; cv=none; b=KmnifUQ8NkpaGRuaFgS/BCHSsevsMCo6cVbZaBhb7b9Hk5Fzcdfj/rgj4r0NovZ3mglIi17aZPiMuC01sy589Si1+wJ5w2+zrwiCsrd2w8n0LEdbn9LxcmXtc+e5U22n/PJQ2yYXAkLH2ZmzQ3Uvo22ZCvQEsAjTZvDdd3Ez4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802738; c=relaxed/simple;
	bh=i5Sv4QsxzlAj8lL2gWGuiU44YFcWXIyJlXrtb2MsKYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/wldYcuiVPAdnnglSdEldevkJKxJKOKFP4pfjvAlHS/u+sXNN+XoymKIMUTcls31oLNZkboWCMVMg33cb30KkcnNbFaFTMZb0QkB4a07+3xCR+cvdgXN2B6dPDxzv88467dovPmAcJnwYanmPrljo99tVoCpa6u8QDflNi2RzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO2TiGT4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-457e153cbdcso50837841cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802736; x=1728407536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5Sv4QsxzlAj8lL2gWGuiU44YFcWXIyJlXrtb2MsKYU=;
        b=NO2TiGT401Tci29VbSeNrM3pb/wXO6Fo97ticThKG8NMTphl89xr3QpmovjM5Qlwnm
         hEohLJdW/2c8MEzCWLKB9lxXwRuuxePpBBBlTwcztcFHn6NnH53XLeVon6hJtL0iKGKa
         zfXL7zEtQXzOKrnxHwB5BIsiJsH+lW+/FD+Vyq7aWAqKrvtdu9dWhL2/JoXDYgSUieme
         6+FS9VouAu5Wv0TGr2+hRMntaJ6EF561E3pzU6MEG6G7KHw3pHIyxPdAM2wIICuhhbjk
         uVZDv3MBErZBb1/tI6mHz4DY8aFKc7JJJ2BOEdU5KseqmWcJtdttlAWlV47VglYRnzDr
         o+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802736; x=1728407536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5Sv4QsxzlAj8lL2gWGuiU44YFcWXIyJlXrtb2MsKYU=;
        b=q45pcyRFeZkD1JgfJcj9dFZkiJRDiqkL58MfEdADPKGqqNHtgcPVPTHIVplecgxCKS
         ikGxRxGyj276feZhZUPMxgCGH61Utx2h8MklbfMEF2+pESFeaZF9XPtbtjrT+uBiXZWo
         ZPq1Trs2fpn8PrX7J6Vj2EB58hPalNzuj3A5mw+98ls8h/YAYnoQKcQlJ6M9AIRoNwhf
         BqDX403BhO20G88YBvzmOdO9pFPibEG2maziYkCeLIm4h6PHdUJcAKai8S91E+fEnxpk
         V/mCmSYWT1YNXnL8S/hqhenPkDX8MVGnLGjvrdsbb3tf3oCeDFaSSClqDaPpdL8o513q
         vxyw==
X-Forwarded-Encrypted: i=1; AJvYcCXPqRDvI0MHMZQgR4Ac5nXLxjN33wFHOD3b67ngaPD67/Ha/eDxHgqwDwQ4q2Zokwb1JjQbw4z4YjTVtwg7@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3/VYfH3V03ThKrHwIdghAqjNz9dmyKFGAmOcgEB+xsa2r/Pe
	PGR/dGAWE/X7Hjdqv/jOX6cEfPdcczNh0PWKteNjF+PJh7gVObjUNKEl876zOO9sD4uaak8V9Uy
	TDkJGf6vB9qo05S8BDfHhq+C1Zqo=
X-Google-Smtp-Source: AGHT+IFEqNTC2YuWSkJZEWP4XSwX9Cwz3fwNFrGnuus5OytCpazTU8+ZL+tYJVWATtb0A4HXDv2jS89EBbO4XZ4pAmc=
X-Received: by 2002:a05:622a:303:b0:458:2bee:f772 with SMTP id
 d75a77b69052e-45d804d7434mr3997281cf.33.1727802735748; Tue, 01 Oct 2024
 10:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
 <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm> <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
In-Reply-To: <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Oct 2024 10:12:04 -0700
Message-ID: <CAJnrk1YviX11gfVS18dhPwRRU9Kkx6CkPTSyRMD=7icOTMtTgw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:03=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sat, Sep 28, 2024 at 1:43=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Joanne,
> >
> > On 9/27/24 21:36, Joanne Koong wrote:
> > > On Mon, Sep 2, 2024 at 3:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > >>
> > >> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> =
wrote:
> > >>>
> > >>> There are situations where fuse servers can become unresponsive or
> > >>> stuck, for example if the server is in a deadlock. Currently, there=
's
> > >>> no good way to detect if a server is stuck and needs to be killed
> > >>> manually.
> > >>>
> > >>> This commit adds an option for enforcing a timeout (in seconds) on
> > >>> requests where if the timeout elapses without a reply from the serv=
er,
> > >>> the connection will be automatically aborted.
> > >>
> > >> Okay.
> > >>
> > >> I'm not sure what the overhead (scheduling and memory) of timers, bu=
t
> > >> starting one for each request seems excessive.
> > >
> > > I ran some benchmarks on this using the passthrough_ll server and saw
> > > roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> > > fio --name randwrite --ioengine=3Dsync --thread --invalidate=3D1
> > > --runtime=3D300 --ramp_time=3D10 --rw=3Drandwrite --size=3D1G --numjo=
bs=3D4
> > > --bs=3D4k --alloc-size 98304 --allrandrepeat=3D1 --randseed=3D12345
> > > --group_reporting=3D1 --directory=3D/root/fuse_mount
> > >
> > > Instead of attaching a timer to each request, I think we can instead
> > > do the following:
> > > * add a "start_time" field to each request tracking (in jiffies) when
> > > the request was started
> > > * add a new list to the connection that all requests get enqueued
> > > onto. When the request is completed, it gets dequeued from this list
> > > * have a timer for the connection that fires off every 10 seconds or
> > > so. When this timer is fired, it checks if "jiffies > req->start_time
> > > + fc->req_timeout" against the head of the list to check if the
> > > timeout has expired and we need to abort the request. We only need to
> > > check against the head of the list because we know every other reques=
t
> > > after this was started later in time. I think we could even just use
> > > the fc->lock for this instead of needing a separate lock. In the wors=
t
> > > case, this grants a 10 second upper bound on the timeout a user
> > > requests (eg if the user requests 2 minutes, in the worst case the
> > > timeout would trigger at 2 minutes and 10 seconds).
> > >
> > > Also, now that we're aborting the connection entirely on a timeout
> > > instead of just aborting the request, maybe it makes sense to change
> > > the timeout granularity to minutes instead of seconds. I'm envisionin=
g
> > > that this timeout mechanism will mostly be used as a safeguard agains=
t
> > > malicious or buggy servers with a high timeout configured (eg 10
> > > minutes), and minutes seems like a nicer interface for users than the=
m
> > > having to convert that to seconds.
> > >
> > > Let me know if I've missed anything with this approach but if not,
> > > then I'll submit v7 with this change.
> >
> >
> > sounds great to me. Just, could we do this per fuse_dev to avoid a
> > single lock for all cores?
> >
>
> Will do! thanks for the suggestion - in that case, I'll add its own
> spinlock for it too then.

Actually, looking at this some more, we can just put this in the
"struct fuse_pqueue" and use the fpq spinlock since the check for
whether any requests timed out will be very quick (eg just checking
against the first entry in the list).
>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd

