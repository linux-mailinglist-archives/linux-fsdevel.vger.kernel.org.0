Return-Path: <linux-fsdevel+bounces-39987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5BA1A95B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C1816704B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E508154C07;
	Thu, 23 Jan 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq2uA637"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81713AD03
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655533; cv=none; b=ecJJcHpaNubXOD1avJkCQ+GmxtXkeM7oMZlIy0jWwZLPJIsJndPn0WRS6x77oSjZJdMYWfyqZvnFW1iTpnTv6ho+1SoouooOryXYcDaBldPNgJR1dIRvJJ7vSYz5WWWGOrjehrUEvKWCOkmi3tL96pGRvtEeTnxbaH1ymwDW/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655533; c=relaxed/simple;
	bh=85uuGF1ZZwCtI1Oqudsd4c0uLyJVU+z4ey2J4aqLBb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbJFbbQk0z+meTMO/O4nrVVCGZ+K55EyjMxw8L6EogUFxCgfVN2czORs6zylXqG6zRIBGVCOOLetia5nrC0jLGxrUHh7qjxrmUazaG192xROqAtlw1mpE+u/NvwdeCnKlB//T+LRH7m5ZmkOKxltI7y9Nv2Kuk96D9Mt293usrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq2uA637; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467b086e0easo7086701cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737655531; x=1738260331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctbnxoaK1/jv2I7AXFfYfSypaMrvWAbdKCkPsiBThCc=;
        b=Jq2uA637COf+GL9+p8TRR7QjAR0AyQJtWNS8MVEH8XR7q3UoADtmPuTd38jk/xcL5Y
         AvPGmqqoW+aGWjcpxRrVxxdk//DNAcj7VBeEB8xWqvLPrDjk98zUu4du+nopU8mkMSAq
         0h12ZfRnEVWEMrlyQw4DhnptFUi/jWM5UntVXLIaNMGTuHjOqO9Ne7Xso1c9XTR176cu
         VzGfDKn2KfrcBR+3ICHWRY/BP2+3olrKOgBj/dFQMoQLfUamDaL0xYbW0JG9P5Ex8Y8/
         1VYYnKtB2/WhK2m2pONKq7PHHauH7vW3T03y7dLAxSo5CrO6oeQqyk+XjQFyIIFx0voX
         dY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737655531; x=1738260331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctbnxoaK1/jv2I7AXFfYfSypaMrvWAbdKCkPsiBThCc=;
        b=GxGntO+uku0uuX+PoaJP4tJpFay3ADu3V5Yf3RcawTW7PaQLHFjO6d8W7nEM6fxDXG
         gfzT7Gs1zyBnwhKujyC5oJsVsMEiZpH/rvhpbL5efKxLQBYs2b+6y+moij0+eoFsol0D
         Lq6CrqhWRScXAvV+fj8wT80PW0x6YxQGHe6T2FhogWnavsvHhIKRB4WhtJYBgIpjP4Bw
         8P/VuGNg/V26T6TpcXBr0tuw7OB6/BDQFIfQKoX667sBKDixWzmNb5Z2L4wrTx6l7XfM
         +KO8BOnpJs3wwGjzNc/I8d96Uozv4Vt/+V4hqYPl+MNLQvbufWpZn70pznEAv85hAoSx
         V69w==
X-Forwarded-Encrypted: i=1; AJvYcCUy/vN4IYgAMu8lqrbycrsm08hX6af/wsYkWMZPxXaFg5UMtw4YgmsMaePwKNOqZ/Axqm/MIC1PDLS/hc5o@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRU8LLxlvAgDCmxFCDWVo0NgL8nL6GobugAdz+RFVgAAlIYsn
	EIUhywE00lXirqWkTI+hZaz5gfC8MqEewRBPnHM2YS0cfVa9OfzKzD8bcdDeh7zqDiSP44kXaSG
	IQSMPg8jVmmVlOTvJ07mqE3g2iEQ=
X-Gm-Gg: ASbGncslh0hVFdkUdoHUwbsJsfA1y4z10U79S0Gb1phZnb8bFzNJqKdNMbY8uhfVQ90
	eaUdNlKjUXqwVJSAw3Vwt+qvWe+k42qSCijaWO3KIWlBeOvy7LUjjCt+KePCoP6n1/+uoRh2q1I
	ry3Q==
X-Google-Smtp-Source: AGHT+IF65c/FvNQk0NLRYnGs6KoJ7lPgfSsKrU+y7Iu41FXW8PkrTU/dUKa+BWxrqxv8XVteBDNkauoPJe31b67LRuE=
X-Received: by 2002:a05:622a:647:b0:46c:9f53:4a45 with SMTP id
 d75a77b69052e-46e12bb320emr356183341cf.43.1737655531019; Thu, 23 Jan 2025
 10:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213221818.322371-1-joannelkoong@gmail.com>
 <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com> <ff59b715-efa7-4ede-8f82-313af11c51f2@linux.alibaba.com>
In-Reply-To: <ff59b715-efa7-4ede-8f82-313af11c51f2@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 10:05:20 -0800
X-Gm-Features: AbW1kvZVEb5hOzZi0uKSrYukAwhVvF3kc55UbWISN5TMsXt4Mwhzmx-i95vkl34
Message-ID: <CAJnrk1YGq2dDjrn06J2-mpGSUKBT7tfP5wfsunK0rqY+e7PvcA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fuse: support large folios
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, shakeel.butt@linux.dev, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:24=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 1/23/25 7:23 AM, Joanne Koong wrote:
> > On Fri, Dec 13, 2024 at 2:23=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> This patchset adds support for folios larger than one page size in FUS=
E.
> >>
> >> This patchset is rebased on top of the (unmerged) patchset that remove=
s temp
> >> folios in writeback [1]. This patchset was tested by running it throug=
h fstests
> >> on passthrough_hp.
> >>
> >> Please note that writes are still effectively one page size. Larger wr=
ites can
> >> be enabled by setting the order on the fgp flag passed in to __filemap=
_get_folio()
> >> but benchmarks show this significantly degrades performance. More inve=
stigation
> >> needs to be done into this. As such, buffered writes will be optimized=
 in a
> >> future patchset.
> >>
> >> Benchmarks show roughly a ~45% improvement in read throughput.
> >>
> >> Benchmark setup:
> >>
> >> -- Set up server --
> >>  ./libfuse/build/example/passthrough_hp --bypass-rw=3D1 ~/libfuse
> >> ~/mounts/fuse/ --nopassthrough
> >> (using libfuse patched with https://github.com/libfuse/libfuse/pull/80=
7)
> >>
> >> -- Run fio --
> >>  fio --name=3Dread --ioengine=3Dsync --rw=3Dread --bs=3D1M --size=3D1G
> >> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> >> --directory=3Dmounts/fuse/
> >>
> >> Machine 1:
> >>     No large folios:     ~4400 MiB/s
> >>     Large folios:        ~7100 MiB/s
> >>
> >> Machine 2:
> >>     No large folios:     ~3700 MiB/s
> >>     Large folios:        ~6400 MiB/s
> >>
> >>
> >> [1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joan=
nelkoong@gmail.com/
> >>
> >
> > A couple of updates on this:
> > * I'm going to remove the writeback patch (patch 11/12) in this series
> > and resubmit, and leave large folios writeback to be done as a
> > separate future patchset. Getting writeback to work with large folios
> > has a dependency on [1], which unfortunately does not look like it'll
> > be resolved anytime soon. If we cannot remove tmp pages, then we'll
> > likely need to use a different data structure than the rb tree to
> > account for large folios w/ tmp pages. I believe we can still enable
> > large folios overall even without large folios writeback, as even with
> > the inode->i_mapping set to a large folio order range, writeback will
> > still only operate on 4k folios until fgf_set_order() is explicitly
> > set in fuse_write_begin() for the __filemap_get_folio() call.
> >
> > * There's a discussion here [2] about perf degradation for writeback
> > writes on large folios due to writeback throttling when balancing
> > dirty pages. This is due to fuse enabling bdi strictlimit. More
> > experimentation will be needed to figure out what a good folio order
> > is, and whether it's possible to do something like remove the
> > strictlimit for privileged servers.
>
> FYI the sysadmin can already disable strictlimit for FUSE through
> /sys/class/bdi/<bdi>/strict_limit knob[*].
>
> [*] https://lore.kernel.org/all/20221119005215.3052436-1-shr@devkernel.io=
/

Oh cool, thanks for pointing this out! AFAICT, this means the sysadmin
would have to do this individually for every fuse server that gets
run. I wonder if we should do something like a) have fuse only enforce
the strictlimit for unprivileged servers or b) add a fuse sysctl that
sysadmins can set more easily for removing strictlimit for any server
that gets run instead of having to do it individually

Thanks,
Joanne

>
> --
> Thanks,
> Jingbo

