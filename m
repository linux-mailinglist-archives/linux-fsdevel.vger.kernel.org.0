Return-Path: <linux-fsdevel+bounces-42007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68671A3A500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FBE170F81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E3270EDD;
	Tue, 18 Feb 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PcIXjTSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A47246348;
	Tue, 18 Feb 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902299; cv=none; b=Vw43nw2Z9O2PwFKZWkRUvtcCaVyVCEz+h/y7jORmZ5obGA0vPFcQxHHkvWH7DMjxuokHS22KqvuyKmbYmRCIk5Vitiz84SQuuwW914mULfLdLT1YUlBR+O3mds+A1H903yVsYXUVmD8qYmIotAwu1fBycY+AVNcvIsPsIm8gGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902299; c=relaxed/simple;
	bh=kZZ5pjQJFYx/jR/ttGx9c+6bkAeq9BxdbBJDLHgv/M0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB5srUWTi2JBuYARYv7jOLgzVM28is6jrtQXLiCsZZCWJxEOfegzlYUe5AX1p5EqOvUCFPNorIpb7xIR5wUsF71iU65RtqhQQWd9zO0ej9evHjYN0F7LnxutFfkgxSSAVvgoGq+gzjmvWdHIcGFWwArD4sm521gVW0Af32viySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PcIXjTSk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=W9kOfy/TvCM9ymdn7cd06+KPst7sda6hgzEZ11ZPZgk=; b=PcIXjTSkjmMVYopn7h1BdLxqww
	uo8zy7ZUUlZh7MWEMAQVx09w741kWWYURw8UrwmHcvu+skitzSpFBaSIwxzcYiiJxNuhzhlXfulSR
	Ipzh/FCqWe0LP/hWOBsrXcLJuQ5SE9F3Owjsbl7JEQcNX6SPBvoQcEZefJ2ojr20SyyirRC4HEYzB
	adx0qMYxD2YsUZWdc1+NpgL8kKztVKMIWyWe4nUdsPruKgwRhiB1zVCgqZUlNn8kmeiKf2a/7pLK2
	uspS8cWofbMCU7DcIu68UDGaHviqYCG9Vg8jtys7RemwcHZdmrEQqZxTk/f+UUM0oLwwVw02thjjB
	1TQl9bTw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkS3s-00BNeS-Dx; Tue, 18 Feb 2025 19:11:18 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>,  Bernd Schubert <bschubert@ddn.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Valentin Volkl <valentin.volkl@cern.ch>,
  Laura Promberger <laura.promberger@cern.ch>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 18 Feb 2025 15:26:24 +0100")
References: <20250217133228.24405-1-luis@igalia.com>
	<20250217133228.24405-3-luis@igalia.com>
	<Z7PaimnCjbGMi6EQ@dread.disaster.area>
	<CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
	<87r03v8t72.fsf@igalia.com>
	<CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
	<87frkb8o94.fsf@igalia.com>
	<CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
Date: Tue, 18 Feb 2025 18:11:17 +0000
Message-ID: <87tt8r6s3e.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18 2025, Miklos Szeredi wrote:

> On Tue, 18 Feb 2025 at 12:51, Luis Henriques <luis@igalia.com> wrote:
>>
>> On Tue, Feb 18 2025, Miklos Szeredi wrote:
>>
>> > On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:
>> >
>> >> The problem I'm trying to solve is that, if a filesystem wants to ask=
 the
>> >> kernel to get rid of all inodes, it has to request the kernel to forg=
et
>> >> each one, individually.  The specific filesystem I'm looking at is CV=
MFS,
>> >> which is a read-only filesystem that needs to be able to update the f=
ull
>> >> set of filesystem objects when a new generation snapshot becomes
>> >> available.
>> >
>> > Yeah, we talked about this use case.  As I remember there was a
>> > proposal to set an epoch, marking all objects for "revalidate needed",
>> > which I think is a better solution to the CVMFS problem, than just
>> > getting rid of unused objects.
>>
>> OK, so I think I'm missing some context here.  And, obviously, I also mi=
ss
>> some more knowledge on the filesystem itself.  But, if I understand it
>> correctly, the concept of 'inode' in CVMFS is very loose: when a new
>> snapshot generation is available (you mentioned 'epoch', which is, I
>> guess, the same thing) the inodes are all renewed -- the inode numbers
>> aren't kept between generations/epochs.
>>
>> Do you have any links for such discussions, or any details on how this
>> proposal is being implemented?  This would probably be done mostly in
>> user-space I guess, but it would still need a way to get rid of the unus=
ed
>> inodes from old snapshots, right?  (inodes from old snapshots still in u=
se
>> would obvious be kept aroud).
>
> I don't have links.  Adding Valentin Volkl and Laura Promberger to the
> Cc list, maybe they can help with clarification.
>
> As far as I understand it would work by incrementing fc->epoch on
> FUSE_INVALIDATE_ALL. When an object is looked up/created the current
> epoch is copied to e.g. dentry->d_time.  fuse_dentry_revalidate() then
> compares d_time with fc->epoch and forces an invalidate on mismatch.

OK, so hopefully Valentin or Laura will be able to help providing some
more details.  But, from your description, we would still require this
FUSE_INVALIDATE_ALL operation to exist in order to increment the epoch.
And this new operation could do that *and* also already invalidate those
unused objects.

> Only problem with this is that it seems very CVMFS specific, but I
> guess so is your proposal.
>
> Implementing the LRU purge is more generally useful, but I'm not sure
> if that helps CVMFS, since it would only get rid of unused objects.

The LRU inodes purge can indeed work for me as well, because my patch is
also only getting rid of unused objects, right?  Any inode still being
referenced will be kept around.

So, based on your reply, let me try to summarize a possible alternative
solution, that I think would be useful for CVMFS but also generic enough
for other filesystems:

- Add a new operation FUSE_INVAL_LRU_INODES, which would get rid of, at
  most, 'N' unused inodes.
=20=20
- This operation would have an argument 'N' with the maximum number of
  inodes to invalidate.

- In addition, it would also increment this new fuse_connection attribute
  'epoch', to be used in the dentry revalidation as you suggested above

- This 'N' could also be set to a pre-#define'ed value that would mean
  *all* (unused) inodes.

Does this make sense?  Would something like this be acceptable?

Cheers,
--=20
Lu=C3=ADs

