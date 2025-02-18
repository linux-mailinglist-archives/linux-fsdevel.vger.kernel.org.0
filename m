Return-Path: <linux-fsdevel+bounces-41984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3AA39B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D8D174C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E623C8DC;
	Tue, 18 Feb 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LCjdnkhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5223958B;
	Tue, 18 Feb 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879497; cv=none; b=nXhsen04k9zZrJV6Cv3UXTESwYaw0iNoJFlHRp6s3q0srzW7dUw/enBoyNgT2Ct9vVNnn6skk/pnzntmdDKgU7aOmm2KL2t7mrVlJJa1bmxxWXYgS/Q4K75vWzZi5k7tBpQfPP8+Iz3bh2nRl86/Y/xeGAhkDVxCOueoVYfcqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879497; c=relaxed/simple;
	bh=Oh2N1/d0twE/oht4u369AivclBMWat1b1M7egJyaA5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MsB2tVCK9Mp0zy1Aut0FHiiMVhBTXr97R0g3dGnqXZv5jTtHxOWm9P3tQf26NDBiPF2DHhkIlMeLEFOSZJxTFfMXHc8cd1bsSuwm9TgeYLf+xLOesHC+pIXPPhv4E8j4ZFJluq63rsbv8NgAFqq/JiulBrOVBjF/bTimePUT03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LCjdnkhz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LJBKZLXPPZUt1paA631LKSCBOvo0igAnLc0aAJ3m/Ek=; b=LCjdnkhz39Zzg/i/5UysEOFpxh
	bYTmF0Wcf/qCUZaL123u6Ga5V/Rw4iX2uG9h0+ZtiwSMrnVk94Mh08WoEW4/WEG1c4ORQkcs1WKGN
	F93kYmWtKS8ID82h3vN5/RXJ2rEUOiLdW9ulnfdTc35HlEFSvuJf9scrfL4KjhEuKzFz2Eracwm0i
	9foXfkIe7ujMPsalI3Q1szRnnGZyGd4fyBLEe2bAn4CBVbIganwvcjdEsSyQcjY4mdraSSkvOaw4g
	mm9QM1JuuWk5eDzj2k98j0TDkaG1Axk04SXOephfbSRWxnSZ0dU0o+FL/KxQjBAJffeN2KjMJcUR1
	3A8ZcCDg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkM89-00A3eO-Sl; Tue, 18 Feb 2025 12:51:19 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dave Chinner <david@fromorbit.com>,  Bernd Schubert <bschubert@ddn.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 18 Feb 2025 11:34:53 +0100")
References: <20250217133228.24405-1-luis@igalia.com>
	<20250217133228.24405-3-luis@igalia.com>
	<Z7PaimnCjbGMi6EQ@dread.disaster.area>
	<CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
	<87r03v8t72.fsf@igalia.com>
	<CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
Date: Tue, 18 Feb 2025 11:51:19 +0000
Message-ID: <87frkb8o94.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18 2025, Miklos Szeredi wrote:

> On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:
>
>> The problem I'm trying to solve is that, if a filesystem wants to ask the
>> kernel to get rid of all inodes, it has to request the kernel to forget
>> each one, individually.  The specific filesystem I'm looking at is CVMFS,
>> which is a read-only filesystem that needs to be able to update the full
>> set of filesystem objects when a new generation snapshot becomes
>> available.
>
> Yeah, we talked about this use case.  As I remember there was a
> proposal to set an epoch, marking all objects for "revalidate needed",
> which I think is a better solution to the CVMFS problem, than just
> getting rid of unused objects.

OK, so I think I'm missing some context here.  And, obviously, I also miss
some more knowledge on the filesystem itself.  But, if I understand it
correctly, the concept of 'inode' in CVMFS is very loose: when a new
snapshot generation is available (you mentioned 'epoch', which is, I
guess, the same thing) the inodes are all renewed -- the inode numbers
aren't kept between generations/epochs.

Do you have any links for such discussions, or any details on how this
proposal is being implemented?  This would probably be done mostly in
user-space I guess, but it would still need a way to get rid of the unused
inodes from old snapshots, right?  (inodes from old snapshots still in use
would obvious be kept aroud).

Cheers,
--=20
Lu=C3=ADs

