Return-Path: <linux-fsdevel+bounces-61288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2ECB57339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947457A6BEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AD2ED15C;
	Mon, 15 Sep 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6r7kSMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C636D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925706; cv=none; b=hhcCrF1q/t6/UvI1wohN/L67QG3AcZ4Nxd/OwQpG7W9gwcqDJG56lPCSiboN2YzP7cyd/ONnw9PU59w0JTsR8yp7giwAkN9zd+ysYxQAK1fCIHta604olVaOPWV9WV44n4qpq5HDv7GMNDJURkqVWxog+AmXBGelh5Df7zHdj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925706; c=relaxed/simple;
	bh=j/cii1yAzGzohPiU1KFlQ8rBtMBQcxz3SdivvBJT8X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9MVfbUIhXqgKR8FYoOneBjZtwvIOm9fI1WgyuPIuT1i82PjIMLyFnxejD/s1qf73DVnV8urMth/iNQYx7s5maUukRNmbLXb/6ZkGhL970kHbWmmvrtkaB4obwAu9ZXx826JXeYfOYyImwjAgqYmQ5lOTsf5n7LDDD6DQYAnapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6r7kSMo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-627b85e4c0fso6177074a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757925703; x=1758530503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgISx98LqP9kaV3d8bosANBzfIr7Kg1cDQ5T0j0QCmU=;
        b=h6r7kSMoPe7Z7nF+0EvUSDDhVHjMAf260x/6Od1S6B/L+xzLZNW16QsJ/QQOvMSqnB
         vpI84BRBM5xW6cYUGYGNszyIpXmwVq7HVCrGQvA2kL1NzAVx5tNQnc1wBNgZPVERbFv/
         RNwvAAzHURL9AsaZOcEMyWuxM795NLisP8IiWb/TAH2bCr/TuyPJN5YSy+TIMSdvwGmh
         vmQvN00cJofGoP2Ae2S3gOEzi1VArHEtj+/xXDjNrW5FbWgRBjzZWTMK0V/DeMOBDJiq
         02sUAH9IBn/hdvjM58fsgseICCXHPuUfHFSNzr46DZ6Q2zd83A4BStC1OmmR6bcIPkEQ
         VlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925703; x=1758530503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgISx98LqP9kaV3d8bosANBzfIr7Kg1cDQ5T0j0QCmU=;
        b=p4Hq+QH0KrOdl9cYg4fGB6+dbGoCUJXEM6vBV+esIwxmyJif7G0rLX4JhSuy0txppy
         ZioveN8XFIdPQTjeQv4QqV7u0HesrGjjP+bbLvg9hdoZrzehKaNJVq70e6QYUMArM5Gh
         0PEO3ons0JaJzPx8BibeOWN8FG0+csTsK8rEO1j9hi4F5qgcp38tNk6b5BzGCZUv3sN2
         yAy0YADiRn7y2bZxkufj9Pwz4gY5Y42H3nF9Zp1frqiHwb6QcwUh4zNuJhSjK3coBpQ7
         IxIyobIUwUoCbAUsM/tsuhUqAnSYfy2CTYNJTIqbP4YffYyeuYhGzwaqMMLhM1W8c5v/
         Sa2w==
X-Forwarded-Encrypted: i=1; AJvYcCXdfJMjrSon1lOHxB4Qt46A0nKTM4WHuDH3Yoz9qL3kEQveLZRFG6r2raPm93+kZ5JP3h8aAcrVQI213BRZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BTksHGvudQKYdc7zqn3GijJqXC0rHMUV0/pkn3CF87606yOP
	MAXy9bwn6NyLg4clGcbtDhTVk4d1bcyeU4rVnS1NoZCp9r6rKDb9oYa7om4d45ONLqesMddV83K
	Jqbx6KRLAIR7iHwui6lqZ5Md4G0cs/Qk=
X-Gm-Gg: ASbGncvORbqE6vNeqRJuCaoh0zMoyw8G7JwLWFJwKG/VbTev+Ba9U8DoAlBMjUa0vWY
	AQEdHrT9Sr4TSDEAI/9z0FiRw5i05ETyO6FFB+n+/Sl146Y4qi9sqWPE33jBsI5J5faeETBKVnw
	o7k5iiAURg6xLjV7D1nA4mr/P5jk+krxTuVBXGlxt94viuOouqOAkduP1f52wSu/34Sg4u+og14
	z2X/qcBpx2l5jFYWkd7pNw2/iuSGc2T9aFnnqTczw==
X-Google-Smtp-Source: AGHT+IHkyfQN/X6YSXGcm0n3Xsx2Z/LBbcmlRhybxqOVSu6LYGl6I+NGgtmqZvKYR4JaE95bKWa0yigYD8lgsM0pc8A=
X-Received: by 2002:a05:6402:520a:b0:628:28ee:958 with SMTP id
 4fb4d7f45d1cf-62ed97d864cmr12024012a12.3.1757925703009; Mon, 15 Sep 2025
 01:41:43 -0700 (PDT)
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
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com> <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
In-Reply-To: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Sep 2025 10:41:31 +0200
X-Gm-Features: AS18NWCek69Tk84GsNixOlHib1hJjxdEe89grKmQ4kSfVNmLbjuZvF9TkfIkZvE
Message-ID: <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 9/15/25 09:07, Amir Goldstein wrote:
> > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> >>
> >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 9/12/25 13:41, Amir Goldstein wrote:
> >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@bsber=
nd.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/1/25 12:15, Luis Henriques wrote:
> >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >>>>>>
> >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >>>>>>>>>
> >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if =
libfuse
> >>>>>>>>> could restart itself.  It's unclear if doing so will actually e=
nable us
> >>>>>>>>> to clear the condition that caused the failure in the first pla=
ce, but I
> >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe resta=
rts
> >>>>>>>>> aren't totally crazy.
> >>>>>>>>
> >>>>>>>> I'm trying to understand what the failure scenario is here.  Is =
this
> >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so=
, what
> >>>>>>>> is supposed to happen with respect to open files, metadata and d=
ata
> >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could =
run
> >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's g=
oing
> >>>>>>>> potentally to be out of sync, right?
> >>>>>>>>
> >>>>>>>> What are the recovery semantics that we hope to be able to provi=
de?
> >>>>>>>
> >>>>>>> <echoing what we said on the ext4 call this morning>
> >>>>>>>
> >>>>>>> With iomap, most of the dirty state is in the kernel, so I think =
the new
> >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED=
, which
> >>>>>>> would initiate GETATTR requests on all the cached inodes to valid=
ate
> >>>>>>> that they still exist; and then resend all the unacknowledged req=
uests
> >>>>>>> that were pending at the time.  It might be the case that you hav=
e to
> >>>>>>> that in the reverse order; I only know enough about the design of=
 fuse
> >>>>>>> to suspect that to be true.
> >>>>>>>
> >>>>>>> Anyhow once those are complete, I think we can resume operations =
with
> >>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidatio=
n are
> >>>>>>> fuse_make_bad'd, which effectively revokes them.
> >>>>>>
> >>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP req=
uests,
> >>>>>> but probably GETATTR is a better option.
> >>>>>>
> >>>>>> So, are you currently working on any of this?  Are you implementin=
g this
> >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a =
closer
> >>>>>> look at fuse2fs too.
> >>>>>
> >>>>> Sorry for joining the discussion late, I was totally occupied, day =
and
> >>>>> night. Added Kevin to CC, who is going to work on recovery on our
> >>>>> DDN side.
> >>>>>
> >>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> >>>>> server restart we want kernel to recover inodes and their lookup co=
unt.
> >>>>> Now inode recovery might be hard, because we currently only have a
> >>>>> 64-bit node-id - which is used my most fuse application as memory
> >>>>> pointer.
> >>>>>
> >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-=
sends
> >>>>> outstanding requests. And that ends up in most cases in sending req=
uests
> >>>>> with invalid node-IDs, that are casted and might provoke random mem=
ory
> >>>>> access on restart. Kind of the same issue why fuse nfs export or
> >>>>> open_by_handle_at doesn't work well right now.
> >>>>>
> >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, whic=
h
> >>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
> >>>>> And then FUSE_REVALIDATE_FH on server restart.
> >>>>> The file handles could be stored into the fuse inode and also used =
for
> >>>>> NFS export.
> >>>>>
> >>>>> I *think* Amir had a similar idea, but I don't find the link quickl=
y.
> >>>>> Adding Amir to CC.
> >>>>
> >>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thr=
ead:
> >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkA=
P8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >>>
> >>> Thanks for the reference Amir! I even had been in that thread.
> >>>
> >>>>
> >>>>>
> >>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, w=
hich
> >>>>> will iterate over all superblock inodes and mark them with fuse_mak=
e_bad.
> >>>>> Any objections against that?
> >>
> >> What if you actually /can/ reuse a nodeid after a restart?  Consider
> >> fuse4fs, where the nodeid is the on-disk inode number.  After a restar=
t,
> >> you can reconnect the fuse_inode to the ondisk inode, assuming recover=
y
> >> didn't delete it, obviously.
> >
> > FUSE_LOOKUP_HANDLE is a contract.
> > If fuse4fs can reuse nodeid after restart then by all means, it should =
sign
> > this contract, otherwise there is no way for client to know that the
> > nodeids are persistent.
> > If fuse4fs_handle :=3D nodeid, that will make implementing the lookup_h=
andle()
> > API trivial.
> >
> >>
> >> I suppose you could just ask for refreshed stat information and either
> >> the server gives it to you and the fuse_inode lives; or the server
> >> returns ENOENT and then we mark it bad.  But I'd have to see code
> >> patches to form a real opinion.
> >>
> >
> > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
> > where fuse_instance_id can be its start time or random number.
> > for auto invalidate, or maybe the fuse_instance_id should be
> > a native part of FUSE protocol so that client knows to only invalidate
> > attr cache in case of fuse_instance_id change?
> >
> > In any case, instead of a storm of revalidate messages after
> > server restart, do it lazily on demand.
>
> For a network file system, probably. For fuse4fs or other block
> based file systems, not sure. Darrick has the example of fsck.
> Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
> fuse-server gets restarted, fsck'ed and some files get removed.
> Now reading these inodes would still work - wouldn't it
> be better to invalidate the cache before going into operation
> again?

Forgive me, I was making a wrong assumption that fuse4fs
was using ext4 filehandle as nodeid, but of course it does not.

The reason I made this wrong assumption is because fuse4fs *can*
already use ext4 (64bit) file handle as nodeid, with existing FUSE protocol
which is what my fuse passthough library [1] does.

My claim was that although fuse4fs could support safe restart, which
cannot read from recycled inode number with current FUSE protocol,
doing so with FUSE_HANDLE protocol would express a commitment
to this behavior.

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/fuse_passthrough

