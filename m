Return-Path: <linux-fsdevel+bounces-51792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174AAADB780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35A417374C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5591288C3C;
	Mon, 16 Jun 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB7uFvlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC7288C0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093260; cv=none; b=qqkumoMQIERxS6hy6hr1OYC0XCtY0WhmSZ4FYg0ZGDoVUhI/Sh1v75gODtrtslOcbk+7nWvFd5C1KfsqKzVPQ3XGx2qoq1KnP/s4nva6sNocVi5J5QJ7qVRAyl2TQbG9o+/rh1VtudmCiJk67BNKWykxh2mai7NgG8Sb+zhk7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093260; c=relaxed/simple;
	bh=5x4hSG+MM5oBmJkrh5XoO8ZGhMN2KWZyTU3jYwkjpaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4fv/F3bEqMm2sBndrTQ132pw7150dcIMJWKDU56IVl1vRtZgdTlwtxAFjItJw/iudZF3EGu9EiNx1IsH4ylZu7nosW3MP6i8kiJbYYUluuANZP+Vgm9GlUOpEadKny6nBWe7xoLalDReoXb8NG4SzJHErcat/VudBaUmu3QXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB7uFvlR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad572ba1347so751824766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093256; x=1750698056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL3Efdxe+EgWePeZuIC+DIxS8/YYQ4lkT5kZx9e6nHM=;
        b=NB7uFvlRUIVNwhD951/ipFYT5DkM/OBbBK5KDAPJupUdiZbLc8tu22wj5y1Y5Vi7VA
         sf+kA+dkLDhpHJ3e7mBLBT2Xcw3w3YSvcQjjx/Hevbu2xA0AZq/EzoXIAwrxyoUgCazJ
         T87b6tYOm0rqpQeKqEKEV7MW1sGkEVe7JKvAX0UFzpjcoHV5W3IkpJOt9BHtAT+B8nta
         V5y/3zwVeFk/I4Qniiiq2JxqKzxCqx7LsFVsV3pjf9KUAyVSdhBq1hvoISZHQdS73/8+
         lQm2WqZBtU7dh2ErldMTmN6Y40BwkBSK5w8IByJufh/yiPBCPfTrrApvgCguIIX4CJaJ
         CVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093256; x=1750698056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL3Efdxe+EgWePeZuIC+DIxS8/YYQ4lkT5kZx9e6nHM=;
        b=KflOawLGxUlnzicB4JY0zU4m57vsftT7HaOfttnyQURhiHzxQ65rY9+mva68hkxqOp
         iZrqQfzGr+IC0aa0KWfPDzHf9L6ikY3IVq/QiYwOaLLswn+Jxgdv4ouOkpET6jV+R0RZ
         a26ylDuPcj2nwXszgjwyZvbpHRmJH4/IJekgMTEDGSrjHV2ANT9U0BamkUxgRcjlck07
         lJ7xAylM4GgRNZq77IpGms1+fHSJRIA3PZXQp/qpQnnE1oGl3R8g22SF2Q08ElbdEOpR
         AdYOWScA0StCIUcZ0n9S48ciJiwwMDoJLxEUBQqTklwxXl5s7AyBFCzMD+eWRP8kVYsI
         BPzg==
X-Forwarded-Encrypted: i=1; AJvYcCV12iJ7TXNO/rxKjUcZBVEhagdwPmoTiAiyCmiq6H8KnWJq2B28tM6BzZLGPGM9HiVZC/I6wRjHo1RwWoeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgL1lGviDoiUGVz5RYc0OKPzvZTbVxnNOS+HrwQB1QH4SCW1k
	ugv6gnfeT8KZivLSsI4BuquK2hLPwLHyUvrTlp1YEP21DsjJuCCIbLt2yJLFVUPFllpQYe1omlD
	fG5nT5FaEMTu4zxrd6ClL/8YPGeBRwms=
X-Gm-Gg: ASbGncs89j6M2CTJD93TkewccFuk/SNzk8SYoXaBDZTmIUbvLkfm5P3RW6Dk0LCmAYn
	FIFeWIjLMKLK02YwrEQUVCzlHbhXjDJ1yPSOLuREXOqH1BQ0uiJ6BcE2LC7+kx6DpWkKLoAvF25
	Vt866bavfWkNo355KDWEoGB+DexgLGaqpn6yvL/utUICY=
X-Google-Smtp-Source: AGHT+IF2FzIF4cM/xZgeR3mjklrkTIpF80H3P4kdQm0v4fsNTe8ZjFuhUPNmS2u0MiESd33mzzPngg82k37AxTQnPR8=
X-Received: by 2002:a17:907:1c08:b0:ad8:a935:b8eb with SMTP id
 a640c23a62f3a-adfad2a1ef0mr1074121966b.3.1750093253323; Mon, 16 Jun 2025
 10:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com> <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com> <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
In-Reply-To: <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Jun 2025 19:00:42 +0200
X-Gm-Features: AX0GCFtBdPkXyi9B05_ZE0TpJOOX43h_8F854w2PGS6mcTgHdpcTKmZAqmixTaU
Message-ID: <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:07=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > I am still tagging this as RFC for two semi-related reasons:
> > > >
> > > > 1) In my original draft of man-page for FAN_PATH_ACCESS [2],
> > > > I had introduced a new class FAN_CLASS_PRE_PATH, which FAN_PATH_ACC=
ESS
> > > > requires and is defined as:
> > > > "Unlike FAN_CLASS_PRE_CONTENT, this class can be used along with
> > > >  FAN_REPORT_DFID_NAME to report the names of the looked up files al=
ong
> > > >  with O_PATH file descriptos in the new path lookup events."
> > > >
> > > > I am not sure if we really need FAN_CLASS_PRE_PATH, so wanted to as=
k
> > > > your opinion.
> > > >
> > > > The basic HSM (as implemented in my POC) does not need to get the l=
ookup
> > > > name in the event - it populates dir on first readdir or lookup acc=
ess.
> > > > So I think that support for (FAN_CLASS_PRE_CONTENT | FAN_REPORT_DFI=
D_NAME)
> > > > could be added later per demand.
> > >
> > > The question here is what a real user is going to do? I know Meta guy=
s
> > > don't care about directory events for their usecase. You seem to care=
 about
> > > them so I presume you have some production use in mind?
> >
> > Yes we have had it in production for a long time -
> > You can instantaneously create a lazy clone of the entire "cloud fs" lo=
cally.
> > Directories get populated with sparse files on first access.
> > Sparse files get populated with data on first IO access.
> > It is essentially the same use case as Meta and many other similar user=
s.
> > The need for directory populate is just a question of scale -
> > How much does it take to create a "metadata clone" or the remote fs cop=
y
> > and create all the sparse files.
> > At some point, it becomes too heavy to not do it lazily.
> >
> > > How's that going to
> > > work? Because if I should guess I'd think that someone asks for the n=
ame
> > > being looked up sooner rather than later because for large dirs not h=
aving
> > > to fetch everything on lookup would be a noticeable win...
> >
> > Populating a single sparse file on lookup would be a large win, but als=
o pretty
> > hard to implement this "partially populated dir" state correctly. For
> > that reason,
> > We have not implemented this so far, but one can imagine (as you wrote)=
 that
> > someone else may want to make use of that in the future.
>
> OK, thanks for clarification.
>
> > > > 2) Current code does not generate FAN_PRE_ACCESS from vfs internal
> > > > lookup helpers such as  lookup_one*() helpers from overalyfs and nf=
sd.
> > > > This is related to the API of reporting an O_PATH event->fd for
> > > > FAN_PATH_ACCESS event, which requires a mount.
> > >
> > > AFAIU this means that you could not NFS export a filesystem that is H=
SM
> > > managed and you could not use HSM managed filesystem to compose overl=
ayfs.
> > > I don't find either of those a critical feature but OTOH it would be =
nice
> > > if the API didn't restrict us from somehow implementing this in the f=
uture.
> > >
> >
> > Right.
> > There are a few ways to address this.
> > FAN_REPORT_DFID_NAME is one of them.
> >
> > Actually, the two cases, overlayfs and nfsd are different
> > in the aspect that the overlayfs layer uses a private mount clone
> > while nfsd actually exports a specific user visible mount.
> > So at least in theory nfsd could report lookup events with a path
> > as demonstrated with commit from my WIP FAN_PRE_MODIFY patches
> > https://github.com/amir73il/linux/commit/4a8b6401e64d8dbe0721e5aaa496f0=
ad59208560
>
> OK, I agree that for nfsd reporting the event with the mount that nfsd ex=
ports
> would make sense.
>
> > Another way is to say that event->fd does not need to indicate the
> > mount where the event happened.
> > Especially if event->fd is O_PATH fd, then it could simply refer to a
> > directory dentry using some arbitrary mount that the listener has acces=
s to.
> > For example, we can allow an opt-in flag to say that the listener keeps
> > an O_PATH fd for the path provided in fanotify_mark() (i.e. for an sb m=
ark)
> > and let fanotify report event->fd based on the listener's mount regardl=
ess
> > of the event generator's mount.
>
> So this would be controversial I think. Mounts can have different
> properties (like different read-only settings, different id mappings, ...=
),
> can reveal different parts of the filesystem and generally will be
> differently placed in mount hierarchy. So in particular with sb marks the
> implications of arbitrarily combining mount of a sb with some random dent=
ry
> (which need not even be accesible through the mount) could lead to surpri=
sing
> results.
>

<nod>

> > There is no real concern about the listener keeping the fs mount busy b=
ecause:
> > 1. lsof will show this reference to the mount
> > 2. A proper listener with FAN_REPORT_DFID_NAME has to keep open
> >    mount_fd mapped to fsid anyway to be able to repose paths from event=
s
> >    (for example: fsnotifywatch implementation in inotify-tools)
> >
> > Then functionally, FAN_REPORT_DIR_FID and FAN_REPORT_DIR_FD
> > would be similar, except that the latter keeps a reference to the objec=
t while
> > in the event queue and the former does not.
>
> Yeah, I'm not that concerned about keeping the fs busy. After all we
> currently grab inode references and drop them on umount and we could do t=
he
> same with whatever other references we have to the fs.
>
> > > > If we decide that we want to support FAN_PATH_ACCESS from all the
> > > > path-less lookup_one*() helpers, then we need to support reporting
> > > > FAN_PATH_ACCESS event with directory fid.
> > > >
> > > > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, we st=
ill
> > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore mask, =
because
> > > > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS even=
ts
> > > > on its "work" mount - the path via which directories are populated.
> > > >
> > > > There may be a middle ground:
> > > > - Pass optional path arg to __lookup_slow() (i.e. from walk_compone=
nt())
> > > > - Move fsnotify hook into __lookup_slow()
> > > > - fsnotify_lookup_perm() passes optional path data to fsnotify()
> > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS withou=
t
> > > >   path data
> > > >
> > > > This way, if HSM is enabled on an sb and not ignored on specific di=
r
> > > > after it was populated, path lookup from syscall will trigger
> > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup insid=
e
> > > > non-populated directories.
> > >
> > > OK, but how will this manifest from the user POV? If we have say nfs
> > > exported filesystem that is HSM managed then there would have to be s=
ome
> > > knowledge in nfsd to know how to access needed files so that HSM can =
pull
> > > them? I guess I'm missing the advantage of this middle-ground solutio=
n...
> >
> > The advantage is that an admin is able to set up a "lazy populated fs"
> > with the guarantee that:
> > 1. Non-populated objects can never be accessed
> > 2. If the remote fetch service is up and the objects are accessed
> >     from a supported path (i.e. not overlayfs layer) then the objects
> >     will be populated on access
> >
> > This is stronger and more useful than silently serving invalid content =
IMO.
> >
> > This is related to the discussion about persistent marks and how to pro=
tect
> > against access to non-populated objects while service is down, but sinc=
e
> > we have at least one case that can result in an EIO error (service down=
)
> > then another case (access from overlayfs) maybe is not a game changer(?=
)
>
> Yes, reporting error for unpopulated content would be acceptable behavior=
.
> I just don't see this would be all that useful.
>

Regarding overlayfs, I think there is an even bigger problem.
There is the promise that we are not calling the blocking pre-content hook
with freeze protection held.
In overlayfs it is very common to take the upper layer freeze protection
for a relatively large scope (e.g. ovl_want_write() in ovl_create_object())
and perform lookups on upper fs or lower fs within this scope.
I am afraid that cleaning that up is not going to be realistic.

IMO, it is perfectly reasonable that overlayfs and HSM (at least pre-dir-ac=
cess)
will be mutually exclusive features.

This is quite similar to overlayfs resulting in EIO if lower fs has an
auto mount point.

Is it quite common for users to want overlayfs mounted over
/var/lib/docker/overlay2
on the root fs.
HSM is not likely to be running on / and /etc, but likely on a very
distinct lazy populated source dir or something.
We can easily document and deny mounting overlayfs over subtrees where
HSM is enabled (or just pre-path events).

This way we can provide HSM lazy dir populate to the users that do not care
about overlayfs without having to solve very hard to unsolvable issues.

I will need to audit all the other users of vfs lookup helpers other than
overlayfs and nfsd, to estimate how many of them are pre-content event
safe and how many are a hopeless case.

On the top of my head, trying to make a cachefilesd directory an HSM
directory is absolutely insane, so not every user of vfs lookup helpers
should be able to populate HSM content - should should simply fail
(with a meaningful kmsg log).

> > > > Supporting populate events from overalyfs/nfsd could be implemented
> > > > later per demand by reporting directory fid instead of O_PATH fd.
> > > >
> > > > If you think that is worth checking, I can prepare a patch for the =
above
> > > > so we can expose it to performance regression bots.
> > > >
> > > > Better yet, if you have no issues with the implementation in this
> > > > patch set, maybe let it soak in for_next/for_testing as is to make
> > > > sure that it does not already introduce any performance regressions=
.
> > > >
> > > > Thoughts?
> > >
> > > If I should summarize the API situation: If we ever want to support H=
SM +
> > > NFS export / overlayfs, we must implement support for pre-content eve=
nts
> > > with FID (DFID + name to be precise).
> >
> > Yes, but there may be alternatives to FID.
> >
> > > If we want to support HSM events on
> > > lookup with looked up name, we don't have to go for full DFID + name =
but we
> > > must at least add additional info with the name to the event.
> >
> > Yes, reporting name is really a feature that could be opt-in.
> > And if we report name, it is no effort to also report FID,
> > regardless if we also report event->fd or not.
> >
> > > Also if we go
> > > for reporting directory pre-content events with standard events, you =
want
> > > to add support for returning O_PATH fds for better efficiency and the=
 code
> > > to handle FMODE_NONOTIFY directory fds in path lookup.
> > >
> >
> > Yes. technically, O_PATH fd itself could be used to perform the populat=
e of
> > dir in a kin way to event->fd being used to populate a file, so it is
> > elegant IMO.
>
> I agree it is kind of elegant. But I find reporting DFID and leaving upto
> userspace to provide "ignored" mount to fill in the contents elegant as
> well and there's no need to define behavior of O_PATH dir fds with NONOTI=
FY
> flags.
>

ok.

> > > Frankly seeing all this I think that going for DFID + name events for
> > > directory HSM events from the start may be the cleanest choice long t=
erm
> > > because then we'll have one way how to access the directory HSM
> > > functionality with possibility of extensions without having to add
> > > different APIs for it.
> >
> > I see the appeal in that.
> > I definitely considered that when we planned the API
> > just wanted to consult with you before going forward with implementatio=
n.
> >
> > > We'd just have to implement replying to FID events
> > > because we won't have fd to identify event we reply to so that will n=
eed
> > > some thought.
> >
> > I keep forgetting about that :-D
> >
> > My suggestion for FAN_REPORT_DIR_FD could work around this
> > problem ellegantly.
>
> I agree FAN_REPORT_DIR_FD doesn't have this problem and that certainly ad=
ds
> some appeal to it:). OTOH it is not that hard to solve - you'd need some
> idr allocator in the notification group and pass the identifier together
> with the event.
>

ok.

> > > What are your thoughts? Am I missing something?
> >
> > My thoughts are that FAN_REPORT_DIR_FD and
> > FAN_REPORT_DFID_NAME may both be valid solutions and
> > they are not even conflicting.
> > In fact, there is no clear reason to deny mixing them together.
> >
> > If you do not have any objection to the FAN_REPORT_DIR_FD
> > solution, then we need to decide if we want to do them both?
> > one at a time? both from the start?
> >
> > My gut feeling is that FAN_REPORT_DIR_FD is going to be
> > more easy to implement and to users to use for first version
> > and then whether or not we need to extend to report name
> > we can deal with later.
>
> As I wrote in my first email what I'd like to avoid is having part of the
> functionality accessible in one way (say through FAN_REPORT_DIR_FD) and
> having to switch to different way (FAN_REPORT_DFID_NAME) for full
> functionality. That is in my opinion confusing to users and makes the api
> messy in the long term. So I'd lean more towards implementing fid-based
> events from the start. I don't think implementation-wise it's going to be
> much higher effort than FAN_REPORT_DIR_FD. I agree that for users it is
> somewhat more effort - they have to keep the private mount, open fhandle =
to
> get to the dir so that they can fill it in. But that doesn't seem to be
> that high bar either?
>

ok.

> We even have some precedens that events for regular files support both fd
> and fid events and for directory operations only fid events are supported=
.
> We could do it similarly for HSM events...

That's true.

Another advantage is that FAN_REPORT_FID | FAN_CLASS_PRE_CONTENT
has not been allowed so far, so we can use it to set new semantics
that do not allow FAN_ONDIR and FAN_EVENT_ON_CHILD at all.
The two would be fully implied from the event type, unlike today
where we ignore them for some event types and use different meanings
to other event types.

I'll see what I can come up with, but first we need to reach an agreement
about the overlayfs case.

Thanks,
Amir.

