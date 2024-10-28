Return-Path: <linux-fsdevel+bounces-33090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A99B3D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 23:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2683F289D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1001F428E;
	Mon, 28 Oct 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUk7WNAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3E1F4286
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152659; cv=none; b=en05Y3e6hxXVswDIuLbqYS3ktmN3M2NHhdiQEbhhnpLveSv3jNRH5j8y0TlgBd/q8CxAlGD7YGV6gaSiUVkZEigDokMPJk/nCdNk5MKI4EKtF9zFp5gnXv9BNRPU6gZBgCWqk5swRNHuIbcCGnIMDGSel8jKZ2XDRkZ+4Jo8vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152659; c=relaxed/simple;
	bh=pCbR8R25DNvqDuCiCbfHSR093a+4Sf18UMJRy5hmEv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shoNnTbXN8iqDkM6DxTkiDQatsy4UfJct4Dewvx+pZxzu+PNPNaC7LH4N6+m+FihEdLxVjLrg27O5Eih5Q7wJx4T1X9R/9Wp6ktD5g+ReRzGXr1Ync+s0GCowpZlD3D1CEzaXab5a+3TTn5S+223Artlby8J6gidQgqCytEddyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUk7WNAF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4609beb631aso36230981cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730152656; x=1730757456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoDhG7CtWuow17GcDNM6QpBq1OhuaDs8XrsewrMi9/A=;
        b=MUk7WNAFEyGVNWX1Yix8yN3F7K5PDw86X52yHjTKvUGUkPp+msiU6aXa4zFDLXX79M
         0XdLRod7M2AuB11X+t8WCWvbBTuan4cAkpJunyoTS6cPvDQwIH6ABYebdYjwnc98YuDV
         1ZT/Dap05frkSa1frNIj78fvqv30k99aJiaz3G4u/vpg4tCHVJjVmowRWQwwA/ZIqRG1
         LomTBaTMHdsORc8EZtCyCP9KMVPdBqA8mi69nWJ5OvebRYd3fIXjZPaYDbkvRK5r8daf
         56qb/kFA7ZR7wlYFXhDDRz1xkBESi4dQAb4IlbQvb6kTefEfqoiUm5M2Gez538ddjEE+
         H37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152656; x=1730757456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoDhG7CtWuow17GcDNM6QpBq1OhuaDs8XrsewrMi9/A=;
        b=wg3ZjpNfO56H+Uoi/L+D/EaQZU39THGifvbDCtnTjlmHg9doyo6LjGjtrf5vMZUeIo
         CFzdruS/KxO6Uzy9Lae1asVJnBnza8PwH/WbybgOlB/Yn3gwRvvl6Qy56SYOD0WwyhOG
         NdRCT5kKK5xt0IVMqrm8tnbao+ioaQogTlsE5W2rVG+uFVAaYqLSWChv6grxbxo2vm03
         TQpuOQDp/fid6QwQa6Kz0heTmtUr2grPj2oFSmf3v4GzxBs7e2OaUeDIYff7ZXjmHqlB
         vKS0WSSDs/bCGU0rBA15iYQPfUqE/EYfMChkmcK7n20pwYpcXd1qx9TRtkD5g64hukio
         FvGw==
X-Forwarded-Encrypted: i=1; AJvYcCUJmJD85MnvllvMHNwEXug6HR9r65igb0zP0M3Dz0HhGVhIKxBB+h7RXggbSlcQVALx/D9gp4ObP0Xzv3Uj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8N77Or8ArTouCVAICdZeBco1uljwHRcmTopzEW7oBBLkT9Vlw
	RfO3/vgamAfhly0bKb3MHGNkp8wT2LTgkmiVrQy2D8eBm4WHycQtvjCJroqG/k3suqYZV4ENcRj
	Pwdk3rqWSAJiBCN74Z0UnPO6bysE=
X-Google-Smtp-Source: AGHT+IEFe/Uk5OKqArsQm2g0vdVuamajpL31KZbxy1aFKSSH/tVAHs6md0SIuT+HkltJCmJO9+vRCPsU1qhDzYn4UmM=
X-Received: by 2002:a05:622a:28f:b0:461:4a7d:202f with SMTP id
 d75a77b69052e-4614a7d3be1mr95798991cf.19.1730152656524; Mon, 28 Oct 2024
 14:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com> <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1Z_+WOcD1W2SHX83Z_89b6LZtPMGH6GDPNW-V5BD_VY9Q@mail.gmail.com> <5825a89f-7994-4de5-aecb-ebb6e3f94488@linux.alibaba.com>
In-Reply-To: <5825a89f-7994-4de5-aecb-ebb6e3f94488@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Oct 2024 14:57:25 -0700
Message-ID: <CAJnrk1bqd+Mcjw3k9K9Ekj9pyjkQOCzpeQrKdTHEhb1SrZDmNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 7:28=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 10/26/24 2:47 AM, Joanne Koong wrote:
> > On Fri, Oct 25, 2024 at 10:36=E2=80=AFAM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> >>
> >> On Thu, Oct 24, 2024 at 6:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/25/24 12:54 AM, Joanne Koong wrote:
> >>>> On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> >>>>>
> >>>>> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szer=
edi.hu> wrote:
> >>>>>>
> >>>>>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
> >>>>>>
> >>>>>>> I feel like this is too much restrictive and I am still not sure =
why
> >>>>>>> blocking on fuse folios served by non-privileges fuse server is w=
orse
> >>>>>>> than blocking on folios served from the network.
> >>>>>>
> >>>>>> Might be.  But historically fuse had this behavior and I'd be very
> >>>>>> reluctant to change that unconditionally.
> >>>>>>
> >>>>>> With a systemwide maximal timeout for fuse requests it might make
> >>>>>> sense to allow sync(2), etc. to wait for fuse writeback.
> >>>>>>
> >>>>>> Without a timeout allowing fuse servers to block sync(2) indefinit=
ely
> >>>>>> seems rather risky.
> >>>>>
> >>>>> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
> >>>>> That seems in line with the sync(2) documentation Jingbo referenced
> >>>>> earlier where it states "The writing, although scheduled, is not
> >>>>> necessarily complete upon return from sync()."
> >>>>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.htm=
l
> >>>>>
> >>>>
> >>>> So I think the answer to this is "no" for Linux. What the Linux man
> >>>> page for sync(2) says:
> >>>>
> >>>> "According to the standard specification (e.g., POSIX.1-2001), sync(=
)
> >>>> schedules the writes, but may return before the actual writing is
> >>>> done.  However Linux waits for I/O completions, and thus sync() or
> >>>> syncfs() provide the same guarantees as fsync() called on every file
> >>>> in the system or filesystem respectively." [1]
> >>>
> >>> Actually as for FUSE, IIUC the writeback is not guaranteed to be
> >>> completed when sync(2) returns since the temp page mechanism.  When
> >>> sync(2) returns, PG_writeback is indeed cleared for all original page=
s
> >>> (in the address_space), while the real writeback work (initiated from
> >>> temp page) may be still in progress.
> >>>
> >>
> >> That's a great point. It seems like we can just skip waiting on
> >> writeback to finish for fuse folios in sync(2) altogether then. I'll
> >> look into what's the best way to do this.
> >
> > I think the most straightforward way to do this for sync(2) is to add
> > the mapping check inside sync_bdevs(). With something like:
> >
> > diff --git a/block/bdev.c b/block/bdev.c
> > index 738e3c8457e7..bcb2b6d3db94 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -1247,7 +1247,7 @@ void sync_bdevs(bool wait)
> >                 mutex_lock(&bdev->bd_disk->open_mutex);
> >                 if (!atomic_read(&bdev->bd_openers)) {
> >                         ; /* skip */
> > -               } else if (wait) {
> > +               } else if (wait &&
> > !mapping_no_writeback_wait(inode->i_mapping)) {
> >                         /*
> >                          * We keep the error status of individual mappi=
ng so
> >                          * that applications can catch the writeback er=
ror using
> >
> >
>
> I'm afraid we are waiting in wait_sb_inodes (ksys_sync -> sync_inodes_sb
> -> wait_sb_inodes) rather than sync_bdevs.  sync_bdevs() is used to
> writeback and sync the metadata residing on the block device directly
> such as the superblock.  It is sync_inodes_one_sb() that actually
> writeback inodes.
>

Great point, thanks for the info!

>
> --
> Thanks,
> Jingbo

