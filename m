Return-Path: <linux-fsdevel+bounces-32931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12E9B0DB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD9EB25D06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83E20EA46;
	Fri, 25 Oct 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2eOPauz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AD20D51D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882084; cv=none; b=Ip0ahSnfzlC+Zju1D1H1soOz9IIrRAwHDABjjYFwF3ezLefpPdlO5DjV+5vE07lkcZ03fEpRuC9MoG8D+ss8HTbdT9vwaPRtyB6bBGdoII0zUEmPt7NPtwpdZRsxzy90vcABuY8IADFeowLcKLV3VkNmKdWPqQuC8Z9B1R//JOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882084; c=relaxed/simple;
	bh=470pbtMIVnXJ+bgT89vZMfT3A516D8CaZmohp9gnV3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4kK/NG12AqboT1VvPdZ1j6rRABIImX2usL+FF5w0QI9dg09sQgX0/K/D9wLNKuPCKHcxzHgE9En53pct/Ey1ic7i73qG7SYfWV2sGODt4VvOr5n+MDfdaxe1D7ut/PJSmwsof3zTjSa7Ii2SHQiBfOLSwFOXr9F4//8tdS09cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2eOPauz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460d1145cd8so16621781cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729882081; x=1730486881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaHQh/uxcueeKmc7Ia2usZ0ir1pT0Tu5YtRHZ1CT2Gg=;
        b=g2eOPauzMyhDxmErjXC75OhFf29u3ncJgUUykfuMBTSEm42QIoT13V+JUj6GAzZdOj
         Zur/++nQmcdBi2VBabQuWPdpi0b8KNYkenWYOyScZG19WQizb6yRHNU1XmkMgiKz6aZJ
         jrziXnYF7QPFds3RbQdoO5Pv3rcsm9qu6XoZKEvBAqN6dL495j55X0VA8f08aNdiDmka
         ygtlkrLa3C+H3QciZhsqghWfWZpgbqXg/Hnhi+rdh9rrtprpG4wj8Ys1dyU40IiziEl8
         /UbjYIh8ZR02s9BUzeb9iNOqiK/F0MGFnLIaoakJkJuZGvCE0JDudurI5vpveaPn20kM
         TJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882081; x=1730486881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaHQh/uxcueeKmc7Ia2usZ0ir1pT0Tu5YtRHZ1CT2Gg=;
        b=jkGtzxQvKf1NO8W5iE4jaY/iXmP28v07IzyoWNRHulqRw8mXXQ7lVUS/GG4k+gYJR9
         2DFWy9TK+0U7QPtkIO+d/7SaGJLGwInkWttNnYumF8vdpg9EXGKn86tRH+OYyT7MKkDL
         GMT4iV/BbNejWUQxcosdrABoWdx2g/vNaU/5bPeEjsCpM27edWd9LWzE2c7gfXvWBzSq
         Ps1pb5+6wwp8AspL0BAHvswSM2Y4xJ5QKNTU6w6vH0AjfOo57hdswOWDupzeMKRq+UmX
         IvZH+vJU4ftj6lu7kPhT5gCBavn+3hr2xJ9YGSSljTUtKNPx3KLG0yPgbvVhPWbnftnY
         PG8A==
X-Forwarded-Encrypted: i=1; AJvYcCVu+St77eSvPCalyW9DAMEID+4oY07RVgym7jqmGzeegd5jvbEalijv2K+Lng7cJnpCXY7WNKhykA7mOWXR@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyzSSuz+VhIw7516gq0A/euYHfH+7BAU/Qf7cRLtrg47x2JiS
	hKH+hsde6aaRMoyeCz+ab3QkQ3ZI688ZnKeNi4mJna3F8Ck+ZJYnazrwL0s/+aEQTqziU8H5GZO
	Pkg//Ml9Tb53IZAo2P5HPjXDNPUY=
X-Google-Smtp-Source: AGHT+IFKzGMyWhJk3WQPpCMXPD5R1Ppb/OJq9Et0s6vPW3KvecDYCHRMmEMI7RTce8d+qOUyE//Giekmeh2v7CzMScc=
X-Received: by 2002:ac8:5f14:0:b0:461:22f0:4f7d with SMTP id
 d75a77b69052e-4613c19dcddmr3037511cf.41.1729882081428; Fri, 25 Oct 2024
 11:48:01 -0700 (PDT)
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
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com> <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
In-Reply-To: <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 25 Oct 2024 11:47:50 -0700
Message-ID: <CAJnrk1Z_+WOcD1W2SHX83Z_89b6LZtPMGH6GDPNW-V5BD_VY9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:36=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 6:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba=
.com> wrote:
> >
> >
> >
> > On 10/25/24 12:54 AM, Joanne Koong wrote:
> > > On Mon, Oct 21, 2024 at 2:05=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > >>
> > >> On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szere=
di.hu> wrote:
> > >>>
> > >>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev>=
 wrote:
> > >>>
> > >>>> I feel like this is too much restrictive and I am still not sure w=
hy
> > >>>> blocking on fuse folios served by non-privileges fuse server is wo=
rse
> > >>>> than blocking on folios served from the network.
> > >>>
> > >>> Might be.  But historically fuse had this behavior and I'd be very
> > >>> reluctant to change that unconditionally.
> > >>>
> > >>> With a systemwide maximal timeout for fuse requests it might make
> > >>> sense to allow sync(2), etc. to wait for fuse writeback.
> > >>>
> > >>> Without a timeout allowing fuse servers to block sync(2) indefinite=
ly
> > >>> seems rather risky.
> > >>
> > >> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
> > >> That seems in line with the sync(2) documentation Jingbo referenced
> > >> earlier where it states "The writing, although scheduled, is not
> > >> necessarily complete upon return from sync()."
> > >> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
> > >>
> > >
> > > So I think the answer to this is "no" for Linux. What the Linux man
> > > page for sync(2) says:
> > >
> > > "According to the standard specification (e.g., POSIX.1-2001), sync()
> > > schedules the writes, but may return before the actual writing is
> > > done.  However Linux waits for I/O completions, and thus sync() or
> > > syncfs() provide the same guarantees as fsync() called on every file
> > > in the system or filesystem respectively." [1]
> >
> > Actually as for FUSE, IIUC the writeback is not guaranteed to be
> > completed when sync(2) returns since the temp page mechanism.  When
> > sync(2) returns, PG_writeback is indeed cleared for all original pages
> > (in the address_space), while the real writeback work (initiated from
> > temp page) may be still in progress.
> >
>
> That's a great point. It seems like we can just skip waiting on
> writeback to finish for fuse folios in sync(2) altogether then. I'll
> look into what's the best way to do this.

I think the most straightforward way to do this for sync(2) is to add
the mapping check inside sync_bdevs(). With something like:

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..bcb2b6d3db94 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1247,7 +1247,7 @@ void sync_bdevs(bool wait)
                mutex_lock(&bdev->bd_disk->open_mutex);
                if (!atomic_read(&bdev->bd_openers)) {
                        ; /* skip */
-               } else if (wait) {
+               } else if (wait &&
!mapping_no_writeback_wait(inode->i_mapping)) {
                        /*
                         * We keep the error status of individual mapping s=
o
                         * that applications can catch the writeback error =
using


and changing AS_NO_WRITEBACK_RECLAIM to AS_NO_WRITEBACK_WAIT.


Thanks,
Joanne
>

