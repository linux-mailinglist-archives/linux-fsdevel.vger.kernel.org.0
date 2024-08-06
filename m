Return-Path: <linux-fsdevel+bounces-25070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF87894894D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7051C230CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8711BBBF1;
	Tue,  6 Aug 2024 06:19:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710D8F77;
	Tue,  6 Aug 2024 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925193; cv=none; b=hT1MEAGX9svtH2W4xI/hWi03gtPHrzM7YFpgTbV7+PEzMrmHytJ3uZllR3W343Gby0e+ixEAr9zQoOdo6W6ljYNhqJ9wLCKZ5Itdk4escYlyEu+ddfAawYZXxBLHSjvF4Tm5aUxO1BHamvVYPHL3LgMmegWSNGBe6JleUxtN3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925193; c=relaxed/simple;
	bh=IczML6LG/jfHt+Bzq9BY3cd38Ulbq2FxstuheNWsQ+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC4ieZcVzb3qVeENuiDbrbfSM/qjOlyB1OqQjyfzXI3JKce20zgCmjB7ONpZ/EHNsuelWz7qyOO6xlJIQXTMSxDFnS7DrCPdvd/Q0he49nIGtGQ7w+EbSWJLbqG4VrxMWLhTq4DxPG70/3oncF1kwYqLPXT9BVpYqU6qsfmRt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765caVP025255;
	Tue, 6 Aug 2024 06:19:17 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40s9ry2g9m-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 Aug 2024 06:19:17 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 23:19:16 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 23:19:13 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Date: Tue, 6 Aug 2024 14:19:12 +0800
Message-ID: <20240806061912.3774595-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806045905.GM5334@ZenIV>
References: <20240806045905.GM5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Bsk1oLj1eONOolJuPrkJXXFpzd2PgXCj
X-Proofpoint-GUID: Bsk1oLj1eONOolJuPrkJXXFpzd2PgXCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_04,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=857 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408060044

On Tue, 6 Aug 2024 05:59:05 +0100, Al Viro wrote:
> > > Please, show me an unsigned int value N such that
> > >
> > > _Bool mismatch(unsigned int N)
> > > {
> > > 	u32 v32 = N;
> > > 	loff_t v64 = N;
> > >
> > > 	return (v32 > PAGE_SIZE) != (v64 > PAGE_SIZE);
> > > }
> > This always return 0, why are you asking this?
> 
> Because that implies the equivalence between
> 
> 	symlink_size = le32_to_cpu(something);
> 	if (symlink_size > PAGE_SIZE)
> 		return -EINVAL;
> 	inode->i_size = symlink_size;
> 
> and
> 
> 	inode->i_size = le32_to_cpu(something);
> 	if (inode->i_size > PAGE_SIZE)
> 		return -EINVAL;
> 
> However, you seem to find some problem in the latter form, and
> your explanations of the reasons have been hard to understand.
Here are the uninit-value related calltrace reports from syzbot:

page_get_link()->
  read_mapping_page()->
    read_cache_page()->
      do_read_cache_page()->
        do_read_cache_folio()->
          filemap_read_folio()->
            squashfs_symlink_read_folio()

fs/squashfs/symlink.c
 8 static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 7 {
 6         struct inode *inode = folio->mapping->host;
 5         struct super_block *sb = inode->i_sb;
 4         struct squashfs_sb_info *msblk = sb->s_fs_info;
 3         int index = folio_pos(folio);
 2         u64 block = squashfs_i(inode)->start;
 1         int offset = squashfs_i(inode)->offset;
41         int length = min_t(int, i_size_read(inode) - index, PAGE_SIZE);

Please see line 41, because the value of i_size is too large, causing integer overflow
in the variable length. Which can result in folio not being initialized (as reported by 
Syzbot: "KMSAN: uninit-value in pick_link").

My solution is to check if the value of symlink_size is too large before
initializing i_size with symlink_size. If it is, return -EINVAL.
> 
> > > Again, on all architectures inode->i_size is capable of representing
> > > all values in range 0..4G-1 (for rather obvious reasons - we want the
> > > kernel to be able to work with files larger than 4Gb).  There is
> > > no wraparound of any kind on that assignment.
> 
> > The type of loff_t is long long, so its values range is not 0..4G-1.
> 
> 6.3.1.3[1] When a value with integer type is converted to another integer type
> other than _Bool, if the value can be represented by the new type, it is unchanged.
> 
> Possible values of u32 are all in range 0..4G-1.  All numbers in that range
> (and many others as well, but that is irrelevant here) can be represented by
> loff_t.  In other words, nothing overflow-related is happening.

--
Lizhi

