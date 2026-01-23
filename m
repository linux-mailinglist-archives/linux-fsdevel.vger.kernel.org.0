Return-Path: <linux-fsdevel+bounces-75262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBuIJaRYc2nruwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:16:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C73074E9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A45C302BDD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592313093C9;
	Fri, 23 Jan 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pvdmOFRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C83287256
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166982; cv=none; b=P6q5fARaZzMRp9+OexdtEGrkNZaP3Y6orNQbJ/t/Eu0Wz8cgO3Xt8sxWNjV9I15rT32eWtoSjP1sXltA9uyccxNY3Vovnh/OlQuaTppKtN5qXKLO4R3EiYEeVbwGorLTqJYEyKyqJlH3oDl9Ryj2ja/PEvh2EeoEXZr6y0FO+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166982; c=relaxed/simple;
	bh=KmxfVO4ykiXxnuxxlu2+GtvvruzBrO37VBzbAn95ag4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTNIsFDA/iSMLkRqd/uYPo32C0YEhLA0zomrdAaKwYBmAD42U3gfraqhGg8TKK/Hu8bzO1v9ygTfhBeUfsnAfF6Tf2GV6UiEKpVEvXVLp2U6zSuqw9JD6BvouuFr1d0lqky7MWGv6apTrujbU4ZLaLN/AqH0Qg2+FJiDOGO7y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pvdmOFRv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eIbs4H7O4mL0vns39zEQPrZpm/3mPKoJwigBdkJoi6Y=; b=pvdmOFRvn3q6aDvdYGhLNTJvIT
	C1l5ZRjuoRspW57NgNZ6oq5MaLqjJNTm+w63fOklB4aPZb+hBdoDBzApG8IRK7qYg0QcBZFSLE132
	viLLERU8D87x+6/Uvy+Oar2HAQpWZX91FtXQZgPfTUPU15ZfsuoZzhkBU38tza2gUd5tsZ0MC2pPU
	4Enuy8tVVxViiRpVaniQhDDIniEaqvK8AEc4xuJEMHigVtA06eRPHmG5+NJR+gRcgKjcVHSBDfHuk
	OtmwmFf1MsqJfdS7v276gusWc5N8LTBxDwKC+W9eHds4roxIsRm22ljQrUgUOfyUOOaqoH+7H0+nV
	zUTt5v6Q==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjF9B-008r6w-O1; Fri, 23 Jan 2026 12:16:13 +0100
From: Luis Henriques <luis@igalia.com>
To: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
    Amir Goldstein <amir73il@gmail.com>,
    Bernd Schubert <bernd@bsbernd.com>,
    Horst Birthelmer <horst@birthelmer.de>,
    Joanne Koong <joannelkoong@gmail.com>,
    "Darrick J. Wong" <djwong@kernel.org>
Subject: [LSF/MM/BPF TOPIC] FUSE servers restartability
Date: Fri, 23 Jan 2026 11:16:07 +0000
Message-ID: <87cy301sw8.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75262-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,birthelmer.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.805];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C73074E9D
X-Rspamd-Action: no action

Hi all,

I would like to propose the user-space FUSE servers restartability topic
for discussion in the next LSF/MM/BPF Summit.  I'm sure there are several
scenarios where restarting a FUSE server without the need for an
unmount/mount cycle is desirable, but the first two that always come to my
mind are:

1) Software bugs: there's a crash in the FUSE server (or in libfuse) and
   we want to be able to restart the server without applications that have
   open files in the file system to notice it.

2) Software upgrades: there is a new version of the FUSE server (or
   libfuse) available and we want to do the upgrade without any downtime.

Over the years, there have been a few threads in the mailing-lists about
this topic, the most recent one started by myself[1].  This thread
triggered the work on the FUSE_LOOKUP_HANDLE operation implementation[2],
which is currently work-in-progress.

What I would like to bring to LSF/MM/BPF, besides any extra details still
open regarding the FUSE_LOOKUP_HANDLE implementation, is what else could
be done in the kernel that would ease the implementation of a user-space
server that could be restarted.

There are two obvious things that would be helpful to have:

  - The implementation of a NOTIFY_RESEND_LOOKUPS operation, which would
    allow FUSE servers to request the kernel to resend all cached inodes
    after the restart.  This new operation could probably be merged into
    the existing NOTIFY_RESEND, by setting a flag in the request, for
    example.

  - The implementation of a NOTIFY_RESEND_INIT operation to request the
    kernel to resend the FUSE parameters that have been negotiated during
    INIT.  Or maybe it would be interesting to have a NOTIFY_REINIT
    instead, so that the FUSE server could actually modify the parameters
    initially negotiated.  This could be useful, for example, when doing a
    server upgrade that would support different features.

There's also the ability of keeping the /dev/fuse file descriptor open
across the server restart.  We could add some helpers for that in libfuse,
but since this is mostly a solved problem if we use systemd file
descriptor store[3], this is a low-priority topic and probably not worth
discussing it.

Hopefully this topic will allow to identify other potential issues and/or
ideas for improving the ability to restart FUSE servers.

[1] https://lore.kernel.org/all/8734afp0ct.fsf@igalia.com
[2] https://lore.kernel.org/all/20251212181254.59365-1-luis@igalia.com
[3] https://systemd.io/FILE_DESCRIPTOR_STORE/

Cheers,
--=20
Lu=C3=ADs

