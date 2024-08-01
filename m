Return-Path: <linux-fsdevel+bounces-24734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A29442B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 07:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E91F22C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57B1411E0;
	Thu,  1 Aug 2024 05:29:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D7132114;
	Thu,  1 Aug 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490144; cv=none; b=V7h+Ti6XTN3Z29pG1UK7nD/EzdrV/yc8mrXnrUuyThjpdNbj2bGBBmwjS9IHNdbW5q+U+UM0Z58fWJR+rCw+WvHwqlcKNL8cb7Ti5aLM0oYh87SQkKCz1G7epmHyVYA5t98e8dJou5fKtJYswdqxnZx19YoDtE2rfOSh/1Bl+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490144; c=relaxed/simple;
	bh=8Ou5pjMJRb/zPenDD4SvV1s3OIKkG5QxAahKkyvdLYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwG32RGMr/qGs8zxYhURsqP1cd+xOjjLcygq/IppDT8QSpWr3G9DzlDWeSTQVLwd4UIXCPWE51zUMU60U5plKI3avUjWgV5Sr53tu9ZSjtbPnGp30CfJ/M16m9N1r7yi/zTNJHcdNBGA8qhL2IIVo5qOQBhexufKpb1Dv+inhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4714de6S025011;
	Thu, 1 Aug 2024 05:28:42 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mqv64uv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 01 Aug 2024 05:28:42 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 22:28:40 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 22:28:38 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for the filemap
Date: Thu, 1 Aug 2024 13:28:37 +0800
Message-ID: <20240801052837.3388478-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801025842.GM5334@ZenIV>
References: <20240801025842.GM5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Dox2R5LnC4_w5BtVKI5x6p1Qg0i9Vu6x
X-Proofpoint-ORIG-GUID: Dox2R5LnC4_w5BtVKI5x6p1Qg0i9Vu6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_02,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=793 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408010030

> > syzbot report KMSAN: uninit-value in pick_link, this is because the
> > corresponding folio was not found from the mapping, and the memory was
> > not initialized when allocating a new folio for the filemap.
> >
> > To avoid the occurrence of kmsan report uninit-value, initialize the
> > newly allocated folio memory to 0.
> 
> NAK.
> 
> You are papering over the real bug here.
Did you see the splat? I think you didn't see that.
> 
> That page either
> 	* has been returned by find_get_page(), cached, uptodate and
> with uninitialized contents or
> 	* has been returned by successful read_mapping_page() - and
> left with uninitialized contents or
> 	* had inode->i_size in excess of initialized contents.
> 
> I'd suggest bisecting that.

