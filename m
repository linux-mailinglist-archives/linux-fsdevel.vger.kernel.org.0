Return-Path: <linux-fsdevel+bounces-62053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E29B82582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 02:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92CB171B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687D1DA4E;
	Thu, 18 Sep 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCnMfX9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5145223
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153908; cv=none; b=UCKygBRdDGhnKyL0a6CBQ5s8ZtFfeN+vhzhd+SSH7PY6hjgoPV+/jrdNmMFzBcwWBX2/8pD+m/E1HN7JG4zakj0Qm37wPNCjPfr8xsg4Sp+/dOsjyM3Z5wG+CVrDoLQcn6wUrCu6Ynj9lkLremHdgemTmDhba0sYdnIRjUpco70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153908; c=relaxed/simple;
	bh=/60HjsF5kDxVQb13pIAAZhD9mjEiPULAqqfFawaT56Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDlEpdVXcwtgISgN1oLNowpdC7aJ++iNgvck6TEFtACkBsFdM7KD5rZe23BbjPlKLyH8l757J0TkTkYTQqJuQZFQ1At9V2ssMaOZRP9geOdGL5y9qCjFk+AGgULiWlhKdSoToYTiEqpHJOwN9jTcazFU68kVhkdV9PwulLzEc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCnMfX9n; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so62267666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758153905; x=1758758705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=eCnMfX9nb2niiMkElvWbWYpa4nkIf/PMO+FAJQTRxvqJJGHMmwDnPPSsVwmRt6mTI4
         260q3Mgnk2P0OrD98cBMEpZBvS5gyw1QVeTi9UNkIZ8yPFslTSr1muU6PHgYrMY6g4Kv
         9DouSVdfLJ67uRCL8NW78Joa/ZZ3uQFjbXiRhUNvSXEuLwEGmOnWX0gPPzT65S9HMxfk
         Sf2sxR91myFqMafdi9ZiM1RhLzShswJDnBVqWxoV17/ZczzMiPmL4Zpvxn5LrjyQD2Lm
         pEgRkvoAtHupuZtkZfLNAK9v16g5hPnbd4BgaTitsvlI1P5YQcIR3217kztIGBnK5yau
         PQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153905; x=1758758705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7rBzal2frbQpnRlW30Mxkh3elZt0aXaSIdElcYyVLY=;
        b=dqtCg9yPauOVTSXKJAwTB1PjB5hG+dcuNFDBL2VOhHl/pY6zK/LLR0kBBmtA0MA+x5
         /vXrC5SvMSq1sV93mD/wNzJ/KyVfXLpsnXQvpBleCDKCLNqor9XO1ha/qACnhXKZUaMy
         5gt3gT63C0Trf7saCvFBlFGYaBjAULvwvjVu+yCXhzpOM4lxY0ETCUduI9TY57M4ariI
         rqiP/laDijbIhqREH6DKp/B8tBTDKefnQip/U4mYOmWH9E8lj+h7evl7JHtmuPh0YrBJ
         TxCdVezF3Vpm+a+dyc9jTtiFtoFKHWyYDEs7Ea+FNHswpLEE9zjg9jqWsfhhnyGmBnZA
         5MIA==
X-Forwarded-Encrypted: i=1; AJvYcCXvxS3DNPOrUSXuQXckVw3GvpMciigPUs5Or/VI3KaXLXMPcUnySSs87vb+h+rJh11MS+dHm8x17Nvjw8o+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bMUv+lNXRQlDVSFYzlAJxY9Ka4k8WDS5zQKIOVSVWVhzr4vh
	FEq6YgeD3HfABBqTn5H8X83ZYQ+x9dk1AnIvXaOfwUBy0fdL8h2rYrUixd/J40rUfojUOnk5jEc
	FecHfScD9qZdTc+WvxbhQWosm+1hbKLA=
X-Gm-Gg: ASbGncs5m2VCoXtyCVJ//Yc4POt3Rth24VmeJCGXoecH1oTqiWeXTLnuCEePyzcDt9v
	w281RgcUUEueZGYNu+zeDg8M5DfhZZny+lisR9gsexe34hum28bpFGOnsUvwthvsP7BS/X+UTb6
	9w41z+gUWGF7rxTkv8DlUNuF0zSfwh2Eeuwrd5wGiQxERK7l4OOC3puAqAin/MeLzm4iUftKXd7
	SbVVxAxdSGy9IDvQd/70b8kkbkUL42ISPdhuhPd5Bj9futTBFZHF7mnPw==
X-Google-Smtp-Source: AGHT+IEG0rY/6zoPQ0V4J9TEMxL5qWtyUtLwQjBHHbE0kU7UOpID9Vbuyc6wLRhaE+GAd8+JbDeWJnkobCY95bQb0m8=
X-Received: by 2002:a17:906:eec3:b0:afe:e9ee:4ae0 with SMTP id
 a640c23a62f3a-b1bbb7425fdmr420216666b.59.1758153905204; Wed, 17 Sep 2025
 17:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area> <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 02:04:52 +0200
X-Gm-Features: AS18NWA8wIEg-rpkslqLzmFrp09CSxzRRbJVlRWEvQeLl_2xapCCNgyg1L-JlpY
Message-ID: <CAGudoHEpd++aMp8zcquh6SwAAT+2uKOhHcWRcBEyC6DRS73osA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:08=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
>
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
>
> As for mainline, I don't believe Josef's patchset addresses the problem.
>
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.
>
> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

To further elaborate, an extra count which only gates the struct being
freed has limited usefulness. Notably it does not help filesystems
which need the inode to be valid for use the entire time as evict() is
only stalled *after* ->evict_inode(), which might have destroyed the
vital parts.

Or to put it differently, the patchset tries to fit btrfs's needs
which don't necessarily line up with other filesystems. For example it
may be ceph needs the full reference in writeback, then the new ref is
of no use here. But for the sake of argument let's say ceph will get
away with the ligher ref instead. Even then this is on the clock for a
different filesystem to show up which can't do it and needs an async
iput and then its developers are looking at "whacky work arounds".

The actual generic async iput is the actual async iput, not an
arbitrary chunk of it after the inode is partway through processing.
But then any form of extra refcounting is of no significance.

To that end a non-whacky mechanism to defer iput would be most
welcome, presumably provided by the vfs layer itself. Per remarks by
Al elsewhere, care needs to be taken to make sure all inodes are
sorted out before the super block gets destroyed.

This suggests expanding the super_block to track all of the deferred
iputs and drain them early in sb destruction. The current struct inode
on LP64 has 2 * 4 byte holes and llist linkage is only 8 bytes, so
this can be added without growing the struct above stock kernel.

I would argue it would be good if the work could be deffered to
task_work if possible (fput-style). Waiting for these should be easy
enough, but arguably the thread which is supposed to get to them can
be stalled elsewhere indefinitely, so perhaps this bit is a no-go.

