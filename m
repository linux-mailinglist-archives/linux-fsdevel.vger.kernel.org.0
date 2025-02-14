Return-Path: <linux-fsdevel+bounces-41763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10744A368EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 00:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF43B1DAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2091FCCE7;
	Fri, 14 Feb 2025 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML03P19q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA771A83F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574872; cv=none; b=HOct/BMQDNLkVWkK48RS+I8i5rDTU1cHjWfh7lnNwhwEhitapCY1heUPU8qVPuQOe4GfW6+1HqQDK/5H+Pq7AzWsLt+JrXmP4Cp7xHH1IIeMVmiO4OR/NhmBkSXK1luep6KZx5z0VqEBwzsju//SinrYLE+8QbvSN+MbYV4D+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574872; c=relaxed/simple;
	bh=L9JljTT5fuAc5tlkzB0DMK7gR3ogzpO7w+syksfJ8+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZILVgmrwOdEuyA/hjhnFAkKgzjHAIs838DVBuxu1RARyGjo2BNSHbzOykG/MzYZzMcIyIWPDBJGsBm3/TS142yl3zVwQwIzS1RKuDJrS0R37U8ByEO2k0lRPgymWzN4+sti5Io/2TSGDGvx3FPOutMuEv0aKjti84pc5XXIwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML03P19q; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa7678ef3so27121581cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 15:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574870; x=1740179670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QoyVwb6acG4spRvsWCBh3pny07A9CIJynGMAyfSJn8=;
        b=ML03P19qZc6GpTDb8iBgy+SMJHCKsqrcT6tYMUo++fF9yphKGSvsq6dYhX1MVywfMx
         4fpurngQxhCrjkAWeBOHwIsbyuFRS+XuL6P04yuHZKWWIvg9IVgqhDAm5NxOxMxM9jea
         GlW78JXqdtWhMne4LUFttXXoo2mgv1k79FpbuAyMm6p6AvjTXsx5cgObzjifsW4PKJVd
         Sz4B8FDxFtkxxEhdHP3EJuyajpOC7fydvtqZ0nrgsfh/lJ+r1ieg7zzd6ra/z/5r3UpN
         OK0kXhuQZGqtnaXOUM4vwfmUNXjgLLCH3r54aj4QFR6kDozzzQM79P/J+74ScOpD6AWD
         fJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574870; x=1740179670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QoyVwb6acG4spRvsWCBh3pny07A9CIJynGMAyfSJn8=;
        b=rZZsPAXLC51ACSnFxrZ8OY5Vb3UDx4EBmotqcJuu3LBCXeY2+iRl5EhutXBlcc2DWE
         yd9kchhY1eGBbL3i25D4PWzuwzES4e+uNrxumQqygjhW4Xn2Va73ImTUwCFAh69i9wzM
         DiXsCfm3zTywrZnGDezf2wwpIV6OjhbX0ZU3YSQDs437BtXCbU1XafiAGey4B8RW3SgP
         AUezd1g6zRtSWQ98NZJhY9eE7JrdTGD5vy0zN3sA3N2Hn4C/svhu/rG/ltD5Q4lpsqgT
         dYcP5zR0GgogvoUTyQtnReVrMkUVSxJOGBwvVU+cYKSx6g/bfNVHV5DLf+rgSLF/yDOt
         soYw==
X-Forwarded-Encrypted: i=1; AJvYcCW4kcvmtqxVvl8k+vCqy3mNF90am4LGKS8fa+0u9L5TnSTs620tALd2eKZh+7BbFF+vtx3SsTRUzBbTtI9D@vger.kernel.org
X-Gm-Message-State: AOJu0YxXW3VzDET2i8x27NoVAhIPdfS9bTGpMuHG4NNVCJZD63RxPSvo
	YdqxA1tIuJDF+wbjdFUOBCne3dOgOrOqhWivpCgP4IwBaFGLpv9S+crIsvYF/XK1f8i5OPk+FUJ
	GhsxKxTF4L4FmwWvMHoiq/pYPYc0=
X-Gm-Gg: ASbGncs+dxEWhtifqn9izjUxo2v44Kwl8BNRyP7lfFW9IoZvbHzEVsj5R8tUfenMjpk
	siOONSUCjklZ8WoUXJGwUCTM3dYmqArqkz79SDwoXEeZqD/YquH+AJuTH73Br3KXxqy+AtI6mvg
	==
X-Google-Smtp-Source: AGHT+IHouGOvZoL80wS7MaHKpbKN1Waow2S0wXLVYJOcQETYSrPgepbpTY5zhfJ8uicXYScSoj7BN5KohqGI6EFw3uI=
X-Received: by 2002:a05:622a:15c9:b0:471:c020:8973 with SMTP id
 d75a77b69052e-471dbe762a0mr18259781cf.38.1739574869605; Fri, 14 Feb 2025
 15:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com> <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm> <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com>
 <0d766a98-9da7-4448-825a-3f938b1c09d9@fastmail.fm> <CAJnrk1b0z7+hrs3q9dGqhtnC3e2wQEEoHEyKQgvgTwg9THd_Xw@mail.gmail.com>
 <015b0ab9-1346-40d6-a94f-e6ef56239db4@fastmail.fm>
In-Reply-To: <015b0ab9-1346-40d6-a94f-e6ef56239db4@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 14 Feb 2025 15:14:18 -0800
X-Gm-Features: AWEUYZnIVfjCxlyTLiS2LCbAooYKBSkqjOGaUK7bVSSsJTpDxwV3eQkR0E7hxPk
Message-ID: <CAJnrk1aakFZoEEGgfCDFUrJ9wXKQzJNzTJpov-rq1vMDOQSJ8w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:25=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
> On 2/14/25 22:26, Joanne Koong wrote:
> > On Fri, Feb 14, 2025 at 12:27=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 2/14/25 21:01, Joanne Koong wrote:
> >>> On Wed, Aug 21, 2024 at 8:04=E2=80=AFAM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> >>>>
> >>>> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmai=
l.fm> wrote:
> >>>>
> >>>>> struct atomic_open
> >>>>> {
> >>>>>         uint64_t atomic_open_flags;
> >>>>>         struct fuse_open_out open_out;
> >>>>>         uint8_t future_padding1[16];
> >>>>>         struct fuse_entry_out entry_out;
> >>>>>         uint8_t future_padding2[16];
> >>>>> }
> >>>>>
> >>>>>
> >>>>> What do you think?
> >>>>
> >>>> I'm wondering if something like the "compound procedure" in NFSv4
> >>>> would work for fuse as well?
> >>>
> >>> Are compound requests still something that's planned to be added to
> >>> fuse given that fuse now has support for sending requests over uring,
> >>> which diminishes the overhead of kernel/userspace context switches fo=
r
> >>> sending multiple requests vs 1 big compound request?
> >>>
> >>> The reason I ask is because the mitigation for the stale attributes
> >>> data corruption for servers backed by network filesystems we saw in
> >>> [1]  is dependent on this patch / compound requests. If compound
> >>> requests are no longer useful / planned, then what are your thoughts
> >>> on [1] as an acceptable solution?
> >>
> >
> > Hi Bernd,
> >
> >> sorry, I have it in our ticket system, but I'm totally occupied with
> >> others issues for weeks *sigh*
> >>
> >
> > No worries!
> >
> >> Does io-uring really help if there is just on application doing IO to
> >> the current core/ring-queue?
> >>
> >> open - blocking fg request
> >> getattr - blocking fg request
> >>
> >
> > My understanding (and please correct me here if i'm wrong) is that the
> > main benefit of compound requests is that it bundles multiple requests
> > into 1 request to minimize kernel/userspace context switches. For fuse
>
> I think it would be good, to give fuse-server also the chance to handle
> the compound on its own. Example, sshfs would benefit from it as well
> (ok, the sftp protocol needs to get an extension, afaik), see here
>
> https://github.com/libfuse/libfuse/issues/945
>
> If sshfs would now do two requests, it would introduce double network
> latency - not your about you, but from my home to main lab hardware
> (US) that would already be quite noticeable.
> If sshfs/sftp would get a protocol extension and handle open+getattr
> in one request, there would be basically zero overhead.
>
> > io-uring [2], "motivation ... is... to increase fuse performance by:
> > Reducing kernel/userspace context switches. Part of that is given by
> > the ring ring - handling multiple requests on either side of
> > kernel/userspace without the need to switch per request".
> >
> > Am I missing something in my understanding of io-uring reducing
> > context switches?
>
> With fuse-io-uring we have reduced context switches, because
> result submit can immediately fetch the next request, vs previous
> read + write.
>
> Then we also avoid context switches if the ring is busy - it

What does it mean for the ring to be "busy"? As in it has multiple
requests queued on it?

> can stay on either side if there is still work to do.

Can you explain what "there is still work to do" here means?

>
> For open and then getattr and if the ring is idle, we still
> have the overhead of two independent operations.
>
> One issue I'm currently working is is reducing memory overhead,
> we actually might need a fuse-io-uring mode with less rings.
> In that mode chances to have a busy ring are higher. Although
> I'm still fighting against it, because it takes away core affinity
> and that was showing 3x performance gains with blocking / fg requests.
>

Awesome, excited to hear the updates on this when you have them. We
will encounter the same issue.

>
> >
> >
> >> If we could dispatch both as bg request and wait for the response it
> >> might work out, but in the current form not ideal.
> >>
> >> I can only try to find the time over the weekend to work on the
> >> compound reuqest, although need to send out the other patch and
> >> especially to test it (the one about possible list corruption).
> >
> > If you need an extra pair of hands, i'm happy to help out with this.
> > Internally, we'd like to get the proper fix in for the issue in [1],
> > but we have a hacky workaround for it right now (returning -ESTALE to
> > redo the lookup and update the file size), so we're not in a huge
> > rush.
>
>
> Could you ping me in latest two weeks again? Either I found some
> time for compound requests by then, or we need to go the easier
> way. As long as our DLM mode is not ready we also need this
> feature, just a lot of the more urgent issues before that.
>

Sounds good, thanks!

>
>
> Thanks,
> Bernd

