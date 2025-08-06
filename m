Return-Path: <linux-fsdevel+bounces-56919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511E6B1CEF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4237AA1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF3235364;
	Wed,  6 Aug 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="I+EoFrRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA49227EB9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517977; cv=none; b=faq1u6Q2lMcYn2fhfRvlgmXQAxYADQzF89MKxqfa5/jpIUybyc7Jbl7TyMNmY3Mf5s/nWDdrrXVJNxXfxyIofxT105enZgrMmdKcgtbhNMVbRiLZ7XmJzwk0s6RDBZA7ZWd2V6asHZoQk2+Hlfpe9jDRxsZc6U9/JtPSw/Djw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517977; c=relaxed/simple;
	bh=uILHMdXnMvch9KpXcARInJtqDpPL5lx8xT+I+oOt+LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GsI46RZuRMxVKvPpmnLBiamhc7YfGL33TnpbpLjjn5eLk4JwMf73fOpih0chFTUILrdnlvKzXKc/VQRPqRDBrJIVuOlCOC2Xu4y0dMcKeQpoFpmaryFzggbufOmq+7saQ5h3C3IvRvaAJ8QbbZchf/Zh8LY/QSxtCPYH2NwUTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=I+EoFrRl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576LJLAb006058
	for <linux-fsdevel@vger.kernel.org>; Wed, 6 Aug 2025 15:06:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=c3h1KIN05ItTmYKSh4
	1Jcsw0F2mjpSKL+fFsbhP3l7I=; b=I+EoFrRlNEoTh9Ypvtq9HsHG7/Ucw7lHEp
	KgnFKzGODMt9JWwLNbJTQ+CAL2qwShnMDuAKEhM7mPP70fbGKRte+ww9OI4ekRim
	xZCHudEIvqPmXeFBxM4cyPGO8DyI/PBsWSR0qranbpNs7+PcvYnt+BmtsfXgcul8
	gQ77IgXTc4pFQsmX+42fm0dHHAS9pA/afWBojjwg3TOxBLdTi/Q4MpsTSedV92tu
	Ks5xqlSFQUsRIQ7poDa5ZDFieSVwvEVbHeEhkksMZULa4NFTyKdoz2wQjKZMCXnB
	afOSY6M2w0e2LWoPNZEwxlYK4haFeyuytKgjvbgfBIiwQDmcajCQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48c0a8y3cf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
Received: from twshared57752.46.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 6 Aug 2025 22:05:45 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id E653E353A75B1; Wed,  6 Aug 2025 15:05:40 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH 0/2] fanotify: support restartable permission events
Date: Wed, 6 Aug 2025 15:05:14 -0700
Message-ID: <20250806220516.953114-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: S_5p10dbIz7AT9uwXjACluB9rOsRXsiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDE0NyBTYWx0ZWRfX1mFMZoAHlBuZ 3YTwm3w/qn0GanvYD5vWMWGiHuuAXP5eqdut4n08W6bWI44UQANau1CVs/Gdac9vyrQnN6WQhz9 dUUod48Cm/T8RaL33xwz6dO9YciZ0fxhU2y1p8slwzJq/c5TKFwcYhPYakdn22RCj8luyAsMgn1
 Ze3S1ShOafKVp8n2GtYZwx3r/PP90/CVJaRtk/vqOoDxNWG66B4fqfnUd0XD0WFTe8vqW9+/3Q0 KsSxVYaVgdkA6RSHfm+1GwKbsadYxvTBlaSU59UjdzBmFtOONbgeEFhLUFubxGK/LWWG+506Fo8 2RRPMpFhIbGzg7jP4AZv5hEf1Bv3rEoGWdG7FdKPD8AJvYQb5SebMGgIdLhq/uy7yYVS24DuW6r
 irHMox939eMRXoMsVZFCwJ0PSDm36+UhqmhXqvzygO7KB7SzH60DAwO67IEZ/9QW+tMg/OkZ
X-Proofpoint-ORIG-GUID: S_5p10dbIz7AT9uwXjACluB9rOsRXsiq
X-Authority-Analysis: v=2.4 cv=Z9jsHGRA c=1 sm=1 tr=0 ts=6893d1d5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=dTtOkBWEU8fUNE3YJ0wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01

These patches are in order to add support for restarting permission
events which is useful for HSM use cases which are backed by a daemon
to respond reliably [1].

In terms of testing, there is an additional LTP test attached which
exercises releasing queue via the new api [2]

[1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr/
[2] https://github.com/ibrahim-jirdeh/ltp/commit/ec38a798b823954f5c5f801b=
006257ff278f523b

Ibrahim Jirdeh (2):
  fanotify: create helper for clearing pending events
  fanotify: introduce restartable permission events

 fs/notify/fanotify/fanotify.c       |   4 +-
 fs/notify/fanotify/fanotify.h       |  10 ++
 fs/notify/fanotify/fanotify_user.c  | 168 +++++++++++++++++++++++++---
 fs/notify/group.c                   |   2 +
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   2 +
 include/uapi/linux/fanotify.h       |   6 +
 tools/include/uapi/linux/fanotify.h |   6 +
 8 files changed, 180 insertions(+), 19 deletions(-)

--
2.47.3

