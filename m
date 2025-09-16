Return-Path: <linux-fsdevel+bounces-61702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC2B58FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D9E3A5188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452152836AF;
	Tue, 16 Sep 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRSpgTW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB12820DB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009592; cv=none; b=ZjMJOJj9em3C8JrOf331Y4t+9Vu3TW379o1HSmOVOXVWigEf15ctNnpZM6H/dN1Xf4zrbvoRGd6tQndQZOVyPqi6LYsQy9ndwTQzETGCPbL/w2JUOwMm49C8yn4F7nSUjNdsO7jKh3sk7JiQJn94vOxZeVuogfmcK7Lm+Ei38dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009592; c=relaxed/simple;
	bh=TtnZBTASvLhdRRLZiwEu/JWKL5OFEkyqkcVu21bPEaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0cw4YZIPGwI7wTN8qIxGU9j3jtxAyToi5r79z0k+bF3ywy7l4Ta57o5ZD54BttX7P5/TuO1GEQnlY1iumPqbZZWD8UkLUjFO50O2/pn6oWxSgkqjKXxNw05GvgGmff7xiV9iNSMqY49GIf/oEjyqEk1nyaCntExAGp2X9THNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRSpgTW8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so3227126a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009589; x=1758614389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIHjXFWbOKCITt8QPNNKdlOfY3f92cfnrG7nxMx9n6o=;
        b=hRSpgTW8QwBEpFUVrXdwAyq8tiRO17oRNn/vqHiy+uBRSlNY5kAOnEUrDP9BVBaLpM
         gMmi5qlpmCZKzVdJZ2ETktdzWe+5mVoT6NVTCLQBSE34xOyeGrBVLjYvSrspbNoggTAT
         EiFUZhLYVaDSI6EZm7S4QJ6McJxqUMGPxkIspUGqmR3o4DnnrnQcELwQVuIhG1cUvCS/
         8/j4of5rnfyW26aistSqogwZyVpZqldUcywM1TJ14rCSlPH3+fa8VJGiJfQwnu4vqGiT
         qdiX1mS/eFyaEio4OSLQtXENUYMl0PuTs3S9fRXOaWd/vkMXofJqw/PthJMypnsEVvRe
         8SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009589; x=1758614389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIHjXFWbOKCITt8QPNNKdlOfY3f92cfnrG7nxMx9n6o=;
        b=i1Qdb6Rm5VcVpRrk9AxrCCogHJnwgvLPebUyswN6cq/D5d79SzC4NrpQiTus/cinN1
         4ebn/zpl8jHCxizqzFl0I40K/TL1U9j7l2zsgD1jCen/FGkMs0kUsNcCA7Z8Q5z0p+M3
         1rlF9395spsiAkhKXonNY3rrEsFy7e7TswXR6AHUIMxI3Plmfbd6PRvevs9y3/MmOZLV
         0pZD1WYiZnDCcyvqwcQ6LZ5nIlJjx8hMRQXas8aBgjU9CWtp62Bn/p/lgSEcOYu+gFUG
         wXuTAQwDqeKsozX6utjlQzdEz79HOXZ5S/ieY8p72jA84mP5IvsoZ6bOiUHdcF0y7t9v
         Mclw==
X-Forwarded-Encrypted: i=1; AJvYcCVNW2cnX1JfjS9pE+osbK4znW0NHwLSoRsCaS4ftvRDxe/CAr2qtF2TbXRSVjUWb6BmDxOAWvin0HQFt8s9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xgE70tu3rjym/rLsh1qMLthCbRBg+7YuXek4Tr4dVHMRZ0U5
	NArOgF2pWMimNHwZylfeJtfPWseFRrth64Y47aszhU2/vh/C1GeBqHw3goFJb+mH26mLW4VpX12
	4UNR5eTprAVxrkp3pN0Iz5Vw0KORSQFgTGkLE9nU=
X-Gm-Gg: ASbGncsXdsKxZPjiN0PmnDX4AEKqHIU/NZTXt4lZ/Hpj9RQB46EcdemSKGEIPThPotP
	U8TxxDW1AoL/6mluNFNaH3z6CqpzcdmTRV2QZbw9Sep3SXUxvzYwwi/XgeypVl5U98+UJLBDSsA
	GgRvYwcfK++Jzf3N+2GJ6imiwxcPyQQj6JIx1axda2JcjKr1UY8qHVWMbcof7DdLMnALc9CLVTk
	IEXC3KXM2Z+Whhhw+CZVUlL3WwpVgXut+Qljjhzcg==
X-Google-Smtp-Source: AGHT+IHd6fXhtt4yBjMo9KJEDYXunMMdmxQDJxbW+f0rTHOPS5NJ+zw34QVkzeoHN3EPo2wEvEleYNLZFtx83712wSs=
X-Received: by 2002:a05:6402:35cc:b0:62f:259f:af43 with SMTP id
 4fb4d7f45d1cf-62f259fb180mr8593437a12.17.1758009588562; Tue, 16 Sep 2025
 00:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731130458.GE273706@mit.edu> <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com> <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com> <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com> <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
In-Reply-To: <20250916025341.GO1587915@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Sep 2025 09:59:36 +0200
X-Gm-Features: AS18NWCpeTG2b8ETVNvhbEv8NvuXpcOrguQdTZuibDiO29yM2fGcCRTwlek8bHY
Message-ID: <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
> > On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> > >
> > >
> > >
> > > On 9/15/25 09:07, Amir Goldstein wrote:
> > > > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > >>
> > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> > > >>>
> > > >>>
> > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
> > > >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@b=
sbernd.com> wrote:
> > > >>>>>
> > > >>>>>
> > > >>>>>
> > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
> > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> > > >>>>>>
> > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote=
:
> > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wr=
ote:
> > > >>>>>>>>>
> > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty=
 if libfuse
> > > >>>>>>>>> could restart itself.  It's unclear if doing so will actual=
ly enable us
> > > >>>>>>>>> to clear the condition that caused the failure in the first=
 place, but I
> > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe r=
estarts
> > > >>>>>>>>> aren't totally crazy.
> > > >>>>>>>>
> > > >>>>>>>> I'm trying to understand what the failure scenario is here. =
 Is this
> > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  I=
f so, what
> > > >>>>>>>> is supposed to happen with respect to open files, metadata a=
nd data
> > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs co=
uld run
> > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that=
's going
> > > >>>>>>>> potentally to be out of sync, right?
> > > >>>>>>>>
> > > >>>>>>>> What are the recovery semantics that we hope to be able to p=
rovide?
> > > >>>>>>>
> > > >>>>>>> <echoing what we said on the ext4 call this morning>
> > > >>>>>>>
> > > >>>>>>> With iomap, most of the dirty state is in the kernel, so I th=
ink the new
> > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTA=
RTED, which
> > > >>>>>>> would initiate GETATTR requests on all the cached inodes to v=
alidate
> > > >>>>>>> that they still exist; and then resend all the unacknowledged=
 requests
> > > >>>>>>> that were pending at the time.  It might be the case that you=
 have to
> > > >>>>>>> that in the reverse order; I only know enough about the desig=
n of fuse
> > > >>>>>>> to suspect that to be true.
> > > >>>>>>>
> > > >>>>>>> Anyhow once those are complete, I think we can resume operati=
ons with
> > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR revalid=
ation are
> > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
> > > >>>>>>
> > > >>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP=
 requests,
> > > >>>>>> but probably GETATTR is a better option.
> > > >>>>>>
> > > >>>>>> So, are you currently working on any of this?  Are you impleme=
nting this
> > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to hav=
e a closer
> > > >>>>>> look at fuse2fs too.
> > > >>>>>
> > > >>>>> Sorry for joining the discussion late, I was totally occupied, =
day and
> > > >>>>> night. Added Kevin to CC, who is going to work on recovery on o=
ur
> > > >>>>> DDN side.
> > > >>>>>
> > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, but on =
fuse
> > > >>>>> server restart we want kernel to recover inodes and their looku=
p count.
> > > >>>>> Now inode recovery might be hard, because we currently only hav=
e a
> > > >>>>> 64-bit node-id - which is used my most fuse application as memo=
ry
> > > >>>>> pointer.
> > > >>>>>
> > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just=
 re-sends
> > > >>>>> outstanding requests. And that ends up in most cases in sending=
 requests
> > > >>>>> with invalid node-IDs, that are casted and might provoke random=
 memory
> > > >>>>> access on restart. Kind of the same issue why fuse nfs export o=
r
> > > >>>>> open_by_handle_at doesn't work well right now.
> > > >>>>>
> > > >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, =
which
> > > >>>>> would not return a 64-bit node ID, but a max 128 byte file hand=
le.
> > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
> > > >>>>> The file handles could be stored into the fuse inode and also u=
sed for
> > > >>>>> NFS export.
> > > >>>>>
> > > >>>>> I *think* Amir had a similar idea, but I don't find the link qu=
ickly.
> > > >>>>> Adding Amir to CC.
> > > >>>>
> > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling=
 thread:
> > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTO=
YNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> > > >>>
> > > >>> Thanks for the reference Amir! I even had been in that thread.
> > > >>>
> > > >>>>
> > > >>>>>
> > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTAR=
T, which
> > > >>>>> will iterate over all superblock inodes and mark them with fuse=
_make_bad.
> > > >>>>> Any objections against that?
> > > >>
> > > >> What if you actually /can/ reuse a nodeid after a restart?  Consid=
er
> > > >> fuse4fs, where the nodeid is the on-disk inode number.  After a re=
start,
> > > >> you can reconnect the fuse_inode to the ondisk inode, assuming rec=
overy
> > > >> didn't delete it, obviously.
> > > >
> > > > FUSE_LOOKUP_HANDLE is a contract.
> > > > If fuse4fs can reuse nodeid after restart then by all means, it sho=
uld sign
> > > > this contract, otherwise there is no way for client to know that th=
e
> > > > nodeids are persistent.
> > > > If fuse4fs_handle :=3D nodeid, that will make implementing the look=
up_handle()
> > > > API trivial.
> > > >
> > > >>
> > > >> I suppose you could just ask for refreshed stat information and ei=
ther
> > > >> the server gives it to you and the fuse_inode lives; or the server
> > > >> returns ENOENT and then we mark it bad.  But I'd have to see code
> > > >> patches to form a real opinion.
> > > >>
> > > >
> > > > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
> > > > where fuse_instance_id can be its start time or random number.
> > > > for auto invalidate, or maybe the fuse_instance_id should be
> > > > a native part of FUSE protocol so that client knows to only invalid=
ate
> > > > attr cache in case of fuse_instance_id change?
> > > >
> > > > In any case, instead of a storm of revalidate messages after
> > > > server restart, do it lazily on demand.
> > >
> > > For a network file system, probably. For fuse4fs or other block
> > > based file systems, not sure. Darrick has the example of fsck.
> > > Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
> > > fuse-server gets restarted, fsck'ed and some files get removed.
> > > Now reading these inodes would still work - wouldn't it
> > > be better to invalidate the cache before going into operation
> > > again?
> >
> > Forgive me, I was making a wrong assumption that fuse4fs
> > was using ext4 filehandle as nodeid, but of course it does not.
>
> Well now that you mention it, there /is/ a risk of shenanigans like
> that.  Consider:
>
> 1) fuse4fs mount an ext4 filesystem
> 2) crash the fuse4fs server
> <fuse4fs server restart stalls...>
> 3) e2fsck -fy /dev/XXX deletes inode 17
> 4) someone else mounts the fs, makes some changes that result in 17
>    being reallocated, user says "OOOOOPS", unmounts it
> 5) fuse4fs server finally restarts, and reconnects to the kernel
>
> Hey, inode 17 is now a different file!!
>
> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
> everything's (potentially) fine because fuse4fs supplied i_generation to
> the kernel, and fuse_stale_inode will mark it bad if that happens.
>
> Hm ok then, at least there's a way out. :)
>

Right.

> > The reason I made this wrong assumption is because fuse4fs *can*
> > already use ext4 (64bit) file handle as nodeid, with existing FUSE prot=
ocol
> > which is what my fuse passthough library [1] does.
> >
> > My claim was that although fuse4fs could support safe restart, which
> > cannot read from recycled inode number with current FUSE protocol,
> > doing so with FUSE_HANDLE protocol would express a commitment
>
> Pardon my na=C3=AFvete, but what is FUSE_HANDLE?
>
> $ git grep -w FUSE_HANDLE fs
> $

Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yU=
Y4L2JRAEKxEwOQ@mail.gmail.com/

Which means to communicate a variable sized "nodeid"
which can also be declared as an object id that survives server restart.

Basically, the reason that I brought up LOOKUP_HANDLE is to
properly support NFS export of fuse filesystems.

My incentive was to support a proper fuse server restart/remount/re-export
with the same fsid in /etc/exports, but this gives us a better starting poi=
nt
for fuse server restart/re-connect.

Thanks,
Amir.

