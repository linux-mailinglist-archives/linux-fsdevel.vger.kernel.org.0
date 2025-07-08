Return-Path: <linux-fsdevel+bounces-54270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3355AFCF45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070D1165D41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11323BCEB;
	Tue,  8 Jul 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvaubWhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFC21ADA2
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988762; cv=none; b=ASS7W2MN7Y6A4HhNjSxkul8+GLBOv1GDM1/Q2Q4sad7nKgSSQCRFbPvjyZ9OALZWk+lZoFxCa3eMtp+q0ScfMqYqlMzXeBOx7cHXH6RhAHcy18ZvVhU7E9vRlY5CeNaqxh0iy03quSEmXyWquaQKg7egaGj19qCc6g5MKWip3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988762; c=relaxed/simple;
	bh=8sHJZ9RKI4KoH60Bzy3i7PhpzaCmTMuifqgEpqhIcLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipu9VvK9fP8qFnvrnnjWqe6d6aTYOp4dqovdOzUgXa8jlwjYJqGa6lSM52HF6DuJMVfo2tpP3NidXdH+1pFhmDr/CcZ1ADu2XFOAtWyk2bnBsS98h8eu9ZBAZczdj3KbSPhdY54x1YWFPqgMbb480wPPfIjDT9tvlUqIcWGcKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvaubWhC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so949895366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751988759; x=1752593559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykHZu1H1RC+hY+btq0Fw3eCrz9Gap8durwKb/DTOW+I=;
        b=fvaubWhCbSVWoJNwBEbIqRoPurPyp1D7OtaamB3x4ku6XYf+F7JKEXXUgQXEJQ4VeS
         LqBkOJWISGJUcIYf+YkCpNNLO0QlW0uV07oF/vgdNrJOkUwdmQTTTWfEq0Kw3BQAsz/9
         sQLCtmn75XqidZZIItSoLuZ32aZiRm2xcdn1ZMmzBIpgZVyP4GvQ0wfvCQfM9jGwlRUk
         5xbUWSuo894mzos19QpGrqTFmc0zBRuxsMeH4Lk8O5LBvYbzgnWn1vevUWQNJmA5JD/A
         FMuw19psDZeY/8vMhTkooVfQlj3feqOImIQ8Ds3BcMSFAMbC648JteMGoFxjUS6BybMi
         h62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988759; x=1752593559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykHZu1H1RC+hY+btq0Fw3eCrz9Gap8durwKb/DTOW+I=;
        b=Ew8jAEKrrNXMw9sd9CCryzs/vtPk6EMXQ0Na4by12s/cWFJY5rLqjoys44zUbWIda5
         sadR5jHCmZ8tTx6cN3W44iSIMt9zR18ZAuC8orGiISTeAtXFmO89fk+Vkesex5rFpXvU
         9Q48JzxywlunTj9cL5LvFjsI51mHG8FHljIOf+N5838B03o7iBGqdm1y8D+pR5oelbog
         OIyJM67B6dxTO3Sov9HpL+B7hJgrOzjxaLDkNw1o2ecRNRtqr6Tbu9Q4uHXWtQlOrqJN
         tDfzNJ5bf031qfz8ffRxjDBIZEXsQdOHO4s6qj/7BhRWegRJs8wPq8Jc1CGEZLmQEr/A
         1cEw==
X-Forwarded-Encrypted: i=1; AJvYcCVDA8yo0ATfDPqzn0iSPcFcuFueS+H0sxQ9WCiW7d+bvzid2LkwNw49MDIgVYR0sdikSYrLxcU9tvWvJ5UO@vger.kernel.org
X-Gm-Message-State: AOJu0YyQK6SI8sHUqSOqsn+1nD3YFTwhwsJB3VSWiNHR1ckhrV6EWUJy
	qBQF5wgkWEhmWU3L7osncuY+cgYZj7r7TCrRMBy7BdIFy6TQzBxijHzKluEyS3yyi6xZwMzCdAa
	tUwHkhMQZGjiPsLjfW9azeGBSLODxp3g=
X-Gm-Gg: ASbGncte44AYs3HWiGZrsUy09StzB2Ea7mBK69xN3x+XdP5dZHmdXkq4CC2P99/RAvk
	/FhPEe2Sq1I5tXDLxivKf4yvKJVIRtjWWwleX2RD1EqeqoyLJJRKUQ+zgVXUj8MRU09MjvLi3dc
	t5abSBiUuUGFBuUwUGwWgMFRaMdHYMKzrBtMTld+slr69tQK4kYnNqhQ==
X-Google-Smtp-Source: AGHT+IFt0DM/d8i67bi8PsbK8vwVKpxBKzqMumeQWfl/Cfj173aqxYKpU2uuzT0Nt6qJ5b+Ew5M03BJLP7JgE70saqY=
X-Received: by 2002:a17:907:7f0b:b0:ae0:b847:435 with SMTP id
 a640c23a62f3a-ae3fe7491f4mr1777799666b.49.1751988758115; Tue, 08 Jul 2025
 08:32:38 -0700 (PDT)
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
 <gi5bf6arjqycvzs5trox65ld5xaabnkihh4dp5oycsb2a2katp@46puvf6luehw> <CAOQ4uxhttUt6makW6GZGfBb=rat+gH9QQmparX3cexDJwzhVMw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhttUt6makW6GZGfBb=rat+gH9QQmparX3cexDJwzhVMw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Jul 2025 17:32:26 +0200
X-Gm-Features: Ac12FXxlS9jv2bSvzLGi3tBbPIoO7epBJLmlzLni7lQD1gPYaWPkSt5DZXazPqA
Message-ID: <CAOQ4uxiZ=UH+Dp974pecpUq1V8OwJBrzb-gtDRDDEGXL=0nVpA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] fanotify HSM events for directories
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:58=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Jul 4, 2025 at 11:24=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 03-07-25 21:14:11, Amir Goldstein wrote:
> > > On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrot=
e:
> > > > On Mon 16-06-25 19:00:42, Amir Goldstein wrote:
> > > > > On Mon, Jun 16, 2025 at 11:07=E2=80=AFAM Jan Kara <jack@suse.cz> =
wrote:
> > > > > > On Tue 10-06-25 17:25:48, Amir Goldstein wrote:
> > > > > > > On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Jan Kara <jack@suse.c=
z> wrote:
> > > > > > > > On Wed 04-06-25 18:09:15, Amir Goldstein wrote:
> > > > > > > > > If we decide that we want to support FAN_PATH_ACCESS from=
 all the
> > > > > > > > > path-less lookup_one*() helpers, then we need to support =
reporting
> > > > > > > > > FAN_PATH_ACCESS event with directory fid.
> > > > > > > > >
> > > > > > > > > If we allow FAN_PATH_ACCESS event from path-less vfs help=
ers, we still
> > > > > > > > > have to allow setting FAN_PATH_ACCESS in a mount mark/ign=
ore mask, because
> > > > > > > > > we need to provide a way for HSM to opt-out of FAN_PATH_A=
CCESS events
> > > > > > > > > on its "work" mount - the path via which directories are =
populated.
> > > > > > > > >
> > > > > > > > > There may be a middle ground:
> > > > > > > > > - Pass optional path arg to __lookup_slow() (i.e. from wa=
lk_component())
> > > > > > > > > - Move fsnotify hook into __lookup_slow()
> > > > > > > > > - fsnotify_lookup_perm() passes optional path data to fsn=
otify()
> > > > > > > > > - fanotify_handle_event() returns -EPERM for FAN_PATH_ACC=
ESS without
> > > > > > > > >   path data
> > > > > > > > >
> > > > > > > > > This way, if HSM is enabled on an sb and not ignored on s=
pecific dir
> > > > > > > > > after it was populated, path lookup from syscall will tri=
gger
> > > > > > > > > FAN_PATH_ACCESS events and overalyfs/nfsd will fail to lo=
okup inside
> > > > > > > > > non-populated directories.
> > > > > > > >
> > > > > > > > OK, but how will this manifest from the user POV? If we hav=
e say nfs
> > > > > > > > exported filesystem that is HSM managed then there would ha=
ve to be some
> > > > > > > > knowledge in nfsd to know how to access needed files so tha=
t HSM can pull
> > > > > > > > them? I guess I'm missing the advantage of this middle-grou=
nd solution...
> > > > > > >
> > > > > > > The advantage is that an admin is able to set up a "lazy popu=
lated fs"
> > > > > > > with the guarantee that:
> > > > > > > 1. Non-populated objects can never be accessed
> > > > > > > 2. If the remote fetch service is up and the objects are acce=
ssed
> > > > > > >     from a supported path (i.e. not overlayfs layer) then the=
 objects
> > > > > > >     will be populated on access
> > > > > > >
> > > > > > > This is stronger and more useful than silently serving invali=
d content IMO.
> > > > > > >
> > > > > > > This is related to the discussion about persistent marks and =
how to protect
> > > > > > > against access to non-populated objects while service is down=
, but since
> > > > > > > we have at least one case that can result in an EIO error (se=
rvice down)
> > > > > > > then another case (access from overlayfs) maybe is not a game=
 changer(?)
> > > > > >
> > > > > > Yes, reporting error for unpopulated content would be acceptabl=
e behavior.
> > > > > > I just don't see this would be all that useful.
> > > > > >
> > > > >
> > > > > Regarding overlayfs, I think there is an even bigger problem.
> > > > > There is the promise that we are not calling the blocking pre-con=
tent hook
> > > > > with freeze protection held.
> > > > > In overlayfs it is very common to take the upper layer freeze pro=
tection
> > > > > for a relatively large scope (e.g. ovl_want_write() in ovl_create=
_object())
> > > > > and perform lookups on upper fs or lower fs within this scope.
> > > > > I am afraid that cleaning that up is not going to be realistic.
> > > > >
> > > > > IMO, it is perfectly reasonable that overlayfs and HSM (at least =
pre-dir-access)
> > > > > will be mutually exclusive features.
> > > > >
> > > > > This is quite similar to overlayfs resulting in EIO if lower fs h=
as an
> > > > > auto mount point.
> > > > >
> > > > > Is it quite common for users to want overlayfs mounted over
> > > > > /var/lib/docker/overlay2
> > > > > on the root fs.
> > > > > HSM is not likely to be running on / and /etc, but likely on a ve=
ry
> > > > > distinct lazy populated source dir or something.
> > > > > We can easily document and deny mounting overlayfs over subtrees =
where
> > > > > HSM is enabled (or just pre-path events).
> > > > >
> > > > > This way we can provide HSM lazy dir populate to the users that d=
o not care
> > > > > about overlayfs without having to solve very hard to unsolvable i=
ssues.
> > > > >
> > > > > I will need to audit all the other users of vfs lookup helpers ot=
her than
> > > > > overlayfs and nfsd, to estimate how many of them are pre-content =
event
> > > > > safe and how many are a hopeless case.
> > > > >
> > > > > On the top of my head, trying to make a cachefilesd directory an =
HSM
> > > > > directory is absolutely insane, so not every user of vfs lookup h=
elpers
> > > > > should be able to populate HSM content - should should simply fai=
l
> > > > > (with a meaningful kmsg log).
> > > >
> > > > Right. What you write makes a lot of sense. You've convinced me tha=
t
> > > > returning error from overlayfs (or similar users) when they try to =
access
> > > > HSM managed dir is the least painful solution :).
> > > >
> > >
> > > Oh oh, now I need to try to convince you of a solution that is less p=
ainful
> > > than the least painful solution ;)
> >
> > :)
> >
> > > I have been experimenting with some code and also did a first pass au=
dit
> > > of the vfs lookup callers.
> > >
> > > First of all, Neil's work to categorize the callers into lookup_noper=
m*
> > > and lookup_one* really helped this audit. (thanks Neil!)
> > >
> > > The lookup_noperm* callers are not "vfs users" they are internal fs
> > > callers that should not call fsnotify pre-content hooks IMO.
> > >
> > > The lookup_one* callers are vfs callers like ovl,cachefiles, as well
> > > as nfsd,ksmbd.
> > >
> > > Some of the lookup_one() calls are made from locked context, so not
> > > good for pre-content events, but most of them are not relevant anyway
> > > because they are not first access to dir (e.g. readdirplus which alre=
ady
> > > started to iterate dir).
> > >
> > > Adding lookup pre-content hooks to nfsd and ksmbd before the relevant
> > > lookup_one* callers and before fs locks are taken looks doable.
> > >
> > > But the more important observation I had is that allowing access to
> > > dirs with unpopulated content is not that big of a deal.
> > >
> > > Allowing access to files that are sparse files before their content i=
s filled
> > > could have led applications to fault and users to suffer.
> > >
> > > Allowing access to unpopulated dirs, e.g. from overlayfs or even from
> > > nfsd, just results in getting ENOENT or viewing an empty directory.
> >
> > Right. Although if some important files would be missing, you'd still c=
ause
> > troubles to applications and possible crashes (or app shutdowns). But I
> > take the ENOENT return in this case as a particular implementation of t=
he
> > "just return error to userspace if we have no chance to handle the look=
up
> > in this context" policy.
> >
> > > My conclusion is, that if we place the fsnotify lookup hook in
> > > lookup_slow() then the only thing we need to do is:
> > > When doing lookup_one*() from possibly unsafe context,
> > > in a fs that has pre-dir-content watchers,
> > > we always allow the lookup,
> > > but we never let it leave a negative dcache entry.
> > >
> > > If the lookup finds a child entry, then dir is anyway populated.
> > > If dir is not populated, the -ENOENT result will not be cached,
> > > so future lookups of the same name from safe context will call the ho=
ok again,
> > > populate the file or entire directory and create positive/negative de=
ntry,
> > > and then following lookups of the same name will not call the hook.
> >
> > Yes, this looks pretty much like what we've agreed on before, just now =
the
> > implementation is getting more concrete shape. Or am I missing somethin=
g?
> >
>
> What (I think) we discussed before was to fail *any* lookup from
> internal vfs callers to HSM moderated fs, so ovl would also not be able t=
o
> access a populated directory in that case.
>
> What I am suggesting is to always allow the lookup in HSM fs
> and depending on a negative lookup result do "something".
>
> There is a nuance here.
> Obviously, userspace will get ENOENT in this case, but
> does lookup_one() succeed and returns a negative unhashed
> dentry (e.g. to ovl) or does it drop the dentry and fail with -ENOENT?
>
> I was thinking of the former, but I think you are implying the latter,
> which is indeed a bit closer to what we agreed on.
>
> For callers that use lookup_one_positive_unlocked()
> like ovl_lookup(), it makes no difference, but for callers that
> create new entries like ovl_create_upper() it means failure to create
> and that is desirable IMO.
>
> I guess, if ovl_mkdir() fails with -ENOENT users would be a bit confused
> but in a way, this parent directory does not fully exist yet, so
> it may be good enough.
>
> We could also annotate those calls as lookup_one_for_create()
> to return -EROFS in the negative lookup result in HSM moderated dir,
> but not sure that this is needed or if it is less confusing to users.
>
> What's even nicer is that for overlayfs it is the more likely case that
> only the lower layer fs is HSM moderated, e.g. for a composefs
> "image repository".
>
> Adding safe pre-dir-content hooks for overlayfs lower layer lookup
> may be possible down the road. A lot easier that supporting
> lazy dir populates in a rw layer.
>
>

FYI, here is a WIP branch for the scheme that we discussed here:

https://github.com/amir73il/linux/commits/fan_pre_dir_access/

There is an LTP branch of the same name that passes tests.

I also added two simple patches for nfsd support for pre-dir-content events
but they are optional, to demonstrate that internal users could be
supported later.

If you have time to look and give me initial feedback that would be great.

Thanks,
Amir.

