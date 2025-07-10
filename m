Return-Path: <linux-fsdevel+bounces-54416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F0AFF7E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A321C4438F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C9283FE4;
	Thu, 10 Jul 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PeYbfBL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA05280A3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121272; cv=none; b=t2z4+Jl4YOBB/nzKQwJvBN3kMQPZRHajQj8pbhJdvtnR12BshfjE+zlySbfBHK3IDULgMgGkn550vfyeUfFWR7YhuaBM+6O4RMxdF/hDVe4sgjGH936Dt5PGP+sV1fptu8KyNf5yJqpnfNeGUS2KL7P0QwnZvyjAhlyHpaM1wGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121272; c=relaxed/simple;
	bh=LMHxhBmoaZQ/c+yevPK1I6iZH/F7VZcV6QKJEgKjpGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BsFkYUv/YvPXT/cjZirtHWeJeSc+G1im66/b86KrpOl7vL2TcVL4i9rtcw/iFJ4865aZcPU9groPhsXXn6ftEE+zc+BNuFgHExRDHm8gpiDEV6ZFJz/M4QpYwd8WxUFR9HSPzZZh55/7V9BIEOttx80r+jmEERvm/eybCnURGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PeYbfBL5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0o93G000616
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 21:21:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=RaOBH78yCW9De2wZ43
	+NGMOmY+Rr7VK2fvpWOcGXYi8=; b=PeYbfBL5ACpmF+Vd4cRt2Q3vztSnlFM7t0
	wsv40hnuXXrgjevbMwSYYXWXlh7KKrC/n3ttac8cn+Q+fZOFsEMI02qILeoV4La0
	FZUBZTjHxjUCHLF6l3afo0yIordTCLPfFN3d30FCl+ilq0xYgX/txsTI0CHkMVt8
	MymAAAVDfj6rD1you+C1H9xByWyYwWz3pF/q6/PbWo6QRSK2TaSFdtdt2dKT6Isa
	Zp5sBDhS5PENFbc5PmocSIYcLXpY3qdPgq56Wu4L0YKrzggNVjny/nfhtUneK1U5
	m7TlIkohouF3tfibu9yRCmfHyGF5sWyIREzlVupWac/oRblzqKaQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47swg8uc1p-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 21:21:09 -0700 (PDT)
Received: from twshared6134.33.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 10 Jul 2025 04:21:06 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id B58FB31E90F01; Wed,  9 Jul 2025 21:20:52 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v2 0/3] fanotify: introduce response identifier
Date: Wed, 9 Jul 2025 21:20:46 -0700
Message-ID: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
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
X-Proofpoint-GUID: OAsIB6gWEPbAlwSdb_FJmGfq98usHTSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzNCBTYWx0ZWRfXwE5FenqwEv/4 8G7EX+ssMWs+xcTuXjf9arMIXhlsKfwZnDelxlqNgUYqp9DcDTZ9OcriJP8+ZS08o+sL/zjuGzE Aa7YPkCheBO87+QvcDJGEA2cqaehLXgl3kOxbfNxNJotIkpAn6qgmp1fdRFYKcNVkqz9ZSO+c8L
 ez6bUCfadteI68/dG5AGWiU+fqdmewdftItb7G+ZQRSM4s31i1WHsKuUjC2Q+4ncD6NEsGdEQV7 sqyDyp1ZSyqFtmKW5WeDdudFpB6wBkVw49UvfqcQ2kNyB1pQhwwyV0oGifcYXQoU9MUj4IkPk9i YqKYDF+qV0MO23IhzvGiSBgMO2yS9lS9lj6+mG804VVGl+iNyRkp/9SXJeOfIZ6LdURLxd1gO0z
 +VKAexjouyaJeTGNjf/8QPdIugzYXequ7ttkPxgo0hNOuUzzSTgsrxGWJoY6afFokjPS+jDi
X-Authority-Analysis: v=2.4 cv=bddrUPPB c=1 sm=1 tr=0 ts=686f3fb5 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=3aefDxiWVug-mi2EcFgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: OAsIB6gWEPbAlwSdb_FJmGfq98usHTSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

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

Changes v1 =3D> v2:

Moved away from adding a unique event identifier, and instead overload
event->fd to support a response identifier for now for FAN_REPORT_FID
setting.

v1: https://lore.kernel.org/linux-fsdevel/20250623193631.2780278-1-ibrahi=
mjirdeh@meta.com/

[1] https://lore.kernel.org/all/CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1b=
wYuvkuBsHg@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cux=
md2rinzwbq7xxfjf5z7@3nqidi3mno46/
[3] https://github.com/ibrahim-jirdeh/ltp/commit/4cdb1ac3b22be7b332cc18ff=
193686f2be7ea69d

Amir Goldstein (2):
  fanotify: add support for a variable length permission event
  fanotify: allow pre-content events with fid info

Ibrahim Jirdeh (1):
  fanotify: introduce event response identifier

 fs/notify/fanotify/fanotify.c       |  81 ++++++++---
 fs/notify/fanotify/fanotify.h       |  26 +++-
 fs/notify/fanotify/fanotify_user.c  | 201 +++++++++++++++++++---------
 include/linux/fanotify.h            |   3 +-
 include/linux/fsnotify_backend.h    |   2 +
 include/uapi/linux/fanotify.h       |  15 ++-
 tools/include/uapi/linux/fanotify.h |  15 ++-
 7 files changed, 249 insertions(+), 94 deletions(-)

--
2.47.1

