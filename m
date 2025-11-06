Return-Path: <linux-fsdevel+bounces-67346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F7C3C59C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A066D352086
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8E3596F7;
	Thu,  6 Nov 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWx40cys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45633590A1
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445532; cv=none; b=rACmta5oQp4M7oU0PHAgBJFGcHxvOdT9uWaZOSkYcNOnJMUiBOhoB9Ndb06mbgMHDE2/slLYwziXyfyPQaAUH07PzVUXZpJUhMDPShNUl9rgRmD4kMOtJtGJk5BLj+lTQdpb3ZHfLauhJ+iDu6Bo1p6nrd99+qCj7AIaCvkGE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445532; c=relaxed/simple;
	bh=NbJj9rTQle2z19HgYJ5MWl9JI99ZIRhaunRQvc4H06g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiJonQHjYZfabh2Vduie8cyZVD3bgzSuG7SYNwMIApBHugukIli+ORyHYffsCQ2Zmw283HRHQX2z7QmGfY9itpK5NfhZCLSjDx7Lm2eq6t6MBnL8Xpq+fjRlFGXhXIXI1XUAgoR9QP2nXLNyELdboCNWMoPP+geB1a5PEIh5yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWx40cys; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so2031663a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445529; x=1763050329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnzUbhAGhtiikERLfxbbxGU6Jui5/OxYbpanoHjzJwo=;
        b=dWx40cysVl/PjWtX74P7LT/3vf/rfUuvrRWPBVAmXtkW1uokUJwa7loA4aslq3h9gV
         gr7y1qks8k92rMof38y5URthUboiM3eprQTDqC4mcwPe6VTtGm3v8R0mgvsdeHlMZrJL
         M+8syqXoKTEKoBdWLBdjq3IGzjBfYiPb7TO1DSAve7hzJ0XTekgmtPwyw2XAblhFw83B
         Xj18XuigY4GAp0Cdoej0yYIvsqXkDu0ZrwztbY6X+pMdm06btjlVffBcTLiC+XFf1y/B
         nGUgrcny1dyWg3BEbNejiaQlxXQXuoWna2ORCYc0h3w7W6NSI0qShl5qO76ggQFdxdv2
         QylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445529; x=1763050329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnzUbhAGhtiikERLfxbbxGU6Jui5/OxYbpanoHjzJwo=;
        b=vIvVPdHwvyH0fR6Q9JbqJl6TJyrMVrnFU0pGFRvaswy7gEra+6H4TOu5XCoDWJwkmM
         G9dphpYcTk73NB1Vn+kYmMUasZSxf2FDtCkSAXH7Eq2eUYQlpWOstCQHUiaR35o4GQ+j
         0no9sdWh2P7x4W2nS81bD8Ozp3hVSJ3ofXP6hPdZhJLKpjUbcvGRVmqsEbXGNRQcK4JK
         qlKx5vhqq0WwdhPtunc3VfM6Jc8b8IZt8hd0DtYgq9ok+qQEE49CQqwfNrSSGi+d32hE
         GcfGhv2I5azOYzktEzN2QF1JB3gtGOXudxAAtpBlZN6YVCU46l2l1fLPOxcKga1ouN5S
         hfpw==
X-Forwarded-Encrypted: i=1; AJvYcCXrM07CggEX0UVWAfrWIhqzT93z+CZypAtSVvh2shELfIfhplpbCEaXBng6zpuKpc7eh442fYs5Wns4l9MH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxkvx6pzNCYljAK3QePnr4miDG8xjJ5nm/m5sxXl3r0d3sh+xj
	jcm3OTsfv33iKRPoRXHVJGJSwEitWRArmXBRilA4PuN6AeW2vHnRZpxtz6lvwyu8M0nDVg0mpv7
	104fy21G/tHMc9XDcKHT6zli4d3Ug6p8=
X-Gm-Gg: ASbGncsqHOiYcl4bcFMxxgIfB6ggn+HsaFS1lKnhWrA+u7tZPYCDMZglKICAxwPtSq6
	UAVSvqHtqzAdKz6HJO1awXcDPYaDjo4Ujyh4pvXMR8FqgqJGp34jNo0GdDzdQqBpXw9CEdD+N8Q
	RzS+l6WQpMonlbfJzUttg4J4X1YAaCXQqaY+EGvtKJ2vyTFT5xi/ykphwRbctenJxheijETZgHr
	oBcnCO+XxTmyhU7lh3xGzsV0iJblC4obvkEzIehK5PPiGzb9Hz9Zp6v5gCyYZcutRq4eyPPFdwh
	E/NL4+mImx3JRAzcc3KQ3X8s+i79C4YJVzwwjvKi
X-Google-Smtp-Source: AGHT+IFu4h93C4tc1A9QoKKyl4nvS7r/OLUFDtq4F1bju/fRPK7xWdltxiKdlUWE8bKunfVG/DxpCyiqg7Afj7IykpM=
X-Received: by 2002:a05:6402:5251:b0:63c:18e:1dee with SMTP id
 4fb4d7f45d1cf-64105a48104mr7659373a12.24.1762445528567; Thu, 06 Nov 2025
 08:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com> <20251105224245.GP196362@frogsfrogsfrogs>
 <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com> <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
 <20251106154940.GF196391@frogsfrogsfrogs>
In-Reply-To: <20251106154940.GF196391@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 6 Nov 2025 17:11:56 +0100
X-Gm-Features: AWmQ_bnkeq4DJh6pYcDoOyVTl77x98taKvxhHR6JnALCqm1GLalcfSIbGgqlyA0
Message-ID: <CAOQ4uxhaDboSe0T1tb9ArVDFg9SEQCBmSH3YEGJv_fG0kJmu2Q@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Nov 06, 2025 at 11:13:01AM +0100, Amir Goldstein wrote:
> > [...]
> >
> > > >>> fuse_entry_out was extended once and fuse_reply_entry()
> > > >>> sends the size of the struct.
> > > >>
> > > >> Sorry, I'm confused. Where does fuse_reply_entry() send the size?
> >
> > Sorry, I meant to say that the reply size is variable.
> > The size is obviously determined at init time.
> >
> > > >>
> > > >>> However fuse_reply_create() sends it with fuse_open_out
> > > >>> appended and fuse_add_direntry_plus() does not seem to write
> > > >>> record size at all, so server and client will need to agree on th=
e
> > > >>> size of fuse_entry_out and this would need to be backward compat.
> > > >>> If both server and client declare support for FUSE_LOOKUP_HANDLE
> > > >>> it should be fine (?).
> > > >>
> > > >> If max_handle size becomes a value in fuse_init_out, server and
> > > >> client would use it? I think appended fuse_open_out could just
> > > >> follow the dynamic actual size of the handle - code that
> > > >> serializes/deserializes the response has to look up the actual
> > > >> handle size then. For example I wouldn't know what to put in
> > > >> for any of the example/passthrough* file systems as handle size -
> > > >> would need to be 128B, but the actual size will be typically
> > > >> much smaller.
> > > >
> > > > name_to_handle_at ?
> > > >
> > > > I guess the problem here is that technically speaking filesystems c=
ould
> > > > have variable sized handles depending on the file.  Sometimes you e=
ncode
> > > > just the ino/gen of the child file, but other times you might know =
the
> > > > parent and put that in the handle too.
> > >
> > > Yeah, I don't think it would be reliable for *all* file systems to us=
e
> > > name_to_handle_at on startup on some example file/directory. At least
> > > not without knowing all the details of the underlying passthrough fil=
e
> > > system.
> > >
> >
> > Maybe it's not a world-wide general solution, but it is a practical one=
.
> >
> > My fuse_passthrough library knows how to detect xfs and ext4 and
> > knows about the size of their file handles.
> > https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/f=
use_passthrough.cpp#L645
> >
> > A server could optimize for max_handle_size if it knows it or use
> > MAX_HANDLE_SZ if it doesn't.
> >
> > Keep in mind that for the sake of restarting fuse servers (title of thi=
s thread)
> > file handles do not need to be the actual filesystem file handles.
> > Server can use its own pid as generation and then all inodes get
> > auto invalidated on server restart.
> >
> > Not invalidating file handles on server restart, because the file handl=
es
> > are persistent file handles is an optimization.
> >
> > LOOKUP_HANDLE still needs to provide the inode+gen of the parent
> > which LOOKUP currently does not.
> >
> > I did not understand why Darrick's suggestion of a flag that ino+gen
> > suffice is any different then max_handle_size =3D 12 and using the
> > standard FILEID_INO64_GEN in that case?
>
> Technically speaking, a 12-byte handle could contain anything.  Maybe
> you have a u32 volumeid, inumber, and generation, whereas the flag that
> I was mumbling about would specify the handle format as well.
>
> Speaking of which: should file handles be exporting volume ids for the
> filesystem (btrfs) that supports it?
>

file handles are opaque so the server can put whatever server wants in them
it does not need to put the native fs file handles (in case of passthrough =
fs
or in case of iomap fs).

Take struct ovl_fh for example, the format of file handles that overlayfs
exports to NFS encapsulates the underlying fs uuid and file handle.

Note that when exporting such a fuse filesystem to NFS, it is still the
responsibility of the exporter to specify an explicit fsid identifier in
/etc/exports for this fuse server type/instance and then the file handles
generated by this server are expected to be unique in the scope of this
NFS export. Not sure how much of this is relevant for the use case
of restarting a fuse server.

Thanks,
Amir.

