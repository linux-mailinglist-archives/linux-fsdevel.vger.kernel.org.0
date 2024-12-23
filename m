Return-Path: <linux-fsdevel+bounces-38066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC54F9FB48B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8FE18851F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598EB1BEF82;
	Mon, 23 Dec 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnjypt4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369141B87DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734980414; cv=none; b=QExvxOT9djHvfaa3SAlGlLeylDnoos3NVsLQHFht+WTs+cmwsy1Hzaz3tlCB5Px5qAMr6UZfHxH24+Z0OZIMbqNhUedchC//XjcvyjzkOgrlEUA1LFbiZs0z95agaiMsFVD7qnJcZi3raf3l5ZkZAp9xWtiNaqT3qbuGrUar0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734980414; c=relaxed/simple;
	bh=E8nGdpIselqZLtdkNLsAuI9a8XKLmHdR+iaGmyeoPbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjg23QU+2fss1MQdZJnqF5h2w852u40Wr2Z6PULO6psnuAdUmSwcvipZ2q7oOpJRV1TwC2boxtEK66v5M9KyA3bPq4mk1vLJMyywbs80kPi5Msou6v2zt5dJn8Pa4vHRVqFjaVdALn4gkEWgI9mQK+IpC3wDnLgTfJxTEWdtHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tnjypt4d; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a6ecaa54so32661201cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734980412; x=1735585212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhu35mDIb/3A2ITYiT2TdbY19VVUfLsBSSpE3vJF3ww=;
        b=Tnjypt4dHtBQ0AGFiISmpeftRdZF+T9lrH6TAZjmzNyZljUzzR0E6XV4WVaRYs0+gi
         cG8I04zYic5NzfPrixCKG5l2QMWlbcQt629bRT6vreB8EzmzerKqYShSPBFsJrPIMyuI
         JVjGfO8pf3EbGGAOLJZpMt+NXAh9Ge1M5p7cZY4WLTMyLIb7gDbvoaV7DsH5fy5GVqum
         01mKD0V4x3+uOuwZNXmWzwDrSLCxci6DZYCvvLHi8CCh6h+KSLITFj9KUIJxxO3vDb50
         Od0zUmEgsLTuo6VsYs3r5NP+w/k11CPFtJqCqYazORt/ylrFWMeh5AYR/iny3w6LQz2z
         qFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734980412; x=1735585212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhu35mDIb/3A2ITYiT2TdbY19VVUfLsBSSpE3vJF3ww=;
        b=qvm1jbej/RaHfiloVs01CoMHWwIrGHIOv9NBt69LT2kzS1V2Yvb02z/3pM8LVPx5sV
         CIfPQe4upYQvw0muBSVb4Jvp/cv7rmvn0WUA8UhKjX2NeozOUTWn5bsOcINBTC2XFjhw
         T3k7oxZAFtCoOeTQCHguXFWUtARbdRIGAvW2zNkqrx9L4my7fu4coik3w/VL6OLvyyGR
         c1ZW9ZkwwdFee+tDSL15ICzCqKCKcKH8Dkn4QkRDobCCmMyQVkLwiR+N1wayUm1zu5KX
         M28mzqrP/sDDPvccX8NL/GPXVaASJzesoBUW5IgDxLUzZ1V77cbFyoc2NawRyKS2cWzj
         Cz+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUnDdShsdN2CYJK5z1BxgWL6cIOFsfuW32MZ6gDk2hXxNQtNBrvplTjwomNPrFSv2OenqXpdGmH5My2ZGr@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEOePZyQJK3hGf+mpiCOMRqJfA97Uk+P1jcJvkeMEfHtA1Wwv
	FyFJ180e7+9UFfBvSt+stkxWaMbj1oiqlX3ZfUsJjs5DrBywB9rA8v/PnrRY7t7DAe4MhAP504B
	F+nlGtMCaANZOqFCQDBbTqX4WPk3wRw==
X-Gm-Gg: ASbGncsf+ttBn8lnYNwGEdzM1u4tI8Bue8Q47l2WEfDv73OAtMHHEsVf/9MuMBVf/G4
	oSTso3blh3m2G59PApU3TKboLuG2ui+cmPqd0J0Y=
X-Google-Smtp-Source: AGHT+IEA0LI4ESWdIbKOz/fFFxR5L+FSLunPLXsuHAFLCFmN6T73zZeJjA57iOlvw2bR+9GwzEmnjTZVJXNS/Tmg6Yw=
X-Received: by 2002:a05:622a:302:b0:467:6e88:4548 with SMTP id
 d75a77b69052e-46a4a9a6203mr295471401cf.39.1734980411992; Mon, 23 Dec 2024
 11:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com> <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com> <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com> <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com> <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com> <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
 <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com> <166a147e-fdd7-4ea6-b545-dd8fb7ef7c2f@fastmail.fm>
In-Reply-To: <166a147e-fdd7-4ea6-b545-dd8fb7ef7c2f@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Dec 2024 11:00:01 -0800
Message-ID: <CAJnrk1ZzOnBwj8HoABWuUZvigMzFaha+YeC117DR1aDJDuOQRg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 1:59=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/21/24 17:25, David Hildenbrand wrote:
> > On 20.12.24 22:01, Joanne Koong wrote:
> >> On Fri, Dec 20, 2024 at 6:49=E2=80=AFAM David Hildenbrand <david@redha=
t.com>
> >> wrote:
> >>>
> >>>>> I'm wondering if there would be a way to just "cancel" the
> >>>>> writeback and
> >>>>> mark the folio dirty again. That way it could be migrated, but not
> >>>>> reclaimed. At least we could avoid the whole
> >>>>> AS_WRITEBACK_INDETERMINATE
> >>>>> thing.
> >>>>>
> >>>>
> >>>> That is what I basically meant with short timeouts. Obviously it is =
not
> >>>> that simple to cancel the request and to retry - it would add in qui=
te
> >>>> some complexity, if all the issues that arise can be solved at all.
> >>>
> >>> At least it would keep that out of core-mm.
> >>>
> >>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
> >>> try to improve such scenarios, not acknowledge and integrate them, th=
en
> >>> work around using timeouts that must be manually configured, and ca
> >>> likely no be default enabled because it could hurt reasonable use
> >>> cases :(
> >>>
> >>> Right now we clear the writeback flag immediately, indicating that da=
ta
> >>> was written back, when in fact it was not written back at all. I susp=
ect
> >>> fsync() currently handles that manually already, to wait for any of t=
he
> >>> allocated pages to actually get written back by user space, so we hav=
e
> >>> control over when something was *actually* written back.
> >>>
> >>>
> >>> Similar to your proposal, I wonder if there could be a way to request
> >>> fuse to "abort" a writeback request (instead of using fixed timeouts =
per
> >>> request). Meaning, when we stumble over a folio that is under writeba=
ck
> >>> on some paths, we would tell fuse to "end writeback now", or "end
> >>> writeback now if it takes longer than X". Essentially hidden inside
> >>> folio_wait_writeback().
> >>>
> >>> When aborting a request, as I said, we would essentially "end writeba=
ck"
> >>> and mark the folio as dirty again. The interesting thing is likely ho=
w
> >>> to handle user space that wants to process this request right now (st=
uck
> >>> in fuse_send_writepage() I assume?), correct?
> >>
> >> This would be fine if the writeback request hasn't been sent yet to
> >> userspace but if it has and the pages are spliced
> >
> > Can you point me at the code where that splicing happens?
>
> fuse_dev_splice_read()
>   fuse_dev_do_read()
>     fuse_copy_args()
>       fuse_copy_page
>
>
> Btw, for the non splice case, disabling migration should be
> only needed while it is copying to the userspace buffer?

I don't think so. We don't currently disable migration when copying
to/from the userspace buffer for reads.


Thanks,
Joanne
>
>
>
> Thanks,
> Bernd

