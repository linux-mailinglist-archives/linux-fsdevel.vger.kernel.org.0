Return-Path: <linux-fsdevel+bounces-35382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A29D4744
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 06:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD32E1F21D48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862E156F39;
	Thu, 21 Nov 2024 05:28:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5231428F3;
	Thu, 21 Nov 2024 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732166925; cv=none; b=hob6u34DouBkMTXc0q7VzA58fxE3L3zL0/sHC8Ab29fYE1OaE5eqiKxhCZK/kTzhTg7/xvOGt9afw2jEIgA6CenDnyyN3L53ygX4gli+XOEpGHNjiZ803FbzYHkwNFmo/ne57scIy+kfb2oxKDzxFtKIcj8olhAVljIQr5K7G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732166925; c=relaxed/simple;
	bh=H4nEbDvEQDnynPlsLfcxoTdGWcmabL35D6NVyIVtqAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktW2hoe+I2+lBVmYuwMneZtlEzSoj3R6nvTfQWl54GUELJNUOe8Hr29opF0gKKh+JTmZmP1WnBAip5s+3xHPIlsehNSTf10oL5QkiCaWKoP6qSxjPO5mt0MTHebfSJ6sozBYee3HKIILS253UCiQQBpoN6Ei+tCYWCNidMVDdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL543E3019769;
	Wed, 20 Nov 2024 21:28:04 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq4y2n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 21:28:03 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 20 Nov 2024 21:28:03 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 20 Nov 2024 21:28:00 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <almaz.alexandrovich@paragon-software.com>, <brauner@kernel.org>,
        <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ntfs3@lists.linux.dev>,
        <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V3] fs/ntfs3: check if the inode is bad before creating symlink
Date: Thu, 21 Nov 2024 13:27:59 +0800
Message-ID: <20241121052759.967642-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121035529.GO3387508@ZenIV>
References: <20241121035529.GO3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8K5XrFakC2YMisJ3Q1P0oNkGYbRujZ1N
X-Proofpoint-ORIG-GUID: 8K5XrFakC2YMisJ3Q1P0oNkGYbRujZ1N
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673ec4e3 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=OEdkkgd6TnMo6Y_G:21 a=VlfZXiiP6vEA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=cYg7BZOSDzSb177eBLgA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_03,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=893 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210041

On Thu, 21 Nov 2024 03:55:29 +0000, Al Viro wrote:
> >   user_path_at()->
> >     filename_lookup()->
> >       path_lookupat()->
> >         lookup_last()->
> >           walk_component()->
> >             __lookup_slow()->
> >               ntfs_lookup()->
> >                 d_splice_alias()->
> >
> > 2. The subsequent chmod fails, causing the inode to be set to bad.
> 
> What's wrong with "return an error"?
make_bad_inode() is executed in attr_set_size() and the error code -ENOENT is returned;
attr_set_size() defined in fs/ntfs3/attrib.c
> 
> > 3. During the link operation, d_instantiate() is executed in ntfs_link() to associate the bad inode with the dentry.
> 
> Yecchhh...  If nothing else, check for is_bad_inode() should be there
> for as long as make_bad_inode() is done on live inodes.
I checked is_bad_inode() in ntfs_link(), see line 146 of ntfs_link(), please see my V3 of the patch [2].

[1]
fs/ntfs3/namei.c
 19 static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 18 {
 17         int err;
 16         struct inode *inode = d_inode(ode);
 15         struct ntfs_inode *ni = ntfs_i(inode);
 14
 13         if (S_ISDIR(inode->i_mode))
 12                 return -EPERM;
 11
 10         if (inode->i_nlink >= NTFS_LINK_MAX)
  9                 return -EMLINK;
  8
  7         ni_lock_dir(ntfs_i(dir));
  6         if (inode != dir)
  5                 ni_lock(ni);
  4
  3         inc_nlink(inode);
  2         ihold(inode);
  1
146         err = ntfs_link_inode(inode, de);
  1
  2         if (!err) {
  3                 inode_set_ctime_current(inode);
  4                 inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
  5                 mark_inode_dirty(inode);
  6                 mark_inode_dirty(dir);
  7                 d_instantiate(de, inode);

[2]  
Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 --> V2: add the root cause of the i_link not set issue and imporve the check
V2 --> V3: when creating a symbolic link, first check whether the inode of file is bad.

 fs/ntfs3/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7..fefbdcf75016 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1719,6 +1719,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
 	struct NTFS_DE *de;

+	if (is_bad_inode(inode))
+		return -EIO;
+
 	/* Allocate PATH_MAX bytes. */
 	de = __getname();
 	if (!de)

