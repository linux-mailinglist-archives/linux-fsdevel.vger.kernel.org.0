Return-Path: <linux-fsdevel+bounces-53228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D5AECB82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC044176B02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E961DDA15;
	Sun, 29 Jun 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TfEJp8+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEEBA45
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751178275; cv=none; b=lF8UYg0XTP2pNt47N9TqH19rvFSuJKDxPT/fukKUwoBHDJqUYTUqa3caQ61LEHyZkirLbOty+HXqf//FY6kXAfcMjLG/Bz6XOYjFNXf8s4CHDZYpNQ+D1gL4TLKlz3n4ON4SVHe+7uJZ7N1Pl3kai71OB8rjy9wGq74XrdAWnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751178275; c=relaxed/simple;
	bh=DZQqR2TgU0yyABSPyl+Mwi/08tBRtOZQAXEaV7roCmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcMaZpHOdR77TLL1G7OEZ87BjwFS/lTYv24SLNzpPufLF2vXLP0U0KAOFRGPjQ3MHyia1ZIcE8IpWAf5Z5Trf0tghFprxIgDI89SdEMH4V/GqOgDvnPwaUcoFE51WtXv2hKXKEjHkuBl6L2WmPIVu67vkExYa3iS70DYT2NcCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TfEJp8+W; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55T3XTn3004999
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 23:24:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oci4NbAwVlDoKflj9dk24JGg7tg2KRvaoTfqze98KCg=; b=TfEJp8+W44FO
	K5SeSbppQ8xmDsrFCEKw26B/Q7kWSsQiPGrPh1nduaYyepjqcirju/r8mCyPW7wt
	yRFzOe9yTviL2HUcttuctjvBSLDg9Sbhc4b5y8KDcvPsxnymI2t2DQJ2LYtK3FUW
	q0oZU+0Uk2UxG66z9sIaNCucmHwMlvR1yVAs394TKSmeYfovyTcfkqJpxVpuzk5I
	mYie8g/jjUUPNaNkZHqVcdmBnO0XFdyUA7CezTSZ3g4RyD+3dGjI0jTfP8WTfpDY
	DpZugZtyxOmx5mT0/lHngAvLF8Gxb10vevdcJ0Kg8qxMb0F4pNFVKoe/jA6P4F+z
	mMoniIbqnQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47jbqvbwav-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 23:24:32 -0700 (PDT)
Received: from twshared26876.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 29 Jun 2025 06:24:31 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 8DC7930E5179A; Sat, 28 Jun 2025 23:24:19 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Date: Sat, 28 Jun 2025 23:22:47 -0700
Message-ID: <20250629062247.1758376-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
References: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4g3xUHD_pbWoREAsP-J3D9ULeDy6nuz8
X-Authority-Analysis: v=2.4 cv=crWbk04i c=1 sm=1 tr=0 ts=6860dc20 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=M0yb78Uiu5BWlevaJ_MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDA1MSBTYWx0ZWRfXwDwj22lGJ9l5 bf3aJDdUcERw4P26ICWeqWZSpVx8aRtiZ3SLQ29usRLsGQH7EwdsKNmLsPVJvG7d3PHj8BPNIB3 MMH6ypLTx3/8bbiE+/NFH4G/ajG/9ryOEs86PBgmLnw/E2a2hmkr6+OTxM5gVbDdfKaA/A8KV4m
 3OuQKaZW7ZjzEy67uDjc/wCwfORhmIvK7Lev+PbCnn2CERkwN6clUk4vjMBy2aerH0QzUhqBaSK zH50Ku8XLi5T7nd2++6WD5JvlWfGxbFyKDG4lPwHwgmQKDVSq0FX5kNFfLNFHHZYdMvEHsETBN2 s9fLV2ZNnqLyyEI4sVqidmEB0XgVD7jGCCgusY1eR6hAnHLGcNlF2KPHRcib0zDr2/UNaGmlMlM
 7VVKxR1qmqbGmJgsWzq/svHE1Lz8SuXI5G4vYBOQzIKMQKLe0Nbv6rNWwnFKe837KJuc5UsX
X-Proofpoint-ORIG-GUID: 4g3xUHD_pbWoREAsP-J3D9ULeDy6nuz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01

> > > Do we prefer to scope this change to adding (s32) response id and n=
ot add new
> > > event id field yet.
> > >
> > > > Thinking out loud, if we use idr to allocate an event id, as Jan =
suggested,
> > > > and we do want to allow it along side event->fd,
> > > > then we could also overload event->pid, i.e. the meaning of
> > > > FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
> > > > Similarly to the way that we overloaded event->pid with FAN_REPOR=
T_TID.
> > > > Users that need both event id and pid can use FAN_REPORT_PIDFD.
> > > >
> > >
> > > At least for our usecase, having event->fd along with response id a=
vailable
> > > would be helpful as we do not use fid mode mentioned above.
> >
> > You cannot use the fid mode mentioned above because it is not yet
> > supported with pre-content events :)
> >
> > My argument goes like this:
> > 1. We are planning to add fid support for pre-content events for othe=
r
> >     reasons anyway (pre-dir-content events)
> > 2. For this mode, event->fd will (probably) not be reported anyway,
> >     so for this mode, we will have to use a different response id
> > 3. Since event->fd will not be used, it would make a lot of sense and
> >     very natural to reuse the field for a response id
> >
> > So if we accept the limitation that writing an advanced hsm service
> > that supports non-interrupted restart requires that service to use th=
e
> > new fid mode, we hit two birds with one event field ;)
> >
> > If we take into account that (the way I see it) an advanced hsm servi=
ce
> > will need to also support pre-dir-content events, then the argument m=
akes
> > even more sense.
> >

Ah I see this makes sense. And as long as we are still able to open files=
 via
open_handle as the tests you shared below show, then at least for our cas=
e I
don't see issue with switching to the new FAN_CLASS_PRE_CONTENT | FAN_REP=
ORT_FID
mode.

> > The fact that for your current use cases, you are ok with populating =
the
> > entire directory tree in a non-lazy way, does not mean that the use c=
ase
> > will not change in the future to require a lazy population of directo=
ry trees.
> >
> > I have another "hidden motive" with the nudge trying to push you over
> > towards pre-content events in fid mode:
> >
> > Allowing pre-content events together with legacy events in the same
> > mark/group brings up some ugly semantic issues that we did not
> > see when we added the API.
> >
> > The flag combination FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
> > was never supported, so when we support it, we can start fresh with n=
ew rules
> > like "only pre-content events are allowed in this group" and that sim=
plifies
> > some of the API questions.
> >
> > While I have your attention I wanted to ask, as possibly the only
> > current user of pre-content events, is any of the Meta use cases
> > setting any other events in the mask along with pre-content events?
> >

Regarding Meta usages of pre-content events as far as I am aware we are t=
he
only ones, and we don't set other events in the mask, only pre-content. I=
 can
confirm there are no other use cases relying on this and follow up here.

> > *if* we agree to this course I can post a patch to add support for
> > FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, temporarily
> > leaving event->fd in use, so that you can later replace it with
> > a response id.
> >
>

Sounds great. If we do go that route, being able to overload event-fd for=
 now
will definitely make this patch much simpler.

> FWIW, here is that patch:
> https://github.com/amir73il/linux/commits/fan_pre_content_fid/
>
> And here is an LTP test which demonstrates how to use this API:
> https://github.com/amir73il/ltp/commits/fan_pre_content_fid/
>
> This kernel patch does not yet eliminate event->fd, but it makes it
> optional because that file can be opened by handle as the test
> demonstrates.
>
> Thanks,
> Amir.

