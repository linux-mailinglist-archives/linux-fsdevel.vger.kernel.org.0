Return-Path: <linux-fsdevel+bounces-20272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C538D0A37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB736B203A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2515FCE0;
	Mon, 27 May 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ah1uodap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4815EFC1;
	Mon, 27 May 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836290; cv=none; b=rJk2nUMDvJ4ZsEI/H1wnInSk7RkUPEcEBXKfeRJji5yC55vo2NxzsZDsWQ7Gnn9KlBQVA/+usjU54bTv11G/s4E+fytN05yMQgiHxJS3MU+kbdnHTOeUXAJ/Vd/0DwVKyLgB8UiTkzreexC1h/iR22aNxjoW4ZtU3pzTea/gjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836290; c=relaxed/simple;
	bh=gIn0lUuRRbe2pCKALahG3K0rMfkv+IQpy/QrigpWnJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=T65mp7QMILaFGQKIXj/DmlxaYucOSGZab9aJx9c8ZpFSU5DkWIuAaAabBaXyNSBYQ1oIf0dEf+qyVHaJu18I4q+4nMHgW7robRXu61wTvLkGfjPHYtUIjS2rhTMN7PPyq+W6uoY3sE/PIOzAQCidv+JUssC9NGzKuxFAatLmkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ah1uodap; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RGv0we020564;
	Mon, 27 May 2024 18:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FFXtrfysMI2d3hjlwhAsSM
	/hBbvP3EWQH+l9HSXOHWE=; b=ah1uodap/Zh/BgM1VUh6DrdYV/iodfWwlKk1x1
	LjWESyqSDSuN2W5lG1A/3FrME+xDqzpcntmfy7Dvml8Igkr1E2FFbu5Hlnhew061
	yUJLeYjkLYdMNz+O3RPyMF+W/60+2mHHJbIlJwmFIJAX3yhdXmoKOFhmRsatkyM7
	R03dpn3WA1xcLWWBA4VBqy2TNph4vHFatphaeNKOfT5R37hj0k5O5ZWqUK0DN+6F
	K6X2Sk7p/4xd8ejYZ5AmD9rjlch15Z7T7X0espdA5F0KkmNr5l2MyWhqf5ePQOpe
	Q3z7Tp7BHNBA6nBzV9asP7O/9ZsrOgSaVeZBsJrVDvQV1L7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2mvdv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:57:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RIvsRF025081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:57:54 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 11:57:54 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 11:57:52 -0700
Subject: [PATCH] fs: binfmt: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-binfmt-v1-1-f9dc1745cb67@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK/XVGYC/x3MwQrCMAyA4VcZORuo1U3xVcRD2qYuYKskUwZj7
 26343f4/wWMVdjg1i2g/BOTd204HjqII9Uno6Rm8M6fXe8vWBJmwyA1lwldPvV5uA4UXYKWfJS
 zzPvu/mgOZIxBqcZxm7ykfmcsZBMrrOsfvICkLX0AAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman
	<ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qVMRl-f1rnCrPvwlMG0VXA3neKuokYOX
X-Proofpoint-ORIG-GUID: qVMRl-f1rnCrPvwlMG0VXA3neKuokYOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=842 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270156

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_misc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_script.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/binfmt_misc.c   | 1 +
 fs/binfmt_script.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 68fa225f89e5..6a3a16f91051 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -1086,4 +1086,5 @@ static void __exit exit_misc_binfmt(void)
 
 core_initcall(init_misc_binfmt);
 module_exit(exit_misc_binfmt);
+MODULE_DESCRIPTION("Kernel support for miscellaneous binaries");
 MODULE_LICENSE("GPL");
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 1b6625e95958..637daf6e4d45 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -155,4 +155,5 @@ static void __exit exit_script_binfmt(void)
 
 core_initcall(init_script_binfmt);
 module_exit(exit_script_binfmt);
+MODULE_DESCRIPTION("Kernel support for scripts starting with #!");
 MODULE_LICENSE("GPL");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-binfmt-0f35f686ac0d


