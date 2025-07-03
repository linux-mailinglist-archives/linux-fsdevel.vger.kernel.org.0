Return-Path: <linux-fsdevel+bounces-53844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0139AF8128
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE18189120A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC16299954;
	Thu,  3 Jul 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIqlal/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E32951C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570066; cv=none; b=XIEtlk8uin8V7HMJWpo3JfTCuzjAfgxf6r1Dp3Tw6+d3ObZIwWjShqN7DtE/NjsLen791DoFsH39rebKV0TBmNxpXGWZzc0JZGq7+HNyBmQALcRX7Xv4REXnWnKrgoPQuFaPbSQ7UcQ7IJfF7sBC/yc6EDUSY0CFEvywpAEop3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570066; c=relaxed/simple;
	bh=ZUKUHTAUDM5I20BzrLf7wOkbMw65LwloDRaJDew7Brw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRME3oAwdORvdIeA5K2GKPa1LDeE6yL4rVwZitIhbDC/z8lKxPc4TCkCNSBrFIvoXVtEpPCgeJC7hZieLqlgYgoAUwIaSQZMqS5DUdGTSZrDNstp0Aedba0XfLPx+UPe4nOSaQvpFk+al45PHGx9SfOQphhjqOf6nprTXZ89CPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIqlal/s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-addda47ebeaso42550866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751570063; x=1752174863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K1jxEHxTx5AwougHkev/T2Vp92besmNEW691msq8oU=;
        b=jIqlal/sF+jcz0M9h4O0TnZdOVW1HL9sZFRF+6H4AoZCzuYGXWmiNdJVSlityIvIYo
         4G98VCsQEsZf/DCln5rjWg/RF+/x24yBtu211dCBdhvkgwBVU5GHPVDqMhq9+a8b7ljY
         NlwutoWVvLwBVkhCOkO6UgRcb+zU+CKXjww9vxe0i9wQlTLdEr27NnLTtwPAPjwtsVST
         nkg2KyxRuiO3laBozu7ci3pw5STtDpdbPUEI/WJpKAfiFS97VI/ed2Db7T7r/oyHJKso
         dTYntKE3Ve+kifdzmH4zLkVKC7YktZVZCe4ixsKGnAC6uquzKGGSDNFLEmr34U9RjEQK
         27Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751570063; x=1752174863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K1jxEHxTx5AwougHkev/T2Vp92besmNEW691msq8oU=;
        b=sIEV+tRiXFdhMwKihPgcC158QCQSQ95Y6WufiwVRsq8amkrFrsXBcpad9gKUYRIfQX
         YXM+kdOzTn/IDmz/+MYyYpV4v/egzSxOGExYo8d9LaG63GDkB53M6e9v+g4hduJjUqBQ
         B3A9UKgmeG40oLvjPtE0IAQGniIHxIx/n8LHsm0Fu1tP7KFtaKDt8YcD0TZ6ptalW7vY
         po8m8cwLrZzcTulp1kAUsvaLln84ntc4T+a43kjFam10bArs6AVqGUCyxZq3Q2fYgicf
         sqm4C/iY0+oZgGYZNVo/xzIEL9IxLlWm2E2hPaxw88sWC6uIR2CoNIacn0+nBVEc4Cn3
         G8+g==
X-Forwarded-Encrypted: i=1; AJvYcCXAjvqIRpFWt0p1CAPLjDeAqTDLiSXSFIcnQUdLY8TNbOc8M/GaXmZQrlbz4ee9TsYwZplU1BrT4S79jQXk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkqkki525XwhMMEzi7KsY19N9qyRGD4zpiOeaiL/JsoHqfZ8H5
	kH73cFXKQBv4nEaUENYw5PgAuc7eFDUoRDusnAaa06V5vQ/M4eaG3ACIBKRKaI3d9hIzoewm8CR
	/DBP2ZOUC9ADcZDfUVV182CmClInmv2c=
X-Gm-Gg: ASbGnct82yiSrK2FM34dEl60D8rKjhMl4g5vOtXj/z3cuzFETaWeOxS6xpZLtqIYUcJ
	aGMPzpHd+W2Zyy/iGpOxov3Zg6Glc4lGV9Fu3fQ84NLuKJQDrMkKURVXfaUph16r0dKJNVbGFdX
	EiV53yt2YbmWtmz90bXFiGrDStSJ74BkJVYCtrNH6+dSs=
X-Google-Smtp-Source: AGHT+IGTNWnVqTkbIgXRM0547Bu4E8aamEiRRrGMpVGSsB7k0feKhK2STHV2+soHEiOhBnlkIO3j+9R4DygHg3Pgn40=
X-Received: by 2002:a17:906:d54f:b0:ae3:6708:941c with SMTP id
 a640c23a62f3a-ae3d83c1879mr462213566b.6.1751570062786; Thu, 03 Jul 2025
 12:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604160918.2170961-1-amir73il@gmail.com> <e2rcmelzasy6q4vgggukdjb2s2qkczcgapknmnjb33advglc6y@jvi3haw7irxy>
 <CAOQ4uxg1k7DZazPDRuRfhnHmps_Oc8mmb1cy55eH-gzB9zwyjw@mail.gmail.com>
 <2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rinzwbq7xxfjf5z7@3nqidi3mno46>
 <CAOQ4uxgjHGL4=9LCCbb=o1rFyziK4QTrJKzUYf=b2Ri9bk4ZPA@mail.gmail.com> <uxetof5i2ejhwujegsbhltntnozd4rz6cxtqx3xmtc63xugkyq@53bwknir2ha7>
In-Reply-To: <uxetof5i2ejhwujegsbhltntnozd4rz6cxtqx3xmtc63xugkyq@53bwknir2ha7>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Jul 2025 21:14:11 +0200
X-Gm-Features: Ac12FXxbhokpSpcs-sQti377idsX16I6T2-NzcY8obYp9lzEguV6wtl9bUCud8w
Message-ID: <CAOQ4uxhnXaQRDK=LpdPbAMfUU8EPze17=EHASQmG7bN5NdHWew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> > On Mon, Jun 16, 2025 at 11:07=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > > On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > > If we decide that we want to support FAN_PATH_ACCESS from all t=
he
> > > > > > path-less lookup_one*() helpers, then we need to support report=
ing
> > > > > > FAN_PATH_ACCESS event with directory fid.
> > > > > >
> > > > > > If we allow FAN_PATH_ACCESS event from path-less vfs helpers, w=
e still
> > > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ignore ma=
sk, because
> > > > > > we need to provide a way for HSM to opt-out of FAN_PATH_ACCESS =
events
> > > > > > on its "work" mount - the path via which directories are popula=
ted.
> > > > > >
> > > > > > There may be a middle ground:
> > > > > > - Pass optional path arg to __lookup_slow() (i.e. from walk_com=
ponent())
> > > > > > - Move fsnotify hook into __lookup_slow()
> > > > > > - fsnotify_lookup_perm() passes optional path data to fsnotify(=
)
> > > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACCESS wi=
thout
> > > > > >   path data
> > > > > >
> > > > > > This way, if HSM is enabled on an sb and not ignored on specifi=
c dir
> > > > > > after it was populated, path lookup from syscall will trigger
> > > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lookup i=
nside
> > > > > > non-populated directories.
> > > > >
> > > > > OK, but how will this manifest from the user POV? If we have say =
nfs
> > > > > exported filesystem that is HSM managed then there would have to =
be some
> > > > > knowledge in nfsd to know how to access needed files so that HSM =
can pull
> > > > > them? I guess I'm missing the advantage of this middle-ground sol=
ution...
> > > >
> > > > The advantage is that an admin is able to set up a "lazy populated =
fs"
> > > > with the guarantee that:
> > > > 1. Non-populated objects can never be accessed
> > > > 2. If the remote fetch service is up and the objects are accessed
> > > >     from a supported path (i.e. not overlayfs layer) then the objec=
ts
> > > >     will be populated on access
> > > >
> > > > This is stronger and more useful than silently serving invalid cont=
ent IMO.
> > > >
> > > > This is related to the discussion about persistent marks and how to=
 protect
> > > > against access to non-populated objects while service is down, but =
since
> > > > we have at least one case that can result in an EIO error (service =
down)
> > > > then another case (access from overlayfs) maybe is not a game chang=
er(?)
> > >
> > > Yes, reporting error for unpopulated content would be acceptable beha=
vior.
> > > I just don't see this would be all that useful.
> > >
> >
> > Regarding overlayfs, I think there is an even bigger problem.
> > There is the promise that we are not calling the blocking pre-content h=
ook
> > with freeze protection held.
> > In overlayfs it is very common to take the upper layer freeze protectio=
n
> > for a relatively large scope (e.g. ovl_want_write() in ovl_create_objec=
t())
> > and perform lookups on upper fs or lower fs within this scope.
> > I am afraid that cleaning that up is not going to be realistic.
> >
> > IMO, it is perfectly reasonable that overlayfs and HSM (at least pre-di=
r-access)
> > will be mutually exclusive features.
> >
> > This is quite similar to overlayfs resulting in EIO if lower fs has an
> > auto mount point.
> >
> > Is it quite common for users to want overlayfs mounted over
> > /var/lib/docker/overlay2
> > on the root fs.
> > HSM is not likely to be running on / and /etc, but likely on a very
> > distinct lazy populated source dir or something.
> > We can easily document and deny mounting overlayfs over subtrees where
> > HSM is enabled (or just pre-path events).
> >
> > This way we can provide HSM lazy dir populate to the users that do not =
care
> > about overlayfs without having to solve very hard to unsolvable issues.
> >
> > I will need to audit all the other users of vfs lookup helpers other th=
an
> > overlayfs and nfsd, to estimate how many of them are pre-content event
> > safe and how many are a hopeless case.
> >
> > On the top of my head, trying to make a cachefilesd directory an HSM
> > directory is absolutely insane, so not every user of vfs lookup helpers
> > should be able to populate HSM content - should should simply fail
> > (with a meaningful kmsg log).
>
> Right. What you write makes a lot of sense. You've convinced me that
> returning error from overlayfs (or similar users) when they try to access
> HSM managed dir is the least painful solution :).
>

Oh oh, now I need to try to convince you of a solution that is less painful
than the least painful solution ;)

I have been experimenting with some code and also did a first pass audit
of the vfs lookup callers.

First of all, Neil's work to categorize the callers into lookup_noperm*
and lookup_one* really helped this audit. (thanks Neil!)

The lookup_noperm* callers are not "vfs users" they are internal fs
callers that should not call fsnotify pre-content hooks IMO.

The lookup_one* callers are vfs callers like ovl,cachefiles, as well
as nfsd,ksmbd.

Some of the lookup_one() calls are made from locked context, so not
good for pre-content events, but most of them are not relevant anyway
because they are not first access to dir (e.g. readdirplus which already
started to iterate dir).

Adding lookup pre-content hooks to nfsd and ksmbd before the relevant
lookup_one* callers and before fs locks are taken looks doable.

But the more important observation I had is that allowing access to
dirs with unpopulated content is not that big of a deal.

Allowing access to files that are sparse files before their content is fill=
ed
could have led applications to fault and users to suffer.

Allowing access to unpopulated dirs, e.g. from overlayfs or even from
nfsd, just results in getting ENOENT or viewing an empty directory.

My conclusion is, that if we place the fsnotify lookup hook in
lookup_slow() then the only thing we need to do is:
When doing lookup_one*() from possibly unsafe context,
in a fs that has pre-dir-content watchers,
we always allow the lookup,
but we never let it leave a negative dcache entry.

If the lookup finds a child entry, then dir is anyway populated.
If dir is not populated, the -ENOENT result will not be cached,
so future lookups of the same name from safe context will call the hook aga=
in,
populate the file or entire directory and create positive/negative dentry,
and then following lookups of the same name will not call the hook.

The only flaw in this plan is that the users that do not populate
directories can create entries in those directories, which can violate
O_CREAT | O_EXCL and mkdir(), w.r.t to a remote file.

But this flaw can be reported properly by the HSM daemon when
trying to populate a directory which is marked as unpopulated and
finding files inside it.

HSM could auto-resolve those conflicts or prompt admin for action
and can return ESTALE error (or a like) to users.

Was I clear? Does that sound reasonable to you?

Thanks,
Amir.

