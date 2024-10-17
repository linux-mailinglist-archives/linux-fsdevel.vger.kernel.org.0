Return-Path: <linux-fsdevel+bounces-32208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAF9A263C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CF01C21795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857455FDA7;
	Thu, 17 Oct 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eT6TuZJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B0770ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178166; cv=none; b=C3C+ieWY6iU1gpyRX5pSj0lgUwDDPr0ykmBOiv3TKkq66ujGZjK8SoKbhn6Y5uvA0CJlGs2U+vMdIumtmByTmeEouoMiVKpBDPY9ZlklIuqU3t5P5zqc7laww5GsDSWh31AaWlUdSHi5W514q0brPUKB4C9fPK92Q94cqzIRpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178166; c=relaxed/simple;
	bh=ilKsvk3bdbOxk7tshNk5blrflPsFv+4Wo29i4YrrjG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmSArmromHukwAqV3dK5e8O6M6kFTNQ34wsYo0ywojoykr2umab6D42sc8j+jt7pcN0bKBoIMc85BECfv6rxoE6DS2+DRvAE0nqlN7B8FkkTXi1uK3r2fvus4INeaialG/Tm9lJsGg5O+9aRtwPEUYpxbby+rN3edf24rRztXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eT6TuZJ8; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2972a311c1so1112942276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729178160; x=1729782960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GdE6eTDGyaNw5M2W3MzymeJfSSH0mPrAR2SroJEoBg=;
        b=eT6TuZJ8rdFpB5U/mm1JBj6OOo5Wtn+gZ+g1SxOEaQTa+KLZIXnljUR7rcpX6+CTMr
         iKKc2RGc4I3IKb4Cp9RLFD2SfZ4Nmnpc3q8+PExXfmj2yM0rf0epjNUhDlo2XduBIhwI
         X34ZtQQz6nZR8EwwW2kb+s7ml1fIHCfX0XN/eCWKdWjLq4pnEugazKaAlYXytNlG5Z7P
         WykVmrupm1Fs9/VbPf6jGrCJmKFBQKjPtu0G9jjYZ2xiw9rvRSovEK1V1nZ9Vy7Lbhf3
         3iMz9nnGEfJa7sdmb4RYNqHMKoD4fs1+pXrvS6yQF4UfiHwYi7a/XyPdSfOzMr+CL7Yn
         MmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178160; x=1729782960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GdE6eTDGyaNw5M2W3MzymeJfSSH0mPrAR2SroJEoBg=;
        b=eBCvBvQv8M0YhwBGKJ9g16+PpJRjy1BVIOmRlIEhMZvC7R/ejB8Rypg/L0H6QxdYT5
         sq+/CMFOIKP/fZNb4JKxfliTuvi4HVUwuThYIZe5sKyFKG3q3K+3ytMp3VIDiKYjedaf
         rBiSkgBDAiq2+xYWeH0YC4N3Ss7yz97E6Xmym791HmgjK2AIj5QsYfMD4LC8CsPzXrkP
         tRY/aFy1d5vV6KBzWbvyvVTruZnGL9HnbYI2q3cuoev3lnODEEDWskbVcoL0Xo2VrTQw
         NcZpy80tR37QW93J4tBZrtWAta5wYK5ZI74B1pwtEx0ElSwGBulQi/dzpyqfEsv+4dgk
         b/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUzGS+Dfdjv35bgg1T01e1WkZzM5lYmM5HhQH44blZ7bBoky1Vi2uDIM0Wb3l9NTq8zKtlUt4m632NZ/meK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yZlVYqX3dp87E7Lyu1wIrbOgS89DiAr2wzYnh7dAMhhoc9j0
	raO8ujpvl87EHvcmHXe0/DRL2R6Yf4dA6ky6efQkI6X6jysc2eef/FVKmLHGPJeh2ORweDQOtm+
	7YFy6IdaqaNDvls13IIzyqqtdTyBLa55Z1j3NyBL38ijMxSQ=
X-Google-Smtp-Source: AGHT+IEbjoCbzHbsLdZDEuUv9h5xDfQJd0zNjesQoMMZNIJjdQDsgALaaqqdPXxo2sDraVO4AHzq8qH2zBoKPszhXps=
X-Received: by 2002:a05:690c:2913:b0:6e5:625c:5ad8 with SMTP id
 00721157ae682-6e5625c6e42mr38775387b3.37.1729178160115; Thu, 17 Oct 2024
 08:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com> <ZxEmDbIClGM1F7e6@infradead.org>
In-Reply-To: <ZxEmDbIClGM1F7e6@infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Oct 2024 11:15:49 -0400
Message-ID: <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "anna@kernel.org" <anna@kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:58=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Thu, Oct 17, 2024 at 10:54:12AM -0400, Paul Moore wrote:
> > Okay, good to know, but I was hoping that there we could come up with
> > an explicit list of filesystems that maintain their own private inode
> > numbers outside of inode-i_ino.
>
> Anything using iget5_locked is a good start.  Add to that file systems
> implementing their own inode cache (at least xfs and bcachefs).

Also good to know, thanks.  However, at this point the lack of a clear
answer is making me wonder a bit more about inode numbers in the view
of VFS developers; do you folks care about inode numbers?  I'm not
asking to start an argument, it's a genuine question so I can get a
better understanding about the durability and sustainability of
inode->i_no.  If all of you (the VFS folks) aren't concerned about
inode numbers, I suspect we are going to have similar issues in the
future and we (the LSM folks) likely need to move away from reporting
inode numbers as they aren't reliably maintained by the VFS layer.

--=20
paul-moore.com

