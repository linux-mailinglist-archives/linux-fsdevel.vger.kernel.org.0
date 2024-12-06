Return-Path: <linux-fsdevel+bounces-36591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B39E63B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E379316AC8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCA145A16;
	Fri,  6 Dec 2024 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Col3DdPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6538282FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450008; cv=none; b=FBLHBuNZNL9iS2AcJndAK6gz7KeG57g0Ix+fHRLxuaA05FrSvsegskXQTjs5sLV8CDPtNmTHhNDTaKgIRMTDHwCItiFOEJYdjYrQ3ZYGFvl+7hT8m44gp3jY+YvQxCL9DETCpDFm6lXaAFrBTJnqZNT+I6lIuxUGPAqM5d49FZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450008; c=relaxed/simple;
	bh=eOuO4i4yPLsc2Im8KihmSljRQ8rTc0TOPgnR2AUqOdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDQkFp+qGgf1KFv/y90SJz/DCwrfiqLmL0xG6h+u4789+B7P3/EqOgoRM20kwg2S1qoagLq0Tp18hQixT0zgKUIXTvNdIF56LHvWwhmQpK9V5zVktZieQahvm4sGo97iniOSEAHfcvB/ZtDihTs14i8tbrc9Y1XbtBgYD65GlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Col3DdPn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B603K9C013801
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=qzN9V22hHNPCY40Lp/Ysqsn5kxkAoYivYUU6jILwvog=; b=Col3DdPn1sBb
	UqgHsnitvyXO3BGkHudQfzF4pfElsNHcdLrxtn6ywSy+EcMHbTXj+e4BbTMTDEye
	L3nM1cqqG7MNXiYbF8Ht0fa8/Vaxes9TWSFIhMCMQlb1gQ4vTYQg0x18e2kSmg+C
	RrhPKFIKooviP/kEWaOD5xBipM7b9LUy8xPb+d1fd9mOEH0wsThNWc2AU1/EJY7k
	x2Zylv5T3+IZNWf44G4RNHwLR72A4u+/ZgIxbnaJ4HFgV+5R39nGigGUhUC9fSC/
	CWtp5h/Abe29e706d5qHBEb1L5cZp3mH+NwXYyclxYByigd9qCE/u2vY0nogEH9g
	LCCNqHXJzg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bnx9rpvh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:25 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id CBF2215B21149; Thu,  5 Dec 2024 17:53:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 01/10] fs: add a write stream field to the kiocb
Date: Thu, 5 Dec 2024 17:52:59 -0800
Message-ID: <20241206015308.3342386-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KkBNJG4vUeXHypa7ML3vvUd1C_71qjB8
X-Proofpoint-GUID: KkBNJG4vUeXHypa7ML3vvUd1C_71qjB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Christoph Hellwig <hch@lst.de>

Prepare for io_uring passthrough of write streams. The write stream
field in the kiocb structure fits into an existing 2-byte hole, so its
size is not changed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2cc3d45da7b01..26940c451f319 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -373,6 +373,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u8			ki_write_stream;
 	union {
 		/*
 		 * Only used for async buffered reads, where it denotes the
--=20
2.43.5


