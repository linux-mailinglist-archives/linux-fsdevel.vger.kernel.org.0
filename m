Return-Path: <linux-fsdevel+bounces-41967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F1A396AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC5D188BE53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F722E015;
	Tue, 18 Feb 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV9jLOa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC622AE42;
	Tue, 18 Feb 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870042; cv=none; b=BAPMuhhFysZPcNSW/0pc5hQwsXhDFxdXU5twCqnsOpjS8b2rzF138PQuUVFgOqWECXWo7QexIJ3WKISQd8LJdbMIRci3lpu/FmhEWEZQUCujS+6pG0KafEF1RpmnRjtKktZubqGAvpxZSgK53dnQlZEXV2nEichDFlUKzC2HyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870042; c=relaxed/simple;
	bh=gWNVM12RivD5MRbtbQ5MAGzTtirxN9oxOsKoZrKbhCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzdZ8ZfMAaDSy7cmQFrkMHUZvmAxpv+ZeHUqcrmHiyGv7fsuddgNn4XVdNeATWg2JyaJjYVUDA9HUwpEYJSWaflqsl6XchSZHkrg+jZBNac57X6UKaUiiK9WDaZ0nn5CQvtr+4zrQzhgvYbMuj2y96syCa6RB6vREGow+Kd9g0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV9jLOa+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so671039666b.3;
        Tue, 18 Feb 2025 01:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739870038; x=1740474838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWEFbTINzWxsW/JqJ2SNOyfzIlQF1fNTD3RtsW2hBTc=;
        b=FV9jLOa+HHNnhNNRhI8ut12KBQ9wXXhoTxp0WOEDOQ8XGWWb6QG+KTLoTKcdUXeMyO
         88n5Oy9kCPcmVd3iISdMVcq+xUqsCptZxiRs/V/YjVeZlhupkFabB8O5BO2NM7a+deNS
         mBUMwUXSuDC/NFv+glSU8e31woTv3FvTdtlLzu9xiwGJmO12eT0iXTZtmyQsuP0hPSah
         x6qElP+neGqBkFzrYrIlZwMi6cTUzblWFKlMRHZhRfk9kyyUUYX7Lx0FI4MhNBOo+HBW
         l+VgYUhAp5huYQXnrbxGO2sCClnygaeQKOpZvdGoQau3BcWBowBsXvY/zXXAAtWzRmFI
         C+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870038; x=1740474838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWEFbTINzWxsW/JqJ2SNOyfzIlQF1fNTD3RtsW2hBTc=;
        b=NQkiZclvKf04cncHXI5x9TsqdGS1BFOCM4dSrWgHfoC/AwPQJ1FbetQIQyuzfrt6BE
         V1OV1O1PNw2BeKjO3H6/9aEXLDDEnw6AKkF8Kw/Bo5259lcaMhEM615aewFuwG+mxBac
         lp41l+KQFSBFtqIuDgcbvkEUwSZ0MbxYY9X4pvmB4KX+5kgmQtu+Hhl8MMicLo3BguPO
         Fj2NXxrQ2sNgfnacmmFPBKxy50VHsIXwe10x4SZKBQvM4EEOz/vHlC1rmaigOh2s9/0i
         JbB29M2A31/rGQVJ0f/EuQqgMZv8d1U2t75Mo3/NUkKn+Cn8O/ggTcdtp+M2pRx9DH3x
         /ILQ==
X-Forwarded-Encrypted: i=1; AJvYcCUImb3vSLJL/yg0ue/rb46mnZD/EUCJTsJUOcWqo+IO8UHeyeTXIQoEVhA4F04ZsfocNc6upxEVl1Ck@vger.kernel.org, AJvYcCUMkGCCzGW1rJjUhl1uaeulbnO0q3pYA3N/IZItJb7RF0jVKcbylgZvPjtEfMJ+M9dPHtPTiiDFO6313Tv3qw==@vger.kernel.org, AJvYcCXgXWqgcnVtapdkPRdP8xq4r4VFrRR0FfBMlGkdcRkcrErTZevwpm8sneQKuMMjrefyBqG1ueHMqlITAVlV@vger.kernel.org
X-Gm-Message-State: AOJu0YydcvATTB+xseuHNMaj9OlYQ2KAAe2dUF+XvcTTiR9RUtg/siJh
	pFPIf9a6nNzGOiirIOLdNWgTsSYwGDT5y0oCcSuvm+gsT5sml1qOX54QYKRx+x53a0C3cmyCN2z
	uxEGhcZxf5BoojUeJS9Fs6Xxz+9Q=
X-Gm-Gg: ASbGncv8UuFOhOnDPnDv8RJBQe8TGmGDts4Eq6bN8FxeysldxeHUsFQi29uN4nkGX3W
	pGaPOADZ3/rGvafMb0xhjZsFbgi/ttKOAriYeW0ETq7/yRZkx2h/zng0zWB8/qNDJt2CrrPx4
X-Google-Smtp-Source: AGHT+IEB0b+dHr5UqG8M9ZVSRBF+tFuJVIUL+OTTFEJ9S68qBDv9eHEC4O94JlwUw1UT3y8fVIlx1AqV8ksDo8W53NE=
X-Received: by 2002:a17:906:3ca9:b0:ab7:bac4:b321 with SMTP id
 a640c23a62f3a-abb70be2be7mr1178156566b.29.1739870037904; Tue, 18 Feb 2025
 01:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216164029.20673-1-pali@kernel.org> <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain> <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali> <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
In-Reply-To: <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Feb 2025 10:13:46 +0100
X-Gm-Features: AWEUYZnHvp-MpYsMxX-gG5kYL3y3kpV6TbAqFUCYIVrD73Pbml11umh0ZwxDxJs
Message-ID: <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
To: Dave Chinner <david@fromorbit.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:33=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sun, Feb 16, 2025 at 09:43:02PM +0100, Amir Goldstein wrote:
> > On Sun, Feb 16, 2025 at 9:24=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > > > On Sun, Feb 16, 2025 at 7:34=E2=80=AFPM Eric Biggers <ebiggers@kern=
el.org> wrote:
> > > > >
> > > > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Roh=C3=A1r wrote:
> > > > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits vi=
a FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > > > >
> > > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > >
> > > > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATT=
R, and how does
> > > > > this interact with the existing fscrypt support in ext4, f2fs, ub=
ifs, and ceph
> > > > > which use that flag?
> > > >
> > > > As far as I can tell, after fileattr_fill_xflags() call in
> > > > ioctl_fssetxattr(), the call
> > > > to ext4_fileattr_set() should behave exactly the same if it came so=
me
> > > > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > > > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> > > >
> > > > However, unlike the legacy API, we now have an opportunity to deal =
with
> > > > EXT4_FL_USER_MODIFIABLE better than this:
> > > >         /*
> > > >          * chattr(1) grabs flags via GETFLAGS, modifies the result =
and
> > > >          * passes that to SETFLAGS. So we cannot easily make SETFLA=
GS
> > > >          * more restrictive than just silently masking off visible =
but
> > > >          * not settable flags as we always did.
> > > >          */
> > > >
> > > > if we have the xflags_mask in the new API (not only the xflags) the=
n
> > > > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > > > ext4_fileattr_set() can verify that
> > > > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE =3D=3D 0).
> > > >
> > > > However, Pali, this is an important point that your RFC did not fol=
low -
> > > > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_file=
attr_set()
> > > > (and other fs) does not return any error for unknown xflags, it jus=
t
> > > > ignores them.
> > > >
> > > > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > > > before adding support to ANY new xflags, whether they are mapped to
> > > > existing flags like in this patch or are completely new xflags.
> > > >
> > > > Thanks,
> > > > Amir.
> > >
> > > But xflags_mask is available in this new API. It is available if the
> > > FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improveme=
nt
> > > mentioned above can be included into this new API.
> > >
> > > Or I'm missing something?
> >
> > Yes, you are missing something very fundamental to backward compat API =
-
> > You cannot change the existing kernels.
> >
> > You should ask yourself one question:
> > What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> > on an existing old kernel with the new extended flags?
>
> It should ignore all the things it does not know about.
>

I don't know about "should" but it certainly does, that's why I was
wondering if a new fresh ioctl was in order before extending to new flags.

> But the correct usage of FS_IOC_FSSETXATTR is to call
> FS_IOC_FSGETXATTR to initialise the structure with all the current
> inode state.

Yeh, this is how the API is being used by exiting xfs_io chattr.
It does not mean that this is a good API.

> In this situation, the fsx.fsx_xflags field needs to
> return a flag that says "FS_XFLAGS_HAS_WIN_ATTRS" and now userspace
> knows that it can set/clear the MS windows attr flags.  Hence if the
> filesystem supports windows attributes, we can require them to
> -support the entire set-.
>
> i.e. if an attempt to set a win attr that the filesystem cannot
> implement (e.g. compression) then it returns an error (-EINVAL),
> otherwise it will store the attr and perform whatever operation it
> requires.
>

I prefer not to limit the discussion to new "win" attributes,
especially when discussing COMPR/ENCRYPT flags which are existing
flags that are also part of the win attributes.

To put it another way, suppose Pali did not come forward with a patch set
to add win attribute control to smb, but to add ENCRYPT support to xfs.
What would have been your prefered way to set the ENCRYPT flag in xfs?
via FS_IOC_SETFLAGS or by extending FS_IOC_FSSETXATTR?
and if the latter, then how would xfs_io chattr be expected to know if
setting the ENCRYPT flag is supported or not?

> IMO, the whole implementation in the patchset is wrong - there is no
> need for a new xflags2 field,

xflags2 is needed to add more bits. I am not following.

> and there is no need for whacky field
> masks or anything like that. All it needs is a single bit to
> indicate if the windows attributes are supported, and they are all
> implemented as normal FS_XFLAG fields in the fsx_xflags field.
>

Sorry, I did not understand your vision about the API.
On the one hand, you are saying that there is no need for xflags2.
On the other hand, that new flags should be treated differently than
old flags (FS_XFLAGS_HAS_WIN_ATTRS).
Either I did not understand what you mean or the documentation of
what you are proposing sounds terribly confusing to me.

> > The answer, to the best of my code emulation abilities is that
> > old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> > and this is suboptimal, because it would be better for the new chattr t=
ool
> > to get -EINVAL when trying to set new xflags and mask on an old kernel.
>
> What new chattr tool? I would expect that xfs_io -c "chattr ..."
> will be extended to support all these new fields because that is the
> historical tool we use for FS_IOC_FS{GS}ETXATTR regression test
> support in fstests. I would also expect that the e2fsprogs chattr(1)
> program to grow support for the new FS_XFLAGS bits as well...
>

That's exactly what I meant by "new chattr tool".
when user executes chattr +i or xfs_io -c "chattr +i"
user does not care which ioctl is used and it is best if both
utils will support the entire set of modern flags with the new ioctls
so that eventually (after old fs are deprecated) the old ioctl may also
be deprecated.

> > It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> > ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
> > so I agree that a new ioctl is not absolutely necessary,
> > but I still believe that it is a better API design.
>
> This is how FS{GS}ETXATTR interface has always worked. You *must*
> do a GET before a SET so that the fsx structure has been correctly
> initialised so the SET operation makes only the exact change being
> asked for.
>
> This makes the -API pair- backwards compatible by allowing struct
> fsxattr feature bits to be reported in the GET operation. If the
> feature bit is set, then those optional fields can be set. If the
> feature bit is not set by the GET operation, then if you try to use
> it on a SET operation you'll either get an error or it will be
> silently ignored.
>

Yes, I know. I still think that this is a poor API design pattern.
Imagine that people will be interested to include the fsxattr
in rsync or such (it has been mentioned in the context of this effort)
The current API is pretty useless for backup/restore and for
copying supported attributes across filesystems.

BTW, the internal ->fileattr_[gs]et() vfs API was created so that
overlayfs could copy flags between filesystems on copy-up,
but right now it only copies common flags.

Adding a support mask to the API will allow smarter copy of
supported attributes between filesystems that have a more
specific common set of supported flags.

> > Would love to hear what other fs developers prefer.
>
> Do not overcomplicate the problem. Use the interface as intended:
> GET then SET, and GET returns feature bits in the xflags field to
> indicate what is valid in the overall struct fsxattr. It's trivial
> to probe for native fs support of windows attributes like this. It
> also allows filesystems to be converted one at a time to support the
> windows attributes (e.g. as they have on-disk format support for
> them added). Applications like Samba can then switch behaviours
> based on what they probe from the underlying filesystem...
>

OK, so we have two opinions.
Debating at design time is much better than after API is released...

I'd still like to hear from other stakeholders before we perpetuate
the existing design pattern which requires apps to GET before SET
and treat new (WIN) flags differently than old flags.

Thanks,
Amir.

