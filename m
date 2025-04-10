Return-Path: <linux-fsdevel+bounces-46200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D4A8422B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931A11B866EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C828EA66;
	Thu, 10 Apr 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IBX6NJ3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F028CF7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286004; cv=none; b=S/nzYWOHSgAzR49retqqZe3Y+4a/VWzWHx89WTL2X7ljFjG4LApikAZIvnlcbYzLgNjZXPBeIWU+aI63ebV673nzprzqwiR+S4YfUX9MR4p33KNuY2jdYKdBoD5NkT0VIj7siT85efFJSaFzQuvpbXUSMjulCcCorCkVfvpk6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286004; c=relaxed/simple;
	bh=xb4Djkq2XeMUN0/diW1Ny4gAAC+RdsV3KZBjNbiBEdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cbODSz57Edv1UA/2hpojS0r06Tv/JXzyuXh50mV26s4z6FJ/ZWLRcor6FzDr40faBadWBFS5Or3a4XBOhb8DOMds6474Xs8yysLi8yWNVlG66xOLv9Lv2O9hPMDi3Ff6aMYgEJDgAeAIDt58yr8iByKgHDdbFNQofV/ZK5ujHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IBX6NJ3B; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=9CNRZFMb+ZGZSnN0e7O2pQJfHsHDLKAcSkkbVrvrqsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=IBX6NJ3BmU4yOtxmKur4FfF87pPiiGgFcw1UW9sndFBPQm+8TLTZK8eRnYWIgBYtC
	 /lOrOUbX+9uA4pYe4Re+VlkFPhQtbyuxw2XXhpOjETOdFf3H5OlNP2vgEH1a9rjblA
	 2fBrTcmzBwC7RaJ0GYIxHDdFR0XHx8mClg/rR8Ex4615pUlZiemR6m9P4z+2khENml
	 iqLZDvY7B/AY+Jq16DJ31pmFeg33dqvq7jHDSzZOm2HdP7QYafxKgwA23zSeDBE3rw
	 X0ROEHZxOU2PttDJcBpREtu7xAqG7RZU/0rQccmN7Y04dBv8ASiWb7le9Rl5jRX35n
	 /M7Jq9L8MoT4Q==
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPS id E70E53118A42;
	Thu, 10 Apr 2025 11:53:19 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 78A433118934;
	Thu, 10 Apr 2025 11:53:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:53:03 +0800
Subject: [PATCH RFC] fs/fs_context: Use KERN_INFO for
 infof()|info_plog()|infofc()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-rfc_fix_fs-v1-1-406e13b3608e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB6x92cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3aK05Pi0zIr4tGLd5LREYzNLS2ODxKRUJaCGgqJUoAzYsGilIDd
 npdjaWgD3StL0YQAAAA==
X-Change-ID: 20250410-rfc_fix_fs-cfa369930abe
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Sls4o2toiBGoOtiR6gG470J5PXjQqsMV
X-Proofpoint-ORIG-GUID: Sls4o2toiBGoOtiR6gG470J5PXjQqsMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Use KERN_INFO instead of default KERN_NOTICE for
infof()|info_plog()|infofc() to printk informational messages.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 582d33e8111739402d38dc9fc268e7d14ced3c49..2877d9dec0753a5f03e0a54fa7b8d25072ea7b4d 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -449,6 +449,10 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
 			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
 						prefix ? ": " : "", &vaf);
 			break;
+		case 'i':
+			printk(KERN_INFO "%s%s%pV\n", prefix ? prefix : "",
+						prefix ? ": " : "", &vaf);
+			break;
 		default:
 			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
 						prefix ? ": " : "", &vaf);

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-rfc_fix_fs-cfa369930abe

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


