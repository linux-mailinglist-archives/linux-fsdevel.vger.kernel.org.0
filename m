Return-Path: <linux-fsdevel+bounces-46195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BCA84200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CD21B85361
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D84284B41;
	Thu, 10 Apr 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sWQj3OwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C082284B25
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285567; cv=none; b=A0DPrV4K1lc07nJcA/Jg4DHdN59cM2EIPt2q1ahfXaNOSdGjzSVGNLmKakuBfpcktR72VBoJfxmdRA+Z0htpPQOuq5Jsx5CyTzw7sbvPxvGCR2pNqkyGBrMnAiYvVQ98Ap6QHqDCDnReMashu9AAnIe+7vC/XOhCSz2r+px7Mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285567; c=relaxed/simple;
	bh=Wbs1f7BkBrorZdVyU1I8hApBT0pFdloDvPlZEmsgsIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlT/ayRJ5XLKvjn0DMlAhnMV0royBg2nmvijAVHV8WXTiDUcRJ5O7zbtCtzyiZyvPVxPl/e7yL6EGE7P6DFdbCwBG1P6LhVQkoyO670YIMqquqCLPzqNamKkr3YmuP90g6eUdpji3WnM9miAwU3tDterqxaK6wyfxMIGF54iudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sWQj3OwI; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=u0JahMP7tuM8FXUTCsozXpgCMXPBrgvUcnz/9Uhu5lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=sWQj3OwIL8O3wW2u16MdLmQhX1pjYdALioshAkFfCHRVgO+4MCLVX3o/z7fRfpV2/
	 639/p8KCo8dHfehGywx1Qg4vmUMQ6u6VfRDPRXxUhxQFwvcsnh7y1/sNhGFzay2O3G
	 hEKcrJkJeJps5RyphI6FDpzq+/3vNKNQxMjYSkThArOXD+W2CFee0eU4TRuf5w3lFv
	 ajTi+MCH0eanm8LN1TQKnIA3/zxSdiQ3aTwpAaorEOn115MfOEqyQlrC2/sAqKMpa2
	 NIKecHU0KMtTE4G0eq5iv21QMnyO3hyJp05RyHXZFODObi2G3jaNGaqKVmGnPcepQL
	 IJSCy9wmuFF0Q==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id 7D3CE3058606;
	Thu, 10 Apr 2025 11:46:03 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 14950305855C;
	Thu, 10 Apr 2025 11:46:00 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:45:28 +0800
Subject: [PATCH 2/5] fs/fs_parse: Fix macro fsparam_u32hex() definition
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_fs-v1-2-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
In-Reply-To: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: wNOiCSmvxxg5rpxHXheK4ZTo8ERiFykr
X-Proofpoint-ORIG-GUID: wNOiCSmvxxg5rpxHXheK4ZTo8ERiFykr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Macro fsparam_u32hex() uses as type @fs_param_is_u32_hex which is
never defined.

Fix by using @fs_param_is_u32 instead as fsparam_u32oct() does.

Fixes: 328de5287b10 ("turn fs_param_is_... into functions")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/fs_parser.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 53e566efd5fd133d19e313e494b975612a227b77..ca76601d0bbdbaded76515cb6b2c06fa30127a06 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -126,7 +126,7 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
 #define fsparam_u32hex(NAME, OPT) \
-			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)

-- 
2.34.1


