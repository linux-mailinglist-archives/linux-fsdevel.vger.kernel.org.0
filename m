Return-Path: <linux-fsdevel+bounces-53957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCBAF9102
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8511C7A9E12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE61289362;
	Fri,  4 Jul 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX3f+NW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0782F19B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626702; cv=none; b=pTRgHBox0ZS+ED+N3X/jyNRMtWA9boIXcKg5Ae5x76Z10bmMHqLn47mCadaiL3FpHLfVvanag1WsiOorHr4oKJMu2uLBMnFEGGJf7t73NsZnZNOJYfLGWWpB4lvqjlPR7MkAubNWZqYHDfvZqeFmK4m0ZTiTvwa8Sd6l16RKk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626702; c=relaxed/simple;
	bh=IDGv0ZmFLScEvN6M8fY3n1SlcLy38N4DcGo/wgRxP1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbPHhXOCam4yQvJr3JnSS0Vwe1oYYnvB2HoakBsnQN8ed82m2g8LHWgZ8fRdOhMateChuOAJajkPKT5RGddepS0Uk4Lc8PrCt28IIKgLABX7MK+0dPABMZeYhzozKTGVdxR8rFhK4o56J+7uljWWdgNSs9AMMQp21T7E/4o1YH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX3f+NW+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so4034565e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751626699; x=1752231499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sunxBafORyIYMPPYlAkiwPs7y1d9n3TdsxEodnGzveM=;
        b=AX3f+NW+fid8jIP0Uj3qx5B6Bdg2NIeg0FIK1G5ed6gCMgEgPlMSiZrpCGvg3Vjrml
         zgcXNC/acR6l6QIyGLluNi15lpEnfQRbHxWusUEqvnDGt1T4OPNV/bcTta/MxaMfeYRJ
         2TR3BOegkObN7/S2UuWRjki0lDfL/5DCyRlBjd7QuRsZQso+RpJOTNyoRXPijg9lZHxt
         /ARuv1h79K00G2WlEkJOGUZxkn465Sh+K3v+n5xDcgUsnoFJiixfoe+XLR4BF8xSotlB
         d1WZzMV+GYsRHdo05e5oZzomsBmUyxc/W8o5kD+7LU1q05Jya0s8rSOjaztJQy3PzE76
         vJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626699; x=1752231499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sunxBafORyIYMPPYlAkiwPs7y1d9n3TdsxEodnGzveM=;
        b=aJaRn/79xExB5qUg9d9t+WO5dKbkTt1Y5xOqpdaLRCBGt04R3coxlr0LUzCicV02Ro
         yShoHjM6zhv+wgIhmLpRYQ2LTRG07+YlotA/IEwSjFAwjb0p/bv7/wCHaQouYteOI431
         A/nHIutxxIhFAv0/AKSSuZSTzoL5GI7dLRxJ8FTWz0waTXL2wiXn2kkvOr5zswzP+2+z
         9eY2ybBidoD25E0o3oZQU+wne1gTx48+7X1D/Yqsd0h5RLTf8rdiRKyI0hyCJ0FhdBto
         jvtFC/QeaAHa1eJbmjuOF1v09kMETCPziUzNrrhwmCi1QNsm9T3zUQYjd5nyn/lD6e0z
         gtIg==
X-Forwarded-Encrypted: i=1; AJvYcCUa0AdySjk1VUl6xjeigABaAozYOdtJ6nkqwKMuoy6aBspRdsx2MOnSRYi9H+29PKOshVlKZ9LnuZLPtu5B@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1B084IXcGwzJPMRVRBrrn6mSxbHqM4Bzx+WCQlkq7Z0BHFgd
	AxhvJ9Mtm1NXTsu8TBvTyIwZ4mvmvlLnvbgIb8I/6NQpcSksnNEwC8ekpiKnC92eaomheKl1Vrr
	zHnvxPyrQG6jp9ZVD0rUob6Ql0F/SdLI=
X-Gm-Gg: ASbGnctvjwyoHZmiN8J/SimwYAtGSUVPBPOVdpSD+YSM1aOfmSbX2HVr05U429ru7oH
	/I6Jg7tMYWBKiIZPmSyYHd+/TWOQr1Yj4OPylNy1hEJMhXm4H/+i1faqUb05QMkTROitGDwPxZC
	E0qJzvFa61Q9Yb8Zt61kq5dcLk6AjyCVENhziwqerCq1o=
X-Google-Smtp-Source: AGHT+IEmo4tGn/rV03PPfwMbcBK9IMSOmuKYyMcbirTLiEvMcwhu6WO2cJZZZR7adhfgnj5RfHyk/Hwq3clD61IuAG8=
X-Received: by 2002:a05:600c:c4a5:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-454b3122478mr18785795e9.13.1751626698197; Fri, 04 Jul 2025
 03:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com> <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
 <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
 <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com>
 <uxetof5i2ejhwujegsbhltntnozd4rz6cxtqx3xmtc63xugkyq@53bwknir2ha7>
 <CAOQ4uxhnXaQRDK=LpdPbAMfUU8EPze17=EHASQmG7bN5NdHWew@mail.gmail.com> <gi5bf6arjqycvzs5trox65ld5xaabnkihh4dp5oycsb2a2katp@46puvf6luehw>
In-Reply-To: <gi5bf6arjqycvzs5trox65ld5xaabnkihh4dp5oycsb2a2katp@46puvf6luehw>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Jul 2025 12:58:06 +0200
X-Gm-Features: Ac12FXzahB6DXZF3D3jbDg00DUfaD8L_VXwBaH2GlUn-KKWUEktGNogoDbSRlgY
Message-ID: <CAOQ4uxhttUt6makW6GZGfBb=rat+gH9QQmparX3cexDJwzhVMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 11:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-07-25 21:14:11, Amir Goldstein wrote:
> > On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> > > > On Mon, Jun 16, 2025 at 11:07=E2=80=AFAM Jan Kara <jack@suse.cz> wr=
ote:
> > > > > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > > > > On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.cz>=
 wrote:
> > > > > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > > > > If we decide that we want to support FAN_PATH_ACCESS from a=
ll the
> > > > > > > > path-less lookup_one*() helpers, then we need to support re=
porting
> > > > > > > > FAN_PATH_ACCESS event with directory fid.
> > > > > > > >
> > > > > > > > If we allow FAN_PATH_ACCESS event from path-less vfs helper=
s, we still
> > > > > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignor=
e mask, because
> > > > > > > > we need to provide a way for HSM to opt-out of FAN_PATH_ACC=
ESS events
> > > > > > > > on its "work" mount - the path via which directories are po=
pulated.
> > > > > > > >
> > > > > > > > There may be a middle ground:
> > > > > > > > - Pass optional path arg to __lookup_slow() (i.e. from walk=
_component())
> > > > > > > > - Move fsnotify hook into __lookup_slow()
> > > > > > > > - fsnotify_lookup_perm() passes optional path data to fsnot=
ify()
> > > > > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCES=
S without
> > > > > > > >   path data
> > > > > > > >
> > > > > > > > This way, if HSM is enabled on an sb and not ignored on spe=
cific dir
> > > > > > > > after it was populated, path lookup from syscall will trigg=
er
> > > > > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to look=
up inside
> > > > > > > > non-populated directories.
> > > > > > >
> > > > > > > OK, but how will this manifest from the user POV? If we have =
say nfs
> > > > > > > exported filesystem that is HSM managed then there would have=
 to be some
> > > > > > > knowledge in nfsd to know how to access needed files so that =
HSM can pull
> > > > > > > them? I guess I'm missing the advantage of this middle-ground=
 solution...
> > > > > >
> > > > > > The advantage is that an admin is able to set up a "lazy popula=
ted fs"
> > > > > > with the guarantee that:
> > > > > > 1. Non-populated objects can never be accessed
> > > > > > 2. If the remote fetch service is up and the objects are access=
ed
> > > > > >     from a supported path (i.e. not overlayfs layer) then the o=
bjects
> > > > > >     will be populated on access
> > > > > >
> > > > > > This is stronger and more useful than silently serving invalid =
content IMO.
> > > > > >
> > > > > > This is related to the discussion about persistent marks and ho=
w to protect
> > > > > > against access to non-populated objects while service is down, =
but since
> > > > > > we have at least one case that can result in an EIO error (serv=
ice down)
> > > > > > then another case (access from overlayfs) maybe is not a game c=
hanger(?)
> > > > >
> > > > > Yes, reporting error for unpopulated content would be acceptable =
behavior.
> > > > > I just don't see this would be all that useful.
> > > > >
> > > >
> > > > Regarding overlayfs, I think there is an even bigger problem.
> > > > There is the promise that we are not calling the blocking pre-conte=
nt hook
> > > > with freeze protection held.
> > > > In overlayfs it is very common to take the upper layer freeze prote=
ction
> > > > for a relatively large scope (e.g. ovl_want_write() in ovl_create_o=
bject())
> > > > and perform lookups on upper fs or lower fs within this scope.
> > > > I am afraid that cleaning that up is not going to be realistic.
> > > >
> > > > IMO, it is perfectly reasonable that overlayfs and HSM (at least pr=
e-dir-access)
> > > > will be mutually exclusive features.
> > > >
> > > > This is quite similar to overlayfs resulting in EIO if lower fs has=
 an
> > > > auto mount point.
> > > >
> > > > Is it quite common for users to want overlayfs mounted over
> > > > /var/lib/docker/overlay2
> > > > on the root fs.
> > > > HSM is not likely to be running on / and /etc, but likely on a very
> > > > distinct lazy populated source dir or something.
> > > > We can easily document and deny mounting overlayfs over subtrees wh=
ere
> > > > HSM is enabled (or just pre-path events).
> > > >
> > > > This way we can provide HSM lazy dir populate to the users that do =
not care
> > > > about overlayfs without having to solve very hard to unsolvable iss=
ues.
> > > >
> > > > I will need to audit all the other users of vfs lookup helpers othe=
r than
> > > > overlayfs and nfsd, to estimate how many of them are pre-content ev=
ent
> > > > safe and how many are a hopeless case.
> > > >
> > > > On the top of my head, trying to make a cachefilesd directory an HS=
M
> > > > directory is absolutely insane, so not every user of vfs lookup hel=
pers
> > > > should be able to populate HSM content - should should simply fail
> > > > (with a meaningful kmsg log).
> > >
> > > Right. What you write makes a lot of sense. You've convinced me that
> > > returning error from overlayfs (or similar users) when they try to ac=
cess
> > > HSM managed dir is the least painful solution :).
> > >
> >
> > Oh oh, now I need to try to convince you of a solution that is less pai=
nful
> > than the least painful solution ;)
>
> :)
>
> > I have been experimenting with some code and also did a first pass audi=
t
> > of the vfs lookup callers.
> >
> > First of all, Neil's work to categorize the callers into lookup_noperm*
> > and lookup_one* really helped this audit. (thanks Neil!)
> >
> > The lookup_noperm* callers are not "vfs users" they are internal fs
> > callers that should not call fsnotify pre-content hooks IMO.
> >
> > The lookup_one* callers are vfs callers like ovl,cachefiles, as well
> > as nfsd,ksmbd.
> >
> > Some of the lookup_one() calls are made from locked context, so not
> > good for pre-content events, but most of them are not relevant anyway
> > because they are not first access to dir (e.g. readdirplus which alread=
y
> > started to iterate dir).
> >
> > Adding lookup pre-content hooks to nfsd and ksmbd before the relevant
> > lookup_one* callers and before fs locks are taken looks doable.
> >
> > But the more important observation I had is that allowing access to
> > dirs with unpopulated content is not that big of a deal.
> >
> > Allowing access to files that are sparse files before their content is =
filled
> > could have led applications to fault and users to suffer.
> >
> > Allowing access to unpopulated dirs, e.g. from overlayfs or even from
> > nfsd, just results in getting ENOENT or viewing an empty directory.
>
> Right. Although if some important files would be missing, you'd still cau=
se
> troubles to applications and possible crashes (or app shutdowns). But I
> take the ENOENT return in this case as a particular implementation of the
> "just return error to userspace if we have no chance to handle the lookup
> in this context" policy.
>
> > My conclusion is, that if we place the fsnotify lookup hook in
> > lookup_slow() then the only thing we need to do is:
> > When doing lookup_one*() from possibly unsafe context,
> > in a fs that has pre-dir-content watchers,
> > we always allow the lookup,
> > but we never let it leave a negative dcache entry.
> >
> > If the lookup finds a child entry, then dir is anyway populated.
> > If dir is not populated, the -ENOENT result will not be cached,
> > so future lookups of the same name from safe context will call the hook=
 again,
> > populate the file or entire directory and create positive/negative dent=
ry,
> > and then following lookups of the same name will not call the hook.
>
> Yes, this looks pretty much like what we've agreed on before, just now th=
e
> implementation is getting more concrete shape. Or am I missing something?
>

What (I think) we discussed before was to fail *any* lookup from
internal vfs callers to HSM moderated fs, so ovl would also not be able to
access a populated directory in that case.

What I am suggesting is to always allow the lookup in HSM fs
and depending on a negative lookup result do "something".

There is a nuance here.
Obviously, userspace will get ENOENT in this case, but
does lookup_one() succeed and returns a negative unhashed
dentry (e.g. to ovl) or does it drop the dentry and fail with -ENOENT?

I was thinking of the former, but I think you are implying the latter,
which is indeed a bit closer to what we agreed on.

For callers that use lookup_one_positive_unlocked()
like ovl_lookup(), it makes no difference, but for callers that
create new entries like ovl_create_upper() it means failure to create
and that is desirable IMO.

I guess, if ovl_mkdir() fails with -ENOENT users would be a bit confused
but in a way, this parent directory does not fully exist yet, so
it may be good enough.

We could also annotate those calls as lookup_one_for_create()
to return -EROFS in the negative lookup result in HSM moderated dir,
but not sure that this is needed or if it is less confusing to users.

What's even nicer is that for overlayfs it is the more likely case that
only the lower layer fs is HSM moderated, e.g. for a composefs
"image repository".

Adding safe pre-dir-content hooks for overlayfs lower layer lookup
may be possible down the road. A lot easier that supporting
lazy dir populates in a rw layer.


> > The only flaw in this plan is that the users that do not populate
> > directories can create entries in those directories, which can violate
> > O_CREAT | O_EXCL and mkdir(), w.r.t to a remote file.
> >
> > But this flaw can be reported properly by the HSM daemon when
> > trying to populate a directory which is marked as unpopulated and
> > finding files inside it.
> >
> > HSM could auto-resolve those conflicts or prompt admin for action
> > and can return ESTALE error (or a like) to users.
> >
> > Was I clear? Does that sound reasonable to you?
>
> So far we have only one-way synchronization for files (i.e., we don't
> expect the HSM client to actually modify the filesystem, the server is th=
e
> ultimate source of truth). Aren't we going to do it similarly for
> directories? It would be weird to try to handle dir modifications without
> supporting file modifications. And if we aim for one-way synchronization,
> then I'd expect the HSM service to maybe just expose RO mount to
> applications (superblock and the private mount used for filling in data
> have to be obviously RW). If it lets applications write to the fs for
> whatever reason, it has to keep all the pieces together, I don't think th=
e
> kernel is responsible there. Hmm?

My use case is "cloud sync engine" so the users do get a RW mount
and it's the server's job to keep all the pieces together.
But for lazy dir populare (subtree never accessed by user), the server
expects to get an empty dir to and to populate it.

So it is much better if the kernel is able to block creating entries in
an HSM moderated dir by the non-blocking internal vfs users.

I think the explicit ENOENT for negative lookup results may just be
enough to get this done, so I will give it a shot.

Thanks,
Amir.

