Return-Path: <linux-fsdevel+bounces-39808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF3A188F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 01:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F061674A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E23FD4;
	Wed, 22 Jan 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EftQ3m6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2669463
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505811; cv=none; b=U3DVccwv3HPHNg1lgbWlaRP8hQNRiLjhBP53IZw74WzfPVDLpg4EtcyvdKWrc7bWmAbJqY9tUYhg9SukqljEQxiBcdZk4uxfauoHErHO3UOYpLN3t5cZ7/QU3/5xIwRIN1lxaXDiSae5DjGPHULEX/KUW6Uvhw6EK79zsCeWxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505811; c=relaxed/simple;
	bh=VhDybvbmTTLfvD9JQlw5GX4s+VRQHNwSoB2o3gJHa+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kR7ofw3vh4NQA7YkzHSz/1MTQ5AEJHRlyZE5vz4KKb8/kJpR9Ox98i388t/maFbzuHHJt21D0wZ1QvDlwr+7Qh8VBdGYHcn6vhujQusisZ8I+lnf5bEMkQryOstYkOLELuyT6hyVCBYYn/Q/cZ2FRTrmR7+RWJsvebx7fS0gi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EftQ3m6L; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467838e75ffso81078991cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737505808; x=1738110608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ThALrZNXsHnY1PGvooVdFPHPlqCyzRVm/X1v+Brcc=;
        b=EftQ3m6LADg32ox9fZEHvXHlpUeUwbl5fYmpSK80WRfNrBoSGDRux9B3IItqXjTZqY
         0rcNx3EMjYCIl8JXd7yAatULOdnz2MX6u+Evz980eaKJmNDSLCyDC5GRw1CHSe8tBQtO
         Ehj3rlKvRmhtfqCHipYbxEd+ttemnY1ArMj8T2l8HD4SPzV4mBQ4MWmrDxDO7xAe/kbV
         DNWz9Ml0GUf8lszGWQc2bD2Jn3KxycqIYKnw/wmpL1v+SKm2Bn54HLkEy+3qzwpPZ9Gp
         4Xw54EJhpv8Egj5jOJoXc6irGi/Kkv+xzbvFNFDaa7VEL5M6jzvodkdaNHObi+QE2ImX
         vETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737505808; x=1738110608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ThALrZNXsHnY1PGvooVdFPHPlqCyzRVm/X1v+Brcc=;
        b=hYQ4Fafo5+fMNIrvggUG4xfYRJqu3PK0qck+hlF6HboAWHWOiHhaXJBC74fOSIVFd7
         GW3IsuTB4cF29lppgd0NQsf6Czpzw/GYNyNhra+Pm17sOT6Xmq3YI1BxKMEMIR6rqMY/
         Bjb1QIT2TqerISY/I13DLhSP5xX4sR+1EGtFUFL0fODe+jGbPhsGUEVmoAnN+dp6OTsH
         wRWBXXDKrebSUcOjirsNsJN6zf5CIYWJ7UbPhDYuqKkfI6eoJ7UDFYJ512uHO5D74L1o
         El3CU+KWflMhYRe8rENrhWEPJTTTGhuC8sUkfBQUtyuvOKDtJCiG3nnqaXopIA2cI42f
         1Owg==
X-Forwarded-Encrypted: i=1; AJvYcCV9pkK8oTvQACcqzMnfuXsCkp0nx/Y955Yb2WFBN+BvwLvY7e2+O6LNCAbOYg1Fqra+/iKGuBkh22GTQLTk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j+AN6HFxDh8y0c6vSSBObS0+tj/OnRmJjXwGh0OBij9oTqWH
	XnseZGAnsrtu9PbaribMYVD2T5Sgt+HBqNdZp6k2SSNub4d4dO7Q6tiG3gOZY7FC1TtJGNA7+jo
	MZDTxj7k2x5dOQo6fhQ4q7RdlBgE=
X-Gm-Gg: ASbGnctUQdyH6o9nN/vCDFd3Y+yUJApwYH/Ajwy7iV5EUz7aIt+KxblQJj7bC9UmWJk
	KleWyjtHSZ+zTzD+e3tL+AYI0Bdg9P85BdKwDzMc8W1UXOPtQNfqC
X-Google-Smtp-Source: AGHT+IH5nTFPA591H1OlXts/g9XE5/8uhTkuyL2Ws7WJN1mnCWLP+2QryIcbOTJ08EwF6a1kANUqV8Y5/SrqLYc4lBA=
X-Received: by 2002:a05:622a:292:b0:467:b7de:da8a with SMTP id
 d75a77b69052e-46e12a2c4e7mr297758521cf.6.1737505808541; Tue, 21 Jan 2025
 16:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
 <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
 <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
 <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com> <xuf742w2v2rir6tfumuu5ll2ow3kgzzbhjgvu47vquc3vgrdxf@blrmpfwvre4y>
In-Reply-To: <xuf742w2v2rir6tfumuu5ll2ow3kgzzbhjgvu47vquc3vgrdxf@blrmpfwvre4y>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 21 Jan 2025 16:29:57 -0800
X-Gm-Features: AbW1kvbWQM79afxBZzxgDAO1WFzzF2GFqqHOkYKREu-1WlvKLkiUoAlrD8Ow-9M
Message-ID: <CAJnrk1Z21NU0GCjj+GzsudyT1LAKx3TNqHt2oO22u1MZAZ4Lug@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 2:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 17-01-25 14:45:01, Joanne Koong wrote:
> > On Fri, Jan 17, 2025 at 3:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> > > I think tweaking min_pause is a wrong way to do this. I think that is=
 just a
> > > symptom. Can you run something like:
> > >
> > > while true; do
> > >         cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
> > >         echo "---------"
> > >         sleep 1
> > > done >bdi-debug.txt
> > >
> > > while you are writing to the FUSE filesystem and share the output fil=
e?
> > > That should tell us a bit more about what's happening inside the writ=
eback
> > > throttling. Also do you somehow configure min/max_ratio for the FUSE =
bdi?
> > > You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I suspec=
t the
> > > problem is that the BDI dirty limit does not ramp up properly when we
> > > increase dirtied pages in large chunks.
> >
> > This is the debug info I see for FUSE large folio writes where bs=3D1M
> > and size=3D1G:
> >
> >
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:            896 kB
> > DirtyThresh:            359824 kB
> > BackgroundThresh:       179692 kB
> > BdiDirtied:            1071104 kB
> > BdiWritten:               4096 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3596 kB
> > DirtyThresh:            359824 kB
> > BackgroundThresh:       179692 kB
> > BdiDirtied:            1290240 kB
> > BdiWritten:               4992 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3596 kB
> > DirtyThresh:            359824 kB
> > BackgroundThresh:       179692 kB
> > BdiDirtied:            1517568 kB
> > BdiWritten:               5824 kB
> > BdiWriteBandwidth:       25692 kBps
> > b_dirty:                     0
> > b_io:                        1
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       7
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3596 kB
> > DirtyThresh:            359824 kB
> > BackgroundThresh:       179692 kB
> > BdiDirtied:            1747968 kB
> > BdiWritten:               6720 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:            896 kB
> > DirtyThresh:            359824 kB
> > BackgroundThresh:       179692 kB
> > BdiDirtied:            1949696 kB
> > BdiWritten:               7552 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3612 kB
> > DirtyThresh:            361300 kB
> > BackgroundThresh:       180428 kB
> > BdiDirtied:            2097152 kB
> > BdiWritten:               8128 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> >
> >
> > I didn't do anything to configure/change the FUSE bdi min/max_ratio.
> > This is what I see on my system:
> >
> > cat /sys/class/bdi/0:52/min_ratio
> > 0
> > cat /sys/class/bdi/0:52/max_ratio
> > 1
>
> OK, we can see that BdiDirtyThresh stabilized more or less at 3.6MB.
> Checking the code, this shows we are hitting __wb_calc_thresh() logic:
>
>         if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>                 unsigned long limit =3D hard_dirty_limit(dom, dtc->thresh=
);
>                 u64 wb_scale_thresh =3D 0;
>
>                 if (limit > dtc->dirty)
>                         wb_scale_thresh =3D (limit - dtc->dirty) / 100;
>                 wb_thresh =3D max(wb_thresh, min(wb_scale_thresh, wb_max_=
thresh /
>         }
>
> so BdiDirtyThresh is set to DirtyThresh/100. This also shows bdi never
> generates enough throughput to ramp up it's share from this initial value=
.
>
> > > Actually, there's a patch queued in mm tree that improves the ramping=
 up of
> > > bdi dirty limit for strictlimit bdis [1]. It would be nice if you cou=
ld
> > > test whether it changes something in the behavior you observe. Thanks=
!
> > >
> > >                                                                 Honza
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/t=
ree/patche
> > > s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb_cal=
c_thresh.pa
> > > tch
> >
> > I still see the same results (~230 MiB/s throughput using fio) with
> > this patch applied, unfortunately. Here's the debug info I see with
> > this patch (same test scenario as above on FUSE large folio writes
> > where bs=3D1M and size=3D1G):
> >
> > BdiWriteback:                0 kB
> > BdiReclaimable:           2048 kB
> > BdiDirtyThresh:           3588 kB
> > DirtyThresh:            359132 kB
> > BackgroundThresh:       179348 kB
> > BdiDirtied:              51200 kB
> > BdiWritten:                128 kB
> > BdiWriteBandwidth:      102400 kBps
> > b_dirty:                     1
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       5
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3588 kB
> > DirtyThresh:            359144 kB
> > BackgroundThresh:       179352 kB
> > BdiDirtied:             331776 kB
> > BdiWritten:               1216 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3588 kB
> > DirtyThresh:            359144 kB
> > BackgroundThresh:       179352 kB
> > BdiDirtied:             562176 kB
> > BdiWritten:               2176 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:                0 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3588 kB
> > DirtyThresh:            359144 kB
> > BackgroundThresh:       179352 kB
> > BdiDirtied:             792576 kB
> > BdiWritten:               3072 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
> > BdiWriteback:               64 kB
> > BdiReclaimable:              0 kB
> > BdiDirtyThresh:           3588 kB
> > DirtyThresh:            359144 kB
> > BackgroundThresh:       179352 kB
> > BdiDirtied:            1026048 kB
> > BdiWritten:               3904 kB
> > BdiWriteBandwidth:           0 kBps
> > b_dirty:                     0
> > b_io:                        0
> > b_more_io:                   0
> > b_dirty_time:                0
> > bdi_list:                    1
> > state:                       1
> > ---------
>
> Yeah, here the situation is really the same. As an experiment can you
> experiment with setting min_ratio for the FUSE bdi to 1, 2, 3, ..., 10 (I
> don't expect you should need to go past 10) and figure out when there's
> enough slack space for the writeback bandwidth to ramp up to a full speed=
?
> Thanks!
>
>                                                                 Honza

When locally testing this, I'm seeing that the max_ratio affects the
bandwidth more so than min_ratio (eg the different min_ratios have
roughly the same bandwidth per max_ratio). I'm also seeing somewhat
high variance across runs which makes it hard to gauge what's
accurate, but on average this is what I'm seeing:

max_ratio=3D1 --- bandwidth=3D ~230 MiB/s
max_ratio=3D2 --- bandwidth=3D ~420 MiB/s
max_ratio=3D3 --- bandwidth=3D ~550 MiB/s
max_ratio=3D4 --- bandwidth=3D ~653 MiB/s
max_ratio=3D5 --- bandwidth=3D ~700 MiB/s
max_ratio=3D6 --- bandwidth=3D ~810 MiB/s
max_ratio=3D7 --- bandwidth=3D ~1040 MiB/s (and then a lot of times, 561
MiB/s on subsequent runs)


Thanks,
Joanne

> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

