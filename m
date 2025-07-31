Return-Path: <linux-fsdevel+bounces-56398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87858B1711B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9418C586AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58D2D0281;
	Thu, 31 Jul 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="da0AN4f0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02B2C15AB;
	Thu, 31 Jul 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964639; cv=none; b=jQE4R0LBog9zHZ8pehsn1Sz1MjPx4MlCQ0CdTcbmqOJBL2BqFFkxJeU2KXwT5NtKg6w9C5vyaKJStbQq7rpKR/isLPa/PGrsPWXmqWu/jMInPXQJgx1fZ1BwiUgTvbkoJeVlXdrsAB/BYa7y8iVpBf2qTTXQieaw0HU9wTpVWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964639; c=relaxed/simple;
	bh=W2rzemPNZ5LHIh3axfvSwTD/JyOmPeLqDRY4zT2WFX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjOB1AnDdAGIFhtxApOtx3AJKJ9B2W9ewm5DuhQHCzwI1A0GSE6+0qYD6Rx9I3JdJejx5sF5SpsPBv9MgzT1S/PPRTDRNgoacCFhiseeNQ0+r9/Fd1QzBRb3ixAyW0w716leuJ3RCkOZa6ce91wnfnTYaUhnIMz3pCFSVHt/uYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=da0AN4f0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A2cnIcYq8PYCOz0CiDn3JmBVvPWO3oydQ8f10T5DUIQ=; b=da0AN4f0+vcYbAOfpRx3yohuhn
	Jo+LGA6RRiI522vbFqa1y+1KBpCOF+7JPKUcc7enPLsvidQtVFiVOTADl65uwbkV5baheAGASz54y
	UPTDJ7ZuSK+09OrnbQ9ZD9srXYZsvq7s/iB27KXeX6Lgi6PxLit2pZwHuFwLRLxKNvOcNCTRt54ai
	lNlCrWIzmSwFPFUNLF6afDLnqzsutdjtS3Riwl25+wTsskqg/4gPjh5b9dnxrMfNQkPk7C2PaITwj
	jHtIYa9f3JGZJnxX/V8geV1IP28Z+Z6MSlKvAz9IKMEKv1g44K5CtmLIbtbR/3NTY1z+OmUUu/f8C
	mHXV0l+g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uhSK3-006d90-Gv; Thu, 31 Jul 2025 14:23:47 +0200
From: Luis Henriques <luis@igalia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <20250731-diamant-kringeln-7f16e5e96173@brauner> (Christian
	Brauner's message of "Thu, 31 Jul 2025 13:33:09 +0200")
References: <8734afp0ct.fsf@igalia.com>
	<20250729233854.GV2672029@frogsfrogsfrogs> <87freddbcf.fsf@igalia.com>
	<20250731-diamant-kringeln-7f16e5e96173@brauner>
Date: Thu, 31 Jul 2025 13:23:41 +0100
Message-ID: <877bzo5z1u.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31 2025, Christian Brauner wrote:

> On Wed, Jul 30, 2025 at 03:04:00PM +0100, Luis Henriques wrote:
>> Hi Darrick,
>>=20
>> On Tue, Jul 29 2025, Darrick J. Wong wrote:
>>=20
>> > On Tue, Jul 29, 2025 at 02:56:02PM +0100, Luis Henriques wrote:
>> >> Hi!
>> >>=20
>> >> I know this has been discussed several times in several places, and t=
he
>> >> recent(ish) addition of NOTIFY_RESEND is an important step towards be=
ing
>> >> able to restart a user-space FUSE server.
>> >>=20
>> >> While looking at how to restart a server that uses the libfuse lowlev=
el
>> >> API, I've created an RFC pull request [1] to understand whether adding
>> >> support for this operation would be something acceptable in the proje=
ct.
>> >
>> > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>> > could restart itself.  It's unclear if doing so will actually enable us
>> > to clear the condition that caused the failure in the first place, but=
 I
>> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>> > aren't totally crazy.
>>=20
>> Maybe my PR lacks a bit of ambition -- it's goal wasn't to have libfuse =
do
>> the restart itself.  Instead, it simply adds some visibility into the
>> opaque data structures so that a FUSE server could re-initialise a sessi=
on
>> without having to go through a full remount.
>>=20
>> But sure, there are other things that could be added to the library as
>> well.  For example, in my current experiments, the FUSE server needs sta=
rt
>> some sort of "file descriptor server" to keep the fd alive for the
>> restart.  This daemon could be optionally provided in libfuse itself,
>> which could also be used to store all sorts of blobs needed by the file
>> system after recovery is done.
>
> Fwiw, for most use-cases you really just want to use systemd's file
> descriptor store to persist the /dev/fuse connection:
> https://systemd.io/FILE_DESCRIPTOR_STORE/

Thank you, Christian.  I guess I should have mentioned systemd's fdstore
here.  In fact, I knew about it, but in my experiments I decided not to
use it because it's trivial to keep the fd alive[1] (and also because my
test environment doesn't run systemd).

But still, any eventual libfuse support could still include the interface
with fdstore for that.

[1] Obviously "it's trivial" for my experiments.  Doing it in a secure way
    is probably a bit more challenging.

Cheers,
--=20
Lu=C3=ADs

>
>>=20
>> >> The PR doesn't do anything sophisticated, it simply hacks into the op=
aque
>> >> libfuse data structures so that a server could set some of the sessio=
ns'
>> >> fields.
>> >>=20
>> >> So, a FUSE server simply has to save the /dev/fuse file descriptor and
>> >> pass it to libfuse while recovering, after a restart or a crash.  The
>> >> mentioned NOTIFY_RESEND should be used so that no requests are lost, =
of
>> >> course.  And there are probably other data structures that user-space=
 file
>> >> systems will have to keep track as well, so that everything can be
>> >> restored.  (The parameters set in the INIT phase, for example.)
>> >
>> > Yeah, I don't know how that would work in practice.  Would the kernel
>> > send back the old connection flags and whatnot via some sort of
>> > FUSE_REINIT request, and the fuse server can either decide that it will
>> > try to recover, or just bail out?
>>=20
>> That would be an option.  But my current idea would be that the server
>> would need to store those somewhere and simply assume they are still OK
>
> The fdstore currently allows to associate a name with a file descriptor
> in the fdstore. That name would allow you to associate the options with
> the fuse connection. However, I would not rule it out that additional
> metadata could be attached to file descriptors in the fdstore if that's
> something that's needed.

