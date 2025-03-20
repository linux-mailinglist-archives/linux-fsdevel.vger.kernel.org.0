Return-Path: <linux-fsdevel+bounces-44623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA828A6AB9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C2188A210
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C91EB5F0;
	Thu, 20 Mar 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBJS66lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6142065
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490056; cv=none; b=NxXruoKrxKKGz+JnOR11ES5ahtoNwbVp9i8SJX+0MzBxIwHcvIfYXgtVCMQ2eYnOFN9iol7bWM4Y9PqbN5UCpZp4dpsCX2LHwb9yEfH7a61W+zuPdI3auifA6fRhVPU0SEW+Yict2LsNL/Qu1mIRknKO83b3eWEfXyse48n33l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490056; c=relaxed/simple;
	bh=PU6R+wPFTRLoSpAjFSt+4EcJEERtPHK4ICoCLjO4sow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXrEfpLXRyheMkgwIc90pmyS5c/KkvkPUR9rxqafDttXL7YkfydBWzaIBJFyk39NP1tfsaHhUlqyOTU7y/eRwJEGHvSKCDLeYpegE7h8677awUNkJzV++7JvuAAFIcfBEXv2oXapw1pNL3tJ7bB3urSlGvcuqdchyyDam6kqKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBJS66lj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso180515766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742490053; x=1743094853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFJeoOiqJ8FbRuMY8d+eOqJGpdi4Y9e7kZ/UxPwtCO0=;
        b=YBJS66ljXMx08rlV6F0HW4rrJ77LFm+1EMCmmNkAcDTXR2LRSWhs5BmQU/G1fDKaUD
         njI182Otyqy452JOpuSqfLBaCFZRZPD2f8lQJoVk6rKDSa5JDY89femRufavmVsulqB0
         ACdkrGBt8ivV1ll4ubTGhVisl20cOBoIpV1meUgAIQZU+YaGZlBlFr5p012EoHNa8TyI
         7hfsHIDWBppVSC5IHCcDDyoTizQRjVSfQVABdpuIL1rj2Cq08si4gysLdZFTTPguioWg
         bdzvFglarz3u8r0+SmGLypxlUbJahYt+lwaRn+rKHX5rmAFVBeGvyxjiYgxGnaW+5X+n
         UitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742490053; x=1743094853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFJeoOiqJ8FbRuMY8d+eOqJGpdi4Y9e7kZ/UxPwtCO0=;
        b=rFavimT9TdX8Pm9pzbLIxD8URn2Gwpgvq7ERr+b/cDefgp28L8W1A6Q9RuC4DS5EnL
         js11I/MmJnD4j3JL+xt2vKYiIoWT8ZAnir16T5AzZoLExgmyXp1nHjVLr5muUQWxzHb7
         hoTOWWBTxOOCmvtIT6i/0iMWGgkQ4zp3lT9EYVddO0/S9snOU8M5gF8382hUibELWmXR
         lUs8lc1pfB9RKFmtSKrWQEhvfYhlGLwwGQoz8s1YvN3ZCaaq8GEwbVgkNpIvTiRMXOAO
         13RoAWcpC179mGp2KRXJXi4NLi2gczPHPNrcFMM62TtSdnFiGS1vISAio7AMVOg5iu3q
         HTcA==
X-Forwarded-Encrypted: i=1; AJvYcCV6D2oWBMIbUBZLbCTTfOdTtXlO4vbEHrKNf0uryUCsCgr3/pkPogAJdyeKUjLPqqovJqeCHE28pa9bWHqU@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiGwcLgjbwb7gaVb+CiG4OARX/DgFHPQvjNdwhbcJormm3M71
	jMmmdWI7UOOY9hgu3csIEv0JEdR7nNjIMvyq16/YtB5yq9ueWPsfCh79WrVOJG9yV3anHVmKQ0v
	CE5khys0Pe4yWg6vgm3zw6q30kwg=
X-Gm-Gg: ASbGncuHEqkVZv9UwmVW5i9hwVFiP/YixoGBzk6n9Wrd434p4Luw9YCelBzXjhMlyBT
	WFpHusBrPQg+gIpU+/k+H6mR+sa+Y572QUpThnMizJ0aZz1cCAl1AF/4M2ab79WeEsi32swVdLk
	16YMf4IKA1ToqSSIMzqbJb2AbAX11TwczcsBPJ
X-Google-Smtp-Source: AGHT+IEK+Gx4M545quvtd2AA8LUzhnO2YYVjTQ730xTz5cykMagH7f1Ggx8Q/7DXxz9ICNc3Ia3Jw03ClI3LZ1dZ6VY=
X-Received: by 2002:a17:907:7208:b0:ac2:898f:ba50 with SMTP id
 a640c23a62f3a-ac3cdf8e3b7mr442674566b.7.1742490052081; Thu, 20 Mar 2025
 10:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org> <gihbrvdkldci257z5amkrowcsrzgjjmtnif7ycvpi6rsbktvnz@rfqybs7klfkj>
In-Reply-To: <gihbrvdkldci257z5amkrowcsrzgjjmtnif7ycvpi6rsbktvnz@rfqybs7klfkj>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Mar 2025 18:00:40 +0100
X-Gm-Features: AQ5f1Jq49eriq2unsRiotrXflSLZR54CA781Diw64heWHNDEpVEMZ50ncFQxFJU
Message-ID: <CAOQ4uxinA4C0iJCwZqkhLo-R9NLF=Sd_YXHEcXCX2BBNBSvNAA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 23-01-25 13:14:11, Jeff Layton wrote:
> > On Mon, 2025-01-20 at 12:41 +0100, Amir Goldstein wrote:
> > > On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromorbi=
t.com> wrote:
> > > >
> > > > On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > > > > Hi all,
> > > > >
> > > > > I would like to present the idea of vfs write barriers that was p=
roposed by Jan
> > > > > and prototyped for the use of fanotify HSM change tracking events=
 [1].
> > > > >
> > > > > The historical records state that I had mentioned the idea briefl=
y at the end of
> > > > > my talk in LSFMM 2023 [2], but we did not really have a lot of ti=
me to discuss
> > > > > its wider implications at the time.
> > > > >
> > > > > The vfs write barriers are implemented by taking a per-sb srcu re=
ad side
> > > > > lock for the scope of {mnt,file}_{want,drop}_write().
> > > > >
> > > > > This could be used by users - in the case of the prototype - an H=
SM service -
> > > > > to wait for all in-flight write syscalls, without blocking new wr=
ite syscalls
> > > > > as the stricter fsfreeze() does.
> > > > >
> > > > > This ability to wait for in-flight write syscalls is used by the =
prototype to
> > > > > implement a crash consistent change tracking method [3] without t=
he
> > > > > need to use the heavy fsfreeze() hammer.
> > > >
> > > > How does this provide anything guarantee at all? It doesn't order o=
r
> > > > wait for physical IOs in any way, so writeback can be active on a
> > > > file and writing data from both sides of a syscall write "barrier".
> > > > i.e. there is no coherency between what is on disk, the cmtime of
> > > > the inode and the write barrier itself.
> > > >
> > > > Freeze is an actual physical write barrier. A very heavy handed
> > > > physical right barrier, yes, but it has very well defined and
> > > > bounded physical data persistence semantics.
> > >
> > > Yes. Freeze is a "write barrier to persistence storage".
> > > This is not what "vfs write barrier" is about.
> > > I will try to explain better.
> > >
> > > Some syscalls modify the data/metadata of filesystem objects in memor=
y
> > > (a.k.a "in-core") and some syscalls query in-core data/metadata
> > > of filesystem objects.
> > >
> > > It is often the case that in-core data/metadata readers are not fully
> > > synchronized with in-core data/metadata writers and it is often that
> > > in-core data and metadata are not modified atomically w.r.t the
> > > in-core data/metadata readers.
> > > Even related metadata attributes are often not modified atomically
> > > w.r.t to their readers (e.g. statx()).
> > >
> > > When it comes to "observing changes" multigrain ctime/mtime has
> > > improved things a lot for observing a change in ctime/mtime since
> > > last sampled and for observing an order of ctime/mtime changes
> > > on different inodes, but it hasn't changed the fact that ctime/mtime
> > > changes can be observed *before* the respective metadata/data
> > > changes can be observed.
> > >
> > > An example problem is that a naive backup or indexing program can
> > > read old data/metadata with new timestamp T and wrongly conclude
> > > that it read all changes up to time T.
> > >
> > > It is true that "real" backup programs know that applications and
> > > filesystem needs to be quisences before backup, but actual
> > > day to day cloud storage sync programs and indexers cannot
> > > practically freeze the filesystem for their work.
> > >
> >
> > Right. That is still a known problem. For directory operations, the
> > i_rwsem keeps things consistent, but for regular files, it's possible
> > to see new timestamps alongside with old file contents. That's a
> > problem since caching algorithms that watch for timestamp changes can
> > end up not seeing the new contents until the _next_ change occurs,
> > which might not ever happen.
> >
> > It would be better to change the file write code to update the
> > timestamps after copying data to the pagecache. It would still be
> > possible in that case to see old attributes + new contents, but that's
> > preferable to the reverse for callers that are watching for changes to
> > attributes.
> >
> > Would fixing that help your use-case at all?
>
> I think Amir wanted to make here a point in the other direction: I.e., if
> the application did:
>  * sample inode timestamp
>  * vfs_write_barrier()
>  * read file data
>
> then it is *guaranteed* it will never see old data & new timestamp and he=
nce
> the caching problem is solved. No need to update timestamp after the writ=
e.
>
> Now I agree updating timestamps after write is much nicer from usability
> POV (given how common pattern above it) but this is just a simple example
> demonstrating possible uses for vfs_write_barrier().
>

I was trying to figure out if updating timestamp after write would be enoug=
h
to deal with file writes and I think that it is not enough when adding
signalling
(events) into the picture.
In this case, the consumer is expected to act on changes (e.g. index/backup=
)
soon after they happen.
I think this case is different from NFS cache which only cares about cache
invalidation on file access(?).

In any case, we need a FAN_PRE_MODIFY blocking event to store a
persistent change intent record before the write - that is needed to find
changes after a crash.

Now unless we want to start polling ctime (and we do not want that),
we need a signal to wake the consumer after the write to page cache

One way is to rely on the FAN_MODIFY async event post write.
But there is ambiguity in the existing FAN_MODIFY events:

    Thread A starts write on file F (no listener for FAN_PRE_MODIFY)
Event consumer starts
        Thread B starts write on file F
        FAN_PRE_MODIFY(F) reported from thread B
    Thread A completes write on file F
    FAN_MODIFY(F) reported from thread A (or from aio completion thread)
Event consumer believes it got the last event and can read the final
version of F

So if we use this method we will need a unique cookie to
associate the POST_MODIFY with the PRE_MODIFY event.

Something like this:

writer                                [fsnotifyd]
-------                                -------------
file_start_write_usn() =3D> FAN_PRE_MODIFY[ fsid, usn, fhandle ]
{                                 <=3D Record change intent before response
=E2=80=A6do some in-core changes
   (e.g. data + mode + ctime)...
} file_end_write_usn() =3D> FAN_POST_MODIFY[ fsid, usn, fhandle ]
                                         Consume changes after FAN_POST_MOD=
IFY

While this is a viable option, it adds yet more hooks and more
events and it does not provide an easy way for consumers to
wait for the completion of a batch of modifications.

The vfs_write_barrier method provides a better way to wait for completion:

writer                                [fsnotifyd]
-------                                -------------
file_start_write_srcu() =3D> FAN_PRE_MODIFY[ fsid, usn, fhandle ]
{                                  <=3D Record change intent before respons=
e
=E2=80=A6do some in-core changes under srcu read lock
   (e.g. data + mode + ctime)...
} file_end_write_srcu()
     synchronize_srcu()   <=3D vfs_write_barrier();
                    Consume a batch of recorded changes after write barrier
                    act on the changes and clear the change intent records

I am hoping to be able to argue for the case of vfs_write_barrier()
in LSFMM, but if this will not be acceptable, I can work with the
post modify events solution.

Thanks,
Amir.

