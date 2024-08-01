Return-Path: <linux-fsdevel+bounces-24724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2094413E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579161F21BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC131EB4AF;
	Thu,  1 Aug 2024 02:34:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EF1EB4A4;
	Thu,  1 Aug 2024 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479666; cv=none; b=jReMeedUwT4EqifkaLoL7QkMkDDvjQAy1wj5XBV4+YYf9L1soUBSDSv+WVDK53M/5be8E7QpIEvIQtc8bs8FPk3lxvTcCFFV+S1hPtuJfyDpuwNf06cERw0QLuI73/PllXLr/Q6IThcm8FlmEySyAhAHq3mMuf7hMdgf7fBygKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479666; c=relaxed/simple;
	bh=qQSPNLios5xKWmTFVwyn3gt+MTcOyJ062V/2dZ2JSFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlFXfAIDqGi+69Rheiz6Iiu0pS4dW4KkwDvvtaDNOquWlHQ7PWdw5NGDR+ejJ7ziybsIIfE+V37Kp7pPqoKjr6R+N7u0x7r4Hly4yggIhdHl0yLdQKuxxTd6/sI9VhOllmlys6L3HdFDhgkkoyTqFgbBxCtS9YNwmICAweFALMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VMUID4025106;
	Thu, 1 Aug 2024 02:27:52 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mp3xctcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 01 Aug 2024 02:27:52 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 19:27:41 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 19:27:39 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <squashfs-devel@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: [PATCH] filemap: Init the newly allocated folio memory to 0 for the filemap
Date: Thu, 1 Aug 2024 10:27:39 +0800
Message-ID: <20240801022739.1199700-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
References: <000000000000a90e8c061e86a76b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2Qn-1ygvAFcpaVndRNr-E9j3oWzc9GPK
X-Proofpoint-ORIG-GUID: 2Qn-1ygvAFcpaVndRNr-E9j3oWzc9GPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_12,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408010013

syzbot report KMSAN: uninit-value in pick_link, this is because the
corresponding folio was not found from the mapping, and the memory was
not initialized when allocating a new folio for the filemap.

To avoid the occurrence of kmsan report uninit-value, initialize the
newly allocated folio memory to 0.

Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 mm/filemap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..1b22eab691e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3753,6 +3753,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		folio = filemap_alloc_folio(gfp, 0);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
+
+		void *kaddr = kmap_local_folio(folio, 0);
+		memset(kaddr, 0, folio_size(folio));
+		kunmap_local(kaddr);
+
 		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
 			folio_put(folio);
-- 
2.43.0


