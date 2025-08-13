Return-Path: <linux-fsdevel+bounces-57697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C5B24A5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E905189B75E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4092E718B;
	Wed, 13 Aug 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UVBp/n60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F82E6115;
	Wed, 13 Aug 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090883; cv=none; b=BRdquXGb0YMdzITJ30GXKNneHDzzeawq1qOfTBtjvEKmjcc+JrZwdogueEDvnETVKrcPVDG0lgRIC97T/CnS3nxHk8xv3x1aJK+bk8FMMg64ZjieNBJqu66zJCk4OD2le7lQPjABScCy+yw7iSX21lARartoV111lz9wJardVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090883; c=relaxed/simple;
	bh=RyeVRceCRE6e1E/cTV6ksa7df2ZLFdOqini9dMVW0Wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mf/GofC7P8mrJIRkBZ6bX0nDpB5bDDUXhvs96ocdOdggy6wLExLAfBX+IepTxV5B5BJqCq3LjqEPC7g/5QMsdKX9DmJVXiqXdqHR++rHbNONb5jgooAhzdk4PWULv1kci55EQFzdCYfACFknWO7XQ5oLIQgAR79svHw0yDGeDJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UVBp/n60; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/fuaP0nNn7GL6ABJJb2SAGKgHgvHmMhY/K9d6ev2HJk=; b=UVBp/n60l2PtQl3nzA3A0Tdivx
	XwVHkEfJutvjGxL2zsS0LMBlzkXnX5D+6k/vaB77PBhvVzk5yzVqrEdOcAx0ASf+CgRu0I98T2Yta
	g9fRyvyTO9MoA4k+seVYyW/ij0VmnJvOgZqbgyhVc1nufRPZSG6Ewn+b1SkmND4OSFz7MxC5LdLsV
	Zpol8HgZbf8p6lVXrC895ix1yzhKg55DeM2g5blx7PfXGxvIG4uAcSVkgTtxifomszQqbTGWeijYj
	KB9QceV/Zs9Ivi+rTqVnCuJQfIdLRMFdRtI+ticgYt7pNEWLfQ47nGl8s7sCLePd+98Z9e05bIvH4
	Gm2VD4Hw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umBJG-00DfwM-Rt; Wed, 13 Aug 2025 15:14:30 +0200
From: Luis Henriques <luis@igalia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,  Miklos Szeredi <miklos@szeredi.hu>,
  Bernd Schubert <bschubert@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <20250811154319.GA7942@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Mon, 11 Aug 2025 08:43:19 -0700")
References: <8734afp0ct.fsf@igalia.com>
	<20250729233854.GV2672029@frogsfrogsfrogs>
	<20250731130458.GE273706@mit.edu>
	<20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
	<20250811154319.GA7942@frogsfrogsfrogs>
Date: Wed, 13 Aug 2025 14:14:24 +0100
Message-ID: <87jz37pdn3.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11 2025, Darrick J. Wong wrote:

> On Fri, Aug 01, 2025 at 11:15:26AM +0100, Luis Henriques wrote:
>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>=20
>> > On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>> >> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>> >> >=20
>> >> > Just speaking for fuse2fs here -- that would be kinda nifty if libf=
use
>> >> > could restart itself.  It's unclear if doing so will actually enabl=
e us
>> >> > to clear the condition that caused the failure in the first place, =
but I
>> >> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>> >> > aren't totally crazy.
>> >>=20
>> >> I'm trying to understand what the failure scenario is here.  Is this
>> >> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>> >> is supposed to happen with respect to open files, metadata and data
>> >> modifications which were in transit, etc.?  Sure, fuse2fs could run
>> >> e2fsck -fy, but if there are dirty inode on the system, that's going
>> >> potentally to be out of sync, right?
>> >>=20
>> >> What are the recovery semantics that we hope to be able to provide?
>> >
>> > <echoing what we said on the ext4 call this morning>
>> >
>> > With iomap, most of the dirty state is in the kernel, so I think the n=
ew
>> > fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, whi=
ch
>> > would initiate GETATTR requests on all the cached inodes to validate
>> > that they still exist; and then resend all the unacknowledged requests
>> > that were pending at the time.  It might be the case that you have to
>> > that in the reverse order; I only know enough about the design of fuse
>> > to suspect that to be true.
>> >
>> > Anyhow once those are complete, I think we can resume operations with
>> > the surviving inodes.  The ones that fail the GETATTR revalidation are
>> > fuse_make_bad'd, which effectively revokes them.
>>=20
>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>> but probably GETATTR is a better option.
>>=20
>> So, are you currently working on any of this?  Are you implementing this
>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>> look at fuse2fs too.
>
> Nope, right now I'm concentrating on making sure the fuse/iomap IO path
> works reliably; and converting fuse2fs to be a lowlevel fuse server.

Great, thanks for clarifying.

> Eliminating all the path walking stuff that the highlevel fuse library
> does reduces the fstests runtime from 7.9 to 3.5h, and turning on iomap
> cuts that to 2.2h.

Wow! those are quite impressive numbers.  Looking forward to look into
those fuse2fs improvements!

Cheers,
--=20
Lu=C3=ADs

