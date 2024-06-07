Return-Path: <linux-fsdevel+bounces-21172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02579001AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 13:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DEF1C211A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F544187321;
	Fri,  7 Jun 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbJYAztQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067512FB01
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758647; cv=none; b=qJWu0jTZjgW8h2HWcBtGqKRVwXQ7JiFPSE/iGLO4fAk4BqeBcG9qf9BC68b0orYKcYBD1QN3blWL9UEZTjdRUlMvCYk/lxwwcfkZRD9WKuW3d4Dl5C64wGGfT/ZavGp+Ij2lS5e7SUinBSf1W/sALxSGnEIYmD0iVJlxf/Ehv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758647; c=relaxed/simple;
	bh=c9TjLu0ffr3MwaqW2GMhaJ955hyzZGXDck4xy5ql7OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJSj0iAmGjUUgnkXb/ckoP7PJmxdblOm3iCGASkjFofrLoWVq9pF8YkvgRAx+AFgt1/SRQkWGeBmMBMqfHZ4Xy7FK2XzQckzF1imqUZFVEVhocj0WFOHKBvDInOHecGE6jKWRqZj6o60y3d/fuSdtthaNSbvVjlepGUmG11zXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbJYAztQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c614c57e1so125012a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758644; x=1718363444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IifZbRwtbIi3l2jA0jz6TA3paY8k5qicIa+PIaMF6t8=;
        b=QbJYAztQ/n1PuuoOJoxy1dZM1g82SI7cR6SkrwXNh5+vdoRon/buLb97cveSihAhv+
         BpDTwv7IgDGXxw45wGRZDlQgzuAbFk0nFNFN88Sd2J4n9IDwq1QocrHR4nA14BgfRJ/i
         mdYBR5YC1sFO6aEqrdGxnrTooz7UZa1hiWGZtNenY0pvZJS2Si51kAvEN5nxzYWyePOL
         v57D2qSbIUaUqFH879ZzM+yBINE/5/pNYJNn855qzmRmOxnndTf3POpGK+jqnIZYCxYr
         Erir5/GnS8rnOL5cBL+ezKSRmtB0y9clhk2seIIhfG4TI+SWqu10tcjDgEI+8S0E1M4T
         95UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758644; x=1718363444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IifZbRwtbIi3l2jA0jz6TA3paY8k5qicIa+PIaMF6t8=;
        b=cuvIG8LYd5d/xy7T8i8YwcBq+cGa7o9vxpg5Y9DIr4rWS170wAR/lBZ9rDty1K1Is7
         Grzg07O9bNrsK3ZSS/RkXMy011mVZaPcbyNPmj3YvwsoKtQOZmYB6wpzBubZKASCDr0u
         lOHPtx8ja1H7BLL0H2jI48/jF6Y7Q5jFaHmuHHCyoDocBozguwd8eGlEsJgTeJHoPcez
         gkEmZYYU6ClvTFs5K5FigNIe09kNQBQyYb57HA5kWCmwZnu1raS1DDO+DZzqIcHrvWNo
         6owFnd39cGQQ+lgoS4uA1x9AeCN5EfAJSoL+3vYf9xt9RfyRQyEoBFaSzOK82ktQ+kky
         I/9Q==
X-Gm-Message-State: AOJu0Yw08vZ6gJb9CIZSB7NWtqdjdZl2IRUAdbFQwF3ESdkk1Fxp903l
	2XOywIU5iZ0NzQCj4tYpTuGv3miyz8vYZ2grGslhln0gSQ8C+rP9MVDD9z+NKXxtsRVCLlTvscT
	3qWRFBerDTW5m0TukQOKgFqjjsgk=
X-Google-Smtp-Source: AGHT+IEm8c18cmDkO73GMHX7MEatGEYN+JErMTKrvvX9Dh4ig0qylqpUFs43TDZsXB1+8jIp3e6+pMWSQopOgW8b4Oo=
X-Received: by 2002:a50:d4c2:0:b0:578:6c3e:3b8f with SMTP id
 4fb4d7f45d1cf-57c5085e741mr1372688a12.2.1717758644190; Fri, 07 Jun 2024
 04:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <20240606151738.GB52973@frogsfrogsfrogs>
In-Reply-To: <20240606151738.GB52973@frogsfrogsfrogs>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Fri, 7 Jun 2024 19:10:32 +0800
Message-ID: <CAHB1NaiRKWP64=2jNc_LXs_JC5xXQ3X_7+xHf_waZbP+V0hL-A@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 03, 2024 at 07:36:42PM +0800, JunChao Sun wrote:
> > Currently, FUSE in the kernel part does not support quotas. If users
> > want to implement quota functionality with FUSE, they can only achieve
> > this at the user level using the underlying file system features.
> > However, if the underlying file system, such as btrfs, does not
> > support UID/GID level quotas and only support subvolume level quota,
> > users will need to find alternative methods to implement quota
> > functionality.
>
>
> > How would your quota shim find out about things like the increase in
> > block usage of the underlying fs?  Let's say the underlying fs is like
> > vfat, which fakes sparse hole support by allocating and zeroing (as
> > needed) all the space before the start of the write.
> >
> > So the kernel tells fuse to write a byte at 1MB.  Most unixy filesystem=
s
> > will allocate a single block, write a byte (and the necessary zeroes)
> > and bump quota by 1.
> >
> > fat instead will allocate 1028K of space, zero all of it, and write the
> > byte.  How does /that/ get communicated back to fuse?  Some sort of
> > protocol extension that says "Hey I wrote the data you asked, and btw
> > block usage increased by XXXX bytes"?  If that increase takes you over
> > an enforced quota limit, the correct response would have been to return
> > EDQUOT having not made any changes to the file.

It turns out that's actually the case, and the previous 1024KB of
empty space cannot be reused. I tested by creating a 10GB vfat
filesystem, created 9 files, and wrote a byte at the 1GB-4KB position
in each file. When I tried to do the same operation on the 10th file,
I encountered an ENOSPC error.

I find this extension a bit peculiar because the user has spent a lot
of time to get data written to the disk and the write has been
completed correctly, but Fuse informs the user that the write has
failed and is invalid... It's likely to get users confused.
Furthermore, users would need knowledge of the underlying filesystem
to accurately report how many bytes the disk usage has increased.

Perhaps it's better to accept that a fuse fs based on vfat cannot
support quotas, and indeed, vfat currently does not support quotas.
However, it's necessary to carefully consider how to make it so that
users do not use quotas on a Fuse filesystem based on vfat...

>
> --D
>
> > And consider another scenario: implementing a FUSE file system on top
> > of an ext4 file system, but all writes to ext4 are done as a single
> > user (e.g., root). In this case, ext4's UID and GID quotas are not
> > applicable, and users need to find other ways to implement quotas for
> > users or groups.
> >
> > Given these challenges, I would like to inquire about the community's
> > perspective on implementing quota functionality at the FUSE kernel
> > part. Is it feasible to implement quota functionality in the FUSE
> > kernel module, allowing users to set quotas for FUSE just as they
> > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > quotaset /mnt/fusefs)?  Would the community consider accepting patches
> > for this feature?
> >
> > I look forward to your insights on this matter.
> >
> > Thank you for your time and consideration.
> >
> > Best regards.
> >


Best regards,
--=20
Junchao Sun <sunjunchao2870@gmail.com>

