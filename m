Return-Path: <linux-fsdevel+bounces-66955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA1C3130E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 14:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 337014FC3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A892F8BF1;
	Tue,  4 Nov 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3k5xJIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00C2F39C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261848; cv=none; b=Wqn5L1m5J66i6m7yLWnxbX56wJHm6t+3Tg2DHEWuPtkDFQjZLmoTvDOQa2FwzzB7i0I15tfU+AOkmlCEAYwYisFDzN4xHjOJbh3UiY8gglPFtn3RIaZJj8+ZVLE84xHNPqze5KBoAW6+s6DNPvPVHH4J+OcONl/ZSn6vUxCMqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261848; c=relaxed/simple;
	bh=VhkhzmMcv/smNo1A6jxBdqBtG3BBvfXHku9Ydct+gvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tsg9ocIp0pQdevvkMwKDbLV7AYGD14+RZebhORv3ZkUoCPP+jqG65yO/HZdH/30KH1Ctlm+gwMjLtmdb0jl8bLpFdl8QsUZ0ZgnW2IIvlN4m6Jc15OnFVRxviGIFsBg2NXSqymuYVQgbTILtfPwEiLLtFCOOlTx0fpYsJUpRe3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3k5xJIu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso1328635266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762261844; x=1762866644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eb6Fhw+jGRkyT5hVdQ02opkzhktDn8toH3DgzCieb8=;
        b=O3k5xJIu+oHsP1/3R52d84SbcFpm0IY+zXzKz2FzhE6FUvvAn5ULHBU/OZuLwpuFNO
         yrsiC5XevLasctWeQbMRLglZNTGuN9C2JxB/5zZzU3snjIos0Wg1v7ldxC3R9tPCR+Nd
         3lVmZ0x1WAleZoxU7vUjuZPOTpBR8I1GE2iTigfrgje1TQlqpON0End6ENqg359M0Xnn
         QhddCguZGTjSwxurswyEaYOuQfqeelUBOC42g5+yi80eS+ixKIRjBwoRzbGz9uivipw8
         aPmgXIirLV3IRl+9DyqiHR54WC6Xw+xa/ASUnonuvWl1W289hGEk403NveV0wlmlpmzE
         7i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261844; x=1762866644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eb6Fhw+jGRkyT5hVdQ02opkzhktDn8toH3DgzCieb8=;
        b=hZ7MmDTz4NoYfK6/vlwD6gbqrRlQjZT8qHAAgbIESH3dXKXpsLzHHzEI4GGMl//x1k
         siQuIahbf7LqSKNf2EF8jhHeXaOSfD7ouUqEbSl3LIZtYIN+RUe5wCFuxcgJWY915dcw
         wTt0emDNYzUAYAO2M2OWj16LlHG1sG6sH4eK6GSAoOX66NRQ5JWzJQ92JGoX1Nvmeke9
         dyANJU9/Drje7hONUhjHJWADQM6hhg0+LtbaEEYrHpKB2VVXGFAAKHQEaAsi51Q2GOgZ
         9+z1O2nR2VacapjIRy1hJrXvgAApffcGdNdTJ4UiF8LMCmWdUqfhNDbQQLpKxtJknuol
         MCmg==
X-Forwarded-Encrypted: i=1; AJvYcCWYIBLIhD0MvLSAjiLIq5ruudZJoa5FNUSBSSNZTVLhi8U4fi0ZAQzIWDxLC+Ir1yOKOAQbJWZeDLBtyO+o@vger.kernel.org
X-Gm-Message-State: AOJu0YwzyDlz/8VBoFkhUeIIwYAP0Dougx9XAGDzpT+7sloicuX+rG7x
	8T6qpQbuyet7uYuXktZxMl+upEV1qjCeJTDVejR2bdOxMZfyCjr0zFz7bqHb/aB5TzDYbTRyxLP
	rr8xaJCV1TvSw77+Hc2dHerryRx0GcckQBh4PEVW6AQ==
X-Gm-Gg: ASbGncsqMYlM/jznLT1gmqx8eiUPZtKWznbTwj2hcnW52S2wph3lXgUd0myQv+sbyyj
	ZphOsiBqZCH9Llzsj/Qf3iJx9zL9jAytgLImV+HjW4IBQmmyFw9FkvJXAbWTn5TcDFCA3ABLTl2
	E+4YroeskHUI4tIechPOwETY2qJ4hphP136KfX2FPf1f/bE8hJtCIHKoYxWaDWQTjdHY9pnBa3c
	ARMaTv2cI2+zDo9X3XJZO0p2pJp+AJd5Oa2nBsxhG5nInQpFhfmt3f4nR8Y2jFbJ/gwYLmLHDyJ
	0xedmMDR3rIHpKu1tcM=
X-Google-Smtp-Source: AGHT+IH/2pUqmrN7VPU+SV+aH7vEEkumO/C5X2+je2g5UclR15/R3ZrjFYbk+o6g4UsV/+K6ojEY6+j2fKHiandD2bA=
X-Received: by 2002:a17:907:dac:b0:b70:aebe:2ef7 with SMTP id
 a640c23a62f3a-b7215bd8863mr352109666b.14.1762261844201; Tue, 04 Nov 2025
 05:10:44 -0800 (PST)
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
 <87ldkm6n5o.fsf@wotan.olymp>
In-Reply-To: <87ldkm6n5o.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Nov 2025 14:10:32 +0100
X-Gm-Features: AWmQ_bly3rdIxKic-xmn_OHbdNdph66vGTwjjJ4W0ydit2BdioRiiUqo7v_TbMk
Message-ID: <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Luis Henriques <luis@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:40=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> On Tue, Sep 16 2025, Amir Goldstein wrote:
>
> > On Tue, Sep 16, 2025 at 4:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> >>
> >> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
> >> > On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bsber=
nd.com> wrote:
> >> > >
> >> > >
> >> > >
> >> > > On 9/15/25 09:07, Amir Goldstein wrote:
> >> > > > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong@=
kernel.org> wrote:
> >> > > >>
> >> > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> >> > > >>>
> >> > > >>>
> >> > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
> >> > > >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bern=
d@bsbernd.com> wrote:
> >> > > >>>>>
> >> > > >>>>>
> >> > > >>>>>
> >> > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
> >> > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >> > > >>>>>>
> >> > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wr=
ote:
> >> > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong=
 wrote:
> >> > > >>>>>>>>>
> >> > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda ni=
fty if libfuse
> >> > > >>>>>>>>> could restart itself.  It's unclear if doing so will act=
ually enable us
> >> > > >>>>>>>>> to clear the condition that caused the failure in the fi=
rst place, but I
> >> > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So mayb=
e restarts
> >> > > >>>>>>>>> aren't totally crazy.
> >> > > >>>>>>>>
> >> > > >>>>>>>> I'm trying to understand what the failure scenario is her=
e.  Is this
> >> > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?=
  If so, what
> >> > > >>>>>>>> is supposed to happen with respect to open files, metadat=
a and data
> >> > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs=
 could run
> >> > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, t=
hat's going
> >> > > >>>>>>>> potentally to be out of sync, right?
> >> > > >>>>>>>>
> >> > > >>>>>>>> What are the recovery semantics that we hope to be able t=
o provide?
> >> > > >>>>>>>
> >> > > >>>>>>> <echoing what we said on the ext4 call this morning>
> >> > > >>>>>>>
> >> > > >>>>>>> With iomap, most of the dirty state is in the kernel, so I=
 think the new
> >> > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RE=
STARTED, which
> >> > > >>>>>>> would initiate GETATTR requests on all the cached inodes t=
o validate
> >> > > >>>>>>> that they still exist; and then resend all the unacknowled=
ged requests
> >> > > >>>>>>> that were pending at the time.  It might be the case that =
you have to
> >> > > >>>>>>> that in the reverse order; I only know enough about the de=
sign of fuse
> >> > > >>>>>>> to suspect that to be true.
> >> > > >>>>>>>
> >> > > >>>>>>> Anyhow once those are complete, I think we can resume oper=
ations with
> >> > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR reva=
lidation are
> >> > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
> >> > > >>>>>>
> >> > > >>>>>> Ah! Interesting, I have been playing a bit with sending LOO=
KUP requests,
> >> > > >>>>>> but probably GETATTR is a better option.
> >> > > >>>>>>
> >> > > >>>>>> So, are you currently working on any of this?  Are you impl=
ementing this
> >> > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to =
have a closer
> >> > > >>>>>> look at fuse2fs too.
> >> > > >>>>>
> >> > > >>>>> Sorry for joining the discussion late, I was totally occupie=
d, day and
> >> > > >>>>> night. Added Kevin to CC, who is going to work on recovery o=
n our
> >> > > >>>>> DDN side.
> >> > > >>>>>
> >> > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, but =
on fuse
> >> > > >>>>> server restart we want kernel to recover inodes and their lo=
okup count.
> >> > > >>>>> Now inode recovery might be hard, because we currently only =
have a
> >> > > >>>>> 64-bit node-id - which is used my most fuse application as m=
emory
> >> > > >>>>> pointer.
> >> > > >>>>>
> >> > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it j=
ust re-sends
> >> > > >>>>> outstanding requests. And that ends up in most cases in send=
ing requests
> >> > > >>>>> with invalid node-IDs, that are casted and might provoke ran=
dom memory
> >> > > >>>>> access on restart. Kind of the same issue why fuse nfs expor=
t or
> >> > > >>>>> open_by_handle_at doesn't work well right now.
> >> > > >>>>>
> >> > > >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_F=
H, which
> >> > > >>>>> would not return a 64-bit node ID, but a max 128 byte file h=
andle.
> >> > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
> >> > > >>>>> The file handles could be stored into the fuse inode and als=
o used for
> >> > > >>>>> NFS export.
> >> > > >>>>>
> >> > > >>>>> I *think* Amir had a similar idea, but I don't find the link=
 quickly.
> >> > > >>>>> Adding Amir to CC.
> >> > > >>>>
> >> > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this roll=
ing thread:
> >> > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quB=
aTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >> > > >>>
> >> > > >>> Thanks for the reference Amir! I even had been in that thread.
> >> > > >>>
> >> > > >>>>
> >> > > >>>>>
> >> > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_RES=
TART, which
> >> > > >>>>> will iterate over all superblock inodes and mark them with f=
use_make_bad.
> >> > > >>>>> Any objections against that?
> >> > > >>
> >> > > >> What if you actually /can/ reuse a nodeid after a restart?  Con=
sider
> >> > > >> fuse4fs, where the nodeid is the on-disk inode number.  After a=
 restart,
> >> > > >> you can reconnect the fuse_inode to the ondisk inode, assuming =
recovery
> >> > > >> didn't delete it, obviously.
> >> > > >
> >> > > > FUSE_LOOKUP_HANDLE is a contract.
> >> > > > If fuse4fs can reuse nodeid after restart then by all means, it =
should sign
> >> > > > this contract, otherwise there is no way for client to know that=
 the
> >> > > > nodeids are persistent.
> >> > > > If fuse4fs_handle :=3D nodeid, that will make implementing the l=
ookup_handle()
> >> > > > API trivial.
> >> > > >
> >> > > >>
> >> > > >> I suppose you could just ask for refreshed stat information and=
 either
> >> > > >> the server gives it to you and the fuse_inode lives; or the ser=
ver
> >> > > >> returns ENOENT and then we mark it bad.  But I'd have to see co=
de
> >> > > >> patches to form a real opinion.
> >> > > >>
> >> > > >
> >> > > > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
> >> > > > where fuse_instance_id can be its start time or random number.
> >> > > > for auto invalidate, or maybe the fuse_instance_id should be
> >> > > > a native part of FUSE protocol so that client knows to only inva=
lidate
> >> > > > attr cache in case of fuse_instance_id change?
> >> > > >
> >> > > > In any case, instead of a storm of revalidate messages after
> >> > > > server restart, do it lazily on demand.
> >> > >
> >> > > For a network file system, probably. For fuse4fs or other block
> >> > > based file systems, not sure. Darrick has the example of fsck.
> >> > > Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
> >> > > fuse-server gets restarted, fsck'ed and some files get removed.
> >> > > Now reading these inodes would still work - wouldn't it
> >> > > be better to invalidate the cache before going into operation
> >> > > again?
> >> >
> >> > Forgive me, I was making a wrong assumption that fuse4fs
> >> > was using ext4 filehandle as nodeid, but of course it does not.
> >>
> >> Well now that you mention it, there /is/ a risk of shenanigans like
> >> that.  Consider:
> >>
> >> 1) fuse4fs mount an ext4 filesystem
> >> 2) crash the fuse4fs server
> >> <fuse4fs server restart stalls...>
> >> 3) e2fsck -fy /dev/XXX deletes inode 17
> >> 4) someone else mounts the fs, makes some changes that result in 17
> >>    being reallocated, user says "OOOOOPS", unmounts it
> >> 5) fuse4fs server finally restarts, and reconnects to the kernel
> >>
> >> Hey, inode 17 is now a different file!!
> >>
> >> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
> >> everything's (potentially) fine because fuse4fs supplied i_generation =
to
> >> the kernel, and fuse_stale_inode will mark it bad if that happens.
> >>
> >> Hm ok then, at least there's a way out. :)
> >>
> >
> > Right.
> >
> >> > The reason I made this wrong assumption is because fuse4fs *can*
> >> > already use ext4 (64bit) file handle as nodeid, with existing FUSE p=
rotocol
> >> > which is what my fuse passthough library [1] does.
> >> >
> >> > My claim was that although fuse4fs could support safe restart, which
> >> > cannot read from recycled inode number with current FUSE protocol,
> >> > doing so with FUSE_HANDLE protocol would express a commitment
> >>
> >> Pardon my na=C3=AFvete, but what is FUSE_HANDLE?
> >>
> >> $ git grep -w FUSE_HANDLE fs
> >> $
> >
> > Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
> > https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W=
_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >
> > Which means to communicate a variable sized "nodeid"
> > which can also be declared as an object id that survives server restart=
.
> >
> > Basically, the reason that I brought up LOOKUP_HANDLE is to
> > properly support NFS export of fuse filesystems.
> >
> > My incentive was to support a proper fuse server restart/remount/re-exp=
ort
> > with the same fsid in /etc/exports, but this gives us a better starting=
 point
> > for fuse server restart/re-connect.
>
> Sorry for resurrecting (again!) this discussion.  I've been thinking abou=
t
> this, and trying to get some initial RFC for this LOOKUP_HANDLE operation=
.
> However, I feel there are other operations that will need to return this
> new handle.
>
> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
> Doesn't this means that, if the user-space server supports the new
> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
> request?

Yes, I think that's what it means.

> The same question applies for TMPFILE, LINK, etc.  Or is there
> something special about the LOOKUP operation that I'm missing?
>

Any command returning fuse_entry_out.

READDIRPLUS, MKNOD, MKDIR, SYMLINK

fuse_entry_out was extended once and fuse_reply_entry()
sends the size of the struct.
However fuse_reply_create() sends it with fuse_open_out
appended and fuse_add_direntry_plus() does not seem to write
record size at all, so server and client will need to agree on the
size of fuse_entry_out and this would need to be backward compat.
If both server and client declare support for FUSE_LOOKUP_HANDLE
it should be fine (?).

Thanks,
Amir.

