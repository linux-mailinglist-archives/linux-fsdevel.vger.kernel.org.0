Return-Path: <linux-fsdevel+bounces-32985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF219B11C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635691C21873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690B2003B4;
	Fri, 25 Oct 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NZ3mtqkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696BD16A94A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892384; cv=none; b=p2wFvHpVLrLedWfCcE+c7VoXa2HfqNNGemV9jWXrjKBCcf5cbFQfk71YSehta9hgaXXLg5w6DmMBd9+H03rU8YTRtx/PkERCRdQwqeXWFBXwgla0e4ujESq0dWAJOm9YDok/eRPNo8OrTFTgw+dqHldQovaNLuXvYlPCzsMWmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892384; c=relaxed/simple;
	bh=xMjQVN3OHCcgU/gP77PyDFUzRZnaporHn6mzvjWY/I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqaJuH0cdqxOkBUpZmbTGZrQelcZi7kQeOqX+B2S8NTr73Xa3m6z2eVPzF/rzz89vR0qDZ61d0uhzMmn9Eok3TDiGNK+mQYP0W2GYqhixN9aqvKbv+nX1ppgr/IaOPgiu4PusqxoW1jwCXK2L2IZwP3EsXHSyFm2Tcmnajw4nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NZ3mtqkQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKXcYx001095
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 14:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Az7R1ZFVXi2bpm9LY0U/yHNjA9kS/rDJ+LRXrwbIfeo=; b=NZ3mtqkQUwwC
	PpaxegeuP5HPcII3XQURrHFC8Fnz1j/dyDlkWhyn7BN3gyZkYkh+XKdqWo32dYoJ
	ManFzjUFAaEfK4Kw1lVoTrF1N2oGmzJ5wrGERryEu6RD39ltOM/94CARo3mk0IoW
	PNQU4S0h7sOtwM0o5HWHhu7VxFQja07Ra8eXCMDbhHdvXjYrqpGxi9ZrJcvhs/e6
	YjkYWPFfQMIs9F9JlSQ4E/dNR9WR2MD+5IJLkOnizTWvevSQl2Mzftsfv5WTG7Ow
	Le9TQwJ/zPb0VmskDULQZkZpy3T2E4V4d2by48EH/wvXzpji/Kch5N88KFOYDDa5
	ngj70qCdog==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42ga1xv7xe-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 14:39:41 -0700 (PDT)
Received: from twshared13460.05.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:39:37 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 66A231476D737; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv9 1/7] block: use generic u16 for write hints
Date: Fri, 25 Oct 2024 14:36:39 -0700
Message-ID: <20241025213645.3464331-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TQwePLC0ba5DuDV2RFnCYHgftzCS2KhB
X-Proofpoint-GUID: TQwePLC0ba5DuDV2RFnCYHgftzCS2KhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

This is still backwards compatible with lifetime hints. It just doesn't
constrain the hints to that definition.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h    | 3 +--
 include/linux/blk_types.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 59e9adf815a49..bf007a4081d9b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,7 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
-#include <linux/rw_hint.h>
=20
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -156,7 +155,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
=20
-	enum rw_hint write_hint;
+	unsigned short write_hint;
 	unsigned short ioprio;
=20
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7e..6737795220e18 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,7 +10,6 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
-#include <linux/rw_hint.h>
=20
 struct bio_set;
 struct bio;
@@ -219,7 +218,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
-	enum rw_hint		bi_write_hint;
+	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
=20
--=20
2.43.5


