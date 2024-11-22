Return-Path: <linux-fsdevel+bounces-35546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27449D5A4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7731628167B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0C17BEC8;
	Fri, 22 Nov 2024 07:50:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB317333D;
	Fri, 22 Nov 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261844; cv=none; b=lP1I4db4v2sgljGQu67W+8Gn7skRIl5TeN7k44KUPi3U5fRHtKyxKW7Sb/by5++0Kjbr0oLN5Z+j3NTx4P7NSL3fOTGZ5I6fiVcQdeOt9KlwXWi1v8BkI17y1JaGAbwNxR7TK9fdjm6bBH/zlPO6WJK/jY5MzBcf3Y+HWZqIeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261844; c=relaxed/simple;
	bh=vFQMulayeNDcDeT2F7tkDS5mZx8b3f0ZaOyQ8oCBwEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPuiK4bbuHzf9IUPsXzh7vMearWsysBlmfZSgCYQp8Dh95vugSIa2o/c0KxWgBhl2VaASPfYHsZYOg9oyC+TnoBlvwEUJ80g85Vvoy3rB+X3Z6cetDTVhjp9QQDqlvAf37gB6V5percrQ7O0LTEOHQXTfVgOgfuPBo3Zs01FTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM6FoPV026432;
	Thu, 21 Nov 2024 23:49:56 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7xj80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Nov 2024 23:49:56 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 21 Nov 2024 23:49:55 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 21 Nov 2024 23:49:53 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V3] fs/ntfs3: check if the inode is bad before creating symlink
Date: Fri, 22 Nov 2024 15:49:52 +0800
Message-ID: <20241122074952.1585521-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120161045.GL3387508@ZenIV>
References: <20241120161045.GL3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X2s8mJJuFld93zBoTIPWOa0g-NpdWvJ2
X-Proofpoint-GUID: X2s8mJJuFld93zBoTIPWOa0g-NpdWvJ2
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=674037a4 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=OEdkkgd6TnMo6Y_G:21 a=VlfZXiiP6vEA:10 a=7E4HPvngilRCga4VZSMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_02,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=874 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411220064

On Wed, 20 Nov 2024 16:10:45 +0000, Al Viro wrote:
> > syzbot reported a null-ptr-deref in pick_link. [1]
> >
> > First, i_link and i_dir_seq are in the same union, they share the same memory
> > address, and i_dir_seq will be updated during the execution of walk_component,
> > which makes the value of i_link equal to i_dir_seq.
> >
> > Secondly, the chmod execution failed, which resulted in setting the mode value
> > of file0's inode to REG when executing ntfs_bad_inode.
> >
> > Third, when creating a symbolic link using the file0 whose inode has been marked
> > as bad, it is not determined whether its inode is bad, which ultimately leads to
> > null-ptr-deref when performing a mount operation on the symbolic link bus because
> > the i_link value is equal to i_dir_seq=2.
> >
> > Note: ("file0, bus" are defined in reproducer [2])
> >
> > To avoid null-ptr-deref in pick_link, when creating a symbolic link, first check
> > whether the inode of file is already bad.
> 
> I would really like to understand how the hell did that bad inode end up passed
> to d_splice_alias()/d_instantiate()/whatever it had been.
> 
> That's the root cause - and it looks like ntfs is too free with make_bad_inode()
> in general, which might cause other problems.
I will release the patch of the v4 version and add root cause:
During the execution of the link command, it sets the inode of the symlink file to the
already bad inode of file0 by calling d_instantiate, which ultimately leads to
null-ptr-deref when performing a mount operation on the symbolic link bus
because it use bad inode's i_link and its value is equal to i_dir_seq=2.

BR,
Lizhi

