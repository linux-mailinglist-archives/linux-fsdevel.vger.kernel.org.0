Return-Path: <linux-fsdevel+bounces-39874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2EA19AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227C83AA99D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB331C5D6E;
	Wed, 22 Jan 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ4OdVIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2064C9F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584236; cv=none; b=PLVpnpKyIan8nSu4BZ/AFAERxKVK2RxRDKn7TKnbcUSQavyHhoB18aDGonpW+CL1zMsArTrHcTErd/fFChTXHM7K11vTxQkeh15J82Rue2NbA7yypad9V+ousfe/qZNYBJD+Z181JPC2/aFPqBP6c0Wz8PMLWmH+ncU/mfJ8xKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584236; c=relaxed/simple;
	bh=KAJglO9X1adxuFoh3QTldxNhR/T49SiZKprL6k/K5pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCbw75WqYGMa+yf4tljPbU1kEEeqn8nIeeYja0ruJR8cSwPICy6MY1NzvCSbID616mo+/VLQad6UBArimGyIrOj17lSpTmhXp3uUjSFc9gInXNzdmJqN1hsYFc1Th8q+0W0aeFwUf9XNwrC0sU0+DF3YoRPNajk5tJso6rOEq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ4OdVIR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4678cce3d60so2509751cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737584233; x=1738189033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EopwUpr8CDIdHSlkl8ERszZCKxp0DkS1X7x5GPG61x8=;
        b=TJ4OdVIRnKrEDCMbtACR8G/h9ea9mH6R6DiiHPOWbEJM5b2Vf5xO8MU6MOJWLReG1+
         DQltR7hFeUrm33K6RRJvaRF5jbejkGeIpPEI8/Pf/uiSRmyb5/9aTB7hxBl5T0Mt84Sj
         +QfENuTkfa5vWLddM6OlqNMozFQD2nSTCp1iRDcMm4tXpA8dIHr16eKRFfHjUv+kTiTp
         MC/1AF3dykMnoidbT+Wka4T5i+nfpTb/hH8fun9wtD1UpOaYQ1ll5L2FFdY0SuHRUbV9
         ZRzS09xxhSgzM3iQQsrNE5YZIYBRJCu2g5UoNt2rEA92uruGp54e53HcFYyngt5MchGq
         HLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584233; x=1738189033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EopwUpr8CDIdHSlkl8ERszZCKxp0DkS1X7x5GPG61x8=;
        b=i3hJY3Ogous5Y/+IjeL6KHGYyXIiyNF1tLG1G79IS6Tvv+pm2ZFi0XCF92sd9AAinA
         bFEfmVGn8VddRKVlGgDLMmKT2Y0WoELldHz/PpxyeRUBZd82DIbBcW3ZZd1zy8mHjAA9
         +lP2PiP7THGeVHnEetcmrUyb7Ge0wcjEpkroP4uDsoR33OblPgcv2WMj0JUP6SNBO+I6
         lg81dEOGNdXwmOd/rnJH0gfvXE+ZgHmE786AqBEycGLNwhKf9g12zzo1MFu9A7Dj6QhF
         8JvRAkbVA+cleNS5c/UPp74btk3fcUfY7jluJf6EVqtn19AwHtTfOKX3Hnl60g826NIN
         vUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUyQ2sXNZs9T7VX98Bi/6wX2tkWhA1xQeqW1SRwi/VQO2q/tfNhUwO8euiEAMAckZOy1/4SCbogm5CE/z/B@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqN2D0klOJ3yK5zbsvGTp1e1aCLbOrLSlsINXQddCJmyGkst7
	VF7cVnyC1fsUWRMNWcTk3kbVZJOGU7bhLuKj8elsCM6BpOVWdkTGppNphlEVswRClmO5Bndj7hh
	yXSh4wr/U7kouJKnshCfwmZP+NXM=
X-Gm-Gg: ASbGncs//sVEZGv3dpqleAldU9yYR6eZsfINIYPolSRKhBWjIxZvZL4Xeqp3kq3Jc00
	b4uIUiY1kXKqZISnjV06886YWpYVHFqQ+xFB+RBIYKOdzmZyE03Pn
X-Google-Smtp-Source: AGHT+IFVpHrQO8rLRJ4cZJ73Sg56MIzb8x9r+g0pBlODP+qwNn+E2LawfxrujXY95+uhKbTFM2EDtXQ6ksG0KM1VXOU=
X-Received: by 2002:a05:622a:1817:b0:467:b1b4:2b6 with SMTP id
 d75a77b69052e-46e12b7bf21mr365983451cf.38.1737584233233; Wed, 22 Jan 2025
 14:17:13 -0800 (PST)
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
 <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com>
 <xuf742w2v2rir6tfumuu5ll2ow3kgzzbhjgvu47vquc3vgrdxf@blrmpfwvre4y>
 <CAJnrk1Z21NU0GCjj+GzsudyT1LAKx3TNqHt2oO22u1MZAZ4Lug@mail.gmail.com> <tglgxjxcs3wpm4msgxlvzk3hebzcguhuu752hs3eefku6wj4zv@2ixuho7rxbah>
In-Reply-To: <tglgxjxcs3wpm4msgxlvzk3hebzcguhuu752hs3eefku6wj4zv@2ixuho7rxbah>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jan 2025 14:17:02 -0800
X-Gm-Features: AbW1kvZO2izQxpQVm3b1L-accBighurtrGC3qBVA0hBEbsKjAYmQzn6TZIWDe4Y
Message-ID: <CAJnrk1YXYD4f0NZWzC+DzQ4Wpoqr2XzBE-kkYk8sUozAce+UPA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 1:22=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 21-01-25 16:29:57, Joanne Koong wrote:
> > On Mon, Jan 20, 2025 at 2:42=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Fri 17-01-25 14:45:01, Joanne Koong wrote:
> > > > On Fri, Jan 17, 2025 at 3:53=E2=80=AFAM Jan Kara <jack@suse.cz> wro=
te:
> > > > > On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> > > > > I think tweaking min_pause is a wrong way to do this. I think tha=
t is just a
> > > > > symptom. Can you run something like:
> > > > >
> > > > > while true; do
> > > > >         cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
> > > > >         echo "---------"
> > > > >         sleep 1
> > > > > done >bdi-debug.txt
> > > > >
> > > > > while you are writing to the FUSE filesystem and share the output=
 file?
> > > > > That should tell us a bit more about what's happening inside the =
writeback
> > > > > throttling. Also do you somehow configure min/max_ratio for the F=
USE bdi?
> > > > > You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I su=
spect the
> > > > > problem is that the BDI dirty limit does not ramp up properly whe=
n we
> > > > > increase dirtied pages in large chunks.
> > > >
> > > > This is the debug info I see for FUSE large folio writes where bs=
=3D1M
> > > > and size=3D1G:
> > > >
> > > >
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:            896 kB
> > > > DirtyThresh:            359824 kB
> > > > BackgroundThresh:       179692 kB
> > > > BdiDirtied:            1071104 kB
> > > > BdiWritten:               4096 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3596 kB
> > > > DirtyThresh:            359824 kB
> > > > BackgroundThresh:       179692 kB
> > > > BdiDirtied:            1290240 kB
> > > > BdiWritten:               4992 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3596 kB
> > > > DirtyThresh:            359824 kB
> > > > BackgroundThresh:       179692 kB
> > > > BdiDirtied:            1517568 kB
> > > > BdiWritten:               5824 kB
> > > > BdiWriteBandwidth:       25692 kBps
> > > > b_dirty:                     0
> > > > b_io:                        1
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       7
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3596 kB
> > > > DirtyThresh:            359824 kB
> > > > BackgroundThresh:       179692 kB
> > > > BdiDirtied:            1747968 kB
> > > > BdiWritten:               6720 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:            896 kB
> > > > DirtyThresh:            359824 kB
> > > > BackgroundThresh:       179692 kB
> > > > BdiDirtied:            1949696 kB
> > > > BdiWritten:               7552 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3612 kB
> > > > DirtyThresh:            361300 kB
> > > > BackgroundThresh:       180428 kB
> > > > BdiDirtied:            2097152 kB
> > > > BdiWritten:               8128 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > >
> > > >
> > > > I didn't do anything to configure/change the FUSE bdi min/max_ratio=
.
> > > > This is what I see on my system:
> > > >
> > > > cat /sys/class/bdi/0:52/min_ratio
> > > > 0
> > > > cat /sys/class/bdi/0:52/max_ratio
> > > > 1
> > >
> > > OK, we can see that BdiDirtyThresh stabilized more or less at 3.6MB.
> > > Checking the code, this shows we are hitting __wb_calc_thresh() logic=
:
> > >
> > >         if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> > >                 unsigned long limit =3D hard_dirty_limit(dom, dtc->th=
resh);
> > >                 u64 wb_scale_thresh =3D 0;
> > >
> > >                 if (limit > dtc->dirty)
> > >                         wb_scale_thresh =3D (limit - dtc->dirty) / 10=
0;
> > >                 wb_thresh =3D max(wb_thresh, min(wb_scale_thresh, wb_=
max_thresh /
> > >         }
> > >
> > > so BdiDirtyThresh is set to DirtyThresh/100. This also shows bdi neve=
r
> > > generates enough throughput to ramp up it's share from this initial v=
alue.
> > >
> > > > > Actually, there's a patch queued in mm tree that improves the ram=
ping up of
> > > > > bdi dirty limit for strictlimit bdis [1]. It would be nice if you=
 could
> > > > > test whether it changes something in the behavior you observe. Th=
anks!
> > > > >
> > > > >                                                                 H=
onza
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.g=
it/tree/patche
> > > > > s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb=
_calc_thresh.pa
> > > > > tch
> > > >
> > > > I still see the same results (~230 MiB/s throughput using fio) with
> > > > this patch applied, unfortunately. Here's the debug info I see with
> > > > this patch (same test scenario as above on FUSE large folio writes
> > > > where bs=3D1M and size=3D1G):
> > > >
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:           2048 kB
> > > > BdiDirtyThresh:           3588 kB
> > > > DirtyThresh:            359132 kB
> > > > BackgroundThresh:       179348 kB
> > > > BdiDirtied:              51200 kB
> > > > BdiWritten:                128 kB
> > > > BdiWriteBandwidth:      102400 kBps
> > > > b_dirty:                     1
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       5
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3588 kB
> > > > DirtyThresh:            359144 kB
> > > > BackgroundThresh:       179352 kB
> > > > BdiDirtied:             331776 kB
> > > > BdiWritten:               1216 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3588 kB
> > > > DirtyThresh:            359144 kB
> > > > BackgroundThresh:       179352 kB
> > > > BdiDirtied:             562176 kB
> > > > BdiWritten:               2176 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:                0 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3588 kB
> > > > DirtyThresh:            359144 kB
> > > > BackgroundThresh:       179352 kB
> > > > BdiDirtied:             792576 kB
> > > > BdiWritten:               3072 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > > > BdiWriteback:               64 kB
> > > > BdiReclaimable:              0 kB
> > > > BdiDirtyThresh:           3588 kB
> > > > DirtyThresh:            359144 kB
> > > > BackgroundThresh:       179352 kB
> > > > BdiDirtied:            1026048 kB
> > > > BdiWritten:               3904 kB
> > > > BdiWriteBandwidth:           0 kBps
> > > > b_dirty:                     0
> > > > b_io:                        0
> > > > b_more_io:                   0
> > > > b_dirty_time:                0
> > > > bdi_list:                    1
> > > > state:                       1
> > > > ---------
> > >
> > > Yeah, here the situation is really the same. As an experiment can you
> > > experiment with setting min_ratio for the FUSE bdi to 1, 2, 3, ..., 1=
0 (I
> > > don't expect you should need to go past 10) and figure out when there=
's
> > > enough slack space for the writeback bandwidth to ramp up to a full s=
peed?
> > > Thanks!
> > >
> > >                                                                 Honza
> >
> > When locally testing this, I'm seeing that the max_ratio affects the
> > bandwidth more so than min_ratio (eg the different min_ratios have
> > roughly the same bandwidth per max_ratio). I'm also seeing somewhat
> > high variance across runs which makes it hard to gauge what's
> > accurate, but on average this is what I'm seeing:
> >
> > max_ratio=3D1 --- bandwidth=3D ~230 MiB/s
> > max_ratio=3D2 --- bandwidth=3D ~420 MiB/s
> > max_ratio=3D3 --- bandwidth=3D ~550 MiB/s
> > max_ratio=3D4 --- bandwidth=3D ~653 MiB/s
> > max_ratio=3D5 --- bandwidth=3D ~700 MiB/s
> > max_ratio=3D6 --- bandwidth=3D ~810 MiB/s
> > max_ratio=3D7 --- bandwidth=3D ~1040 MiB/s (and then a lot of times, 56=
1
> > MiB/s on subsequent runs)
>
> Ah, sorry. I actually misinterpretted your reply from previous email that=
:
>
> > > > cat /sys/class/bdi/0:52/max_ratio
> > > > 1
>
> This means the amount of dirty pages for the fuse filesystem is indeed
> hard-capped at 1% of dirty limit which happens to be ~3MB on your machine=
.
> Checking where this is coming from I can see that fuse_bdi_init() does
> this by:
>
>         bdi_set_max_ratio(sb->s_bdi, 1);
>
> So FUSE restricts itself and with only 3MB dirty limit and 2MB dirtying
> granularity it is not surprising that dirty throttling doesn't work well.
>
> I'd say there needs to be some better heuristic within FUSE that balances
> maximum folio size and maximum dirty limit setting for the filesystem to =
a
> sensible compromise (so that there's space for at least say 10 dirty
> max-sized folios within the dirty limit).
>
> But I guess this is just a shorter-term workaround. Long-term, finer
> grained dirtiness tracking within FUSE (and writeback counters tracking i=
n
> MM) is going to be a more effective solution.
>

Thanks for taking a look, Jan. I'll play around with the bdi limits,
though I don't think we'll be able to up this for unprivileged FUSE
servers. I'm planning to add finer grained diritiness tracking to FUSE
and the associated mm writeback counter changes but even then, having
full writes be that much slower is probably a no-go, so I'll
experiment with limiting the fgf order.


Thanks,
Joanne

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

