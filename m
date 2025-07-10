Return-Path: <linux-fsdevel+bounces-54420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D145AFF7F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98B31C47C45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1D2820B7;
	Thu, 10 Jul 2025 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kb5tv91w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5F28002B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121341; cv=none; b=gGvcS3zqGGMSrSI32IxTNFIHKPhexG3zlndlJ8Uap+kI48c0QXq241+rraFh+3UPjCPO5rKTV7iFocqYotvD3SYFVYddwJYqHWO/0XBD0daTveFLfQ/HnfL6iM535IEzdvYsoNF1d6jvaS9/5IWvXjZ1PO2RJFS3srutjNeKCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121341; c=relaxed/simple;
	bh=LMHxhBmoaZQ/c+yevPK1I6iZH/F7VZcV6QKJEgKjpGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kavyldYdPjhuGWf5aSCjGTixpkxaTH+HpZnB5bMCdYs1CvMghkU+h3bXEIFk8EzNZGQripaun8PCHq9Cwd6Gmeur/R1c/AHnDZE5acEBs+EiBqf3IomI31jLZOn3kWRCa8165X/6LmONyn3J7jhsUwWcxKcQLs5gQEXKFkdrp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kb5tv91w; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0oKVD005491
	for <linux-fsdevel@vger.kernel.org>; Wed, 9 Jul 2025 21:22:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=RaOBH78yCW9De2wZ43
	+NGMOmY+Rr7VK2fvpWOcGXYi8=; b=kb5tv91wNy7+Vut0H9TkFF5HTWQFJofTM8
	kdIl1hvjbH0XFUsJGqPNuOQUdsOhPgk4R0GJiIkce7qxoy83txfw8nPBb0Cm7LpQ
	eaiombzbq6txvWuYBDmYYHrsyllSIf4JWTaazJU5Qzau2ApJ4aoWQObYasquKWVM
	U1GZxDKfri1cC0OvY/NCtNHYf/WXPR7v8xBZAnRpuC+AgEVNgK05k+GgZj8f4fjo
	H0HFxuYYZ/JGZjxpk68ZXWSylpGoxEJT4Gt/t6KQUyZI+Mro+2v33bUYKHn8Qn/f
	oDoKprFXSyPiEbAdaoGRW2BqEwXM+HcsW1h67DJxNam9aPlqAjig==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47t16dsjp5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 21:22:17 -0700 (PDT)
Received: from twshared26876.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 10 Jul 2025 04:22:16 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 3819B31E90A60; Wed,  9 Jul 2025 21:19:04 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <=amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v2 0/3] fanotify: introduce response identifier
Date: Wed, 9 Jul 2025 21:18:32 -0700
Message-ID: <20250710041835.3692987-1-ibrahimjirdeh@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzNCBTYWx0ZWRfX2v9ZxBRkdaA2 iNgvSF/Ck4ewt7AEQNWQey0k1XAnzodFgYIwXJCMA5QpWvJLCWHmyuuywpOwQI6gDO6x14wpCzu 1e7Zoyk4ffxbQWSV054WkyZifoR60f937K9HmHMbhWrZyE8nB5mwlQnnvqaE/m35CHOD1nfiqSZ
 D5HVisraKxWhw6gJKRtQ8eTFEZNmcQ1hZw3M7qWFTeOA7S0V7dQn8nL0/l87FR7dg8mSDnMxrNd czgGrFpdIaV/XZ40v0+CksYWtlTzASG9WlNZNvAfbLGYFfM7MGtBEF5gYYWwu3S+0OYxl29zs0i zoSNR2U/JF+1ectM3vNPOMph9SGA1b//r6lfiNiAw0Qxea8afuuFXweXCaZHkHvS0jrnFJu7WJj
 1n215Jl1DXFM/vAV9xwKDLMYIGKEXCII4Xjl1Hwvpqc4dS5oE4JkFE2X7YPs2C68XbH1st+6
X-Proofpoint-GUID: deEYkRDrdV0Ci2ocOhdRMwqD4lzHDE4B
X-Proofpoint-ORIG-GUID: deEYkRDrdV0Ci2ocOhdRMwqD4lzHDE4B
X-Authority-Analysis: v=2.4 cv=GIMIEvNK c=1 sm=1 tr=0 ts=686f3ffa cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=3aefDxiWVug-mi2EcFgA:9
 a=gKebqoRLp9LExxC7YDUY:22
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

