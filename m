Return-Path: <linux-fsdevel+bounces-5127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B42808326
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270AA282E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84433CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuRz+L86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4F10C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 23:40:05 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67aa0f5855cso3489836d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701934805; x=1702539605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORQ7iv8DtKIjwhcLjT0ZnKFQX82zfus2fU2J4pJsDtI=;
        b=FuRz+L86GMpHkPEeGpqLfmbkXR0HGSY6CfpFJTvAluM7lqY6N5f7nwEqhlYbjZGz/0
         AEQBPQwSz1lO0QN1Gcw3STSWsATaJrl56jqrx1/x8sgXFtuOw4peGAwc6athvoZJob5d
         +hnFv7cPeUUQzkNLZTFSppthgr9TnHShjzaYStalr2phNl0/mWXUdnMD6lZktOXDrTUb
         3ltC/emVQVBCMzq+HZaMJQk1IMyVu7CdL2ZxcVJVxZVYEbNW+MV79JI3JrAhcBiyu0EK
         AmPuzOt6/OiMdHtm3CYfNBb1T4toEUl+88KmQvFGn5t9g+Nz7u7HDZTZOvvNDmPjufYg
         +7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701934805; x=1702539605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORQ7iv8DtKIjwhcLjT0ZnKFQX82zfus2fU2J4pJsDtI=;
        b=C+GYXOXKy4u7KxE96DI3OVcp7v8MWRCDLpcJ8HtC8t/r+uUAjJc7uBa+JKKkHsEf5p
         9aVE57txTsiypushSGdX/ElA5EBvx2pamaupbnUqrkCR9UCIJeaxA18oSamNfDb90p4H
         6AhXqXYpR0U6F0V6sRz9tBlt5cbBwluV0qkvb5eL2gZyQ46nGTZhKO5k+ls6FvOzf4Bs
         QKSJLEowueTcy5897Yx2pmgAdIzh44NqEHzQrkOhYRu4XAifbwJxkLbhFK1xI4+u6rUV
         DVncu7+WV+h2XvXRRakBM7Le7NUVcl8xMiFPzJPEauxNaVOoSzv17kjrCkHf1HrXt3jD
         MvMA==
X-Gm-Message-State: AOJu0Yy2n8WPb5qAy/bXc3gJ1KyNhdLQHeECaMWl09sxzpxq9WwNDM0X
	ZdsdhS59MU8+AEg/r3Wm3f+9Fu5DcccV+esR2vVP6w627ag=
X-Google-Smtp-Source: AGHT+IGUh2CBVdek24erjc4LEV7sk6iYHHLMnz/JOfijmmphZF/0kHUThugHNgrCOWKGO1hOav2GGOr9b9vlFiCLn8c=
X-Received: by 2002:a0c:ea2c:0:b0:67a:aef9:5ebb with SMTP id
 t12-20020a0cea2c000000b0067aaef95ebbmr2122034qvp.76.1701934804645; Wed, 06
 Dec 2023 23:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm> <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com> <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
In-Reply-To: <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Dec 2023 09:39:53 +0200
Message-ID: <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:28=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/6/23 09:25, Amir Goldstein wrote:
> >>>> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
> >>>> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
> >>>> I guess not otherwise, the combination would have been tested.
> >>>
> >>> I'm not sure how many people are aware of these different flags/featu=
res.
> >>> I had just finalized the backport of the related patches to RHEL8 on
> >>> Friday, as we (or our customers) need both for different jobs.
> >>>
> >>>>
> >>>> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
> >>>> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
> >>>> for network fs. Right?
> >>>
> >>> We kind of have these use cases for our network file systems
> >>>
> >>> FOPEN_PARALLEL_DIRECT_WRITES:
> >>>      - Traditional HPC, large files, parallel IO
> >>>      - Large file used on local node as container for many small file=
s
> >>>
> >>> FUSE_DIRECT_IO_ALLOW_MMAP:
> >>>      - compilation through gcc (not so important, just not nice when =
it
> >>> does not work)
> >>>      - rather recent: python libraries using mmap _reads_. As it is r=
ead
> >>> only no issue of consistency.
> >>>
> >>>
> >>> These jobs do not intermix - no issue as in generic/095. If such
> >>> applications really exist, I have no issue with a serialization penal=
ty.
> >>> Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
> >>> nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
> >>>
> >>> Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on pl=
ain
> >>> O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this bran=
ch
> >>> and post the next version
> >>> https://github.com/bsbernd/linux/commits/fuse-dio-v4
> >>>
> >>>
> >>> In the mean time I have another idea how to solve
> >>> FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
> >>
> >> Please find attached what I had in my mind. With that generic/095 is n=
ot
> >> crashing for me anymore. I just finished the initial coding - it still
> >> needs a bit cleanup and maybe a few comments.
> >>
> >
> > Nice. I like the FUSE_I_CACHE_WRITES state.
> > For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
> > in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
> > of the last open file of the inode.
> >
> > I did not understand some of the complexity here:
> >
> >>         /* The inode ever got page writes and we do not know for sure
> >>          * in the DIO path if these are pending - shared lock not poss=
ible */
> >>         spin_lock(&fi->lock);
> >>         if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
> >>                 if (!(*cnt_increased)) {
> >
> > How can *cnt_increased be true here?
>
> I think you missed the 2nd entry into this function, when the shared
> lock was already taken?

Yeh, I did.

> I have changed the code now to have all
> complexity in this function (test, lock, retest with lock, release,
> wakeup). I hope that will make it easier to see the intention of the
> code. Will post the new patches in the morning.
>

Sounds good. Current version was a bit hard to follow.

>
> >
> >>                         fi->shared_lock_direct_io_ctr++;
> >>                         *cnt_increased =3D true;
> >>                 }
> >>                 excl_lock =3D false;
> >
> > Seems like in every outcome of this function
> > *cnt_increased =3D !excl_lock
> > so there is not need for out arg cnt_increased
>
> If excl_lock would be used as input - yeah, would have worked as well.
> Or a parameter like "retest-under-lock". Code is changed now to avoid
> going in and out.
>
> >
> >>         }
> >>         spin_unlock(&fi->lock);
> >>
> >> out:
> >>         if (excl_lock && *cnt_increased) {
> >>                 bool wake =3D false;
> >>                 spin_lock(&fi->lock);
> >>                 if (--fi->shared_lock_direct_io_ctr =3D=3D 0)
> >>                         wake =3D true;
> >>                 spin_unlock(&fi->lock);
> >>                 if (wake)
> >>                         wake_up(&fi->direct_io_waitq);
> >>         }
> >
> > I don't see how this wake_up code is reachable.
> >
> > TBH, I don't fully understand the expected result.
> > Surely, the behavior of dio mixed with mmap is undefined. Right?
> > IIUC, your patch does not prevent dirtying page cache while dio is in
> > flight. It only prevents writeback while dio is in flight, which is the=
 same
> > behavior as with exclusive inode lock. Right?
>
> Yeah, thanks. I will add it in the patch description.
>
> And there was actually an issue with the patch, as cache flushing needs
> to be initiated before doing the lock decision, fixed now.
>

I thought there was, because of the wait in fuse_send_writepage()
but wasn't sure if I was following the flow correctly.

> >
> > Maybe this interaction is spelled out somewhere else, but if not
> > better spell it out for people like me that are new to this code.
>
> Sure, thanks a lot for your helpful comments!
>

Just to be clear, this patch looks like a good improvement and
is mostly independent of the "inode caching mode" and
FOPEN_CACHE_MMAP idea that I suggested.

The only thing that my idea changes is replacing the
FUSE_I_CACHE_WRITES state with a FUSE_I_CACHE_IO_MODE
state, which is set earlier than FUSE_I_CACHE_WRITES
on caching file open or first direct_io mmap and unlike
FUSE_I_CACHE_WRITES, it is cleared on the last file close.

FUSE_I_CACHE_WRITES means that caching writes happened.
FUSE_I_CACHE_IO_MODE means the caching writes and reads
may happen.

FOPEN_PARALLEL_DIRECT_WRITES obviously shouldn't care
about "caching reads may happen", but IMO that is a small trade off
to make for maintaining the same state for
"do not allow parallel dio" and "do not allow passthrough open".

Thanks,
Amir.

