Return-Path: <linux-fsdevel+bounces-61282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB7B570DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD9417077F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFFC2D23A8;
	Mon, 15 Sep 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeZqtshR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72561F5E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920069; cv=none; b=MrAjCEw6lNUs4/3o7GVO6xhdVueCcPEjy35pC0dZJpZeibL4LcpS8N6ffL8lNYs4ig+sBC1W1LISWgCiFC1CNGLMFQ5GvJbCgNErYThIX18J9WGKluClwyJGmKVT7nk2PEjWxzNBnvtDEkGMkhXjEEdNo91EsXCigAwyZ3PzR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920069; c=relaxed/simple;
	bh=ZvObV4F4WzdyFGPtNoK3wQSjt68O74C0fk4CNH0TmB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKhc13F6rNullaBEO4hXVCds+Gzg3V354Bs2fUZ36jigCSCSJ3Fr8GYcpN+MkZJPVXDtXFau7SS6Oek/12eyr0vGJH7t/U7gXkCQBmNq0ADzKFhDJ52JarOdJKFMB8O47J7D58iPuoRUhB5nH5Co5lGV+shp3WQDr5esXi5eLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeZqtshR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-627b85e4c0fso6060946a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757920066; x=1758524866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbBmoO54v1pk4v+qVcX6Y6rDE0GFaPscZfUuuanCNWo=;
        b=jeZqtshRCM+3ldSOb6qYVydh+r3xcbXS86j/gHbVXK6Apv9diknPLUTZzFidshgHFI
         sE/cXCQUlzdA1lfJywJW08rhtI/p5zBekoTwAEMFe+aLx/yYHyIiqlH8yvFySaYdyPg2
         HPuLLZOAVa7N1OtHlDWG3KP1pTey4N8Cq8KxYXjlbqJGKJflQFCL+31J3Y8Mui04OG9p
         hbpC6cXHHKld6iiv59koV3Xp3pGuak9kqVMVuRiToNg+zpl5erD81lyeOwEiGsHsu7qf
         QMA0L9bghxUJIoLtjn7XmGXf/njTo/FrrNAINsFJOR2HzqoBPu0qlKw7eW4xHWODSPqe
         HHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920066; x=1758524866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbBmoO54v1pk4v+qVcX6Y6rDE0GFaPscZfUuuanCNWo=;
        b=kW86f4bwW87YToYvqoZEjpSCg2tApJjgQA9Ah6Tm24/lMQRIeKDUC8Jt2BoEkZ4FqY
         zS3YbRaoLBdwl4C0Z0RzVPO3RnR3Tfm8jKCuxVVB/GR+kJG/uFHtv9Df99bFD6xenUat
         Vk47h6ZqUS5COxaSDmfrgwQWDNj+3mPLa0zpY3YiW4eXPpo3WGRyTrx6lqV9MXegnzGH
         d1GIRPWOEfMrpg3VoBK80MSfiUgsAxuwyiuAWt5hAHWc4Z9o/YCAXYymkXencoCAYVsc
         OdK0KFXC+1m+eHyZcinTbU9FnmAoJ4PIIIUjM10Qx+jUGQpIiMOqhA2OEKwP83OwFJnm
         6Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCV7tdFQx3z+IPvSr0qSVrXa4VcHGZNytfa9kR7HdT/3kNeK/WpwyQFTk0sgsJ1rnBi6yba/3ddU2PwxvGTz@vger.kernel.org
X-Gm-Message-State: AOJu0YwyV/2nq8R5JEKSuhV3OlqRojojQR4aOvEUN++xKsfqXBQg2S6B
	K/ChMu8DOQVZ1qH6awMbKE3OoTm15XhBo4c11dnR0tRQBObe6+2sDwWd0v7qKKbxTrXl4VJFjz5
	58d68IJjQIzFANQsYeKfLBPxDhlD34O6NkSnOipo=
X-Gm-Gg: ASbGnctaLMI4AS6l2jBJXJQzx+oEvtu4IBFk416qKDk8pb5R0IlZIWZnxPAPsbyJwx3
	Mw7Fupmpro9wbqlx+0HygjLp+mGGN8/tpK9+NkQvEuEFeGCT1jrlk/p/40glCejyOEY6Ctjhz84
	56zMi17SWEkKR6axl53b4Hg37818xEv8y1Q2k+PH2WruRYNHYDbICteg4A0HaFctFPCb5DiB3Ms
	nvaiTP3mSLsgsXpnWBT/jigPlgR3oRpdV6REKIiWybkDrMeLAez
X-Google-Smtp-Source: AGHT+IFoUa1WmUKtRahwMs1ns10q4BxYyVtWogbq3yfZ9Z3l4+mt5f1iqFoReBJ8lmfntx7fTtJgUUQnNIkuXA+gmss=
X-Received: by 2002:a05:6402:5056:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-62ed9d80c3emr11447112a12.18.1757920065874; Mon, 15 Sep 2025
 00:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8734afp0ct.fsf@igalia.com> <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu> <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com> <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com> <20250912145857.GQ8117@frogsfrogsfrogs>
In-Reply-To: <20250912145857.GQ8117@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Sep 2025 09:07:34 +0200
X-Gm-Features: AS18NWDYMQ3oGUTZk_-KnAXzaj5C2xAaXij_x2T_P1ov1kQsJUGCIdqPwaY_W6U
Message-ID: <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> >
> >
> > On 9/12/25 13:41, Amir Goldstein wrote:
> > > On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > >>
> > >>
> > >>
> > >> On 8/1/25 12:15, Luis Henriques wrote:
> > >>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> > >>>
> > >>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> > >>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> > >>>>>>
> > >>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if l=
ibfuse
> > >>>>>> could restart itself.  It's unclear if doing so will actually en=
able us
> > >>>>>> to clear the condition that caused the failure in the first plac=
e, but I
> > >>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restar=
ts
> > >>>>>> aren't totally crazy.
> > >>>>>
> > >>>>> I'm trying to understand what the failure scenario is here.  Is t=
his
> > >>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so,=
 what
> > >>>>> is supposed to happen with respect to open files, metadata and da=
ta
> > >>>>> modifications which were in transit, etc.?  Sure, fuse2fs could r=
un
> > >>>>> e2fsck -fy, but if there are dirty inode on the system, that's go=
ing
> > >>>>> potentally to be out of sync, right?
> > >>>>>
> > >>>>> What are the recovery semantics that we hope to be able to provid=
e?
> > >>>>
> > >>>> <echoing what we said on the ext4 call this morning>
> > >>>>
> > >>>> With iomap, most of the dirty state is in the kernel, so I think t=
he new
> > >>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED,=
 which
> > >>>> would initiate GETATTR requests on all the cached inodes to valida=
te
> > >>>> that they still exist; and then resend all the unacknowledged requ=
ests
> > >>>> that were pending at the time.  It might be the case that you have=
 to
> > >>>> that in the reverse order; I only know enough about the design of =
fuse
> > >>>> to suspect that to be true.
> > >>>>
> > >>>> Anyhow once those are complete, I think we can resume operations w=
ith
> > >>>> the surviving inodes.  The ones that fail the GETATTR revalidation=
 are
> > >>>> fuse_make_bad'd, which effectively revokes them.
> > >>>
> > >>> Ah! Interesting, I have been playing a bit with sending LOOKUP requ=
ests,
> > >>> but probably GETATTR is a better option.
> > >>>
> > >>> So, are you currently working on any of this?  Are you implementing=
 this
> > >>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a c=
loser
> > >>> look at fuse2fs too.
> > >>
> > >> Sorry for joining the discussion late, I was totally occupied, day a=
nd
> > >> night. Added Kevin to CC, who is going to work on recovery on our
> > >> DDN side.
> > >>
> > >> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> > >> server restart we want kernel to recover inodes and their lookup cou=
nt.
> > >> Now inode recovery might be hard, because we currently only have a
> > >> 64-bit node-id - which is used my most fuse application as memory
> > >> pointer.
> > >>
> > >> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-s=
ends
> > >> outstanding requests. And that ends up in most cases in sending requ=
ests
> > >> with invalid node-IDs, that are casted and might provoke random memo=
ry
> > >> access on restart. Kind of the same issue why fuse nfs export or
> > >> open_by_handle_at doesn't work well right now.
> > >>
> > >> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> > >> would not return a 64-bit node ID, but a max 128 byte file handle.
> > >> And then FUSE_REVALIDATE_FH on server restart.
> > >> The file handles could be stored into the fuse inode and also used f=
or
> > >> NFS export.
> > >>
> > >> I *think* Amir had a similar idea, but I don't find the link quickly=
.
> > >> Adding Amir to CC.
> > >
> > > Or maybe it was Miklos' idea. Hard to keep track of this rolling thre=
ad:
> > > https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP=
8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >
> > Thanks for the reference Amir! I even had been in that thread.
> >
> > >
> > >>
> > >> Our short term plan is to add something like FUSE_NOTIFY_RESTART, wh=
ich
> > >> will iterate over all superblock inodes and mark them with fuse_make=
_bad.
> > >> Any objections against that?
>
> What if you actually /can/ reuse a nodeid after a restart?  Consider
> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
> didn't delete it, obviously.

FUSE_LOOKUP_HANDLE is a contract.
If fuse4fs can reuse nodeid after restart then by all means, it should sign
this contract, otherwise there is no way for client to know that the
nodeids are persistent.
If fuse4fs_handle :=3D nodeid, that will make implementing the lookup_handl=
e()
API trivial.

>
> I suppose you could just ask for refreshed stat information and either
> the server gives it to you and the fuse_inode lives; or the server
> returns ENOENT and then we mark it bad.  But I'd have to see code
> patches to form a real opinion.
>

You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
where fuse_instance_id can be its start time or random number.
for auto invalidate, or maybe the fuse_instance_id should be
a native part of FUSE protocol so that client knows to only invalidate
attr cache in case of fuse_instance_id change?

In any case, instead of a storm of revalidate messages after
server restart, do it lazily on demand.

Thanks,
Amir.

