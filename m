Return-Path: <linux-fsdevel+bounces-56538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65088B18993
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6989C5A2364
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3523C8D6;
	Fri,  1 Aug 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FD+ChOYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C12206B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092072; cv=none; b=aRewh47SBQj+26Y63uccRcpssTMnMLSH9uxNQZIrtsX5KYVpi13xTLtkr3i7yBMHhgw6c5Ui1Pu6Wv2rcy+9rpjwnPGOWQqcysx6dZp4ec31Is+W3WgZO+6wVyS8gTRuVXKm6XZ/mssTzOFs86hZIY31lCg7tc9PX2rD/mY117w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092072; c=relaxed/simple;
	bh=yawt4GLbtfkvbaUJZ5kOUtqrePnmOrCGb6Kso3LofT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+/zDfVS4bUnJe+2RTf78+a24FpONKFYIHaQfC5+P+aO60jaY1jXWa+ZH3W6Kjcl8kSBtYwTguij536/3FniZEeGWgRP21J5NupV3Rf6uuwWx7t/P25nbGVgg0xOi7kgcBbOrgHhSJVNcnczVPpZF6hxK1lnLkK2gRpb5esysCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FD+ChOYW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoTs020635
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 16:47:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=G6dqwmMmZJ1kXj+Rc/
	2AKaMeSpGPdARz82Yt30s8+pQ=; b=FD+ChOYWqEK2YBnwRv07tSwOyB6n8eQqYY
	9Zox2wW1TdtC8sJ4BKDNjHMzybYm1PhkjQfMfH/YF8NCGhS5WxjSKyex3TnKV5Go
	7gbty3fLw4n1n2umEItsaGeEANZ5dszsFEh5KyTzZMQPISIto6ef3GjITGn0cZh6
	uhjMRxLM3iL/jNcJNPEy4j8z3qfs4iZyIMPNm6fVucHeAaHLoZV4ycBg/53CSRRN
	GWadbufG8EBo+Fb9MBn82PcqZMtu+XfGVxq8qN4WEaxGjHuYIgbJHh/YIdMUOTjv
	+yRal2IqRTw0zAYJScpWu317u8IVXATxbc1CVQNzBIlPXIvfwMoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 488rmynk9w-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 16:47:49 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9C2BA3105E8; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/7] direct-io: even more flexible io vectors
Date: Fri, 1 Aug 2025 16:47:29 -0700
Message-ID: <20250801234736.1913170-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=DptW+H/+ c=1 sm=1 tr=0 ts=688d5225 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=TzghJXyiTW9mTth-5jUA:9
X-Proofpoint-ORIG-GUID: iNO2p4qYMxmbXARr6RUAcrp0DTockejy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXwhsP7l+rew2l 2C2GHOnAfuwd9reE0JpXF5hfgxGduj8C1cNzAa88ueqpDnYn2jhPrN5DDnyyBgO7y/4R2o4P7/n k70BXFZZlvuk7oLU5lfJuVFTSiPGMFGsabge5DCOMKBfH+NxK+ZcYczOMFaW68ujaqKgUAf3SvD
 9ZoUxhx9HLXtUUQlOhodv3jz6ENbViXcY0JkgU8fVQLZQRQDOk4twv2ApqScsRQ4/So/z81+OTf amhKix++KV8TpVkoFBVlEAUL+59nYUdJAOVDV3q4vji2YEk3X3PniY7izJTKYeFBn4BBUawb8tG 3UYU8HVu8LjVTKdbpIa3applFhdwmr2HU4oLCKEzEVVZ6GrtKoezB1eMrf3hXmrGJQo3SvNwOLZ
 B2PQtJQ5kWNV592CK3Y6vekSGNCGcAHxw2DQb5bz6DHZPJkUAQjWBE0c0/toRhlIHN4bcfUo
X-Proofpoint-GUID: iNO2p4qYMxmbXARr6RUAcrp0DTockejy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

In furthering direct IO use from user space buffers without bouncing to
align to unnecessary kernel software constraints, this series removes
the requirement that io vector lengths align to the logical block size.
The downside (if want to call it that) is that mis-aligned io vectors
are caught further down the block stack rather than closer to the
syscall.

This change also removes one walking of the io vector, so that's nice
too.

Keith Busch (7):
  block: check for valid bio while splitting
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 58 +++++++++++++++++---------
 block/blk-merge.c      |  5 +++
 block/fops.c           |  4 +-
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  7 ----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 8 files changed, 49 insertions(+), 129 deletions(-)

--=20
2.47.3


