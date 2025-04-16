Return-Path: <linux-fsdevel+bounces-46541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF77A8B01E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 08:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7810D1902520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5E21E0AF;
	Wed, 16 Apr 2025 06:18:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DA219A81;
	Wed, 16 Apr 2025 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784331; cv=none; b=KzVr3YnyADvvFxL88zy57OnkM32QS5iiCy7k6lPBP2Zmaw8DFwdWHwq37617jYZpRUtzuqROidcm2DGfAiAm7sTaZwqFoUDGuce6DBoXRxZ7qMdG7gz2aKOT94yncSZog+79mFqWoHkZmoZ+y612aOetz4DO1g0soKzIuAu9r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784331; c=relaxed/simple;
	bh=suSMq9iVHxQM5u7UB4YBN9mUydNJQLH2Jg1AhbkJWHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfQCnJLdhcQCp7nYdMDJvgeTrTLj8YXrpWhEOyYuiT0n0S2MVeiPglkJbE8HOAWH5AJKrZlecUI7e+EWAjkCEl1GLfiG8e1lpErP7fmVkfW7Fi8xGdd7zkwFTBRgkSssa7jEZpE4wnZ41/zwDrEWzFIaVEIo7reAh1dUgsHdUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G5thZ9013510;
	Tue, 15 Apr 2025 23:18:32 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkm3dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Apr 2025 23:18:32 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 15 Apr 2025 23:18:31 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 15 Apr 2025 23:18:28 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Wed, 16 Apr 2025 14:18:27 +0800
Message-ID: <20250416061827.2995095-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_9IxOypdO5Ks44N@infradead.org>
References: <Z_9IxOypdO5Ks44N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BnqVxG8VK0WFqjPmkANnMIqWHjR1nEQU
X-Proofpoint-GUID: BnqVxG8VK0WFqjPmkANnMIqWHjR1nEQU
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=67ff4bb8 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=Lu9379bB4VU3hevTGzEA:9
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=736 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160050

On Tue, 15 Apr 2025 23:05:56 -0700, Christoph Hellwig wrote:
> > In the reproducer, the second file passed in by the system call sendfile()
> > sets the file flag O_DIRECT when opening the file, which bypasses the page
> > cache and accesses the direct io interface of the ntfs3 file system.
> > However, ntfs3 does not set direct_IO for compressed files in ntfs_aops_cmpr.
> 
> Not allowing direct I/O is perfectly fine.  If you think you need to
> support direct I/O for this case it is also fine.  But none of this
> has anything to do with 'can use the page cache' and there are also
The "The ntfs3 can use the page cache directly" I mentioned in the patch
is to explain that the calltrace is the direct I/O of ntfs3 called from
generic_file_read_iter().

