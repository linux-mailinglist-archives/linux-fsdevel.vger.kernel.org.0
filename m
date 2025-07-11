Return-Path: <linux-fsdevel+bounces-54688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D10B023AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C209D5C39A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E72F2C7E;
	Fri, 11 Jul 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KtaS/xRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF191ADC7E
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258720; cv=none; b=jJqQrsqfaby/+UzQ16Wj/ZUNJ1jcYANx+sNVFFlKq+PAVxoza/N19oNR9dBO+LxXvio3r1X+ouvOX7p4dauXTjxrqiv7uW+J6Z5fQvimFxWyPnpBouH4fRuloffq0/2j5QCCKyQ7KgCjS/EqGJPQOKLoA+2xADs0TGJnmxHM8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258720; c=relaxed/simple;
	bh=RfGu5AlSmK/f+bABSNcDoOWuGhadeiuU59uxMb7LltA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NOsNbsQy6fMO/VPIUZt/WzNRqsQa24oTZj4IwoMnPRz+4ew5hhCXUlqOHqPuskViw0OnmXBS0yiCQRmknH2djgd51jPzmJ2jQ4+glT9Us/Uy5CmHrmvwOpT7dyYr/kX9xQ9UxjjiXbomkNTAqc+Ij94FpdhsZyNY4O72pyOXTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KtaS/xRG; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHWAR3001261
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=D/IR9lwxYUcmQ7GbLv
	t1Jj21hj0GjPVOABnGCCKLRKM=; b=KtaS/xRG6pPD8vY4Dvw//gsp31NhPJyoHW
	x2J9Lhj6v2mD0hN2ktwBkS7A1DSxPBqgmu6aMx1uYQbGvTz2EIs4vsmjVmCBbau1
	18IRnxsFhaxOm5+Emzj59qReXv8Oyfd2MNyzXguFkG5TbvTcZzYWKI4Wfd+7BEu4
	pc6H0o1pKhass43JAlaA1ZkQFOAEOTO5GfrGQr+0wjHpwDmmlXmXTkfVN8SuWHzE
	atlDWq5lSY658iUbBR3eVH/WYyOgI4cfe+m/A6nm+pqzgMecdSa1A3Fm6EBlsK6L
	ljZDA8epev5FjDXQ1L90SO0QjVe614kNcIMHAFdVWkUDBirdNz4g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47u16du61n-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:31:57 -0700 (PDT)
Received: from twshared21725.48.prn1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 18:31:54 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id AA02D3210B687; Fri, 11 Jul 2025 11:31:41 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v4 0/3] fanotify: introduce response identifier
Date: Fri, 11 Jul 2025 11:30:58 -0700
Message-ID: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
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
X-Proofpoint-GUID: I0-6T-AZLyPKXHujkU224vx9fNIqwV9X
X-Authority-Analysis: v=2.4 cv=OLMn3TaB c=1 sm=1 tr=0 ts=6871589d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=cGpj8UEGDxW2moZ7_C4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzNyBTYWx0ZWRfX0MUxD2NHqc/M JE70o3x/3UEvkis2KWRAEQSviIiQXtbE7MqdNj6tEP/8MivCjgFPz3ggRW/h6g4XCZ1Q7g906f9 n2KRFoCZMm6zzjEDW50LFneryewJf5aTxd6IU6BYGyhxW7C8ylTIKjch91DpicxYnD9lTddxJA/
 lmFxqoP3CZhMH+y2uPocKwtUN6DCWhaRKEJL8IVk26RJC34fthoGaKwuTMjIwmT5Qkga4IdpwdT 0ljSgu0G9o55Yh5wfJbLQx7JIeEIt/7g+I4QnSi2Nvd0+vnOQhCWn2inpOQ5YgH0xsqjZrcHyhD 9hCdaMl2fmGaxOlzTzj97ej44qlgj99hQI0JWSvVlypRMbls9lL3JZUB3Si31vpxTJnWg9Xi1Et
 q4V2AJYjnRUmODOH0PCpiZ7vdzxaDElafqPlwtt1ut5opZQzNVoUFTOQzkSszePSVTIBWm9u
X-Proofpoint-ORIG-GUID: I0-6T-AZLyPKXHujkU224vx9fNIqwV9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01

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

v3: https://lore.kernel.org/linux-fsdevel/20250711023604.593885-1-ibrahim=
jirdeh@meta.com/
v2: https://lore.kernel.org/linux-fsdevel/20250710042049.3705747-1-ibrahi=
mjirdeh@meta.com/
v1: https://lore.kernel.org/linux-fsdevel/20250623193631.2780278-1-ibrahi=
mjirdeh@meta.com/

Changes v3 =3D> v4:
- Use ida instead of idr for response id allocation


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

 fs/notify/fanotify/fanotify.c       |  72 +++++++++++----
 fs/notify/fanotify/fanotify.h       |  30 +++++--
 fs/notify/fanotify/fanotify_user.c  | 133 +++++++++++++++++++++-------
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   2 +
 include/uapi/linux/fanotify.h       |  14 ++-
 tools/include/uapi/linux/fanotify.h |  11 ++-
 7 files changed, 204 insertions(+), 59 deletions(-)

--
2.47.1

