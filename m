Return-Path: <linux-fsdevel+bounces-76185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCxJAk/VgWkCKgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 12:00:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73573D802B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD479304AC25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94732E68E;
	Tue,  3 Feb 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wp84O40l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16FE32BF3A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116426; cv=none; b=E/VmGeLHnecI0Zz4J39FemPOxeVfoOgWh5a9bHQSVcKIQz5l8TNjjXiKJM22thaaS1+ng8+w0M9z/UlLJaWUClTCpAZbpvRTi4FQmvHsG6XK12rcJLsdLeTYeJ0qxXh8tYDrfWZDG/NkHp2OyX/SlRti6ILaqilo1ALvKD4EGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116426; c=relaxed/simple;
	bh=Pw3YCH/u4IEHdMrogs7/24yotJlNv3UbCFMFQ6nI93c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DlBndNdJau+Siz0LF95nmV7o1kcvMHJ+a0xJ5E5v7k+CiE9PBU0o1ZVbq0nbi1Z8Zns1onmunSmWA1mJY70hM5q+HiZNllRg7A+PEXZKFca8vr/JzBIsLzUkZzUdfW6H7JBprFdoVJlbdyMSqp/s9+4ZQJ8gmMlJzHsk6ntAgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wp84O40l; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6GyYVf2tHmvXfim3s/+qFkLoJymI0UKfl0HJMmpOmmA=; b=Wp84O40l6EwJocgCX0LAfC5P1U
	iNp5NZKhk+9ICgFj/kv0sUNEfBcDwYz3IoGb+mB14qAmsajHB3eQJ8f6h2rP9PoZqb8BL0rLNJUNK
	T3R2gN8XhrRWsoDTP4c7I2neZ14HBqfdqKMB3UIUNI08dB07H7pPpZSqfzRPi50BSVEahJdY4B1sb
	AK3Lf15VAbGfdW7Zy4ddIm6qxTnpG28bmrxjjI0ZNskn2VBOlg13cx11uiVcTMcOkrizgoTdP2Lic
	KOWQ8DtpukTS2D9gt3THIDl+ZOkbrQWx/SuWLS/6T12KzY9UnJYZZ8Il825aqfWJPgQFMFm5mfwtu
	dvPEvnqg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vnDR9-00DA6J-0E; Tue, 03 Feb 2026 11:15:11 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  Joanne Koong <joannelkoong@gmail.com>,  "Darrick J . Wong"
 <djwong@kernel.org>,  John Groves <John@groves.net>,  Bernd Schubert
 <bernd@bsbernd.com>,  Horst Birthelmer <horst@birthelmer.de>,  lsf-pc
 <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
In-Reply-To: <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
	(Amir Goldstein's message of "Mon, 2 Feb 2026 17:14:37 +0100")
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
	<CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
Date: Tue, 03 Feb 2026 10:15:05 +0000
Message-ID: <87cy2myvyu.fsf@wotan.olymp>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,wotan.olymp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-76185-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[szeredi.hu,vger.kernel.org,gmail.com,kernel.org,groves.net,bsbernd.com,birthelmer.de,lists.linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 73573D802B
X-Rspamd-Action: no action

On Mon, Feb 02 2026, Amir Goldstein wrote:

> [Fixed lsf-pc address typo]
>
> On Mon, Feb 2, 2026 at 2:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>>
>> I propose a session where various topics of interest could be
>> discussed including but not limited to the below list
>>
>> New features being proposed at various stages of readiness:
>>
>>  - fuse4fs: exporting the iomap interface to userspace
>>
>>  - famfs: export distributed memory
>>
>>  - zero copy for fuse-io-uring
>>
>>  - large folios
>>
>>  - file handles on the userspace API
>>
>>  - compound requests
>>
>>  - BPF scripts
>>
>> How do these fit into the existing codebase?
>>
>> Cleaner separation of layers:
>>
>>  - transport layer: /dev/fuse, io-uring, viriofs
>>
>>  - filesystem layer: local fs, distributed fs
>>
>> Introduce new version of cleaned up API?
>>
>>  - remove async INIT
>>
>>  - no fixed ROOT_ID
>>
>>  - consolidate caching rules
>>
>>  - who's responsible for updating which metadata?
>>
>>  - remove legacy and problematic flags
>>
>>  - get rid of splice on /dev/fuse for new API version?
>>
>> Unresolved issues:
>>
>>  - locked / writeback folios vs. reclaim / page migration
>>
>>  - strictlimiting vs. large folios
>
> All important topics which I am sure will be discussed on a FUSE BoF.

I wonder if the topic I proposed separately (on restarting FUSE servers)
should also be merged into this list.  It's already a very comprehensive
list, so I'm not sure it's worth having a separate topic if most of it
will (likely) be touched here already.

What do you think?

Cheers,
--=20
Lu=C3=ADs

> I think that at least one question of interest to the wider fs audience is
>
> Can any of the above improvements be used to help phase out some
> of the old under maintained fs and reduce the burden on vfs maintainers?
>
> Thanks,
> Amir.


