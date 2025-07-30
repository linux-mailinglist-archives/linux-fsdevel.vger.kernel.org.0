Return-Path: <linux-fsdevel+bounces-56344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDFB16234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EC93A9551
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37E2D97AF;
	Wed, 30 Jul 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ONhNN1bE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA12D8DD9;
	Wed, 30 Jul 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884267; cv=none; b=J4twvXSshZejifYhxKYvC26bSilMq0Xxll6708xmn568U7ak23bibcIXOLwwz4BEWWlGE3tTowq1ZVPHa4Rhkk5vXJwsobulnaAiA5zS9gB4FylRzacSATIl0CV9gQZmuYo+++i1ZNF/qzLSGJKtZ5fr+cNDaJO6DsbsaILJvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884267; c=relaxed/simple;
	bh=0QUgoLmOzTxIOTgR39jazaxTcUO8R7achWFRTaEI3hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=psstdiGQ/6OJB5dzVV+JvZZBKX7jzvXMNVLFU8N1F83LowsOIZF8H3DBCxJkFWGTPZ2XXepMbELEjzowklAjNt2B7Ud0etGF6a/gmZV5v3qtLOz/+GQ8Ux5vBHWsLAuxhSKtU0cciKx8MsQlKBYrH5CRDdhA1LTzfAcb/VIJU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ONhNN1bE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9FOzRDrm4k7ocA4kO9VO4g/icl7IvB2SOCCVPLY5wro=; b=ONhNN1bEEM357dbXPC3O3Qg4Oe
	euUQQmnp/SYBZJydRPlm7IxUaesPobFN8su/IDUF6MMaKE39cua60kRc1rxdVr7qE06GqlqaAUVIe
	zFvBnDeA/33LZ17l+vmQSRrBDnsdvAd0IoZS4e5aPGB4qSYu51Xodj0PPJsLmp2Vi9T973Hd3M19G
	U7koTuV6jodGla8Meu8UA0im+dZWLTGffRtFC3Od55uUYXmdXCMXPf0fay40sWRTOejMBzVy/lSkd
	BtYIBgSK28VHSqmuflcyNwCa9OlGbqigkD9ICXkPBjC8VrgCduYr1vlIgDLPHwhsj+tTw5VBHYAAV
	dLkrNwjg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uh7Pa-005yiX-HZ; Wed, 30 Jul 2025 16:04:06 +0200
From: Luis Henriques <luis@igalia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <20250729233854.GV2672029@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Tue, 29 Jul 2025 16:38:54 -0700")
References: <8734afp0ct.fsf@igalia.com>
	<20250729233854.GV2672029@frogsfrogsfrogs>
Date: Wed, 30 Jul 2025 15:04:00 +0100
Message-ID: <87freddbcf.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Darrick,

On Tue, Jul 29 2025, Darrick J. Wong wrote:

> On Tue, Jul 29, 2025 at 02:56:02PM +0100, Luis Henriques wrote:
>> Hi!
>>=20
>> I know this has been discussed several times in several places, and the
>> recent(ish) addition of NOTIFY_RESEND is an important step towards being
>> able to restart a user-space FUSE server.
>>=20
>> While looking at how to restart a server that uses the libfuse lowlevel
>> API, I've created an RFC pull request [1] to understand whether adding
>> support for this operation would be something acceptable in the project.
>
> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> could restart itself.  It's unclear if doing so will actually enable us
> to clear the condition that caused the failure in the first place, but I
> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> aren't totally crazy.

Maybe my PR lacks a bit of ambition -- it's goal wasn't to have libfuse do
the restart itself.  Instead, it simply adds some visibility into the
opaque data structures so that a FUSE server could re-initialise a session
without having to go through a full remount.

But sure, there are other things that could be added to the library as
well.  For example, in my current experiments, the FUSE server needs start
some sort of "file descriptor server" to keep the fd alive for the
restart.  This daemon could be optionally provided in libfuse itself,
which could also be used to store all sorts of blobs needed by the file
system after recovery is done.

>> The PR doesn't do anything sophisticated, it simply hacks into the opaque
>> libfuse data structures so that a server could set some of the sessions'
>> fields.
>>=20
>> So, a FUSE server simply has to save the /dev/fuse file descriptor and
>> pass it to libfuse while recovering, after a restart or a crash.  The
>> mentioned NOTIFY_RESEND should be used so that no requests are lost, of
>> course.  And there are probably other data structures that user-space fi=
le
>> systems will have to keep track as well, so that everything can be
>> restored.  (The parameters set in the INIT phase, for example.)
>
> Yeah, I don't know how that would work in practice.  Would the kernel
> send back the old connection flags and whatnot via some sort of
> FUSE_REINIT request, and the fuse server can either decide that it will
> try to recover, or just bail out?

That would be an option.  But my current idea would be that the server
would need to store those somewhere and simply assume they are still OK
after reconnecting.  The kernel wouldn't need to know the user-space was
replaced by another server, potentially different, after an upgrade for
example.

Right now, AFAIU, restarting a FUSE server *can* be done without any help
from the kernel side, as long as the fd is kept alive.  The NOTIFY_RESEND
is used only for resending FUSE requests for which the kernel is currently
waiting replies for.  So, for example if the kernel sends a FUSE_READ to
user-space and the server crashes while trying to serve it, the kernel
will still be waiting for that reply.  However, a new server trying to
recover from the crash will have no way to know that.  And this is where
the NOTIFY_RESEND is useful.

>> But, from the discussion with Bernd in the PR, one of the things that
>> would be good to have is for the kernel to send back to user-space the
>> information about the inodes it already knows about.
>>=20
>> I have been playing with this idea with a patch that simply sends out
>> LOOKUPs for each of these inodes.  This could be done through a new
>> NOTIFY_RESEND_INODES, or maybe it could be an extra operation added to t=
he
>> already existing NOTIFY_RESEND.
>
> I have no idea if NOTIFY_RESEND already does this, but you'd probably
> want to purge all the unreferenced dentries/inodes to reduce the amount
> of re-querying.

No, NOTIFY_RESEND doesn't purge any of those; currently it simply resend
all the requests.

> I gather that any fuse server that wants to reboot itself would either
> have to persist what the nodeids map to, or otherwise stabilize them?
> For example, fuse2fs could set the nodeid to match the ext2 inode
> numbers.  Then reconnecting them wouldn't be too hard.

Right, that's my understanding as well -- restarting a server requires
stable nodeids.  IIRC most (all?) examples shipped with libfuse can't be
restarted because they cast a pointer (the memory address to some sort of
inode data struct) and use that as the nodeid.

>> Anyway, before spending any more time with this, I wanted to ask whether
>> this is something that could be acceptable in the kernel, if people think
>> a different approach should be followed, or if I'm simply trying to solve
>> the wrong problem.
>>=20
>> Thanks in advance for any feedback on this.
>>=20
>> [1] https://github.com/libfuse/libfuse/pull/1219
>
> Who calls fuse_session_reinitialize() ?

Ah! Good question!  So, my idea was that a FUSE server would do something
like this:

	fuse_session_new()

	if (do_recovery) {
		get_old_fd()
		fuse_session_reinitialize()
                fuse_lowlevel_notify_resend()
	} else
		fuse_session_mount()

	fuse_daemonize()
	fuse_session_loop_mt()

Anyway, my initial concerns with restartability started because it is
currently not possible to restart a server that uses libfuse without
hacking into it's internal data structures.  The idea of resending all
LOOKUPs just came from the discussion in the PR.

Cheers,
--=20
Lu=C3=ADs

