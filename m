Return-Path: <linux-fsdevel+bounces-35375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431769D461E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C081F2233F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275D13B58B;
	Thu, 21 Nov 2024 03:14:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883070817;
	Thu, 21 Nov 2024 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158860; cv=none; b=i5pMZpdskKcywlvleBH7LsRKLf1z7UvSE0P35Xo7gyaP8pWB2bDvZIytbmdPtduUNPE+pIDk+ezj4h3mcxybIQmEFv2KBWmeta7rS0Y4q+UJgZmUYXgp6d+wL4F6rCDwKnYG7s4DHenKrzu+Stmk5G5q+p+osbsioQozAW6OID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158860; c=relaxed/simple;
	bh=PUuC1t5t+/n5ZB+R5Tem9vzjEzm8d5KZbCxm79ml7I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adylf98iHZpZ0Ob/6BuyLb3qrMGKYoAlIlgQfssEn+OU243AoOuMx5UPA1ejPgO7AsPTcfnYRaQHc1Uzi3q/l/d87rhQTr9ivJvWt0bnaHZWjQe44x5j+LxSvKx8GguxJbvPheX2JXHrpU0zAV35cmzQbeaRQtzh1YHxzk2QUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL2pI2c029337;
	Thu, 21 Nov 2024 03:13:34 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0n541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Nov 2024 03:13:34 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 20 Nov 2024 19:13:32 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 20 Nov 2024 19:13:30 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V3] fs/ntfs3: check if the inode is bad before creating symlink
Date: Thu, 21 Nov 2024 11:13:29 +0800
Message-ID: <20241121031329.354341-1-lizhi.xu@windriver.com>
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
X-Proofpoint-ORIG-GUID: NAjo1vfwGLZaS1hclXBN6lHomPxM8qOx
X-Proofpoint-GUID: NAjo1vfwGLZaS1hclXBN6lHomPxM8qOx
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673ea55e cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=OEdkkgd6TnMo6Y_G:21 a=VlfZXiiP6vEA:10 a=oXN7jNVGPntKbSpEweEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_01,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=771 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210024

On Wed, 20 Nov 2024 16:10:45 +0000, Al Viro wrote:
> On Wed, Nov 20, 2024 at 11:04:43AM +0800, Lizhi Xu wrote:
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
1. In the move_mount() process, the inode is created by ntfs_alloc_inode() and enters d_splice_alias() by ntfs_lookup(), at this time inode is good, as shown below:
move_mount()->
  user_path_at()->
    filename_lookup()->
      path_lookupat()->
        lookup_last()->
          walk_component()->
            __lookup_slow()->
              ntfs_lookup()->
                d_splice_alias()->

2. The subsequent chmod fails, causing the inode to be set to bad.
3. During the link operation, d_instantiate() is executed in ntfs_link() to associate the bad inode with the dentry.
4. During the mount operation, walk_component executes pick_link, triggering null-ptr-deref.

Reproducer:
move_mount(0xffffffffffffff9c, &(0x7f00000003c0)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000400)='./file0/file0\x00', 0x140)
chmod(&(0x7f0000000080)='./file0\x00', 0x0)
link(&(0x7f0000000200)='./file0\x00', &(0x7f0000000240)='./bus\x00')
mount$overlay(0x0, &(0x7f00000000c0)='./bus\x00', 0x0, 0x0, 0x0)
> 
> That's the root cause - and it looks like ntfs is too free with make_bad_inode()
> in general, which might cause other problems.

