Return-Path: <linux-fsdevel+bounces-53779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8048AF6D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9187B420B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A812D29C7;
	Thu,  3 Jul 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvAM0owN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0002DE6E8;
	Thu,  3 Jul 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532163; cv=none; b=bMNNI6Ks19jDlxpuesGPaA/BRYCH+BcdjBwC2LucvYYJxxXILXG3w1K/mGK3j2BYNXdxAvirTbYKD3broDgoNpIn71Lb681U19Qpm3HLd9uqC4ObJBFPXtsZnBTjktvmDlLh9DXuD0ueGXC4P9xWaP01PS0Fkf5T1yyS70HpezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532163; c=relaxed/simple;
	bh=NXhSux8cQ5fFuxd8YazRWpTbkk+b8DS3AMQtLWa4HYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB/HmOChvdJth8ZOqJL72VFqRt9OCyDEBFh0LlLlHV+fU571zyL/T3m9/rSoHcy3ku8EAExPdh/GsojG3Cg5LOqDDEde09nTyncPJUTrOyqAFlkH6h1G+Hs2XO3o/NhXgfzRZeRvEWJ3TQgpLPiWmeFyEki+jfNrIb6AxJcOPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvAM0owN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so9668299a12.2;
        Thu, 03 Jul 2025 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751532160; x=1752136960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8M8TTrEpCRO+REGMbyo0IPniee+CGBg1Ax9nIB/F8E=;
        b=ZvAM0owNqHVHfUcoCrTZjubDroE5ir9Eb3NNRDn49THtDCkHMU9thvC1rDR8Pavwtm
         MuXAwHo8gpEfZrKjVINgAoa6GEAqAN9oYk08yq5HIc3xpEkK1FtiboJedfESrwtrvdks
         LOLMvBirNZgismW6/E/aHsNypRlXPsCDOKWN0uU/CPyUNYXX1Zy7J0kaZUTf+5PY0Mh3
         EbWvZjMHax3GelMn3GYn5f8Podl/kpVSh4cjOo48azL+xNnJnro68QvcVWVmtp3XxCJC
         RJZwcZmcK197ifUv8PXeP8CaH3fdUtYjeKdPc73QP+cZJhDV0PJoIXo9+aC9g/aLtwUa
         qzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751532160; x=1752136960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8M8TTrEpCRO+REGMbyo0IPniee+CGBg1Ax9nIB/F8E=;
        b=XrGtiaatwjlt/On4OdNokmKKJYLnABNnlnu8/esI+145poM6nJ19wnB/1xJV9vfLQY
         aRXEolnUuhRTv7Pt3PesyBLbV4EDRIDOXC3hSkWanvGOIsXYqDcmliT+71Cppap1gy5e
         jPBREci7426NOtUv1TJPz6nhaPtBpNxK+HOUNMy5n8Y3HABJesghEPpEawlq55QAnSrB
         oW8VYXLQu+c6I7UgfRCFnYZlnX2qD2gEM3a7WnZdzFzGMjDZr9uT2wpDyuobGnOwEm5r
         jeqtZ0p7AXcJH8z46R9qbv6xlZeqHAHYhDvkCCIq/fMHwjQypFcH6ud5wYKuKKmtKDuo
         q19A==
X-Forwarded-Encrypted: i=1; AJvYcCUjy3T3IL+sDyG6f3et335xA1OHNKeCGwmS+3ckWujOxAsw1JXp82XU+sdrj5AQP60jGu2Rs7zjL7g47KmF@vger.kernel.org, AJvYcCVj1UgWCe8b1VgIhR/x8MGCQPMN1LxZffyjyaP5HeItDRuCUFgrlr/iJciyKAorWyzdIsGCIqGcqqVhp15KWQ==@vger.kernel.org, AJvYcCVqI9XeNKGLoDpucLW2I2gvhUYOzuEmEdti5YXjbGTagDoJMaTqr+Xa2vL0hlZIO8KXuzmIFEK7WA==@vger.kernel.org, AJvYcCWEKIUn762wThTtibAhMb0CqdJo3meyQfNbIxFRQGyzhUhQLW2unxwvcoPKw3OZ7aNynOGtzsF8LVc=@vger.kernel.org, AJvYcCXHeepOQeJWVt0vBtISbdF8UuDwSxf2WRMdZ66iH+Wo4LRzkk7pSEjs+lHQJvd2OozAO07Jjmyasew/@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyFQ9dgAR7U7HmZ+BqO3kV0LTyZabd/baqR8bmf1Z7vk5i7sg
	Bwhc7mzLZ7OVydkQHpWgeSug4i+QrrCWP25iGRluN35FjeLVVO1Ae/DoBqBiOHFcxBrmUOwgJMf
	fs5STYuGOtx1WjQbJJIr14GGILrdOD6FIyzMl
X-Gm-Gg: ASbGncsiFYS6KduPDqm8qCAgbd7uk5dd1FwY0xX8oo32fpF59cfKG39XOsAYvg36exA
	k6yarhneBEqsQXVE8JS2b3wKYwzd/V2IUt2QdHQQs9QGIUXnxYK7/EWQWtm4l+rWV1HrdE8vdRP
	wv4U0A1d3F1KDrOqJCpXrzwnJVURNRd35UkD4ZlOjRsCs=
X-Google-Smtp-Source: AGHT+IFWBGBtwfl1pVsOqSUUSlfecRc0IfMyWZZ43ne2PtwWES/q69Rl8myJrR3H84dxA9TpGS/HAbi2z1XIKeY/R4Q=
X-Received: by 2002:a17:907:da5:b0:ae3:c767:da11 with SMTP id
 a640c23a62f3a-ae3d8b65f88mr207720866b.50.1751532159351; Thu, 03 Jul 2025
 01:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org> <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner> <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
 <20250702183750.GW10009@frogsfrogsfrogs> <20250703-restlaufzeit-baurecht-9ed44552b481@brauner>
In-Reply-To: <20250703-restlaufzeit-baurecht-9ed44552b481@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Jul 2025 10:42:27 +0200
X-Gm-Features: Ac12FXxUejgRNBaPDbYKwjZ8mH-zg6ue2kSGCUfEA76rDfzZTUpg-r8ydXrEHYc
Message-ID: <CAOQ4uxjouOA+RkiVQ8H11nNVcsi24qOujruqKgfajOCKP1SMpQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr syscalls
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 10:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jul 02, 2025 at 11:37:50AM -0700, Darrick J. Wong wrote:
> > On Wed, Jul 02, 2025 at 03:43:28PM +0200, Amir Goldstein wrote:
> > > On Wed, Jul 2, 2025 at 2:40=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > >
> > > > > Er... "fsx_fileattr" is the struct that the system call uses?
> > > > >
> > > > > That's a little confusing considering that xfs already has a
> > > > > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > > > > That could be renamed xfs_fill_fileattr.
> > > > >
> > > > > I dunno.  There's a part of me that would really rather that the
> > > > > file_getattr and file_setattr syscalls operate on a struct file_a=
ttr.
> > > >
> > > > Agreed, I'm pretty sure I suggested this during an earlier review. =
Fits
> > > > in line with struct mount_attr and others. Fwiw, struct fileattr (t=
he
> > > > kernel internal thing) should've really been struct file_kattr or s=
truct
> > > > kernel_file_attr. This is a common pattern now:
> > > >
> > > > struct mount_attr vs struct mount_kattr
> > > >
> > > > struct clone_args vs struct kernel_clone_kargs
> > > >
> > > > etc.
> > > >file_attr
> > >
> > > I can see the allure, but we have a long history here with fsxattr,
> > > so I think it serves the users better to reference this history with
> > > fsxattr64.
> >
> > <shrug> XFS has a long history with 'struct fsxattr' (the structure you
> > passed to XFS_IOC_FSGETXATTR) but the rest of the kernel needn't be so
> > fixated upon the historical name.  ext4/f2fs/overlay afaict are just
> > going along for the ride.
> >
> > IOWs I like brauner's struct file_attr and struct file_kattr
> > suggestions.
> >
> > > That, and also, avoid the churn of s/fileattr/file_kattr/
> > > If you want to do this renaming, please do it in the same PR
> > > because I don't like the idea of having both file_attr and fileattr
> > > in the tree for an unknown period.
> >
> > But yeah, that ought to be a treewide change done at the same time.
>
> Why do you all hate me? ;)
> See the appended patch.

This looks obviously fine, but I wonder how much conflicts that would
cause in linux-next?
It may just be small enough to get by.

Thanks,
Amir.

