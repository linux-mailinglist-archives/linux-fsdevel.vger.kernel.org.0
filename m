Return-Path: <linux-fsdevel+bounces-52257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2BAE0E35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BC1BC5B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596B2459F3;
	Thu, 19 Jun 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9/mlCmt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B830E826
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750362640; cv=none; b=eWaQmPla5HzGYgXtoh4IIIEiBSqLMhNsy/CClXBqJB/dGEReAecsn1HzZe4VhP57XVhjo6KbK3qv6j+ckrS1Jo3uk6NmHUdvF5NhLAWNVLFORFwVPM81O3t5FlgXLrhWRxi9boQ8PV4j98K+Ajw1AKtb1skpLKts9m+t8SqNJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750362640; c=relaxed/simple;
	bh=u6fU0wkban8cgA6TIBNGibUvihvY6/CDKN1BsBFONmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnXvvsJHeqKYRfSSF4fx2pRnSSBhkuH83Rf3wmDBXGuPoDzNKBOzyrzd3XhrKRzXNI8CxXfhcoStztf9Avt5eSQ0BKz6q1bGDFcBuGlcD/vK/zswus0kln1DbgR3bWBmlJJYVNAM+ibcgVXZLXdcJcfj5wtCCRJXBL9eIu/oMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9/mlCmt; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad3400ea3so10934276d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750362637; x=1750967437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6fU0wkban8cgA6TIBNGibUvihvY6/CDKN1BsBFONmI=;
        b=k9/mlCmt1X4e/QbtHx5261GOQ29Nxl3rFdv2vTguHaI9pKPyUh3Wwr6FEOmbQrpet4
         dWeJyhBwq/tj7c6dT8JrThhZtMCD9iaAei9iRNOLGs4RPK+czQ6EqFx0XeFfajlQysco
         /zKFv0175aGNY26MPYP2ykPXDTblh9ymkIDl5iCz1xEcRvGTZsoo7wN3uKG0we/+NoB0
         qtSZWgPEAzuNY7JgbSzFkYWnc8O1FouMeemAWRJpDNFgoJM4wyKo3h/JNNL5NzmbKNSi
         cQ6rw/9bJvtufgwmzRcU6NYtiwtx2eWuHZJIsClh97VvU4vF4qrxKn7Nn1dmluYdV3Al
         wlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750362637; x=1750967437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6fU0wkban8cgA6TIBNGibUvihvY6/CDKN1BsBFONmI=;
        b=IUfdenrEHiQazSwyAJGT+6NrpnD0mS1mIV6OJAumVnuKL63gojIpdrkhH+/AAQvO23
         gci/YqW4dwAkkqmg91DX7b5hygilC69xi0J6tSiFqnSqfZ+j370uB7YwdfDJlF1mSRKx
         +YdBOpaBymTM8K4UI0HJDAwtGP3talc3rEgcRnlEZmbi8fWZALjKf9IwhUfgJjIAm6IM
         O1IbjeDXIgih0YT82Hg3aSJi9uXP1YyVWkLEJY0kdtDGeEEdef3yPBboPA8G8bK/FVcJ
         YakeNEu3KlQTbAMc2Qw3srE7GlfA9rUWKLy7GOmfUj0ouhlcHqEov5l58MR1I0hrIBrF
         WmIw==
X-Forwarded-Encrypted: i=1; AJvYcCW7VTkGl/6Z3z/mQPxS8ywG6KkE43DQ8QdGVjAgVWPMNDgGI/te/zQPDZ7oE1fNxEKIWNjSXlvWHTHtXkyv@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcPRYRA/0hV2BigyFUAFvf1U3VZSEkgllOaPyu5m2V51fbAyO
	HquPIs7h6Eme6Cd/lSEaEWdMpYCVWDi7yMG1tyRoNdc08yl9ImmdC3mP1oROdgb+HeNi3OBwXLP
	9HaDa+DWWIwhqDlIoVZI8GKvNovMTZWXCtfU1Q+o1UfVd7wi9HJcKbk5i
X-Gm-Gg: ASbGncvpS0gFpxKT/jLoCpDeUufAIkFRMeBs7qjAv+dBEQt6ny35pnZm325ABfvBovA
	TiCiZ0HYWzkv19HerXdhjrkxhmV0YDKu4iYhmbwmAy+E+XT6g4yZXuMbdTO0LX55aFiZzCLWatc
	xtAAZktvhcgqkMHkzdfK3klcndo6L7HV0Z/YoruJBy54GwiNhUWnvreG1I7NucofmNEmuAhXDHl
	wJKIQY6zKUx
X-Google-Smtp-Source: AGHT+IHE26LvRT3IO+Dxq1WOGpRw9xwlz4WIqDkIYFQhiqHa13y0vAtaMtNRXgya+a5H4Ntw2scaAI9cGMoZTnfEKFc=
X-Received: by 2002:ad4:5bee:0:b0:6f9:201a:c05d with SMTP id
 6a1803df08f44-6fd0a53b861mr7133776d6.33.1750362637225; Thu, 19 Jun 2025
 12:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com> <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Thu, 19 Jun 2025 12:50:26 -0700
X-Gm-Features: Ac12FXwfl68qCDHrJbziX8qTOPC7H2Im2uXQfIh8FjRJJeTT5dXjEv4aeNDCOi4
Message-ID: <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

Hi Amir,

Thank you for your detailed reply. My intent with this patch was to see if there
was interest (a definite yes) and to see what path would best get us
to our common
goal.

I'm thinking the best approach is to start with your ops_mask API. In
fact, that solves
the biggest single problem with my future patch set, which was that it
was going to be
huge and not realistically divisible, since you need everything for
directory passthrough
to work without the mask. Your way allows us to proceed in nice
logical steps, which is
much, much better. Thank you for that suggestion.

So my follow-up question is: What can I do to help get the
foundational patches you
wrote upstreamed?

In the meantime, a few thoughts on your comments. (Note that one of
the beauties of
your suggestion is that we don't need to agree on any of this to get
started - we can
discuss them in detail when we get to the specific ops that require them.)

1) Yes, let's use backing_id. I won't mention that again.

2) The backing path per dentry comes from the way dentry_open works.
If we are going to
attach a file to a lookup, we have to put something into the
fuse_dentry or the fuse_inode.
This makes more sense once you see points 3 & 4 below - without them,
we have an open
file, so why not just use it?

3) A cute idea that we had that seems to work is to allow negative
dentries as backing
dentries. It appears to work well - for instance, a create first looks
up the (negative) dentry
then creates the file into that dentry. If the lookup puts a negative
dentry as the backing
file, we can now just use vfs_create to create the backing file.

This means that only FUSE_LOOKUP and (I think) FUSE_READDIRPLUS need to have
the ability to accept backing_ids. I think is is both more elegant
conceptually, simpler to
code in the kernel *and* simpler to use in the daemon.

4) Having to open a file for it to be passed into a lookup is
problematic. Imagine
readdirplus on a large folder. We would need to open every single
backing file, and it
would stay open until the dentry was removed from the cache.

Both of these suggest that rather than just passing a backing_id to FUSE_LOOKUP
and FUSE_READDIRPLUS we should be able to pass a backing_id and a relative path.
This is where the idea of putting the backing path into the fuse
dentry comes from.

I don't *think* this creates any security issues, so long as the
relative path is traversed
in the context of the daemon. (We might want to ban '..' and traverses
over file systems.)
Again, these are details we can debate when the patches are ready for
discussion.

But again, let's start with your patch set. What are the next steps in
taking it upstream?
And which are the next ops you would like to see implemented? I would
be happy to take
a stab at one or two.

Paul

