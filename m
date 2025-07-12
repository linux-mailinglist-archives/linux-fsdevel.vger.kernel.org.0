Return-Path: <linux-fsdevel+bounces-54755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C2B02A85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 12:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD86E168AEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4C275844;
	Sat, 12 Jul 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccAoL6d3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC494A59;
	Sat, 12 Jul 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752317889; cv=none; b=kNDm4wzQ2Oqzn49rrmIu/kBqa8bzEQTzDyFxaE7PZzLInsM4fbZulXT+BJMkUP89BRO1rpIA0cOg/QY5Aqi+oOYAB+DrdkI1eh0+0bFCZs+m9ZW3kvLvhwAMcwt+TuQojyeFR/J68kN4oGjjLl29704aCxuxns2xVqWNSPele5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752317889; c=relaxed/simple;
	bh=fcie66mWvwOJ6YpAcZs+i1R6TJHgjxefFvTTseHjrac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3L5WrDNf0vdopgTlZD3U2u2QTq7VGeYTFftvHlttkUtLPTB7bHB/sRGnMMzjH7dZP1LB2f2j5fdGVegA8LDLgd4JT+rfBCxoc2jigi7RRpWV6bg4Z/J80vt0ueVugUsFQ1kNLYXz/EWJaUj7Xk+RdSqjwoa0HY8lHCrYo3jWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccAoL6d3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1897001f8f.0;
        Sat, 12 Jul 2025 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752317886; x=1752922686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq31oy/tF7ji6FEBX3VPLuFkrFDumCL1oq4Tw5MVgnI=;
        b=ccAoL6d32CJV/7MOQinY+wX7DkzDCHdsuJVUBTLYotmnHtpxshE/0Tq2Ft9OFt6zru
         M9bTtkxj9MCWpboaJRe7LKccxUai+ClKSskf3KnqkL0Bl/XjM6nYM9CCXd9nPkAKvxe5
         UVYQXroU5XX6g9t9wjTKt/E53/DGy6u9lMuDKSIzYsYjrE3MWr+t47mJfujVBseetoRU
         Zw8064wb2NVq29KSPCMqHOMIdiSFdr2UuCNQLwQVo8vjsfiEQSccOyHlRDbBtXOBgOEX
         vUDuopQnEFhRGrstdhyifeD6XeZpdzJxaBaq2o2FvGfHSJkavDbt4JLdMDlUSuBmgjVQ
         hcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752317886; x=1752922686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq31oy/tF7ji6FEBX3VPLuFkrFDumCL1oq4Tw5MVgnI=;
        b=Az/fTUxd+bCNYbBMQppwrUj4Wu+TN9xOZu5lNivkM+Cw84+UKQheI351SBAetliyW+
         UInjUce+2S/lkr0p+vOKdQWYMhTWiLTwtt9QMMvvZm5VljhwZRtUYCLkVN2aX9GcaNNl
         mv9XmU2BnRXE5QKIdkc2fbLUVy/aUjH0LonD3V67bOHhna/NnBgrljapClsCWQMSW3z+
         1fy3F0VTJlnzWHpof+d0Fnt6DlP4XBEHGyAuFz5nvUxu+bIPtgTimKHdHOySAvnDW0e6
         j7/XttldE2KNi6maDap7qmnrtnfDGW3U5doEF47aXVNuuxqZgB7G8Yv9my6G/FoWwA/v
         T2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWe8fC5cGZiNPA+eL9J6Oog6sf+TJrAMZG3TXpa3dlVMU5sf6TL8UqxomwKFNmL8pnFvPLc8jnrYOK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7HNeWmlmMXqsgSVBp1Kj12lz9YxxOCpRqX+MquPMCAdCdjeX
	OpVHS4p/tYQFVnzf+nxw3ITuHYyN8GtDrTddmwAqzYxrZUpSrPHvYWa8hMoYTwlWbSF6lkDSXlT
	WMfCDz+DnPNVvuRPAEfIT+qtm8bN6eco=
X-Gm-Gg: ASbGnct76sTMKYejRB4Pm61THNZc20Z89Pe8CtU7Kqvw87zkOFzT6fll8OUvbYPs3K4
	ucg2PSke9v5l1D5MapZJrH9lDnxrb/mWGTkxO1bQ8/jr3F5qTjeV4ditNORhycvLDyaEgNGout+
	2HNrtR0o9DYPquTUgo3bjp7JRsMT54Cw8wTjTTswsVniuvUl0WyGBcPcg7ANrKHiFia3MqnawO1
	KM9p+U=
X-Google-Smtp-Source: AGHT+IEH8XVA4Dbd1XVWRumbmfyNno76vxcb3Jvk4QDfFtuh3jCMqVQvGbZu+bvosgMEZGxLi/KdgxM3VlelbHQbn1o=
X-Received: by 2002:a5d:6f1d:0:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b5f1c726admr5744274f8f.10.1752317885736; Sat, 12 Jul 2025
 03:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Jul 2025 12:57:53 +0200
X-Gm-Features: Ac12FXy4aqVq-PS4EwmQxehOdSXtpELetqRZGIC420RrnVT6jgdkfCA_90IVY4c
Message-ID: <CAOQ4uxhp3Zs-J92jcXPAD=VjY=t0s0=kf2bOMo50E-Lk6tWJgA@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, May 29, 2025 at 6:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
...
> > So I /think/ we could ask the fuse server at inode instantiation time
> > (which, if I'm reading the code correctly, is when iget5_locked gives
> > fuse an INEW inode and calls fuse_init_inode) provided it's ok to upcal=
l
> > to userspace at that time.  Alternately I guess we could extend struct
> > fuse_attr with another FUSE_ATTR_ flag, I think?
> >
>
> The latter. Either extend fuse_attr or struct fuse_entry_out,
> which is in the responses of FUSE_LOOKUP,
> FUSE_READDIRPLUS, FUSE_CREATE, FUSE_TMPFILE.
> which instantiate fuse inodes.
>

Update:
I went to look at this extension for my inode ops passthrough patches.

What I saw is that while struct fuse_attr and struct fuse_entry_out
are designed to be extended and have been extended in the past:
 * 7.9:
 *  - add blksize field to fuse_attr

Later on, struct fuse_direntplus was introduced
 * 7.21
 *  - add FUSE_READDIRPLUS

With struct struct fuse_entry_out/fuse_attr embedded in the middle
and I don't see any code in the kernel/lib that is prepared to handle
a change in the FUSE_NAME_OFFSET_DIRENTPLUS constant
(maybe it's there and I am missing it)

So for my own use, which only requires passing a single int backing_id
I was tempted to try and overload attr_valid{,_nsec} which are
not relevant for passthrough getattr case,
something like {attr_valid =3D backing_id, attr_valid_nsec =3D UTIME_OMIT}.

In the meanwhile, as an example I used a hole in struct fuse_attr_out
to implement backing file setup in reply to GETATTR in the wip branch [1].

Bernd,

I wonder if I am missing something w.r.t the intended extensibility of
struct fuse_entry_out/fuse_attr and current readdirplus code?

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/

