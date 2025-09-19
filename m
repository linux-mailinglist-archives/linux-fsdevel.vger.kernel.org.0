Return-Path: <linux-fsdevel+bounces-62216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5332B88AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BE52583A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932E265CCB;
	Fri, 19 Sep 2025 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0ww+35H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAE2264D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275694; cv=none; b=kIHDS+YtpUhO3rZTV87ZPJ5N8D1hjQkK4Imq8FbeL0wQ6+Ce2qn0pMHLb6H+UEesT3cvIX7x013cx88jrYIlyha+R9TgXqTat2k7eRlcBtsVWLXV7sG/XFg38w0cGQR9sKneZiAs0zHhvesNZNM+/L72sUyZJv3hGEr/Ek444oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275694; c=relaxed/simple;
	bh=dgtFOm38P9aI6/915v1yVDS2kMb9u/O/desqpxSnf0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExmiJxoO2hfidz+bYphlVHmvo77D3854LN5UZ+3RlDVPYWFZj20RwEX0TDM5jH+eDadwnDmZXV/2k6TZEGOGhRJpwkGNEASFItnebhza0pxwcN/llLSPc0PcZxQ5nGXQYDQdTIJoukYP/IubwIeI08rEaRyB5NR12pjBRgRN4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0ww+35H; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fbd0a9031so1229150a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275691; x=1758880491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1fKK2VeIGcuA6sZx7T8OVafrUk30/MIz6Mtn0eRk4A=;
        b=D0ww+35HPYDgbX+WJHvGWzEHxGXOKMQF80wYpwCHYLX/o8mh/QwYse62u6Pl8WvlpB
         G9vy9O/fn4jSzD9BGizMNga1kdo5J1wAlD5SgH+qdhdhgQrmL1YyYGim3d0lSt1aRY9z
         g+y2DXGoGOZXWBXTf9xOn5N5j4cc/N3oFG0ah/chZJGQmGQQCMuDAEqijyjxWWZ3xDdO
         587G7hg0BJlaf6n4/aTdbz31VLrx3a6iABwmyJlhC+AfOyqQWblHEPPdMY2pFRODzSlQ
         zJYMkLZtsEZMxBDdoGdIVcNpH2sD2fzpwNjnEmDPPb9IAnMzc4tVVa7IFUogZPXR08g9
         N7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275691; x=1758880491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1fKK2VeIGcuA6sZx7T8OVafrUk30/MIz6Mtn0eRk4A=;
        b=A75FcdKufzNK1iTRwylCFgqT7a5t9/im0ZIwhoEY4yeyMzGiURyJsTDJX9ga5T/sI6
         6I46Hp/iimVMCn4HlKySHeNtELHwR6EQqlSFKtmG2jaJgdpjzrFUZaM7AMpYe0RVhg5L
         Bgs7LhrT21I+O9tmN0n0MKpsLKbwkP5jx8sEkNU4WS3NSg2FTRc2KytAKbnpdERrNCpa
         ozEhJxxoTf7WwcSFXzbvox4QlaRYaF6sM1/T0YTggnZ/Y7hbxqUlWRdQYBA1ADj4xQrN
         uPUvP45UqIQRxuQLapBRJ5+r92KaiIosSHmvhAs3CltAK6v3GPDX1HOkGfifh8zxZwto
         6m1g==
X-Forwarded-Encrypted: i=1; AJvYcCXWGhrr75WDShJ/R682pI2M5KQxwI+88SldGAOf71y+0RmFntwqwPRXQr7iegsqZowp7dEhr0QdFU5qZL0q@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLb3Ip4jT0RmT6FVN7Pd4bQ1T3npwo2bzd9k0/k+XO1Yucpyl
	ew9MSIYhnbAersx/u2ahWnKe2m3kbPLLBxIOPn316EAKA2NfTMrGhB8x1Ki0VQZqUTApHdOx/2q
	O7iwI2Ocqzk1OY9zde4muhvPec0oxU6g=
X-Gm-Gg: ASbGncuCTC+1FXnirZRc19aKJxMNJbnbJ6FSBjoSrLjikoh5k3KsVBXU5ZqSaZwa5kV
	Tj/X9l2Jyho1FY/RaBXKlvlODeu4E0BfBz9LqN1MJZoSqasgVq4vAtMLC0OoSjeAV+QU6tF/QfS
	1dJiWlw1gGZq1h8rFmXDOg/E8tntnO7wazvkCBrykBa37ikbP3+Wz5lmHbwYC4d69ia84kgBr08
	lb5EBD7fVjBoIjpE/77q/CuUgqRkyLZ0HFF3qHEHDRFXa8=
X-Google-Smtp-Source: AGHT+IE5oiKuJw8bSM5pCB6RKkNUQyiqR7jU1bNaTBtzzRRL/3JjPFaCojPjFSXwo6+sUUPKTUkwNzO7kN2G6awGZQk=
X-Received: by 2002:a05:6402:21c6:b0:62f:50b9:2881 with SMTP id
 4fb4d7f45d1cf-62fc0a7b232mr2468458a12.19.1758275691061; Fri, 19 Sep 2025
 02:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151352.382724.799745519035147130.stgit@frogsfrogsfrogs>
 <CAOQ4uxibHLq7YVpjtXdrHk74rXrOLSc7sAW7s=RADc7OYN2ndA@mail.gmail.com>
 <20250918181703.GR1587915@frogsfrogsfrogs> <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
 <CAJfpegsrBN9uSmKzYbrbdbP2mKxFTGkMS_0Hx4094e4PtiAXHg@mail.gmail.com>
In-Reply-To: <CAJfpegsrBN9uSmKzYbrbdbP2mKxFTGkMS_0Hx4094e4PtiAXHg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Sep 2025 11:54:39 +0200
X-Gm-Features: AS18NWA621z2KRPPWOGIYUM6iJJ0YvzsnlUffsLmeJBzhEVFirihKN7gNrA_jS0
Message-ID: <CAOQ4uxgvzrJVErnbHW5ow1t-++PE8Y3uN-Fc8Vv+Q02RgDHA=Q@mail.gmail.com>
Subject: Re: [PATCH 04/28] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:14=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 18 Sept 2025 at 20:42, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 8:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
>
> > > How about restricting the backing ids to RLIMIT_NOFILE?  The @end par=
am
> > > to idr_alloc_cyclic constrains them in exactly that way.
> >
> > IDK. My impression was that Miklos didn't like having a large number
> > of unaccounted files, but it's up to him.
>
> There's no 1:1 mapping between a fuse instance and a "fuse server
> process", so the question is whose RLIMIT_NOFILE?  Accounting to the
> process that registered the fd would be good, but implementing it
> looks exceedingly complex.  Just taking RLIMIT_NOFILE value from the
> process that is doing the fd registering should work, I guess.
>
> There's still the question of unhiding these files.  Latest discussion
> ended with lets create a proper directory tree for open files in proc.
> I.e. /proc/PID/fdtree/FD/hidden/...
>

Yes, well, fuse_backing_open() says:
/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
So that's the reason I was saying there is no justification to
relax this for FUSE_IOMAP as long as this issue is not resolved.

As Darrick writes, fuse4fs needs only 1 backing blockdev
and other iomap fuse fs are unlikely to need more than a few
backing blockdevs.

So maybe, similar to max_stack_depth, we require the server to
negotiate the max_backing_id at FUSE_INIT time.

We could allow any "reasonable" number without any capabilities
and regardless of RLIMIT_NOFILE or we can account max_backing_id
in advance for the user setting up the connection.

For backward compat (or for privileged servers) zero max_backing_id
means unlimited (within the int32 range) and that requires
CAP_SYS_ADMIN for fuse_backing_open() regardless of which
type of backing file it is.

WDYT?

Thanks,
Amir.

