Return-Path: <linux-fsdevel+bounces-56325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DDB15F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25C87AFB53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD36285CB0;
	Wed, 30 Jul 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfhYQeLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B778F4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875315; cv=none; b=YnBkgPB6KI2R+8D8t76DCyvFKGR5H9NQoJpaLaLYdYBkx0XdvmwPcor0tvxIFJ5qpvJdvppITwk/B7mgVpZLrpfK4LYEl5x9Np/2E6NqtZFIZds0Ss+UT9nYt9npDbyJc0g/0EXJIFoONFgEVSmnObIhkQk5KILQYYgW6xxtCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875315; c=relaxed/simple;
	bh=cS3jzH5qD+TtuznAs0NDToiNIM9fmacWZBMDom9qNmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uh8U7lvBYhNY0ULhHcvb/UP8i7zUwEFVm8n0/HYZxCR+frQN+wKe7AgZUb4oWBPgamFjUbr/XwJ8lbuj7hdX7SoiltFLXpJ255Du8VyKpFJb7jIMC1Ea8BxboetCNFU2rHeWYM395JLMLPWhPHpO9kEtnLj+ycYKdgLQcO5mL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfhYQeLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U72s16017659
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 11:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BhCKTD8r+PtEiCiOXNxswbUmBHQNdQ6OsmN
	mzxRSaec=; b=hfhYQeLAjdvpelqJbPDopViDbil4yS3ew278zWna8mHW849q8Co
	heEhRK2hkJ7DFS/TAZnH4jTsAmufVP8GJC2WVNGwW3F4UCxkoPqXHlHGKBaNoahp
	Ek5GTUO9alBX1gkUfl1H8wDOeAfNE4B+ZTwkKkiauxcT7uU7ZjhUkScXrkWSA2T1
	IzQgM449PPm1iMay7ZozZz1XEYnzFumm35sjuB9os8W9bl8cnZS6HpCdMCiAzQUp
	rwn/50M4gkuCYlvyLatOM9sdU082WZ+Ns4t5Y0ZCtH8z5g8cHiP26dKQ5BYxKvY+
	ZJNvdkIiLDyan+cnEYP39QJRlkjHVDEXkhA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1akge5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 11:34:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7074f138855so12799786d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 04:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875252; x=1754480052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhCKTD8r+PtEiCiOXNxswbUmBHQNdQ6OsmNmzxRSaec=;
        b=pbnpFZyxpM8rDiXvegcF6CrH3sB2glVcgZDaOO7O9OKTGdlpy4J+3VP0MuelcA1m2N
         zMu/3sNewvMjvdWH24mVKlRIp+fdWx98T8ih9dkpVHuoAwEtMAZBcPJXNk6Mc1Fw1a3V
         xi7HwBint+SbjC60IutWgO54smIKQ0IFbVMNTKvoiAleNC+1J8nCTe9AiuDNxMZ85ddV
         FJdnRwmY7ZK/JSxMDrS3YuzIzGfaL8/LMxbi7RmM159NjmkamVSSp5OM0fkvhju1xPS8
         XFS9zbZ44mC2NktSmWByyVE2oIQ5UZ70nEzaZVBfFQj24P8yr8Si4S4fekqBpIEEl5I8
         nM8A==
X-Gm-Message-State: AOJu0YzTnWmpxlFHTF7s7FPHpst1o/3TuLX5KKoKFTYX85XN4poKc/2t
	hbtxIbdQJwnzbV28ov/5jHwOb0NwsclCa6o7TSdvVVfuSgb7d5JztT0J2SSFNdwEy5IxkFEoty5
	/IavdqIfMC2LS+46/p3iKupn3Wrfahk1g/vPBpbsWqt32ej52CJLSHz32fTO5oKLebbTm
X-Gm-Gg: ASbGnctZeLCzP7zX4jQHZUow+VFyACYLHkQ9kFdMQjIjIiArjw7SlHIHWib1tGOOJnI
	IzVA23/ZTeHoT8En3ZtmoaChrXc8HInc7jZulrxuMcBjJUbUST9qWCIlS7tJsQcoXNwkED9/b4/
	57qg2sufwrCnl8efq4bT7z+xJSOpyZrc/kMg4lC8I3oa3o+64MxmdGh+sR0PcT5HBW9jzRgNWDn
	zEpG8wJE0etgR+Yxg4MapS8+fOaPurFu+RpSViKXBEXdPxV7ehdIUmwciHly9Tdk75MBVKrX6lk
	HK9Wfs3m6KzCCCnnTqRRWe6EjoJQwOAxxz9WAnkGjYyYFAAugOq+o0c7Ara5
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr42274036d6.18.1753875252414;
        Wed, 30 Jul 2025 04:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGexGDGuxaehZW2/cifgkeDlHP40UB5yPKGc7P/QMgOHs9eSLCivNSPwq4Mlwv+4EQiv5YxTg==
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr42273556d6.18.1753875252021;
        Wed, 30 Jul 2025 04:34:12 -0700 (PDT)
Received: from work.. ([117.193.215.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951745asm64937751cf.6.2025.07.30.04.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:34:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] idr: Fix the kernel-doc for idr_is_empty()
Date: Wed, 30 Jul 2025 17:04:02 +0530
Message-ID: <20250730113402.11733-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xr5CK1ILt_0iXPfl1yFwk7BEHfAmWrt9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MiBTYWx0ZWRfX4uKHRVpSSHP0
 hINXbCHVREVGvWBKqvuHwI3fW/umEWOa4klv8NTZSpCfJa2nf0IydTg+MuAbhnNQnpHGWft/VQl
 0og7Tk4+C0OCs8MhfP/Vejihspr5wa+uM62CXFA/oBvjHSblQLZtNsQfm+5hzZHm7iNttPxMuhw
 43mExTA7+WPt4/I0KWA/XGvBk/sKQnHpUMKD/A2kXo1nJ+MwN9M2RAouGK2lLBUD/qkbjTYNMG7
 4f05wAO1QmZDNqVgzOsgC+E8VUHeY2/FxH176RjCCJm3yvrn+3/oBJ/oMetl/HiY9GF0gMyBkY+
 EFGvlnzcCYd/plosjtUDpuQFAcj4G9H110bxPNSIXetalInHX4Z/rBdZ1ijsm2cpwLwA9nGu7FM
 QgGSp/prc5zBWOYJ7MNhice9FxuZ/QA85GS3G1DLKAUgdaRds7lT6Bfww93bLhsTFkRY9LwD
X-Proofpoint-GUID: xr5CK1ILt_0iXPfl1yFwk7BEHfAmWrt9
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688a0335 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=+urnqZw5vKot7juVQre6pw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-2WPVV21f4NiumMF_pwA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300082

idr_is_empty() will return 'true' if IDR is empty and 'false' if any IDs
have been allocated from it. But the kernel-doc says the opposite. Hence,
fix it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Btw, I'm not sure if we really need the radix_tree_tagged() check in this
function. It looks redundant to me. But since I'm not too sure about it, I left
it as it is.

 include/linux/idr.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 2267902d29a7..4955cf89e9c7 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -172,7 +172,9 @@ static inline void idr_init(struct idr *idr)
  * idr_is_empty() - Are there any IDs allocated?
  * @idr: IDR handle.
  *
- * Return: %true if any IDs have been allocated from this IDR.
+ * Return:
+ * * %true if this IDR is empty, or
+ * * %false if any IDs have been allocated from this IDR.
  */
 static inline bool idr_is_empty(const struct idr *idr)
 {
-- 
2.45.2


