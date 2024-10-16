Return-Path: <linux-fsdevel+bounces-32157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E69A15F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 01:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB803B2326E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB5188583;
	Wed, 16 Oct 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WnxmZKyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E41925BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729119928; cv=none; b=aaRTFtuKKDsD9HaLTSElSfBpDgRQiPOpCHJzi0WVYRAyyvLTcw5d8opyznq2q6A72GJE23tHyy8tDybq4PjLZ+DYI5q/a1Sx4jXN1yYeFGixVJaiKskTE7G51Nx1mUvgADp2jEZnoeE6q9r2dNm2fW23qMAQsY7pwSVA0QObpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729119928; c=relaxed/simple;
	bh=d0uKaAXKONrOkDyAtX/h88dJkchHL1dn8bs4MDPcvQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6UXDIrOOTrwwl7j/SbDd3gaVEbRSXQDMVliAjiMssvNSg4iflaavTLOtsUUNKij64cEHRDLJ95LNC0nlVkW9zcOolh6TMFme/qE2S0V8c4EkbVvPn61b7IhLi9mmVXqfyJUfZ9FfJc2ku8ZCI6s2D+wUmAHfOGXFSdw6WIrMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WnxmZKyG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e1f48e7c18so3657887b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729119924; x=1729724724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cVudONtlG0DSATJhn0pVb7UjgJe0gedfKRf00DL53Q=;
        b=WnxmZKyGgdpcX9DMOaQyQfUbA+lGGZh2c7FQ5c797xe1irS3dcjylraO0QfoT0Fimy
         Zb/a2mjt2az7cPlQdL77m63ttpiNnjl5eKY7zM5BURBc0Tqr2AgFoYGz6ksRLMf/w0H4
         TkwSdYD6Vi6nV/Ki9+KKScNQabK/l+pgmHRS8HWLRtZmT/gUtzWnUl1dtzrlSAYOdXNn
         mkgZwCcgS8IFUd/faQDIjE7GQnas1CKagY8WHsgZtMPXwPK9elNUY96HNiGApOIjqdpK
         IFkoc+V+A41/alsrkLrEZhhnIoldOSCMCwNOsJ9iJySZmmCVMLuxl4uAnfhn9y34Owys
         wWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729119924; x=1729724724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cVudONtlG0DSATJhn0pVb7UjgJe0gedfKRf00DL53Q=;
        b=O4mIE5UZ27b3wQzTydJ9/h7AXXrGS9+GaqxGcD+ACubhKC3p5pHNx+gxvNJ8biN0P3
         OeMbQNwkiKM9hEn7lPHg+1CknqQXSVY0lSyqlwukEqQDZK7jzipsmLxGazIjxGXhEG+g
         lWtgwT4o0n1qJeFJxsV1E7c3prdc8hBNwIz0xCwmXgXfdVksqiKIaJmoNTYW4LrEoWvx
         aAZWM67Gmp3jDr3BZnGwt9wcwJn2FVY8I4rrZlUro79zEhfiQNWY7TxYehU1Ml0DBhby
         SL89NkPDUMZm0C7risGnrE6w8/w/AZ7eKmbW/Y3viL3CAg/mTymmxV7G6cb0bTqLum7D
         /+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUbbyxx1+BkvyLxvM+3/lOhhnnyoTQQZuDPhR5ZW9P2Cnb0Z1yfd4R2L1WqihHv1dHbG/dWy9N4lsi//epl@vger.kernel.org
X-Gm-Message-State: AOJu0YzvtSgT7uHy+xCq+jPA9gbCiXsf91Ce6UEVQ5oz0Bsf1GBRpuBk
	P+pPC6uG2x6czldOrEdFPgncDfyFQhVAQT+c0cVAZ1yLdYTJlfxkjn8Pd0wrgaDHR6scsY2Jwfw
	CKEcb6CxGA9hbI9YhiFpUWjuspnTzUINXXGgu
X-Google-Smtp-Source: AGHT+IG2CPptgPS49bwv2hguubXRhRaimsNmlj5Z9rOQxJzocCCkAz/fhUVsWUtFP4Dou7cPhB/fDfEopYqUrMLhoCY=
X-Received: by 2002:a05:690c:10d:b0:6e3:195a:7247 with SMTP id
 00721157ae682-6e3d41fe7e2mr42371807b3.46.1729119924355; Wed, 16 Oct 2024
 16:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241016-mitdenken-bankdaten-afb403982468@brauner>
In-Reply-To: <20241016-mitdenken-bankdaten-afb403982468@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 16 Oct 2024 19:05:13 -0400
Message-ID: <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:23=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Oct 10, 2024 at 05:26:41PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid show=
n
> > to user space with getattr(), other part of the kernel may still expose
> > the private inode->ino through kernel logs and audit.
> >
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64 bits.
> >
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of a=
n
> > inode number.  inode_get_ino() is called by generic_fillattr().
> >
> > Implement get_ino() for NFS.
> >
> > Cc: Trond Myklebust <trondmy@kernel.org>
> > Cc: Anna Schumaker <anna@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >
> > I'm not sure about nfs_namespace_getattr(), please review carefully.
> >
> > I guess there are other filesystems exposing inode numbers different
> > than inode->i_ino, and they should be patched too.
>
> What are the other filesystems that are presumably affected by this that
> would need an inode accessor?

I don't want to speak for Micka=C3=ABl, but my reading of the patchset was
that he was suspecting that other filesystems had the same issue
(privately maintained inode numbers) and was posting this as a RFC
partly for clarity on this from the VFS developers such as yourself.

> If this is just about NFS then just add a helper function that audit and
> whatever can call if they need to know the real inode number without
> forcing a new get_inode() method onto struct inode_operations.

If this really is just limited to NFS, or perhaps NFS and a small
number of filesystems, then a a helper function is a reasonable
solution.  I think Micka=C3=ABl was worried that private inode numbers
would be more common, in which case a get_ino() method makes a bit
more sense.

> And I don't buy that is suddenly rush hour for this.

I don't think Micka=C3=ABl ever characterized this as a "rush hour" issue
and I know I didn't.  It definitely caught us by surprise to learn
that inode->i_no wasn't always maintained, and we want to find a
solution, but I'm not hearing anyone screaming for a solution
"yesterday".

> Seemingly no one noticed this in the past idk how many years.

Yet the issue has been noticed and we would like to find a solution,
one that is acceptable both to the VFS and LSM folks.

Can we start with compiling a list of filesystems that maintain their
inode numbers outside of inode->i_no?  NFS is obviously first on that
list, are there others that the VFS devs can add?

--=20
paul-moore.com

