Return-Path: <linux-fsdevel+bounces-20128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29538CEA0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 20:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91B11F23A57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86194085D;
	Fri, 24 May 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TE37dC61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999D94642B;
	Fri, 24 May 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576503; cv=none; b=bkaYXcXlxWCiW4HMGuexkRVuyKWxHLhTlso6mKCQtN4KI/jajn4zrq5+rUby1riVi5rdN7c5z3loGkNBZL+DYqnLvSmtnOM5RkL3ndZrctCGxxSS1oYqtBhJOdZONJUwTIfNkaNCJjFopH7IvvGdOfinw6IZWRP6g1chkLZ9sQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576503; c=relaxed/simple;
	bh=SnDU0pGVxgci1LL9UROqqRYtN2WSgpN4SI/1K7x4WQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=B+vyMhcnmU38S+PgFT055JF13X6kr+6pDBKc7K6VQ2lBQBmh0M+4czMEcvtvSReiGZFDFhd27RuxaiQrVEV/jXpT0icYLcQRudl3MxxcdUBQm8DRBXGJj8pglOCe6wdFlvcBkpR5d2aO5zyLO1noUFPiUtFJ9bSj4e1B1ICFvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TE37dC61; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9LdCx026374;
	Fri, 24 May 2024 18:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8l2Emop1qAQF+HZ7Y2wdL0
	/32jzzi597XdPe0758sgw=; b=TE37dC61a0OQl+x/Q8pCm66ZnN1Lmd2VE8fuAF
	4sAlDUUfXZDktwsDfcgVBWmNGWCrlCdCG4m2WlYXO87lmpPaoxCeT2zBnevRQY6x
	KxtGt8tBufszx9q0chh3nmFvMmE4M0dzVI1Q8Wbf5Grn9EMBK/s2iup547eNZXBS
	c0Xw/j6Tzm82Zv2XxqSTMycIUEmAZHfgDiOD6MEfGy/l0ZczMxiySUzp2Au/jTLQ
	tnuU90/3hRdan4PShA4oG9fl2KE3EF+ifEHio3LlWKOjhq1BWA4t0dhcLXNEBQH+
	Z7YoMNQ8lQskLgz/AAD85Gv8vgmQwtsEh22Q1umMwG5MoBrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa97baue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 18:48:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OImGkw031129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 18:48:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 11:48:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 11:48:09 -0700
Subject: [PATCH] unicode: add MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-unicode-v1-1-e2727ce8574d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOjgUGYC/x3MywrCQAyF4VcpWRuo4wxaX0VczCW1AZuWiZVK6
 bsbXX5wzr+BUmVSuDYbVHqz8iSG46GBPER5EHIxg2udb4PzOBZchPNUCP3lFM59Crl0HdhhrtT
 z+o/d7uYUlTDVKHn4JZ4sy4pj1BdVnD82hX3/Ak+N3/aBAAAA
To: Gabriel Krisman Bertazi <krisman@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BdLzRcCcrN_PB4PsLOagSb4ZYdw6TYs2
X-Proofpoint-GUID: BdLzRcCcrN_PB4PsLOagSb4ZYdw6TYs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_06,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 clxscore=1011 spamscore=0 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240133

Currently 'make W=1' reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o

Add a MODULE_DESCRIPTION() to utf8-selftest.c and utf8data.c_shipped,
and update mkutf8data.c to add a MODULE_DESCRIPTION() to any future
generated utf8data file.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Note that I verified that REGENERATE_UTF8DATA creates a file with
the correct MODULE_DESCRIPTION(), but that file has significantly
different contents than utf8data.c_shipped using the current:
https://www.unicode.org/Public/UNIDATA/UCD.zip
---
 fs/unicode/mkutf8data.c       | 1 +
 fs/unicode/utf8-selftest.c    | 1 +
 fs/unicode/utf8data.c_shipped | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5c8d..77b685db8275 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -3352,6 +3352,7 @@ static void write_file(void)
 	fprintf(file, "};\n");
 	fprintf(file, "EXPORT_SYMBOL_GPL(utf8_data_table);");
 	fprintf(file, "\n");
+	fprintf(file, "MODULE_DESCRIPTION(\"UTF8 data table\");\n");
 	fprintf(file, "MODULE_LICENSE(\"GPL v2\");\n");
 	fclose(file);
 }
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index eb2bbdd688d7..f955dfcaba8c 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -307,4 +307,5 @@ module_init(init_test_ucd);
 module_exit(exit_test_ucd);
 
 MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
+MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
 MODULE_LICENSE("GPL");
diff --git a/fs/unicode/utf8data.c_shipped b/fs/unicode/utf8data.c_shipped
index d9b62901aa96..dafa5fed761d 100644
--- a/fs/unicode/utf8data.c_shipped
+++ b/fs/unicode/utf8data.c_shipped
@@ -4120,4 +4120,5 @@ struct utf8data_table utf8_data_table = {
 	.utf8data = utf8data,
 };
 EXPORT_SYMBOL_GPL(utf8_data_table);
+MODULE_DESCRIPTION("UTF8 data table");
 MODULE_LICENSE("GPL v2");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-unicode-48357fb5cd99


