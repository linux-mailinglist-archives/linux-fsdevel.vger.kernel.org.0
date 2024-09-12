Return-Path: <linux-fsdevel+bounces-29248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D597752E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C9E286054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F4F1CE713;
	Thu, 12 Sep 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8jR+Ff/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D91CDFD4;
	Thu, 12 Sep 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183098; cv=none; b=sHwmVjdmSWS4YAOF5KuhXSO2Q7GmOH16Og8jkroZZ15t0VdHRoFMws//G1ZlF8q3fW1SvAwGRrz8wEBXFBDbbQhluZN7V3KWld6E6V8hH7wufSw5Tl7e2jAUjUpe0T1xRKtyqcLFlZkhW6jGbM0ZUK6uV106OjSY0h3yy1Fn6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183098; c=relaxed/simple;
	bh=Ns4lQeNcWSYEbKxbEgvG6kwlvdYFgPjC/A2j0jbzXAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWEhsKp/xcrmq3G473Uhgtb+FTa+3+NjuKdDACAHeqQ6SHDWUtKo5p9/BzhfsjPc7ZEWlnYApzjyfR4srd6PXrbAKnKZnee4aHMHEJqCgbNhMZsFf/ULcb5ISkmv2oWUSEpcmkNzNi6KTnqQ7Egs1VKGlqqMv9qsksHm8FjlT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8jR+Ff/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4582c4aa2c2so9340541cf.0;
        Thu, 12 Sep 2024 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183096; x=1726787896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MPIlYcZWlx3tQ/7cIgcQXejSStNXwDd/F54jH6NnWQ=;
        b=S8jR+Ff/cT6S8Q9kznZ4ZMpnj1eiLs74aZpml+Qyl5nw2WqtteeRekAwTr9Yd3CyUe
         TusVAOo/Zn6qdk2a/DybdKiT4Y5UEdINkRvUZtXoyDm4tLdUYnXQ3IDgsl37rcr06JP+
         Z5RYqC4CrimHN91fklz2A1MKau+K7+tPtu2mVCGdDUp3gJC8W9sy0rd93Nikakyze6Xb
         B5fSAvl/h3FZ0x29JAt+9EFfExb/UDEnp+yPQ6iEkJMPIV/BYjrkZTW4k/+mwdZUC07l
         JBZL4tUd0aO/cuBNDC3TSeT/bGWNfUJ8efIeHqClTGbSWCT4IZcj8pjn576bcNRWx7GR
         oIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183096; x=1726787896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MPIlYcZWlx3tQ/7cIgcQXejSStNXwDd/F54jH6NnWQ=;
        b=IwohPsZr6cYZwSyCJgi12xp2fKyn2HFXY7Ohfq40sN3mihCujtK/pdYHb4RW8CugGH
         /IiSUmI6YONY9b3euca+UyvU3wJyQmVopC/+6CyoK1uxDa7RQDUL9dYbq6p5q4JnwDi7
         QyWXHD+k0aalqpOZbF9t5mG/xZkKT59EAtBDeiAvg0rp2nRXzlTecYtk5d1fBOrtZ9F7
         Z00UKiui2UG0tfdSrEvEP3DC+dKlKE+wJJHv/NmYxT7sS+1QbOMT8TMa32iHCsSxPgfY
         qnc1Or/ExKob1URAcHTsudJBJWkrYFDF/zR22YxetmV/Kf5rk9iL9fwYw/6ubwV1ZXlz
         ly1w==
X-Forwarded-Encrypted: i=1; AJvYcCVGKygLNzvoMYhb6lAQoQuIr76TRCF1H1qODT0AB153ts/36kbHIXznzt7G8+8nRpMflcI8Qo9/UpXcoVI+@vger.kernel.org, AJvYcCWYJOXmzWg8lq+NyyoMikf7twDhKw2825cTghCpe+igJj3ZZzZDE5s2dJA/94ilgUQRRCRRfDva4oTDJ7Yj@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2LGBG1c8dhoY4I2VjApZU/RkJNIrX6Bj6/BNAgDw3KiLpfiZ
	bluhPQ/CSA6p2YDXQZDYNC5zL61NijGznwY0oLDfnWoxIHhUHJXONJ9bZUg4N2wFR8F21vuVnRI
	kaRl+5w6yU0P0YoEf+NKRIkwHbhI=
X-Google-Smtp-Source: AGHT+IEzfEwoEr6zI2D6nZE33iEIs2Q95Yqt/HHjEQE2Y+ReYYQKwFpLUZeTnTWz8NmwJGqU9NsR925L1EYHjaGdMss=
X-Received: by 2002:a05:622a:7:b0:458:a70:d9bb with SMTP id
 d75a77b69052e-458602dc73amr52386891cf.22.1726183094786; Thu, 12 Sep 2024
 16:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <19ffac65-8e1f-431e-a6bd-f942a4b908fe@linux.alibaba.com>
In-Reply-To: <19ffac65-8e1f-431e-a6bd-f942a4b908fe@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Sep 2024 16:18:03 -0700
Message-ID: <CAJnrk1bcN4k8Ou6xp20Zd5W3k349T3S=QGmxAVmAkF5=B5bq3w@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi all,
>
> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
> > On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wro=
te:
> >
> >> IIUC, there are two sources that may cause deadlock:
> >> 1) the fuse server needs memory allocation when processing FUSE_WRITE
> >> requests, which in turn triggers direct memory reclaim, and FUSE
> >> writeback then - deadlock here
> >
> > Yep, see the folio_wait_writeback() call deep in the guts of direct
> > reclaim, which sleeps until the PG_writeback flag is cleared.  If that
> > happens to be triggered by the writeback in question, then that's a
> > deadlock.
>
> After diving deep into the direct reclaim code, there are some insights
> may be helpful.
>
> Back to the time when the support for fuse writeback is introduced, i.e.
> commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, the
> direct reclaim indeed unconditionally waits for PG_writeback flag being
> cleared.  At that time the direct reclaim is implemented in a two-stage
> style, stage 1) pass over the LRU list to start parallel writeback
> asynchronously, and stage 2) synchronously wait for completion of the
> writeback previously started.
>
> This two-stage design and the unconditionally waiting for PG_writeback
> flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
> stall on writeback during memory compaction") since v3.5.
>
> Though the direct reclaim logic continues to evolve and the waiting is
> added back, now the stall will happen only when the direct reclaim is
> triggered from kswapd or memory cgroup.
>
> Specifically the stall will only happen in following certain conditions
> (see shrink_folio_list() for details):
> 1) kswapd
> 2) or it's a user process under a non-root memory cgroup (actually
> cgroup_v1) with GFP_IO permitted
>
> Thus the potential deadlock does not exist actually (if I'm not wrong) if=
:
> 1) cgroup is not enabled
> 2) or cgroup_v2 is actually used
> 3) or (memory cgroup is enabled and is attached upon cgroup_v1) the fuse
> server actually resides under the root cgroup
> 4) or (the fuse server resides under a non-root memory cgroup_v1), but
> the fuse server advertises itself as a PR_IO_FLUSHER[1]
>
>
> Then we could considering adding a new feature bit indicating that any
> one of the above condition is met and thus the fuse server is safe from
> the potential deadlock inside direct reclaim.  When this feature bit is
> set, the kernel side could bypass the temp page copying when doing
> writeback.
>

Hi Jingbo, thanks for sharing your analysis of this.

Having the temp page copying gated on the conditions you mentioned
above seems a bit brittle to me. My understanding is that the mm code
for when it decides to stall or not stall can change anytime in the
future, in which case that seems like it could automatically break our
precondition assumptions. Additionally, if I'm understanding it
correctly, we also would need to know if the writeback is being
triggered from reclaim by kswapd - is there even a way in the kernel
to check that?

I'm wondering if there's some way we could tell if a folio is under
reclaim when we're writing it back. I'm not familiar yet with the
reclaim code, but my initial thoughts were whether it'd be possible to
purpose the PG_reclaim flag or perhaps if the folio is not on any lru
list, as an indication that it's being reclaimed. We could then just
use the temp page in those cases, and skip the temp page otherwise.

Could you also point me to where in the reclaim code we end up
invoking the writeback callback? I see pageout() calls ->writepage()
but I'm not seeing where we invoke ->writepages().


Thanks,
Joanne

>
> As for the condition 4 (PR_IO_FLUSHER), there was a concern from
> Miklos[2].  I think the new feature bit could be disabled by default,
> and enabled only when the fuse server itself guarantees that it is in a
> safe distribution condition.  Even when it's enabled either by a mistake
> or a malicious fuse server, and thus causes a deadlock, maybe the
> sysadmin could still abort the connection through the abort sysctl knob?
>
>
> Just some insights and brainstorm here.
>
>
> [1] https://lore.kernel.org/all/Zl4%2FOAsMiqB4LO0e@dread.disaster.area/
> [2]
> https://lore.kernel.org/all/CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx92=
T8W6uQ@mail.gmail.com/
>
>
>
> --
> Thanks,
> Jingbo

