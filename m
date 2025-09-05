Return-Path: <linux-fsdevel+bounces-60328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA27B44B68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E18E7AA120
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456020C477;
	Fri,  5 Sep 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="hIfrmYVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D51AA7A6;
	Fri,  5 Sep 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037591; cv=none; b=UEkUi49o6VrwlbbwGxZ52HJnc84OjO+uxfsMFFE+G6Py2bNQbIqT2B3EuLhBxR/dBOdJ2xg6+oVLCwMT7beOA9ukpwwrAYxd6sFRkiUFRDpMYtrMfl1vSIq8E0maOFdjlLVQ+dUEJ08MnIrihf21A/rjtlJaD4YDWDnxv/y+7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037591; c=relaxed/simple;
	bh=gA4Mh35DL16tO9ykLk/jxV4bapjsLQBQgQUcaxFhOSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNaP89cMVeEYm/o0nTJtY+4JAUGQGjcFzPPSv42Q2ZdVYCS5Pqa3afUdYXgSEnQ/A+3x90Yac0PZISWlYh70IMEsJxiNd7BRjLFUqgAAM7bTlhgEQqDoZQVxB6FXbgkmSxt76rq1crV86AbPClIlRqcP/enrUEdAg7vDTjKeIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=hIfrmYVU; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5851e2AR4127040;
	Thu, 4 Sep 2025 18:59:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=dev7IaIeKSTxt4NEKjiqP0mEW51ewSs8JZD7A60ZlJo=; b=
	hIfrmYVUBNVckIK1GqPkUyX8eEwftqq8R1q1clFIXQKshcyFvbY74EJCNOzqWaRU
	NJjMBZDZEpPvxZtRcg2ptK9Uy5u/7ufo9XkRyZBv4f2UnOVnSS8tiEXvTnxgDMpb
	JJe0c6IOA6ueaZshVVTZFU+sq9eioGLfHkGAJPQy1ISFr54sDFKox0m6NIVm/GBK
	ZrwEA4nodUUqwD5BLoq3boB4YJBp0NoXz3qWdlWJYPDMcWSD6Lytjo0Ub1609zNz
	CmMGjhj4NulffuzT8GN4idDFTbgQQxFLjLlJjcIr3lPL2AIf0dwHknNESbDwx544
	bX+ig0WpGATvONhUBWDLcg==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48y7sb161s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 04 Sep 2025 18:59:28 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 4 Sep 2025 18:57:47 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 4 Sep 2025 18:57:45 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com>
CC: <dhowells@redhat.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netfs@lists.linux.dev>,
        <pc@manguebit.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] netfs: Prevent duplicate unlocking
Date: Fri, 5 Sep 2025 09:59:25 +0800
Message-ID: <20250905015925.2269482-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68b9d0eb.050a0220.192772.000c.GAE@google.com>
References: <68b9d0eb.050a0220.192772.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDAxNiBTYWx0ZWRfX/Mag4kq53t23
 6gOOtN8W0yahmgAai8TcXCIpi2/RxOhOLtKzbdqzxPVr6A9CKnjedf3N3uI26pWpQYf35pmA1MF
 /SpDGwkDVy7Ns9qEEJleMyuMuBWqBA6FMwTn0P3jZZrVOeleP/kd7ISoeNdB6BgZ3K/A+C2HDfM
 PwvCgU5TybPBk60Kgyndn1Q59bECGdP8ZbJvTspVzlBObGzkzB5H1fshSZK8Bj3efE9F7epJdz4
 c8hxEG63+Z6QyFKimTxeVfxU0X49xYiUSs3w4neQuZlId7gE5Eyu5lbCgwFZ5pugqFpZ8UsaeZS
 UpumyaC+W0bJe3WyofA7dsAoGg3FUmvZlVbPN5ay/DKqXKLRm4cBqXFUm36pwE=
X-Proofpoint-GUID: 1WKAbH2NX1y1ujUTQaNOyUdaVB08zYtZ
X-Authority-Analysis: v=2.4 cv=M5BNKzws c=1 sm=1 tr=0 ts=68ba4400 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=3yRTcMStzHrrPhRN-PwA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 1WKAbH2NX1y1ujUTQaNOyUdaVB08zYtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

The filio lock has been released here, so there is no need to jump to
error_folio_unlock to release it again.

Reported-by: syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b73c7d94a151e2ee1e9b
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f27ea5099a68..09394ac2c180 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -347,7 +347,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		folio_put(folio);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
-			goto error_folio_unlock;
+			goto out;
 		continue;
 
 	copied:
-- 
2.43.0


