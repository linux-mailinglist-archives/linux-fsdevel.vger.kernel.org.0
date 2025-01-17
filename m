Return-Path: <linux-fsdevel+bounces-39563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E6EA15997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 23:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DBB3A8F8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4161D47A2;
	Fri, 17 Jan 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSuxePhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0E1DE2C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153915; cv=none; b=fh/bCvEczrkiWfrmVbanmE8FwUbjqnbk4FSPrJjANZ01aPbP/gPnrdR9hiJUl+66hBo9yitVkijoi8d4/fPSCfeobXH+w5On50/EirPiXtZLJi2OC3EYfMeIvAwcmDoD6pLZQgFIu+kXuCJzL0n++l9IbCNEiEt54JOSn61aAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153915; c=relaxed/simple;
	bh=ZYiuJFtz4+UlV+iekqY2MC4wymOtrf8sOi0jws0lj4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeQJms8joh7esaRWMBMQWXgvFR424rn3BwvjWizYtfSRjgsMYbNbvbBJudGYPAsxCLJAIXuhyluLDXkUhfPWUj35kEyDmzB9s6F9cD4xXsHgUV2SqiaSYlrdam5E8ZQhyXaLlxQiX8rRZFwm7BmxZuCcyOxYsJQ9qICv7iuvN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSuxePhf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a17055e6so30953221cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737153912; x=1737758712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVGMMNdci1fpRsJcW/V30M8issQrQyqlggYL6PN/p4E=;
        b=lSuxePhfxevAv5l9zBxzvCkdPLLokDiy7jM5o5gC3jE8MlliDg4zWV1t4nksGaM9C9
         5nReoKucpJghO7BWG2u5DIWXhYvQFU+JPbds5SGZAijq1ek/CdY0imfkOORrZCLesGSt
         dm+m+4o1De7GGAvI7gqK5b4Q4h0QNko+DveaGQjo5RAQQq/X+crARJAcplRytMikevRc
         6lObZGQ7rX937YHdQAB0s/ClCXTBGPGHRWEvTMJVYZku9PfnvxNwmsOc+3N1Ay6n4KHo
         KZ5vFqfJ19PP9ZFkVZpZrsqzRJwRVJW39FDctcVTMXOICWIdV77bciSAHwb+tNTVHHmF
         7LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153912; x=1737758712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVGMMNdci1fpRsJcW/V30M8issQrQyqlggYL6PN/p4E=;
        b=ZzXP7NBkFLxYteDu/KtfbLo7sgqLv5ZHXWa+j7z0LBdAAqgGf12GdSYYGuJWGi6dFV
         g+jXMnkiNW4e+Eqsa8cBC66TcMkGzfsl4I3ipj9imDdpiGrUlKQ/mIlHVatPf3ne9Rwr
         i0mrSQCcTD1zP5IVfzsrct1dwBR+tO1mutaNuE25R1oAIc5hOu0b4XntwcOSlPe4O+Eo
         NqJORxf+GQBpL50DAo5dqkH/D6ArM/IzyfPGz+rbTpK9lkPm6wjLtmPsep+Cz039RoNM
         fQT8p9i+m4lOgHqFT4T9qLXlTcZCAKaRhb+KQX6R5r40M33sj7MXMMFcBaEmW+O/rCYK
         X0Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVSHOurHDAect2bfxc0KfSGC1QwVYUP2+TuyVRH9naeMJukR4E7TI/QGbhmLC7yZ0CFgGqm1G+HEgovFo9s@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzxzxPrVu74VSGiF8poD5/2weUd/yoXmkk8KzvVUkzoqL0yW/
	3YaP3RcXAZo8OU5XDElp8o9C2jnl9apdr/ByHhJC3iGg0KhiiT8dkzuJ2/DyhN2aGDnKbyZvWxf
	+gC3ppqw4xs4KyL15xcGsj8F3wRsPcq1/3oA=
X-Gm-Gg: ASbGnct4oefa04ZyWdkdDit7HIwhgZOIZlHDZOTcJJayC6jVCUsZtGAeQ47ICn8F4kY
	uOEk0pjwvWrcvZ9/bTvU8IxqTTEhvAzBnKZEsirl+3zRpbkxJKca0X9+susC2iuFw5g==
X-Google-Smtp-Source: AGHT+IHjo/kwTJrZ4eQLTHx7i9eMG3PkQ60CPH5SyToQgKdp1jhiOEO+tmdeqcpctW9Q5TSsz+Cy+4aNoGCFIdXY79Q=
X-Received: by 2002:ac8:7d8b:0:b0:467:6b96:dc5a with SMTP id
 d75a77b69052e-46e12b97280mr60596521cf.47.1737153912358; Fri, 17 Jan 2025
 14:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
 <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com> <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
In-Reply-To: <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jan 2025 14:45:01 -0800
X-Gm-Features: AbW1kvbSfv33KHSFKhq9273Chnq1fyPNq5qN1QMEAUXci_5R5vFGOG1fpzpQ-SY
Message-ID: <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 3:53=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> > On Thu, Jan 16, 2025 at 3:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 14-01-25 16:50:53, Joanne Koong wrote:
> > > > I would like to propose a discussion topic about improving large fo=
lio
> > > > writeback performance. As more filesystems adopt large folios, it
> > > > becomes increasingly important that writeback is made to be as
> > > > performant as possible. There are two areas I'd like to discuss:
> > > >
> > > > =3D=3D Granularity of dirty pages writeback =3D=3D
> > > > Currently, the granularity of writeback is at the folio level. If o=
ne
> > > > byte in a folio is dirty, the entire folio will be written back. Th=
is
> > > > becomes unscalable for larger folios and significantly degrades
> > > > performance, especially for workloads that employ random writes.
> > > >
> > > > One idea is to track dirty pages at a smaller granularity using a
> > > > 64-bit bitmap stored inside the folio struct where each bit tracks =
a
> > > > smaller chunk of pages (eg for 2 MB folios, each bit would track 32=
k
> > > > pages), and only write back dirty chunks rather than the entire fol=
io.
> > >
> > > Yes, this is known problem and as Dave pointed out, currently it is u=
pto
> > > the lower layer to handle finer grained dirtiness handling. You can t=
ake
> > > inspiration in the iomap layer that already does this, or you can con=
vert
> > > your filesystem to use iomap (preferred way).
> > >
> > > > =3D=3D Balancing dirty pages =3D=3D
> > > > It was observed that the dirty page balancing logic used in
> > > > balance_dirty_pages() fails to scale for large folios [1]. For
> > > > example, fuse saw around a 125% drop in throughput for writes when
> > > > using large folios vs small folios on 1MB block sizes, which was
> > > > attributed to scheduled io waits in the dirty page balancing logic.=
 In
> > > > generic_perform_write(), dirty pages are balanced after every write=
 to
> > > > the page cache by the filesystem. With large folios, each write
> > > > dirties a larger number of pages which can grossly exceed the
> > > > ratelimit, whereas with small folios each write is one page and so
> > > > pages are balanced more incrementally and adheres more closely to t=
he
> > > > ratelimit. In order to accomodate large folios, likely the logic in
> > > > balancing dirty pages needs to be reworked.
> > >
> > > I think there are several separate issues here. One is that
> > > folio_account_dirtied() will consider the whole folio as needing writ=
eback
> > > which is not necessarily the case (as e.g. iomap will writeback only =
dirty
> > > blocks in it). This was OKish when pages were 4k and you were using 1=
k
> > > blocks (which was uncommon configuration anyway, usually you had 4k b=
lock
> > > size), it starts to hurt a lot with 2M folios so we might need to fin=
d a
> > > way how to propagate the information about really dirty bits into wri=
teback
> > > accounting.
> >
> > Agreed. The only workable solution I see is to have some sort of api
> > similar to filemap_dirty_folio() that takes in the number of pages
> > dirtied as an arg, but maybe there's a better solution.
>
> Yes, something like that I suppose.
>
> > > Another problem *may* be that fast increments to dirtied pages (as we=
 dirty
> > > 512 pages at once instead of 16 we did in the past) cause over-reacti=
on in
> > > the dirtiness balancing logic and we throttle the task too much. The
> > > heuristics there try to find the right amount of time to block a task=
 so
> > > that dirtying speed matches the writeback speed and it's plausible th=
at
> > > the large increments make this logic oscilate between two extremes le=
ading
> > > to suboptimal throughput. Also, since this was observed with FUSE, I =
belive
> > > a significant factor is that FUSE enables "strictlimit" feature of th=
e BDI
> > > which makes dirty throttling more aggressive (generally the amount of
> > > allowed dirty pages is lower). Anyway, these are mostly speculations =
from
> > > my end. This needs more data to decide what exactly (if anything) nee=
ds
> > > tweaking in the dirty throttling logic.
> >
> > I tested this experimentally and you're right, on FUSE this is
> > impacted a lot by the "strictlimit". I didn't see any bottlenecks when
> > strictlimit wasn't enabled on FUSE. AFAICT, the strictlimit affects
> > the dirty throttle control freerun flag (which gets used to determine
> > whether throttling can be skipped) in the balance_dirty_pages() logic.
> > For FUSE, we can't turn off strictlimit for unprivileged servers, but
> > maybe we can make the throttling check more permissive by upping the
> > value of the min_pause calculation in wb_min_pause() for writes that
> > support large folios? As of right now, the current logic makes writing
> > large folios unfeasible in FUSE (estimates show around a 75% drop in
> > throughput).
>
> I think tweaking min_pause is a wrong way to do this. I think that is jus=
t a
> symptom. Can you run something like:
>
> while true; do
>         cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
>         echo "---------"
>         sleep 1
> done >bdi-debug.txt
>
> while you are writing to the FUSE filesystem and share the output file?
> That should tell us a bit more about what's happening inside the writebac=
k
> throttling. Also do you somehow configure min/max_ratio for the FUSE bdi?
> You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I suspect th=
e
> problem is that the BDI dirty limit does not ramp up properly when we
> increase dirtied pages in large chunks.

This is the debug info I see for FUSE large folio writes where bs=3D1M
and size=3D1G:


BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:            896 kB
DirtyThresh:            359824 kB
BackgroundThresh:       179692 kB
BdiDirtied:            1071104 kB
BdiWritten:               4096 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3596 kB
DirtyThresh:            359824 kB
BackgroundThresh:       179692 kB
BdiDirtied:            1290240 kB
BdiWritten:               4992 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3596 kB
DirtyThresh:            359824 kB
BackgroundThresh:       179692 kB
BdiDirtied:            1517568 kB
BdiWritten:               5824 kB
BdiWriteBandwidth:       25692 kBps
b_dirty:                     0
b_io:                        1
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       7
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3596 kB
DirtyThresh:            359824 kB
BackgroundThresh:       179692 kB
BdiDirtied:            1747968 kB
BdiWritten:               6720 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:            896 kB
DirtyThresh:            359824 kB
BackgroundThresh:       179692 kB
BdiDirtied:            1949696 kB
BdiWritten:               7552 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3612 kB
DirtyThresh:            361300 kB
BackgroundThresh:       180428 kB
BdiDirtied:            2097152 kB
BdiWritten:               8128 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------


I didn't do anything to configure/change the FUSE bdi min/max_ratio.
This is what I see on my system:

cat /sys/class/bdi/0:52/min_ratio
0
cat /sys/class/bdi/0:52/max_ratio
1


>
> Actually, there's a patch queued in mm tree that improves the ramping up =
of
> bdi dirty limit for strictlimit bdis [1]. It would be nice if you could
> test whether it changes something in the behavior you observe. Thanks!
>
>                                                                 Honza
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patche
> s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb_calc_th=
resh.pa
> tch

I still see the same results (~230 MiB/s throughput using fio) with
this patch applied, unfortunately. Here's the debug info I see with
this patch (same test scenario as above on FUSE large folio writes
where bs=3D1M and size=3D1G):

BdiWriteback:                0 kB
BdiReclaimable:           2048 kB
BdiDirtyThresh:           3588 kB
DirtyThresh:            359132 kB
BackgroundThresh:       179348 kB
BdiDirtied:              51200 kB
BdiWritten:                128 kB
BdiWriteBandwidth:      102400 kBps
b_dirty:                     1
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       5
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3588 kB
DirtyThresh:            359144 kB
BackgroundThresh:       179352 kB
BdiDirtied:             331776 kB
BdiWritten:               1216 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3588 kB
DirtyThresh:            359144 kB
BackgroundThresh:       179352 kB
BdiDirtied:             562176 kB
BdiWritten:               2176 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3588 kB
DirtyThresh:            359144 kB
BackgroundThresh:       179352 kB
BdiDirtied:             792576 kB
BdiWritten:               3072 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------
BdiWriteback:               64 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:           3588 kB
DirtyThresh:            359144 kB
BackgroundThresh:       179352 kB
BdiDirtied:            1026048 kB
BdiWritten:               3904 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1
---------


Thanks,
Joanne
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

