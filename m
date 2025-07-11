Return-Path: <linux-fsdevel+bounces-54581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8AB0114B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1211F3B4168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 02:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1918DB35;
	Fri, 11 Jul 2025 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hSg7DaJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3A10E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201410; cv=none; b=niGcB++QQ4l8LWXvrxeoH91PTP0QYMxKYISN5kmtsNxuJG3wIxeVqlTjKvBzjxu5z+TQ6qKzvLYGSyEswCHl6PVn+7zigcnEmoBQkYYQ+Xl4/2NuxKKNPerOYNuTFzXLIs1nnPycJiQECfUzATr8myYxvh6d7jYm2qCc0mh/NPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201410; c=relaxed/simple;
	bh=+nzuy4y+vMxDPzWlwd11rwjt4FMxsA+BZXxPqT3uAEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BEV9fNwtaO6Kfb8JGUqNVc5shk7L4H4z0OrdxxC1IxEFAKyCxWJXLkSRVJwsUpDjwF0Jm2RE47ONGyCk2/EvMZK/EwzFsIKtaVow+cliAmEotwuWT/pUcIr9QfcGZad7/aWcrh2+BhV+4h+acQh1vM1TeW+kVLJca1IIa58DIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hSg7DaJv; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ANNkpG027945
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Qy17XpUc0dHtgdRKGC
	R4QFpRQh/AY26nFuvuM4QiNXQ=; b=hSg7DaJvO96UPtveNpKGM0RxUNQo8EsIF8
	u9NRN7pNeNlboWGDwcLlBS4wm/BnoYG+FOz3J4Cmgpx39CETrm6yxqYUbTjiH972
	xoDAY1qqU+aMKiSG2vIQNBbpqSpIKgsNo/TsOJ4lvFMJ21yBsx/oRvwBtVnN0O1Y
	QBId7JgcyPIlKvOZ5TVVUsOBRyWsQZw+WN8a8nuTWyYYHRmj4mk/thRzArs20dNu
	wwrl6F9m7vYXtpdSQfxWpppbZZaVude9eZbcWkj20hqv2134B0t6Rpfti9OShVbv
	3ph3aRwpMddJgYxiwdeFz7j+2fbKkKF/omSjX7oDpFA4AI4mSg9A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47tbaqey4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 19:36:48 -0700 (PDT)
Received: from twshared11388.32.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 02:36:47 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 1EDE83200EEFD; Thu, 10 Jul 2025 19:36:34 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 0/3] fanotify: introduce response identifier
Date: Thu, 10 Jul 2025 19:36:01 -0700
Message-ID: <20250711023604.593885-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=JqfxrN4C c=1 sm=1 tr=0 ts=687078c0 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=3aefDxiWVug-mi2EcFgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAxNyBTYWx0ZWRfXzgTRxJVfOEO9 PCAaZKQzOi0rsYyPHVmmwVi7FzY7zNuRpQNDZilP+zm5zP4lKo+mGWRXnS8OYYedB4t+FD9RFKf 0TJU9SJ1qpgdsFH+Qkv65IDUNmbt+jGe2u2S9hNndGtDWGTxJouTwleCA/VsJusqSYZte3x0IUE
 A2PBuzI4QB9hKBe8YaBRG5syaSYuYW2FRf2+ZQ8FTZdTs6PC0vUzOHQuV7rTJCo+4USm8XXbXUZ LNRJUwGsa7zlV/+3Lf3DhDRY/gqEh7ak54/QZVA8UTLWiO/lNGsvIbVzXPnQAyFRaCGJZIiJ9gb o5vZfEnlCAJ9IiKuZQjMxDl4vPQZOKxV3gEJcjUc6YjVGXRSiqXkOzCZiti2sBdqt8T1pwwl5ZG
 N2L/bsTcSQEcWKddrznzjRZKBKPFiEuRz5kkrVhZ/ZVbAMM6OFRi9yKzSlAUs2NUCkoCcMFh
X-Proofpoint-ORIG-GUID: zM_ioLkACpakNCtZwHNJlnyH-G_rdauu
X-Proofpoint-GUID: zM_ioLkACpakNCtZwHNJlnyH-G_rdauu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01

These patches are in order to add an identifier other than fd which
can be used to respond to fanotify permission events. This is useful
for HSM use cases which are backed by a daemon to respond reliably
[1] and also for reporting pre-dir-content events without an event->fd [2=
]

The first few patches in the series are pulled in from Amir's work to
add support for pre-dir-content events.

In terms of testing, there are some additional LTP test cases to go with
these patches which exercise responding to events via response identifier
[3]

v2: https://lore.kernel.org/linux-fsdevel/20250710042049.3705747-1-ibrahi=
mjirdeh@meta.com/
v1: https://lore.kernel.org/linux-fsdevel/20250623193631.2780278-1-ibrahi=
mjirdeh@meta.com/

Changes v2 =3D> v3:
- Add build assertions on new id fields and use union fields interchangea=
bly


Changes v1 =3D> v2:
- Moved away from adding a unique event identifier, and instead overload
event->fd to support a response identifier for now for FAN_REPORT_FID
setting.


[1] https://lore.kernel.org/all/CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1b=
wYuvkuBsHg@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cux=
md2rinzwbq7xxfjf5z7@3nqidi3mno46/
[3] https://github.com/ibrahim-jirdeh/ltp/commit/91c963eb6758b12ce70b87ec=
060308017bf08ccb

Amir Goldstein (2):
  fanotify: add support for a variable length permission event
  fanotify: allow pre-content events with fid info

Ibrahim Jirdeh (1):
  fanotify: introduce event response identifier

 fs/notify/fanotify/fanotify.c       |  71 +++++++++++----
 fs/notify/fanotify/fanotify.h       |  30 +++++--
 fs/notify/fanotify/fanotify_user.c  | 133 +++++++++++++++++++++-------
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   2 +
 include/uapi/linux/fanotify.h       |  14 ++-
 tools/include/uapi/linux/fanotify.h |  11 ++-
 7 files changed, 203 insertions(+), 59 deletions(-)

--
2.47.1

