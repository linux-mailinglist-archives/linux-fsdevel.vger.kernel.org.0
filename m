Return-Path: <linux-fsdevel+bounces-46455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F3A89A61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94ADD3B8CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00525289357;
	Tue, 15 Apr 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F6OoJux8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8221DED7B;
	Tue, 15 Apr 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713298; cv=none; b=s4Kr5SlOsDcWdE1uaDbloFNmdAyUfhRb95EVWYXMUEyfo5ZtiqRgLMU4DGvfP49avtX7TNcZjWMUWrNOP63SEc1DFEE/lOM+sV+7XivMbc1N58KaPQfkZrD5Rv92JuuJ5T8RVEjVUal2wWtk4w7CpLDAWv9UltEHQ5L4gyQvhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713298; c=relaxed/simple;
	bh=2d9Ov9hhikBrse5IuoWoSVSQmXqSkr5D1kwckyMnTgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GX3v8BQwITPb0+X5ZAv5Cp+sQRw8bh4uCXEIN3gD1iSSaH2dLjtgZHU/6ZgCLSoR2GBsiEB85ipbhYq+9UgwixDb56WwLOphPT8nV5hzNYmJgOfqiaOcCbqf06ICxMqhUbZznlaZ9IjC2WmW5I5Z6PvyoP+LnIKN6V3gjgxOBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F6OoJux8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LWR5t3wZU4YK8CsxmecAlIdhPIhp9PGOYDkAfl34jM4=; b=F6OoJux8+/bCieuXVjValq70t2
	cTdJRe+Ir8SW8mXbIKCQfxLBsMT9tX8WyWsH42SBVwwVfIPhRJycIVUkfXmDUMd7c96wi4coosRJg
	JPWyDLJ0Xp3FmBXcULBbTYca0B1fqsaPHjNU9I26a6bZlx7GfVRnZmDz4TKrAFPx43C3qILSyI4ds
	ZyLiVH+qCzFAb34wNYshC4SJeD0SS+P0UZRUWtAUdOFotNuvqUVoqfMikAzmDIZ7CTsecSO1gYwx+
	TNnT+knOBEQj7OAWCpPa/DLxI7mdKRUlzdYRbElzt3tNMlKua1Wvaw9Ph0el69eNbPYrhu5urtNvt
	fxmJ8UHg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4dcq-00GtmQ-4B; Tue, 15 Apr 2025 12:34:44 +0200
From: Luis Henriques <luis@igalia.com>
To: Laura Promberger <laura.promberger@cern.ch>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  Dave Chinner <david@fromorbit.com>,  Matt Harvey
 <mharvey@jumptrading.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <GV0P278MB07182F4A1BDFD2506E2F58AC85B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
	(Laura Promberger's message of "Fri, 11 Apr 2025 15:16:53 +0000")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	<875xk7zyjm.fsf@igalia.com>
	<GV0P278MB07182F4A1BDFD2506E2F58AC85B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
Date: Tue, 15 Apr 2025 11:34:38 +0100
Message-ID: <87r01tn269.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Laura,

On Fri, Apr 11 2025, Laura Promberger wrote:

> Hello Miklos, Luis,
>
> I tested Luis NOTIFY_INC_EPOCH patch (kernel, libfuse, cvmfs) on RHEL9 an=
d can
> confirm that in combination with your fix to the symlink truncate it solv=
es all
> the problem we had with cvmfs when applying a new revision and at the sam=
e time
> hammering a symlink with readlink() that would change its target. (
> https://github.com/cvmfs/cvmfs/issues/3626 )
>
> With those two patches we no longer end up with corrupted symlinks or get=
 stuck on an old revision.
> (old revision was possible because the kernel started caching the old one=
 again during the update due to the high access rate and the asynchronous e=
vict of inodes)
>
> As such we would be very happy if this patch could be accepted.

Even though this patch and the one that fixed the symlinks corruption [1]
aren't really related, it's always good to have extra testing.  Thanks a
lot for your help, Laura.

In the meantime, I hope to send a refreshed v9 of this patch soon (maybe
today) as it doesn't apply cleanly to current master anymore.  And I also
plan to send v2 of the (RFC) patch that adds the workqueue to clean-up
expired cache entries.

[1] That's commit b4c173dfbb6c ("fuse: don't truncate cached, mutated
    symlink"), which has been merged already.

Cheers,
--=20
Lu=C3=ADs


>
> Have a nice weekend
> Laura
>
>
> ________________________________________
> From:=C2=A0Luis Henriques <luis@igalia.com>
> Sent:=C2=A0Monday, March 17, 2025 12:28
> To:=C2=A0Miklos Szeredi <miklos@szeredi.hu>
> Cc:=C2=A0Laura Promberger <laura.promberger@cern.ch>; Bernd Schubert
> <bschubert@ddn.com>; Dave Chinner <david@fromorbit.com>; Matt Harvey
> <mharvey@jumptrading.com>; linux-fsdevel@vger.kernel.org
> <linux-fsdevel@vger.kernel.org>; linux-kernel@vger.kernel.org
> <linux-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH v8] fuse: add more control over cache invalidati=
on behaviour
> =C2=A0
> Hi Miklos,
>
> [ adding Laura to CC, something I should have done before ]
>
> On Mon, Mar 10 2025, Miklos Szeredi wrote:
>
>> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:
>>
>>> Any further feedback on this patch, or is it already OK for being merge=
d?
>>
>> The patch looks okay.=C2=A0 I have ideas about improving the name, but t=
hat can wait.
>>
>> What I think is still needed is an actual use case with performance numb=
ers.
>
> As requested, I've run some tests on CVMFS using this kernel patch[1].
> For reference, I'm also sharing the changes I've done to libfuse[2] and
> CVMFS[3] in order to use this new FUSE operation.=C2=A0 The changes to th=
ese
> two repositories are in a branch named 'wip-notify-inc-epoch'.
>
> As for the details, basically what I've done was to hack the CVMFS loop in
> FuseInvalidator::MainInvalidator() so that it would do a single call to
> the libfuse operation fuse_lowlevel_notify_increment_epoch() instead of
> cycling through the inodes list.=C2=A0 The CVMFS patch is ugly, it just
> short-circuiting the loop, but I didn't want to spend any more time with
> it at this stage.=C2=A0 The real patch will be slightly more complex in o=
rder
> to deal with both approaches, in case the NOTIFY_INC_EPOCH isn't
> available.
>
> Anyway, my test environment was a small VM, where I have two scenarios: a
> small file-system with just a few inodes, and a larger one with around
> 8000 inodes.=C2=A0 The test approach was to simply mount the filesystem, =
load
> the caches with 'find /mnt' and force a flush using the cvmfs_swissknife
> tool, with the 'ingest' command.
>
> [ Disclosure: my test environment actually uses a fork of upstream cvmfs,
> =C2=A0 but for the purposes of these tests that shouldn't really make any
> =C2=A0 difference. ]
>
> The numbers in the table below represent the average time (tests were run
> 100 times) it takes to run the MainInvalidator() function.=C2=A0 As expec=
ted,
> using the NOTIFY_INC_EPOCH is much faster, as it's a single operation, a
> single call into FUSE.=C2=A0 Using the NOTIFY_INVAL_* is much more expens=
ive --
> it requires calling into the kernel several times, depending on the number
> of inodes on the list.
>
> |------------------+------------------+----------------|
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | small filesystem | "big" fs=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (~20 inodes)=C2=A0=C2=A0=C2=A0=C2=A0 | (~8=
000 inodes) |
> |------------------+------------------+----------------|
> | NOTIFY_INVAL_*=C2=A0=C2=A0 | 330 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 4300 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> | NOTIFY_INC_EPOCH | 40 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 45 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
> |------------------+------------------+----------------|
>
> Hopefully these results help answering Miklos questions regarding the
> cvmfs use-case.
>
> [1] https://lore.kernel.org/all/20250226091451.11899-1-luis@igalia.com/
> [2] https://github.com/luis-henrix/libfuse
> [3] https://github.com/luis-henrix/cvmfs
>
> Cheers,
> --
> Lu=C3=ADs


