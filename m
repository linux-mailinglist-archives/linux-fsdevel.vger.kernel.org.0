Return-Path: <linux-fsdevel+bounces-35004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD29CFC38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49E9B26A16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866B18FDAF;
	Sat, 16 Nov 2024 01:40:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A2161;
	Sat, 16 Nov 2024 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721212; cv=none; b=elfCsRzHlGMV8CbQ8tYZdElaDdx4gQ3ajsAtD5vS5a1BvZVk/lvpxKj4lv1/gT1ZWLKqMooDu9GrhpztkFMN+uJbKgwdN6odVbfrCUp6g1yd3PoS1gzaEUlm81TexPnHYZMl/Hsk5nuy4BN+IWOit4vCOWr2QVsBAk7j7sQM/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721212; c=relaxed/simple;
	bh=uHAJ0bruxmxO3JnrAFjxExYbyZ8+CU4TEPNbJPXRiCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo3Tcj9/OS8ZvxE1F01vpCpUieOGgg/lqpfXkgRgkAyLVbg1R25VSo5nRFp4M1ar5AeCQqvlT7WhihjsxFF953PlKwRKlr2gjUM1+LavMphKhz9vCWT03l9ddKn2kKZ97L5T/SERGX/ODz//WIm84LfS+QAKfEvMaxnHVzi4wOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AG1QVSh007459;
	Fri, 15 Nov 2024 17:39:54 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwppdsdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Nov 2024 17:39:54 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 15 Nov 2024 17:39:53 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 15 Nov 2024 17:39:51 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] fs: add check for symlink corrupted
Date: Sat, 16 Nov 2024 09:39:50 +0800
Message-ID: <20241116013950.1563199-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115132455.GS3387508@ZenIV>
References: <20241115132455.GS3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ExmeDj9_P2gE9nXS9MVtI8Zl-X2a2S1x
X-Proofpoint-GUID: ExmeDj9_P2gE9nXS9MVtI8Zl-X2a2S1x
X-Authority-Analysis: v=2.4 cv=J4f47xnS c=1 sm=1 tr=0 ts=6737f7ea cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=_2Td6NZvx3lezrQ3NhQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_12,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=724 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411160010

On Fri, 15 Nov 2024 13:24:55 +0000, Al Viro wrote:
> On Fri, Nov 15, 2024 at 01:06:15PM +0000, Al Viro wrote:
> > On Fri, Nov 15, 2024 at 05:49:08PM +0800, Lizhi Xu wrote:
> > > syzbot reported a null-ptr-deref in pick_link. [1]
> > > When symlink's inode is corrupted, the value of the i_link is 2 in this case,
> > > it will trigger null pointer deref when accessing *res in pick_link().
> > >
> > > To avoid this issue, add a check for inode mode, return -EINVAL when it's
> > > not symlink.
> >
> > NAK.  Don't paper over filesystem bugs at pathwalk time - it's the wrong
> > place for that.  Fix it at in-core inode creation time.
> 
> BTW, seeing that ntfs doesn't even touch ->i_link, you are dealing
Yes, ntfs3 does not handle the relevant code of i_link.
> with aftermath of memory corruption, so it's definitely papering over
> the actual bug here.
I see that finding out how the value of i_link becomes 2 is the key.

