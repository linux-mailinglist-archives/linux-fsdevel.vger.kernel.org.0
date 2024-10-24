Return-Path: <linux-fsdevel+bounces-32793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9E79AECBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF29F1F22728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193B1F8EE3;
	Thu, 24 Oct 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asnLdUuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30041F4724
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788910; cv=none; b=n3dJK054kQKET9sD8ZONhvfhkdSR/7DwakVu0OtYfuAMJr6vrNMNW+MjmOPQzSb5kxjXXgQzt5M0dbg4EBsSYTBeuLVz0907pdeoS45N29USBOFe5ZvCu7PeUxCde/8oPhHF6OQUaZEEos57SR9d3hBC8NUtno5qMgvOcd9T5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788910; c=relaxed/simple;
	bh=flzP3/Y59m7mtYOzeygRE1onxB7HTlzYO0eBFoktGP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvElKx4tYXSbLGHGwZsXXuLJC82fOadCV393LzSrECBlQLdMMOsR12MT3VagzK6r5tkOUJynBui2pGup/OtBXm02HvA+2FSdtGHxemYYEHQ36gYdyy3HiY+7KtiN5wFTRi9l9HW2RgVmtzQjEenDrkxna2NfKARTgE3eYltd73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asnLdUuM; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7183a3f3beaso722295a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788907; x=1730393707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsxehwx5rj/3butAtwSut3oTBv9CrenVnd4AZCxzHE8=;
        b=asnLdUuMPweDLeqVG2DAjnB3Onv4MyRfxBvosNLNq+maWZSe/8oWk1YWdZ7Bjfqn5A
         pzm1p9ZOFKktdC0b0xtBnvjKiOhoXmE6gMWiVPgn+BOQKYEAWwAelWO10myjEI67A2Gc
         Jg03XbTctSZduk1tc1KDTb+pTdBuQW/YMYI3IT1KnbYkUafiEyuQWqrPU0fSO2Qk4HXy
         0vAVaON0xZx5CC4C7vf2+ElWN7Tdx6kGjwzS/OAc0jAXNpFr0X0RRcFFhkp/L3bVXo+v
         X1GdSWQVcQD7ZClvroooGVVDA5ZtrZr/r/FUVTVjsSENBCsspgJ19aRp4/TzvOZ2daB2
         5gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788907; x=1730393707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsxehwx5rj/3butAtwSut3oTBv9CrenVnd4AZCxzHE8=;
        b=MI23yPdZRBqdmPZLcwQ76rbS5cmFpomNNUAnBM5gHkY56iyYTPkNR/zloYX9+deyFA
         2o11lHR7Rqcunr93R5yM3dBJCCVt3nLQSfLZoRUlyiaHtspE4CJdHhYzmWNes5DReqp+
         sTA9UuGyzdejQp071yW1cKDg2y4woucrAn572YaFJCnNSdVJMzdBlCj9sAvzsiQ6VL7f
         MNVGFFch8eTPz54CnHuPMlRemCgZ8givNE2viINZR+N+XcMMTo6jZCVbLCJ2XgZ9KzjL
         SqOna/D0+by26BuraesJIgLwbDuIdHA7IVQxwT3zGsXIwfKiEwazvqwO1allt4nwHbZV
         E4Og==
X-Forwarded-Encrypted: i=1; AJvYcCUtEZF/5MCHD8vv2rwQk6J8z+kEAOWxjRxAGCf7Aim8N+N0Tk7U1DT9QWoZJbtbrvq3yatEgqKV5/lxbWCu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzln43RhK+nf+kQzK6FCUVwLm6qR6yg5Bn2AbjM1Quc9yV7LsYK
	sLcZvo3YTGqxvd3P445zfKvdGu0UywK85lIgrU4hDYTfj07HO7Hl6Ig4m+hUnZUddN45yhXikyb
	rOadUqg2Dy3Bft1B31vff/yLeexA=
X-Google-Smtp-Source: AGHT+IHmvls8WbFBJsOeRRviOjJpnHymZ95JCWz5Av1XvK2GK/Y28lqgr259UNOkqA2HjjcxAmhvSTSHqywQ1MgxXo4=
X-Received: by 2002:a05:6358:7188:b0:1c3:727:844d with SMTP id
 e5c5f4694b2df-1c3e4d171b9mr189199755d.4.1729788906681; Thu, 24 Oct 2024
 09:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com> <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Oct 2024 09:54:55 -0700
Message-ID: <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wro=
te:
> >
> > > I feel like this is too much restrictive and I am still not sure why
> > > blocking on fuse folios served by non-privileges fuse server is worse
> > > than blocking on folios served from the network.
> >
> > Might be.  But historically fuse had this behavior and I'd be very
> > reluctant to change that unconditionally.
> >
> > With a systemwide maximal timeout for fuse requests it might make
> > sense to allow sync(2), etc. to wait for fuse writeback.
> >
> > Without a timeout allowing fuse servers to block sync(2) indefinitely
> > seems rather risky.
>
> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
> That seems in line with the sync(2) documentation Jingbo referenced
> earlier where it states "The writing, although scheduled, is not
> necessarily complete upon return from sync()."
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
>

So I think the answer to this is "no" for Linux. What the Linux man
page for sync(2) says:

"According to the standard specification (e.g., POSIX.1-2001), sync()
schedules the writes, but may return before the actual writing is
done.  However Linux waits for I/O completions, and thus sync() or
syncfs() provide the same guarantees as fsync() called on every file
in the system or filesystem respectively." [1]

Regardless of the compaction / page migration issue then, this
blocking sync(2) is a dealbreaker.

I see two workarounds around this:

1) Optimistically skip the tmp page but add a timeout where if the
server doesn't reply to the writeback in X seconds, then allocate the
tmp folio and clear writeback immediately on the original folio).
This would address any page migration deadlocks as well. And probably
we don't need the reclaim patch either then, since that could also be
handled by the timeout.
This would make 99% of writebacks fast but in the case of a malicious
fuse server, could make sync() and page migration wait an extra X
seconds.

2) Only skip the tmp folio for privileged fuse servers (we'd still
need to address the page migration path)

Would love to hear thoughts on this. Should we go ahead with option 1?

[1] https://man7.org/linux/man-pages/man2/sync.2.html

>
> Thanks,
> Joanne
> >
> > Thanks,
> > Miklos

