Return-Path: <linux-fsdevel+bounces-24962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98339472C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 03:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FB61C20A9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758582AEF5;
	Mon,  5 Aug 2024 01:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542423A6;
	Mon,  5 Aug 2024 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722819786; cv=none; b=Oaosc1vyopzwhM3BLg2vPUVbMv83UUaObs6t3yQXlJMfXLvELldFwkVxo5rfAhLyPPUYyEbK+cskcik2PBzZolxGDoQiA/mVRQLwoJj84sNbw6kEVfSAkn+7usJncyU0KiaKfHV0gICkq7XSy9isRq+2zGN7HqpEMBTMphEwW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722819786; c=relaxed/simple;
	bh=yE3Bod8OrrsmULofuJn+GpNjS3MMXItlyMwYRlDzc8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyE8dYmYJKuspfA3oIfZR81NUdJLkrkOTib2vbp/MdoZta7HsFxNfVUOkOk7kTbScCePSW0ZX/uSv56X0bRNw/mdzLu2obSoC2KMp/NMSpZxSnNwe3+uUF3ukeLPUPGyl18FWMhh/XVdlRroNEbCzr7U9zUBSPIYSqez8QJ7qVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4750hkXT020114;
	Sun, 4 Aug 2024 18:02:36 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40sm2h10mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 04 Aug 2024 18:02:35 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 18:02:35 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 18:02:32 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Date: Mon, 5 Aug 2024 09:02:31 +0800
Message-ID: <20240805010231.1197391-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804212034.GE5334@ZenIV>
References: <20240804212034.GE5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iNvRO91Mbi9Nmy4v-K34L7Y8pHGTjoHw
X-Proofpoint-GUID: iNvRO91Mbi9Nmy4v-K34L7Y8pHGTjoHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=584
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408050006

On Sun, 4 Aug 2024 22:20:34 +0100, Al Viro wrote:
> Alternatively, just check ->i_size after assignment.  loff_t is
> always a 64bit signed; le32_to_cpu() returns 32bit unsigned.
> Conversion from u32 to s64 is always going to yield a non-negative
> result; comparison with PAGE_SIZE is all you need there.
It is int overflow, not others. 
Please see my V7 patch,
Link: https://lore.kernel.org/all/20240803074349.3599957-1-lizhi.xu@windriver.com/

--
Lizhi

