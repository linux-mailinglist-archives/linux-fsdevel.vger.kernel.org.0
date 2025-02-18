Return-Path: <linux-fsdevel+bounces-41979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A4A39813
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DB5165787
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C542198E81;
	Tue, 18 Feb 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SbMv04yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A449653;
	Tue, 18 Feb 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873098; cv=none; b=hcpSDzDcQpxSpqmmnuDFDW0QEgEr+1v+mCnAK6lpUZ2QAdev+X4gg8QZSirwFp5H1EuTj2/oeCOOnOfALk0gsXIbuDb1RMc9FkTIapIxqRmW33yiLE8U/audRAE47w/juiKoGRKcBaYl6eswagjd0p6K7E5Seo2LF6l0CRWx9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873098; c=relaxed/simple;
	bh=DHIkEQXcUfg8cwjm2kMKue3rxLA7AYb3xdjRyqpYTeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJeUCyx7shmCg8hPtbiXIxWlUJQBRwzTVCoGOtk4IGWt++P5uviH2OKcRzg2w6fAoPPEVne7AC6FEYVhklqD44xpn/RDjdWTEZp9JdjMZU51i4j54qbdhBJkKvpXpdNlHd4MpDYCGKYiGpGW2nJPN71PE8w+mJbiQfRLdB4P1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SbMv04yR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EILQ0yUwDiA0yjQW+sSupa2oNs9Hu2s5IYbZsZvRMuE=; b=SbMv04yRMqBvCcnc1VKsVHvkqt
	+S/S5oxsDZaqNSw47aVFB1SgwSfA06XSP06d5xravKEs4Jq5oREbKPn5RNGuqamNpkwKybya+9bPE
	H1aiIAucTYun2F4Ej1jTIJwfwfYP42FgtC1RD4uVzHnW79rdbQXCiGSIiNEule5dRl9dgkei4gjsB
	MbbavA0vaAXoD0cmmFFAoRs4HqbVbsdx4rDuWyp38jroRVEmdqVeaP1bAQlKQX5w378LtbtwRBAnx
	7IcHKv6Vub07TTTDlg4ZH74JU3DSV1HBjzl/8X9ERJYETE6nmcIbq0i5cQkviZDIFFVOprVpF8h+V
	GiR0NE1Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkKSw-009emU-Hk; Tue, 18 Feb 2025 11:04:40 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>,  Bernd Schubert <bschubert@ddn.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 18 Feb 2025 10:15:26 +0100")
References: <20250217133228.24405-1-luis@igalia.com>
	<20250217133228.24405-3-luis@igalia.com>
	<Z7PaimnCjbGMi6EQ@dread.disaster.area>
	<CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
Date: Tue, 18 Feb 2025 10:04:33 +0000
Message-ID: <87r03v8t72.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18 2025, Miklos Szeredi wrote:

> On Tue, 18 Feb 2025 at 01:55, Dave Chinner <david@fromorbit.com> wrote:
>>
>> On Mon, Feb 17, 2025 at 01:32:28PM +0000, Luis Henriques wrote:
>> > Currently userspace is able to notify the kernel to invalidate the cac=
he
>> > for an inode.  This means that, if all the inodes in a filesystem need=
 to
>> > be invalidated, then userspace needs to iterate through all of them an=
d do
>> > this kernel notification separately.
>> >
>> > This patch adds a new option that allows userspace to invalidate all t=
he
>> > inodes with a single notification operation.  In addition to invalidate
>> > all the inodes, it also shrinks the sb dcache.
>>
>> You still haven't justified why we should be exposing this
>> functionality in a low level filesystem ioctl out of sight of the
>> VFS.
>>
>> User driven VFS cache invalidation has long been considered a
>> DOS-in-waiting, hence we don't allow user APIs to invalidate caches
>> like this. This is one of the reasons that /proc/sys/vm/drop_caches
>> requires root access - it's system debug and problem triage
>> functionality, not a production system interface....
>>
>> Every other situation where filesystems invalidate vfs caches is
>> during mount, remount or unmount operations.  Without actually
>> explaining how this functionality is controlled and how user abuse
>> is not possible (e.g. explain the permission model and/or how only
>> root can run this operation), it is not really possible to determine
>> whether we should unconditional allow VFS cache invalidation outside
>> of the existing operation scope....
>
> I think you are grabbing the wrong end of the stick here.
>
> This is not about an arbitrary user being able to control caching
> behavior of a fuse filesystem.  It's about the filesystem itself being
> able to control caching behavior.
>
> I'm not arguing for the validity of this particular patch, just saying
> that something like this could be valid.  And as explained in my other
> reply there's actually a real problem out there waiting for a
> solution.

The problem I'm trying to solve is that, if a filesystem wants to ask the
kernel to get rid of all inodes, it has to request the kernel to forget
each one, individually.  The specific filesystem I'm looking at is CVMFS,
which is a read-only filesystem that needs to be able to update the full
set of filesystem objects when a new generation snapshot becomes
available.

The obvious problem with the current solution (i.e. walking through all
the inodes) is that it is slow.  And if new snapshot generations succeed
fast enough, memory usage becomes a major issue -- enough to have a helper
daemon monitoring memory and do a full remount when it passes some
predefined threshold.

Obviously, I'm open to other solutions, including the one suggested by
Miklos in is other reply -- to get rid of the N LRU inodes.  I'm not sure
how that could be implemented yet, but I can have a look into that if you
think that's the right interface.

Cheers,
--=20
Lu=C3=ADs

> Thanks,
> Miklos
>
>
>>
>> FInally, given that the VFS can only do best-effort invalidation
>> and won't provide FUSE (or any other filesystem) with any cache
>> invalidation guarantees outside of specific mount and unmount
>> contexts, I'm not convinced that this is actually worth anything...
>>
>> -Dave.
>> --
>> Dave Chinner
>> david@fromorbit.com

