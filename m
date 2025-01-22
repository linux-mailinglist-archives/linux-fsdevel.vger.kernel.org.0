Return-Path: <linux-fsdevel+bounces-39846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905EA19544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 16:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975E81622E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F602147ED;
	Wed, 22 Jan 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWo+dJ2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FB12144DB;
	Wed, 22 Jan 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559809; cv=none; b=cmtCxtfMFm8XJ0pa7SKMuJeptyGcY5N6JMldjZrJBftgpgfqs+p4XgU6QcznoTUtUcxXEqngeNStPLkAWK0pkq8rAk+78HbDFd9wCpUejGYWP6RsDYUSDq2Y4TF3mH8YZlrE2/YtWjv9dAP4L7DRUsoIoIRlIDycbWyQlrg1qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559809; c=relaxed/simple;
	bh=VVTMus9FiiiE+qscpwYKxCwOb0IgaatTOfGcsQmEa0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrEPMA1simRNtgN8F3wv1gpUugB32rT08xTqHOWRcGt8L5+rPYR/RSSggdokQowQZElKejXT+5oP5mGgyw2YuDnPAtIbgRJOlvSJ+X2S2SXZEhoBF8wjJWa8ZnztIG2sgktlbtZiGgmTlPNCsC6PCotP7NJr6sClCv7og71s9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWo+dJ2o; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so1061168166b.1;
        Wed, 22 Jan 2025 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737559805; x=1738164605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xia3n3gFD2Osx4zVkL/+Acf5hDgVmecirrBdyJ1EHjM=;
        b=IWo+dJ2oajRAxw7KMEh9wAG4epKwoWv2EoI7kUe8WEZ0WHuLjMu3d69mZ00s9x9e2c
         t9Z18lVEBO1Vw2EwmavRWm7j3PHSBOermuNCPI66ljmcP0yQvMUvyCh7xgxijc7j6K2k
         KS9ISKrEsnZu7U2jbm47kiTG4ixQvtqa1PokgTHehsbmlmHZdYDDnHWnYkY5bxujldv+
         Wi3lD5JzsjylXKJ926IyEsjQDYGORZu199u/LAUFrbvXuRrVBTOP1ZE6KtiIUZ3Kp+lq
         GC1w1tbm/BRKulqdG39Kqr+LjrHlWb6eHnRzSxZwl4Rwopz5VP+rLR7IzghKbXQByoMj
         HeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559805; x=1738164605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xia3n3gFD2Osx4zVkL/+Acf5hDgVmecirrBdyJ1EHjM=;
        b=LGdhQ4Fv9CvTazr0EcRs9FNB1iCxqImcFHtwZr/T5eJDXs+0DOcawWdVQT6T2kJWKt
         /iZP4C/Lr83XjuxxGHofs0m5pr6te7yTa8MWxejZererNATEoJNCXLeo9zs2OthQzabE
         uNKVU7ex6Ihxxk7KttdxwhXkVoY5zmSJBIFLEEa6ZztQyeDmP7J9wP39Ku92hQrT/D5y
         +lzeO0M6SMNfC6HMHyHXO2majbJ81DwdHCprejk1WdvSAs0EQh/PCiMymEktH1HtkObv
         /Vf3Bc+Eg4IoC5meV7gNx8ueSI9VMD412zWr/JeWWPXzRyWT6cvVkDmc4IMYfTg1h6Fi
         qATw==
X-Forwarded-Encrypted: i=1; AJvYcCVWdU6aAtesLzqoee7gLp3E1WOny8JE4DVw2/4HSq03fq8hraflZoeYghmJpb9gM3X6Gp1YKrZXGP7j@vger.kernel.org, AJvYcCWYObPda/T2iat8s2RCV9YI4CawAmGJBRzyyORDUfVKsdHlPoYxknzGuGx4R6kMFf4o77ASPlMcWRbHOKev@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Q1DttYaRHkWxWbiixiK7O/8xrMO9DHPz+HLCwN6YwFRSVaQu
	hWPV6wemWUI4Ah5fP3zZ0eVVpUjXMP46o4Wf9t6f4p+6rI2Lpz9S13TqDNZ8F+QyY1TBh4diHV+
	x2HVXEvu2480ispeZmd1xcKezKhg=
X-Gm-Gg: ASbGnct3oVQxPjXZ+VafW7mKN4YhmyQSCbvZBKYrJvlgTT53S5KysxVsWo/ARASujmh
	7phbFs1CgkePZ7NqqbjkvyRdc8ioSWGAJILH3Hfn2fag6R7LL5fk=
X-Google-Smtp-Source: AGHT+IF0aAz9AU1evGpib35vsvKAwhvY40I7DDvCfu2MG5hLaljZZN2Jh6zOd2Rh0+kqf/b2Slp71deIgGoElfQoaNY=
X-Received: by 2002:a17:907:7f0d:b0:ab2:b5f1:568c with SMTP id
 a640c23a62f3a-ab38b165e7dmr2082313966b.28.1737559804878; Wed, 22 Jan 2025
 07:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com> <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
In-Reply-To: <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jan 2025 16:29:53 +0100
X-Gm-Features: AWEUYZkqMaX6j3CruVxh-xuV0uqBbK2wxcuewOyia6Sh0UFsQNRl2K43urTJjsA
Message-ID: <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 4:04=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/22/25 4:05 AM, Amir Goldstein wrote:
> > On Tue, Jan 21, 2025 at 11:59=E2=80=AFPM NeilBrown <neilb@suse.de> wrot=
e:
> >>
> >> On Wed, 22 Jan 2025, Amir Goldstein wrote:
> >>> On Tue, Jan 21, 2025 at 8:45=E2=80=AFPM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> >>>>
> >>>> Please send patches To: the NFSD reviewers listed in MAINTAINERS and
> >>>> Cc: linux-nfs and others. Thanks!
> >>>>
> >>>>
> >>>> On 1/21/25 5:39 AM, Amir Goldstein wrote:
> >>>>> Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_uni=
nk.")
> >>>>> mapped EBUSY host error from rmdir/unlink operation to avoid unknow=
n
> >>>>> error server warning.
> >>>>
> >>>>> The same reason that casued the reported EBUSY on rmdir() (dir is a
> >>>>> local mount point in some other bind mount) could also cause EBUSY =
on
> >>>>> rename and some filesystems (e.g. FUSE) can return EBUSY on other
> >>>>> operations like open().
> >>>>>
> >>>>> Therefore, to avoid unknown error warning in server, we need to map
> >>>>> EBUSY for all operations.
> >>>>>
> >>>>> The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
> >>>>> to NFS4ERR_ACCESS in v2/v3 server.
> >>>>>
> >>>>> During the discussion on this issue, Trond claimed that the mapping
> >>>>> made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
> >>>>> protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
> >>>>> for directories.
> >>>>
> >>>> NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
> >>>> file system objects. Here's what I find in RFC 8881 Section 18.25.4:
> >>>>
> >>>>   > If a file has an outstanding OPEN and this prevents the removal =
of the
> >>>>   > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.
> >>>>
> >>>> It's not normative, but it does suggest that any object that cannot =
be
> >>>> associated with an OPEN state ID should never cause REMOVE to return
> >>>> NFS4ERR_FILE_OPEN.
> >>>>
> >>>>
> >>>>> To keep things simple and consistent and avoid the server warning,
> >>>>> map EBUSY to NFS4ERR_ACCESS for all operations in all protocol vers=
ions.
> >>>>
> >>>> Generally a "one size fits all" mapping for these status codes is
> >>>> not going to cut it. That's why we have nfsd3_map_status() and
> >>>> nfsd_map_status() -- the set of permitted status codes for each
> >>>> operation is different for each NFS version.
> >>>>
> >>>> NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMO=
VE.
> >>>>
> >>>> NFSv4 has only REMOVE, and it removes the directory entry for the
> >>>> object no matter its type. The set of failure modes is different for
> >>>> this operation compared to NFSv3 REMOVE.
> >>>>
> >>>> Adding a specific mapping for -EBUSY in nfserrno() is going to have
> >>>> unintended consequences for any VFS call NFSD might make that return=
s
> >>>> -EBUSY.
> >>>>
> >>>> I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(=
),
> >>>> nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
> >>>> trigger a warning.
> >>>>
> >>>>
> >>>
> >>> Sorry, I didn't understand what you are suggesting.
>
> I'm saying that we need to consider the errno -> NFS status code
> mapping on a case-by-case basis first.
>
>
> >>> FUSE can return EBUSY for open().
> >>> What do you suggest to do when nfsd encounters EBUSY on open()?
> >>>
> >>> vfs_rename() can return EBUSY.
> >>> What do you suggest to do when nfsd v3 encounters EBUSY on rename()?
>
> I totally agree that we do not want NFSD to leak -EBUSY to NFS clients.
>
> But we do need to examine all the ways -EBUSY can leak through to the
> NFS protocol layers (nfs?proc.c). The mapping is not going to be the
> same for every NFS operation in every NFS version. (or, at least we
> need to examine these cases closely and decide that nfserr_access is
> the closest we can get for /every/ case).
>
>
> >>> This sort of assertion:
> >>>          WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
> >>>
> >>> Is a code assertion for a situation that should not be possible in th=
e
> >>> code and certainly not possible to trigger by userspace.
> >>>
> >>> Both cases above could trigger the warning from userspace.
> >>> If you want to leave the warning it should not be a WARN_ONCE()
> >>> assertion, but I must say that I did not understand the explanation
> >>> for not mapping EBUSY by default to NFS4ERR_ACCESS in nfserrno().
> >>
> >> My answer to this last question is that it isn't obvious that EBUSY
> >> should map to NFS4ERR_ACCESS.
> >> I would rather that nfsd explicitly checked the error from unlink/rmdi=
r and
> >> mapped EBUSY to NFS4ERR_ACCESS (if we all agree that is best) with a
> >> comment (like we have now) explaining why it is best.
> >
> > Can you please suggest the text for this comment because I did not
> > understand the reasoning for the error.
> > All I argued for is conformity to NFSv2/3, but you are the one who chos=
e
> > NFS3ERR_ACCES for v2/3 mapping and I don't know what is the
> > reasoning for this error code. All I have is:
> > "For NFSv3, the best we can do is probably NFS3ERR_ACCES,
> >    which isn't true, but is not less true than the other options."
>
> You're proposing to change the behavior of NFSv4 to match NFSv2/3, and
> that's where we might need to take a moment. The NFSv4 protocol provides
> a richer set of status codes to report this situation.
>
>

To be fair, I did not propose that in patch v1:
https://lore.kernel.org/linux-nfs/20250120172016.397916-1-amir73il@gmail.co=
m/

I proposed to keep the EBUSY -> NFS4ERR_FILE_OPEN mapping for v4
and extend the operations that it applies to.
Trond had reservations about his mapping.
I have no problem with going back to v1 mapping and reducing the
mapped operations to rmdir/unlink/rename/open or any other mapping
that you prefer.

> >> And nfsd should explicitly check the error from open() and map EBUSY t=
o
> >> whatever seems appropriate.  Maybe that is also NS4ERR_ACCESS but if i=
t
> >> is, the reason is likely different to the reason that it is best for
> >> rmdir.
> >> So again, I would like a comment in the code explaining the choice wit=
h
> >> a reference to FUSE.
> >
> > My specific FUSE filesystem can return EBUSY for open(), but FUSE
> > filesystem in general can return EBUSY for any operation if that is wha=
t
> > the userspace server returns.
>
> Fair, that suggests that eventually we might need the general nfserrno
> mapping in addition to some individual checking in NFS operation- and
> version-specific code. I'm not ready to leap to that conclusion yet.
>
>

I am fine with handling EBUSY in unlink/rmdir/rename/open
only for now if that is what everyone prefers.

> >> Then if some other function that we haven't thought about starts
> >> returning EBUSY, we'll get warning and have a change to think about it=
.
> >>
> >
> > I have no objection to that, but I think that the WARN_ONCE should be
> > converted to pr_warn_once() or pr_warn_ratelimited() because userspace
> > should not be able to trigger a WARN_ON in any case.
>
> It isn't user space that's the concern -- it's that NFS clients can
> trigger this warning. If a client accidentally or maliciously triggers
> it repeatedly, it can fill the NFS server's system journal.
>
> Our general policy is that we use the _ONCE variants to prevent a remote
> attack from overflowing the server's root partition.
>
>

This is what Documentation/process/coding-style.rst has to say:

Do not WARN lightly
*******************

WARN*() is intended for unexpected, this-should-never-happen situations.
WARN*() macros are not to be used for anything that is expected to happen
during normal operation. These are not pre- or post-condition asserts, for
example. Again: WARN*() must not be used for a condition that is expected
to trigger easily, for example, by user space actions. pr_warn_once() is a
possible alternative, if you need to notify the user of a problem.

---

But it's not even that - I find that syzbot and other testers treat any WAR=
N_ON
as a bug (as they should according to coding style).
This WARN_ON in nfsd is really easy to trigger from userspace and from
malicious nfs client.
If you do not replace this WARN_ON, I anticipate that the day will come whe=
n
protocol fuzzers will start bombing you with bug reports.

If it is "possible" to hit this assertion - it should not be an assertion.

> > I realize the great value of the stack trace that WARN_ON provides in
> > this scenario, but if we include in the warning the operation id and th=
e
> > filesystem sid I think that would be enough information to understand
> > where the unmapped error is coming from.
>
> Hm. The stack trace tells us all that without having to add the extra
> (rarely used) arguments to nfserrno. I'm OK with a stack trace here
> because this is information for developers, who can make sense of it.
> It's not a message that a system admin or user needs to understand.
>
>

It's your call. If you are not bothered by the bug reports.

Thanks,
Amir.

