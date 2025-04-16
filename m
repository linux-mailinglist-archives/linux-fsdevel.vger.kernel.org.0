Return-Path: <linux-fsdevel+bounces-46539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF55A8AFF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 08:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2446C1900C6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D4227E89;
	Wed, 16 Apr 2025 06:04:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48704188733;
	Wed, 16 Apr 2025 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783455; cv=none; b=C9+2lEA5bjZbLHsYU4uKZ4VBbaQ4lDDJUX2dzl3TfMQbS7T9Y2gEGNHw98mA9CI1HyDPOaQ7oTBZs9IqfsLVcXttDZUX96PHgUe3qRItvEr90PEOtHgHSpjcceGvSLNeVWgyFCCJ8iJ7MYMFEisTnWEuUvVZYRnFcr4Qr3Tjn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783455; c=relaxed/simple;
	bh=4MDKCGkDUE/VV29m/nvWYOckWsDczyJcPwJQL/LFEGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bqtaw8wRAwGzlMMY23ZtnbREsyfe/dQs5t7LX9DFJGnpzH0WG6JT9Kcxk/zGixko0Z0fHb8wXrgE7wb/TQLJTyoy9qiN2DRVu3rHqCB7T7qRC1wU5Me5Oiv560qPBJ6j71RaaeqeKEzEDaoOif1VUKxOrk8EeblkI/xnWQy9wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G5T7WW003339;
	Wed, 16 Apr 2025 06:03:55 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 461u2m8pfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 16 Apr 2025 06:03:55 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 15 Apr 2025 23:03:54 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 15 Apr 2025 23:03:51 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Wed, 16 Apr 2025 14:03:51 +0800
Message-ID: <20250416060351.2971835-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_9Bou858C-pJnmd@infradead.org>
References: <Z_9Bou858C-pJnmd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cH3Omw0ffxpczzBLqApii_YH40AfYMjL
X-Proofpoint-GUID: cH3Omw0ffxpczzBLqApii_YH40AfYMjL
X-Authority-Analysis: v=2.4 cv=BaLY0qt2 c=1 sm=1 tr=0 ts=67ff484b cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=b4dnZuen8jT_dhO8QXEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=758
 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160048

On Tue, 15 Apr 2025 22:35:30 -0700, Christoph Hellwig wrote:
> > > > The ntfs3 can use the page cache directly, so its address_space_operations
> > > > need direct_IO.
> > >
> > > This sentence still does not make any sense.
> > Did you see the following comments?
> > https://lore.kernel.org/all/20250415010518.2008216-1-lizhi.xu@windriver.com/
> 
> I did, but that changes nothing about the fact that the above sentence
> doesn't make sense.
In the reproducer, the second file passed in by the system call sendfile()
sets the file flag O_DIRECT when opening the file, which bypasses the page
cache and accesses the direct io interface of the ntfs3 file system.
However, ntfs3 does not set direct_IO for compressed files in ntfs_aops_cmpr.

