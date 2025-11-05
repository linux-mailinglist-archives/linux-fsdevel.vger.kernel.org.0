Return-Path: <linux-fsdevel+bounces-67090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC93C35139
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113404EF17D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD073009CA;
	Wed,  5 Nov 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRj+StZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5C2FFDDC
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338090; cv=none; b=jPp8y5KxLKhsaJUGrXE2SjCRbEBE244VdsQzeIhhSAgHLbrC5mWZ/IyJPDkdsIFwP2lymv46W2zrqq7G/m65e9vejIPS41VQtXVy0vrQuPrzfx7VB/1i1I9vvra3so2eQhWfGDk+kQflViY7p5cOyfRMbYnayP3GuqNXd/h8jZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338090; c=relaxed/simple;
	bh=cE9UkL3olCKyLsDRjYoPL7A+zZaHis/WmZfqvVo1EXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXoqCuyZrQrmGfhT/xhc2H6mnNpuJDZQ/asSix17tXyxeLeChQmI4dmV0gPoyiTKM56n7JIWjbuu5OtbFzFOgO4sm4MuvagX6ALfOz2SIkyOqJ0OeugsE9HCZRD7MRxQcCTbWXevELovw8o3MgJeBTi+cxfXJG+eLgX0TMJmF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRj+StZ+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so1812785a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 02:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762338087; x=1762942887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5usDB8bQcdIa15TdZFyLcSseHaVIP4sZb3586VqZxHA=;
        b=MRj+StZ+Xbv3IaHbcmJTuYCSH5Uws5t+3g0iBI9zfxIvfdkr1Gs+f/P7WIKydEJRfc
         RywfC/ab2D4jlvmFPJlh2MAnvLTWskQreKXcSYQyerJQNMutCPCCJ5jR6o5vD8AaF06W
         7km5fcxmQMEQXMscw1bOD7awKS6izN3NGjsYMmefm2AiHrleWSEIvpsOeq+mtI96UpSP
         WlbHCTyfHJ10ywQvD7AyL1U9rMW6qsiJwgaB04E7eD6TClVP9Bce9bM3VCQQO/e8Azjt
         1Qm6yFHvRuX2SlPIHZ4F8B96DPoO2BFFgzGfP5JwC8Xl2tSBLwwSwQJygsKEk2RDFxtI
         Zpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338087; x=1762942887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5usDB8bQcdIa15TdZFyLcSseHaVIP4sZb3586VqZxHA=;
        b=IqazLc8y8YECfLU1np9gyqVidYDFJH6Z7d9VdfamCxgCrQHNqOJz/hyxMRRfVvBhZW
         solYXA8KxqQZsKRsqNpWLF1TImyKIWebo01Wsu3PtnvQTUi7AkCJl6T26V02qkCS0RF7
         W/HaoANiTZXxD3DGPJVfjEicXi56PKQ2mscBX8oKCg4Q2/hMKaOOmpGIa01GQRERel3W
         ksS7vkQBG6TgmRXakcdbU5Ia4Bo6HSWm6NF9PaL0IuZNbuHBS2ZXHVMexAP5lLhdzy6j
         bGeICs4GWbR8JMz7DM9Pt50P/Ajjp//Pro97ceUzbL6dZklxdA2nHRmrTiqp+d3AZLSS
         +rsg==
X-Forwarded-Encrypted: i=1; AJvYcCUeMWWFH2ukyda9VDpG7rA0pjLpxiQDxtCh+1tp7Y79NVWOV8O2ZojUPNrrgefV+NL90YFlUPCpLJm5dEwN@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYeuGpN2aEJTZXSksCyLWu99MG77NsDYPRfe3otbX0/K6CGam
	MNHnn0y0TywNHHhkjGDNWZcpQ0uvXz7OVQxDwxUUx7Dn2qIXo3dqb8fQA1ftm7f313wbzyVnh2Q
	ZZMO8qssMGDEPZhQWm3LJsNuTQi1XjNM=
X-Gm-Gg: ASbGncuj19tQY9imwNzUvYkVAHXA8z2ambdoXlL4aiaM+pG1JOSgAMvX7kekGn6xh8C
	jUxuHj7g8m1jlr4RMFSkxGGDiSoQRjwPhAJwCngHQ78ljBIXwNWmk18Vaoea8svdvsePwQRhNcf
	AlKoEzvkknTEeeTtjHTbsUPidZA05hec6dxoiQcxpJnLEY4DEPzbwOqNF5SHsQwxphnSl5W+NKp
	w4P7e/WVhoHUu34pDyFvKuPqnhVpLmfY7HAYvIbskdxiBbT9uGG1YHIJYHIy5EDaLJa8Agsag4d
	HbhQaduPLeMf7UigQB4=
X-Google-Smtp-Source: AGHT+IGZSu6v4RXJHL22KuWaWPH3d61zIIo69rows/UjIRH9ZOJdu8oMuC7usz7GCUKtM96TjCd8oAy/8cou53pKZ84=
X-Received: by 2002:a17:906:6a04:b0:b70:ac48:db8d with SMTP id
 a640c23a62f3a-b72652bfb58mr262860566b.28.1762338086534; Wed, 05 Nov 2025
 02:21:26 -0800 (PST)
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
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <87cy5x7sud.fsf@wotan.olymp>
In-Reply-To: <87cy5x7sud.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Nov 2025 11:21:14 +0100
X-Gm-Features: AWmQ_blxgcaN_LBKZ2KWjl3dDFn0eFkYGIBHf2dFbeb64V0R2xlyJ1gjtLvm4Lk
Message-ID: <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Luis Henriques <luis@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM Luis Henriques <luis@igalia.com> wro=
te:
>
> On Tue, Nov 04 2025, Amir Goldstein wrote:
>
> > On Tue, Nov 4, 2025 at 12:40=E2=80=AFPM Luis Henriques <luis@igalia.com=
> wrote:
> >>
> >> On Tue, Sep 16 2025, Amir Goldstein wrote:
> >>
> >> > On Tue, Sep 16, 2025 at 4:53=E2=80=AFAM Darrick J. Wong <djwong@kern=
el.org> wrote:
> >> >>
> >> >> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
> >> >> > On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bs=
bernd.com> wrote:
> >> >> > >
> >> >> > >
> >> >> > >
> >> >> > > On 9/15/25 09:07, Amir Goldstein wrote:
> >> >> > > > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwo=
ng@kernel.org> wrote:
> >> >> > > >>
> >> >> > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wro=
te:
> >> >> > > >>>
> >> >> > > >>>
> >> >> > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
> >> >> > > >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <b=
ernd@bsbernd.com> wrote:
> >> >> > > >>>>>
> >> >> > > >>>>>
> >> >> > > >>>>>
> >> >> > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
> >> >> > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >> >> > > >>>>>>
> >> >> > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o=
 wrote:
> >> >> > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. W=
ong wrote:
> >> >> > > >>>>>>>>>
> >> >> > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda=
 nifty if libfuse
> >> >> > > >>>>>>>>> could restart itself.  It's unclear if doing so will =
actually enable us
> >> >> > > >>>>>>>>> to clear the condition that caused the failure in the=
 first place, but I
> >> >> > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So m=
aybe restarts
> >> >> > > >>>>>>>>> aren't totally crazy.
> >> >> > > >>>>>>>>
> >> >> > > >>>>>>>> I'm trying to understand what the failure scenario is =
here.  Is this
> >> >> > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crash=
ed?  If so, what
> >> >> > > >>>>>>>> is supposed to happen with respect to open files, meta=
data and data
> >> >> > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse=
2fs could run
> >> >> > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system=
, that's going
> >> >> > > >>>>>>>> potentally to be out of sync, right?
> >> >> > > >>>>>>>>
> >> >> > > >>>>>>>> What are the recovery semantics that we hope to be abl=
e to provide?
> >> >> > > >>>>>>>
> >> >> > > >>>>>>> <echoing what we said on the ext4 call this morning>
> >> >> > > >>>>>>>
> >> >> > > >>>>>>> With iomap, most of the dirty state is in the kernel, s=
o I think the new
> >> >> > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY=
_RESTARTED, which
> >> >> > > >>>>>>> would initiate GETATTR requests on all the cached inode=
s to validate
> >> >> > > >>>>>>> that they still exist; and then resend all the unacknow=
ledged requests
> >> >> > > >>>>>>> that were pending at the time.  It might be the case th=
at you have to
> >> >> > > >>>>>>> that in the reverse order; I only know enough about the=
 design of fuse
> >> >> > > >>>>>>> to suspect that to be true.
> >> >> > > >>>>>>>
> >> >> > > >>>>>>> Anyhow once those are complete, I think we can resume o=
perations with
> >> >> > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR r=
evalidation are
> >> >> > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
> >> >> > > >>>>>>
> >> >> > > >>>>>> Ah! Interesting, I have been playing a bit with sending =
LOOKUP requests,
> >> >> > > >>>>>> but probably GETATTR is a better option.
> >> >> > > >>>>>>
> >> >> > > >>>>>> So, are you currently working on any of this?  Are you i=
mplementing this
> >> >> > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me =
to have a closer
> >> >> > > >>>>>> look at fuse2fs too.
> >> >> > > >>>>>
> >> >> > > >>>>> Sorry for joining the discussion late, I was totally occu=
pied, day and
> >> >> > > >>>>> night. Added Kevin to CC, who is going to work on recover=
y on our
> >> >> > > >>>>> DDN side.
> >> >> > > >>>>>
> >> >> > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, b=
ut on fuse
> >> >> > > >>>>> server restart we want kernel to recover inodes and their=
 lookup count.
> >> >> > > >>>>> Now inode recovery might be hard, because we currently on=
ly have a
> >> >> > > >>>>> 64-bit node-id - which is used my most fuse application a=
s memory
> >> >> > > >>>>> pointer.
> >> >> > > >>>>>
> >> >> > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that i=
t just re-sends
> >> >> > > >>>>> outstanding requests. And that ends up in most cases in s=
ending requests
> >> >> > > >>>>> with invalid node-IDs, that are casted and might provoke =
random memory
> >> >> > > >>>>> access on restart. Kind of the same issue why fuse nfs ex=
port or
> >> >> > > >>>>> open_by_handle_at doesn't work well right now.
> >> >> > > >>>>>
> >> >> > > >>>>> So IMHO, what we really want is something like FUSE_LOOKU=
P_FH, which
> >> >> > > >>>>> would not return a 64-bit node ID, but a max 128 byte fil=
e handle.
> >> >> > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
> >> >> > > >>>>> The file handles could be stored into the fuse inode and =
also used for
> >> >> > > >>>>> NFS export.
> >> >> > > >>>>>
> >> >> > > >>>>> I *think* Amir had a similar idea, but I don't find the l=
ink quickly.
> >> >> > > >>>>> Adding Amir to CC.
> >> >> > > >>>>
> >> >> > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this r=
olling thread:
> >> >> > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6=
quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >> >> > > >>>
> >> >> > > >>> Thanks for the reference Amir! I even had been in that thre=
ad.
> >> >> > > >>>
> >> >> > > >>>>
> >> >> > > >>>>>
> >> >> > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_=
RESTART, which
> >> >> > > >>>>> will iterate over all superblock inodes and mark them wit=
h fuse_make_bad.
> >> >> > > >>>>> Any objections against that?
> >> >> > > >>
> >> >> > > >> What if you actually /can/ reuse a nodeid after a restart?  =
Consider
> >> >> > > >> fuse4fs, where the nodeid is the on-disk inode number.  Afte=
r a restart,
> >> >> > > >> you can reconnect the fuse_inode to the ondisk inode, assumi=
ng recovery
> >> >> > > >> didn't delete it, obviously.
> >> >> > > >
> >> >> > > > FUSE_LOOKUP_HANDLE is a contract.
> >> >> > > > If fuse4fs can reuse nodeid after restart then by all means, =
it should sign
> >> >> > > > this contract, otherwise there is no way for client to know t=
hat the
> >> >> > > > nodeids are persistent.
> >> >> > > > If fuse4fs_handle :=3D nodeid, that will make implementing th=
e lookup_handle()
> >> >> > > > API trivial.
> >> >> > > >
> >> >> > > >>
> >> >> > > >> I suppose you could just ask for refreshed stat information =
and either
> >> >> > > >> the server gives it to you and the fuse_inode lives; or the =
server
> >> >> > > >> returns ENOENT and then we mark it bad.  But I'd have to see=
 code
> >> >> > > >> patches to form a real opinion.
> >> >> > > >>
> >> >> > > >
> >> >> > > > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
> >> >> > > > where fuse_instance_id can be its start time or random number=
.
> >> >> > > > for auto invalidate, or maybe the fuse_instance_id should be
> >> >> > > > a native part of FUSE protocol so that client knows to only i=
nvalidate
> >> >> > > > attr cache in case of fuse_instance_id change?
> >> >> > > >
> >> >> > > > In any case, instead of a storm of revalidate messages after
> >> >> > > > server restart, do it lazily on demand.
> >> >> > >
> >> >> > > For a network file system, probably. For fuse4fs or other block
> >> >> > > based file systems, not sure. Darrick has the example of fsck.
> >> >> > > Let's assume fuse4fs runs with attribute and dentry timeouts > =
0,
> >> >> > > fuse-server gets restarted, fsck'ed and some files get removed.
> >> >> > > Now reading these inodes would still work - wouldn't it
> >> >> > > be better to invalidate the cache before going into operation
> >> >> > > again?
> >> >> >
> >> >> > Forgive me, I was making a wrong assumption that fuse4fs
> >> >> > was using ext4 filehandle as nodeid, but of course it does not.
> >> >>
> >> >> Well now that you mention it, there /is/ a risk of shenanigans like
> >> >> that.  Consider:
> >> >>
> >> >> 1) fuse4fs mount an ext4 filesystem
> >> >> 2) crash the fuse4fs server
> >> >> <fuse4fs server restart stalls...>
> >> >> 3) e2fsck -fy /dev/XXX deletes inode 17
> >> >> 4) someone else mounts the fs, makes some changes that result in 17
> >> >>    being reallocated, user says "OOOOOPS", unmounts it
> >> >> 5) fuse4fs server finally restarts, and reconnects to the kernel
> >> >>
> >> >> Hey, inode 17 is now a different file!!
> >> >>
> >> >> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
> >> >> everything's (potentially) fine because fuse4fs supplied i_generati=
on to
> >> >> the kernel, and fuse_stale_inode will mark it bad if that happens.
> >> >>
> >> >> Hm ok then, at least there's a way out. :)
> >> >>
> >> >
> >> > Right.
> >> >
> >> >> > The reason I made this wrong assumption is because fuse4fs *can*
> >> >> > already use ext4 (64bit) file handle as nodeid, with existing FUS=
E protocol
> >> >> > which is what my fuse passthough library [1] does.
> >> >> >
> >> >> > My claim was that although fuse4fs could support safe restart, wh=
ich
> >> >> > cannot read from recycled inode number with current FUSE protocol=
,
> >> >> > doing so with FUSE_HANDLE protocol would express a commitment
> >> >>
> >> >> Pardon my na=C3=AFvete, but what is FUSE_HANDLE?
> >> >>
> >> >> $ git grep -w FUSE_HANDLE fs
> >> >> $
> >> >
> >> > Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
> >> > https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkA=
P8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >> >
> >> > Which means to communicate a variable sized "nodeid"
> >> > which can also be declared as an object id that survives server rest=
art.
> >> >
> >> > Basically, the reason that I brought up LOOKUP_HANDLE is to
> >> > properly support NFS export of fuse filesystems.
> >> >
> >> > My incentive was to support a proper fuse server restart/remount/re-=
export
> >> > with the same fsid in /etc/exports, but this gives us a better start=
ing point
> >> > for fuse server restart/re-connect.
> >>
> >> Sorry for resurrecting (again!) this discussion.  I've been thinking a=
bout
> >> this, and trying to get some initial RFC for this LOOKUP_HANDLE operat=
ion.
> >> However, I feel there are other operations that will need to return th=
is
> >> new handle.
> >>
> >> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
> >> Doesn't this means that, if the user-space server supports the new
> >> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
> >> request?
> >
> > Yes, I think that's what it means.
>
> Awesome, thank you for confirming this.
>
> >> The same question applies for TMPFILE, LINK, etc.  Or is there
> >> something special about the LOOKUP operation that I'm missing?
> >>
> >
> > Any command returning fuse_entry_out.
> >
> > READDIRPLUS, MKNOD, MKDIR, SYMLINK
>
> Right, I had this list, but totally missed READDIRPLUS.
>
> > fuse_entry_out was extended once and fuse_reply_entry()
> > sends the size of the struct.
>
> So, if I'm understanding you correctly, you're suggesting to extend
> fuse_entry_out to add the new handle (a 'size' field + the actual handle)=
.

Well it depends...

There are several ways to do it.
I would really like to get Miklos and Bernd's opinion on the preferred way.

So far, it looks like the client determines the size of the output args.

If we want the server to be able to write a different file handle size
per inode that's going to be a bigger challenge.

I think it's plenty enough if server and client negotiate a max file handle
size and then the client always reserves enough space in the output
args buffer.

One more thing to ask is what is "the actual handle".
If "the actual handle" is the variable sized struct file_handle then
the size is already available in the file handle header.
If it is not, then I think some sort of type or version of the file handles
encoding should be negotiated beyond the max handle size.

> That's probably a good idea.  I was working towards having the
> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
> include:
>
>  - An extra inarg: the parent directory handle.  (To be honest, I'm not
>    really sure this would be needed.)

Yes, I think you need extra inarg.
Why would it not be needed?
The problem is that you cannot know if the parent node id in the lookup
command is stale after server restart.

The thing is that the kernel fuse inode will need to store the file handle,
much the same as an NFS client stores the file handle provided by the
NFS server.

FYI, fanotify has an optimized way to store file handles in
struct fanotify_fid_event - small file handles are stored inline
and larger file handles can use an external buffer.

But fuse does not need to support any size of file handles.
For first version we could definitely simplify things by limiting the size
of supported file handles, because server and client need to negotiate
the max file handle size anyway.

>  - An extra outarg: for the actual handle.
>
> With your suggestion, only the extra inarg would be required.
>

Yes, either extra arg or just an extended size of fuse_entry_out
negotiated at init time.

TBH it seems cleaner to add 2nd outarg to all the commands,
but CREATE already has a 2nd arg and 2nd arg does not solve
READDIRPLUS.

> > However fuse_reply_create() sends it with fuse_open_out
> > appended
>
> This one should be fine...
>
> > and fuse_add_direntry_plus() does not seem to write
> > record size at all, so server and client will need to agree on the
> > size of fuse_entry_out and this would need to be backward compat.
> > If both server and client declare support for FUSE_LOOKUP_HANDLE
> > it should be fine (?).
>
> ... yeah, this could be a bit trickier.  But I'll need to go look into it=
.
>
> Thanks a lot for your comments, Amir.  I was trying to get an RFC out
> soon(ish) to get early feedback, hoping to prevent me following wrong
> paths.
>

Disclaimer, following my advice may well lead you down wrong paths..
Best to wait for confirmation from Miklos and Bernd if you want to have
more certainty...

Thanks,
Amir.

