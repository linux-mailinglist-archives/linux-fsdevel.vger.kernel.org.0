Return-Path: <linux-fsdevel+bounces-33129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7479B4DA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF38F1C2233D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFD193416;
	Tue, 29 Oct 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NI3Pdccr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBC18C936
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215333; cv=none; b=VALEbd2HbFugLGQc/OuMEnHKeKpD5LqVMjWp5RrEmA7XMpT5ObmWwChFK/Zrl9Lwba2DA4W9ZcEItWLlXkBKN+vr+Uj1dTJ9oNv05yXU+GdqSvODRTP91OTt9QoDOXw98J+rUUCMcNyHO5WU3liG91ca45S3yevByp5Nz4IpPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215333; c=relaxed/simple;
	bh=lTngeVgYMu8iRvvavbDcw/84hBpD6tPbdXy11QgC3/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzzI5nAzslxfrOT3TgcKLpFIF26jAYWfMIRm6TuMpz6p/rO+ZgYLPKiV0/G2OjgnImLXKDfJNQZtpF3UO08Kfd51OWpU/0271ZlqX5Zi0KHF07DenVKyrLYRLcOAVeuRxXa/5+Do4jhXZAfMSdYtzAsnGUZfjfvzJ99bOvn9MSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NI3Pdccr; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T72saQ018940
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:22:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=lpkw70ScsQg5oJhrDT3X/i9ncqvY2EB0/2EmfsOYbl0=; b=NI3Pdccrpn9s
	1KZ0FlPkPtyF6fvqqHi9EgyUKaFA/nqfW5x968ow82SiwbIF9969BnCCVrau2nK6
	XZYtgqbOPrTN90pI9k75IN5Yei8alA2JoKnOAXpjKPQDU2xuuvg+iJ6jHdE9rvv8
	e/PiHhXTtYFu1mamJfWKLQkWaaaDc4Trepge9GFgs8XlOzGGo+iPZLU1F5ujndHB
	BAFKif/TIPJgI+HGekz0415+pDngH6ux9B/esMXWJxWNkKtuyRWK3lg0AmyF1cId
	XYJ/M9LbFVRNUk7Q/MBPK9FmfSrUJXEDTrX7W0QYOAJT9wVdCtVFTD9nYpdhI3kO
	bNve1sBzPw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jtygtuba-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:22:11 -0700 (PDT)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:22:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4346D14920EAF; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Date: Tue, 29 Oct 2024 08:19:22 -0700
Message-ID: <20241029151922.459139-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CgfoIh-kUdhslcZ6h7nbABPW3Em3mS2Q
X-Proofpoint-ORIG-GUID: CgfoIh-kUdhslcZ6h7nbABPW3Em3mS2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

The block limits exports the number of write hints, so set this limit if
the device reports support for the lifetime hints. Not only does this
inform the user of which hints are possible, it also allows scsi devices
supporting the feature to utilize the full range through raw block
device direct-io.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76adc..235dd6e5b6688 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3768,6 +3768,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_config_protection(sdkp, &lim);
 	}
=20
+	lim.max_write_hints =3D sdkp->permanent_stream_count;
+
 	/*
 	 * We now have all cache related info, determine how we deal
 	 * with flush requests.
--=20
2.43.5


