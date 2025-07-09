Return-Path: <linux-fsdevel+bounces-54338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30AAFE368
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1810A7AE590
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620626B778;
	Wed,  9 Jul 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsfrsXgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64C281525
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051657; cv=none; b=TY3YWCCs7ZEVhQKKj5JnqMUD0sgRYff73sURaJH4EM4jGeWuFmNlZ1eUaqWwfp6OsxP6K5WDjc5RHtxatU8HnXV3+SEuN/nDgfpWJeyUIxiWmhkFrYRIDIDvxQoZWsiOXeilAwde7rquUDJ9Y/D9FupBJMLh+ZTX6n+7X2eqr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051657; c=relaxed/simple;
	bh=3SS7fczBg0FUuCdrHjcd8+2Aj+813nRjZwYkKQNvONI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij2kZR5tnbgPDkNF89WIE5EPzvINA5m7Zh9piTJIThHCtL3tBxDPFbZi0TMb8H/MleMCH2UQHAkKx6m2Yq6QHkDDshKlVHxeeSkyx+RV3+B9Wv4dQaPAatjvY14a0anwQEWD48/FACdo5vCKl3+oQf0YDk91tQnJ60pBtRXzl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsfrsXgz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so905803866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752051653; x=1752656453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz++lXVZZRg85V8nKOrpOvqejfIfLzDK/+6R1g01Te0=;
        b=YsfrsXgzUt76QvAI5R141U+ogzyIkYKnBrpCz/DD4znNdfxnp5GlD4cK1b6cBsqCZ0
         D9VsshUSs8t35ePUtIs2NriegL+ibCverChm399eB94BHaaiCThgFL/CcCdau1MS5ypz
         FYinVerUQPb33AXVgs6IRFrqonISYmtT8T0rEcRFPGtzUe73FGh+HjUUhuX/s0lz54mO
         iqZsLTnblyEhObTPPjnjWUH1DozEprqm/KI6I9eIecizs2n0kvt6OD7mzM3x7yY6mUe/
         PphEzyAOjfZVYOjjUVJUcXPyEd318gvT0RpkWcZXU/7gnKX1v6KKWumD+5R77RXK9ETq
         b9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051653; x=1752656453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz++lXVZZRg85V8nKOrpOvqejfIfLzDK/+6R1g01Te0=;
        b=P4rxSt45uMKfDqnnbColLA3qXhPtOGTjKWa+CpRUZNSzfqYCdUHDUiurYUzrp2Zi/r
         +POXCuidT9iI+0D90lTClZ94iudrZCqDek2lwk7CUC8TFjeSD250pLiId6LegGv1Da/j
         Qzy9MQJuxgkCWf8zcK9MCadTM5hJTZToVhcYdzZGNJEwWcJ8VPV3Etw5ek21I3ZSNUId
         w7rlUyqqoaOcyp2RxOFTU6BC6OKSdN/KB1q6YLxAvlju6D3RYuANp/DLbsWvquylbaBj
         Qxi7Ao6++BwH4VR3qbXdmkaw1C2l9LibFR+e+TtMm/a2Qd1EgF34SukUgXufGdp/aKlk
         EAgA==
X-Forwarded-Encrypted: i=1; AJvYcCWyfk0Sx25CYpmSX2jbeIQa4Ny/PGeCJNak3rPm/+4QAVx/0r3fnwTKzbLOXmfZswM8Y4WJA2bp3exLpj5P@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMAA6hjnhU+1d7/yoD37CM6rfpyH4o18MxfGmSgBwqhrNYQh1
	R9NWDCg+riSMIh+iFRfn4NI74iNtzDO/4+bYa+9tCfM7DILjC2J9joGx/MWUTyHhIbNOP2O4ccP
	vO91hFdFeTN4pvulewrglcGOF5t3niVY=
X-Gm-Gg: ASbGncv3cvOWEiCTZac9dQVq2QPajTcZnfywpF2ul5QciquPB1NOt/hTn7PTwOwNDZz
	1QEvlC3p3v804o+BRDzas43zORdllnY8olS0sE30MaNQ6ZLyfmp82aE+K/cgpdC6lFkxpcQvUy7
	z099JyJ0NAr3L61paVLfuhpDsnTXtOJEvYR55nyQJZOMGgshHZ+AkSrA==
X-Google-Smtp-Source: AGHT+IEQHhUlqAlqNU6carduPGmBsodkSwQll1a2fT4tVuWHdD9lczISDXMUZ1pf2OcxHiAahmOHtvCysqAONEWHG5g=
X-Received: by 2002:a17:907:9704:b0:ad8:a935:b8e8 with SMTP id
 a640c23a62f3a-ae6cf526a63mr169848466b.5.1752051652275; Wed, 09 Jul 2025
 02:00:52 -0700 (PDT)
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
 <CAOQ4uxhnXaQRDK=LpdPbAMfUU8EPze17=EHASQmG7bN5NdHWew@mail.gmail.com>
 <gi5bf6arjqycvzs5trox65ld5xaabnkihh4dp5oycsb2a2katp@46puvf6luehw>
 <CAOQ4uxhttUt6makW6GZGfBb=rat+gH9QQmparX3cexDJwzhVMw@mail.gmail.com> <CAOQ4uxiZ=UH+Dp974pecpUq1V8OwJBrzb-gtDRDDEGXL=0nVpA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiZ=UH+Dp974pecpUq1V8OwJBrzb-gtDRDDEGXL=0nVpA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Jul 2025 11:00:40 +0200
X-Gm-Features: Ac12FXw-5S571KyvebXeXwZP4dhd4oZSpMOVrDa3grfREskBbP15FfGaUyuMp4A
Message-ID: <CAOQ4uxjNsY4jyeBFGY9Pu=qV2k_oMjC0LM6k9uk0X_6mQH9OoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 5:32=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Jul 4, 2025 at 12:58=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Fri, Jul 4, 2025 at 11:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 03-07-25 21:14:11, Amir Goldstein wrote:
> > > > On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Jan Kara <jack@suse.cz> wr=
ote:
> > > > > On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> > > > > > On Mon, Jun 16, 2025 at 11:07=E2=80=AFAM Jan Kara <jack@suse.cz=
> wrote:
> > > > > > > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > > > > > > On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse=
.cz> wrote:
> > > > > > > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > > > > > > If we decide that we want to support FAN_PATH_ACCESS fr=
om all the
> > > > > > > > > > path-less lookup_one*() helpers, then we need to suppor=
t reporting
> > > > > > > > > > FAN_PATH_ACCESS event with directory fid.
> > > > > > > > > >
> > > > > > > > > > If we allow FAN_PATH_ACCESS event from path-less vfs he=
lpers, we still
> > > > > > > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/i=
gnore mask, because
> > > > > > > > > > we need to provide a way for HSM to opt-out of FAN_PATH=
_ACCESS events
> > > > > > > > > > on its "work" mount - the path via which directories ar=
e populated.
> > > > > > > > > >
> > > > > > > > > > There may be a middle ground:
> > > > > > > > > > - Pass optional path arg to __lookup_slow() (i.e. from =
walk_component())
> > > > > > > > > > - Move fsnotify hook into __lookup_slow()
> > > > > > > > > > - fsnotify_lookup_perm() passes optional path data to f=
snotify()
> > > > > > > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_A=
CCESS without
> > > > > > > > > >   path data
> > > > > > > > > >
> > > > > > > > > > This way, if HSM is enabled on an sb and not ignored on=
 specific dir
> > > > > > > > > > after it was populated, path lookup from syscall will t=
rigger
> > > > > > > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to =
lookup inside
> > > > > > > > > > non-populated directories.
> > > > > > > > >
> > > > > > > > > OK, but how will this manifest from the user POV? If we h=
ave say nfs
> > > > > > > > > exported filesystem that is HSM managed then there would =
have to be some
> > > > > > > > > knowledge in nfsd to know how to access needed files so t=
hat HSM can pull
> > > > > > > > > them? I guess I'm missing the advantage of this middle-gr=
ound solution...
> > > > > > > >
> > > > > > > > The advantage is that an admin is able to set up a "lazy po=
pulated fs"
> > > > > > > > with the guarantee that:
> > > > > > > > 1. Non-populated objects can never be accessed
> > > > > > > > 2. If the remote fetch service is up and the objects are ac=
cessed
> > > > > > > >     from a supported path (i.e. not overlayfs layer) then t=
he objects
> > > > > > > >     will be populated on access
> > > > > > > >
> > > > > > > > This is stronger and more useful than silently serving inva=
lid content IMO.
> > > > > > > >
> > > > > > > > This is related to the discussion about persistent marks an=
d how to protect
> > > > > > > > against access to non-populated objects while service is do=
wn, but since
> > > > > > > > we have at least one case that can result in an EIO error (=
service down)
> > > > > > > > then another case (access from overlayfs) maybe is not a ga=
me changer(?)
> > > > > > >
> > > > > > > Yes, reporting error for unpopulated content would be accepta=
ble behavior.
> > > > > > > I just don't see this would be all that useful.
> > > > > > >
> > > > > >
> > > > > > Regarding overlayfs, I think there is an even bigger problem.
> > > > > > There is the promise that we are not calling the blocking pre-c=
ontent hook
> > > > > > with freeze protection held.
> > > > > > In overlayfs it is very common to take the upper layer freeze p=
rotection
> > > > > > for a relatively large scope (e.g. ovl_want_write() in ovl_crea=
te_object())
> > > > > > and perform lookups on upper fs or lower fs within this scope.
> > > > > > I am afraid that cleaning that up is not going to be realistic.
> > > > > >
> > > > > > IMO, it is perfectly reasonable that overlayfs and HSM (at leas=
t pre-dir-access)
> > > > > > will be mutually exclusive features.
> > > > > >
> > > > > > This is quite similar to overlayfs resulting in EIO if lower fs=
 has an
> > > > > > auto mount point.
> > > > > >
> > > > > > Is it quite common for users to want overlayfs mounted over
> > > > > > /var/lib/docker/overlay2
> > > > > > on the root fs.
> > > > > > HSM is not likely to be running on / and /etc, but likely on a =
very
> > > > > > distinct lazy populated source dir or something.
> > > > > > We can easily document and deny mounting overlayfs over subtree=
s where
> > > > > > HSM is enabled (or just pre-path events).
> > > > > >
> > > > > > This way we can provide HSM lazy dir populate to the users that=
 do not care
> > > > > > about overlayfs without having to solve very hard to unsolvable=
 issues.
> > > > > >
> > > > > > I will need to audit all the other users of vfs lookup helpers =
other than
> > > > > > overlayfs and nfsd, to estimate how many of them are pre-conten=
t event
> > > > > > safe and how many are a hopeless case.
> > > > > >
> > > > > > On the top of my head, trying to make a cachefilesd directory a=
n HSM
> > > > > > directory is absolutely insane, so not every user of vfs lookup=
 helpers
> > > > > > should be able to populate HSM content - should should simply f=
ail
> > > > > > (with a meaningful kmsg log).
> > > > >
> > > > > Right. What you write makes a lot of sense. You've convinced me t=
hat
> > > > > returning error from overlayfs (or similar users) when they try t=
o access
> > > > > HSM managed dir is the least painful solution :).
> > > > >
> > > >
> > > > Oh oh, now I need to try to convince you of a solution that is less=
 painful
> > > > than the least painful solution ;)
> > >
> > > :)
> > >
> > > > I have been experimenting with some code and also did a first pass =
audit
> > > > of the vfs lookup callers.
> > > >
> > > > First of all, Neil's work to categorize the callers into lookup_nop=
erm*
> > > > and lookup_one* really helped this audit. (thanks Neil!)
> > > >
> > > > The lookup_noperm* callers are not "vfs users" they are internal fs
> > > > callers that should not call fsnotify pre-content hooks IMO.
> > > >
> > > > The lookup_one* callers are vfs callers like ovl,cachefiles, as wel=
l
> > > > as nfsd,ksmbd.
> > > >
> > > > Some of the lookup_one() calls are made from locked context, so not
> > > > good for pre-content events, but most of them are not relevant anyw=
ay
> > > > because they are not first access to dir (e.g. readdirplus which al=
ready
> > > > started to iterate dir).
> > > >
> > > > Adding lookup pre-content hooks to nfsd and ksmbd before the releva=
nt
> > > > lookup_one* callers and before fs locks are taken looks doable.
> > > >
> > > > But the more important observation I had is that allowing access to
> > > > dirs with unpopulated content is not that big of a deal.
> > > >
> > > > Allowing access to files that are sparse files before their content=
 is filled
> > > > could have led applications to fault and users to suffer.
> > > >
> > > > Allowing access to unpopulated dirs, e.g. from overlayfs or even fr=
om
> > > > nfsd, just results in getting ENOENT or viewing an empty directory.
> > >
> > > Right. Although if some important files would be missing, you'd still=
 cause
> > > troubles to applications and possible crashes (or app shutdowns). But=
 I
> > > take the ENOENT return in this case as a particular implementation of=
 the
> > > "just return error to userspace if we have no chance to handle the lo=
okup
> > > in this context" policy.
> > >
> > > > My conclusion is, that if we place the fsnotify lookup hook in
> > > > lookup_slow() then the only thing we need to do is:
> > > > When doing lookup_one*() from possibly unsafe context,
> > > > in a fs that has pre-dir-content watchers,
> > > > we always allow the lookup,
> > > > but we never let it leave a negative dcache entry.
> > > >
> > > > If the lookup finds a child entry, then dir is anyway populated.
> > > > If dir is not populated, the -ENOENT result will not be cached,
> > > > so future lookups of the same name from safe context will call the =
hook again,
> > > > populate the file or entire directory and create positive/negative =
dentry,
> > > > and then following lookups of the same name will not call the hook.
> > >
> > > Yes, this looks pretty much like what we've agreed on before, just no=
w the
> > > implementation is getting more concrete shape. Or am I missing someth=
ing?
> > >
> >
> > What (I think) we discussed before was to fail *any* lookup from
> > internal vfs callers to HSM moderated fs, so ovl would also not be able=
 to
> > access a populated directory in that case.
> >
> > What I am suggesting is to always allow the lookup in HSM fs
> > and depending on a negative lookup result do "something".
> >
> > There is a nuance here.
> > Obviously, userspace will get ENOENT in this case, but
> > does lookup_one() succeed and returns a negative unhashed
> > dentry (e.g. to ovl) or does it drop the dentry and fail with -ENOENT?
> >
> > I was thinking of the former, but I think you are implying the latter,
> > which is indeed a bit closer to what we agreed on.
> >
> > For callers that use lookup_one_positive_unlocked()
> > like ovl_lookup(), it makes no difference, but for callers that
> > create new entries like ovl_create_upper() it means failure to create
> > and that is desirable IMO.
> >
> > I guess, if ovl_mkdir() fails with -ENOENT users would be a bit confuse=
d
> > but in a way, this parent directory does not fully exist yet, so
> > it may be good enough.
> >
> > We could also annotate those calls as lookup_one_for_create()
> > to return -EROFS in the negative lookup result in HSM moderated dir,
> > but not sure that this is needed or if it is less confusing to users.
> >
> > What's even nicer is that for overlayfs it is the more likely case that
> > only the lower layer fs is HSM moderated, e.g. for a composefs
> > "image repository".
> >
> > Adding safe pre-dir-content hooks for overlayfs lower layer lookup
> > may be possible down the road. A lot easier that supporting
> > lazy dir populates in a rw layer.
> >
> >
>
> FYI, here is a WIP branch for the scheme that we discussed here:
>
> https://github.com/amir73il/linux/commits/fan_pre_dir_access/
>

Some more commentary of design choices in this WIP patch set.

We have discussed in the context of page fault events the concept of
a "handle once" HSM event per file range, where events are not
generated if page cache pages are already populated, even if said
page cache pages were populated before the HSM marks were set up.

The pre-content events on page fault did not happen eventually,
but as far as API documentation is concerned, we are still allowed
to suppress multiple pre-content events on the same file range.

A similar concept was applied to pre-dir-content events w.r.t dcache,
but with a few nuances.

The pre-dir-content event from lookup on NAME in DIR is only generated
in lookup_slow() when the dcache entry of NAME is not populated.
If a positive/negative dentry was created before setup of HSM mark,
the event will not be generated.

***This is the new part that we did not discuss that I implemented:***
When a pre-dir-content event WITHOUT a NAME (i.e. from readdir)
is handled by HSM (i.e. FAN_ALLOW response), the dentry is marked
DCACHE_HSM_ONCE and no further pre-dir-content events are generated
on that directory.
The DCACHE_HSM_ONCE flag is not set when there are no HSM marks
or when a directory has an HSM ignore mark!
***

IMO this behavior is inline with the former "handle once" strategy.

> There is an LTP branch of the same name that passes tests.
>
> I also added two simple patches for nfsd support for pre-dir-content even=
ts
> but they are optional, to demonstrate that internal users could be
> supported later.
>

The "handle once" design helps with the implementation of nfsd
pre-dir-content hook.
For simplification, those hooks were implemented in the permission check in=
side
fh_verify(fhp, NFSD_MAY_EXEC) which is called before every nfsd lookup_one(=
)
operation. fhp is the context for the entire "transaction", and this
hook position
is usually [*] safe w.r.t held fs locks.

The DCACHE_HSM_ONCE design, guarantees that there will be a single
"safe context" pre-dir-content event in fh_verify(fhp, NFSD_MAY_EXEC)
and the latter hooks in lookup_one() with freeze protection held will be
suppressed.

However, the nfsd "safe" pre-dir-content hooks are not a must for merging
the pre-dir-content event feature.

If the nfsd "safe" hooks are not merged, nfsd (as will overlayfs) will stil=
l be
able to safely do lookup_one() on directories where HSM marks exist
with some caveats:
- A directory that was already populated (DCACHE_HSM_ONCE)
  will be fully accessible (read/write) for nfsd
- An existing child name (positive dentry) can be looked up by nfsd
- A lookup of non-existing name lookup will return -ENOENT
  as it should (without leaving a negative dentry behind)
- An attempt to create a positive dentry (create/rename) will fail
  with -ENOENT (as if directory is IS_DEADDIR)

[*] in nfsd_create_locked() the fh_verify(fhp, NFSD_MAY_EXEC) is not
in safe context, so there is also a preemptive hook also in fh_want_write(f=
hp)
in nfsd_create().
CC nfsd guys to explain to me why nfsd_create() has a NFSD_MAY_NOP
access permission and not NFSD_MAY_EXEC.

Thanks,
Amir.

