Return-Path: <linux-fsdevel+bounces-46234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A79A85138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 03:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DBB4C03AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE215270EC7;
	Fri, 11 Apr 2025 01:24:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC126FA4E;
	Fri, 11 Apr 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334696; cv=none; b=K8v819RSDT4buW+P7grGgFEdtvdEBkCaciup0t/jPbwq9bd2dX4rGOomv6tDxtPNBbK+syHXio2GM3wpQhVq5DYWMxVJqSG6nzq7ucCuCYr636hGF0tmBPKdROZzRjqkThLDzqvqBE7jWPiO/SSZC4OaMb0JNCE5kdUd9aIq0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334696; c=relaxed/simple;
	bh=dSSjUm1qkj9N0lBPFnjlZ3nQVsQFC/1C77m25QuWoKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlElrCyDKnlHmXvKDSoK5iDmS8CvKo8gT0URp0yMefbEupLUWGCPeMIMumbNHF7pQAtReohotT7gB7OIPP9BasHe6ptppyTl6mucbhf9w8ESQwyrnJeMksyCHwdJiCVTs8mqjqBy0vKYT2aQfZZX65InmL2m+yqrntfYM4vsqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ANm3aY017752;
	Thu, 10 Apr 2025 18:24:32 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4ffp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Apr 2025 18:24:32 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 10 Apr 2025 18:24:31 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 10 Apr 2025 18:24:28 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Fri, 11 Apr 2025 09:24:27 +0800
Message-ID: <20250411012428.3473333-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67f818d3.050a0220.355867.000d.GAE@google.com>
References: <67f818d3.050a0220.355867.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dDioEEsJy4xVUNQp_mgWi5Z4hGF7QV90
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f86f50 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=4PoWjKlla1C8yqjNy9cA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: dDioEEsJy4xVUNQp_mgWi5Z4hGF7QV90
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=843 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110009

The ntfs3 can use the page cache directly, so its address_space_operations
need direct_IO.

Fixes: b432163ebd15 ("fs/ntfs3: Update inode->i_mapping->a_ops on compression state")
Reported-by: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e36cc3297bd3afd25e19
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/ntfs3/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3e2957a1e360..50524f573d3a 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2068,5 +2068,6 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.dirty_folio	= block_dirty_folio,
+	.direct_IO	= ntfs_direct_IO,
 };
 // clang-format on
-- 
2.43.0


