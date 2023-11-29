Return-Path: <linux-fsdevel+bounces-4164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D77FD473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FAE2833FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5A1B27C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TlLOWeuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE849AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 00:55:05 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231129085502epoutp02ce2007ee08a115f056a6a5d4644747ca~cDCK9V_ir0287602876epoutp02g
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231129085502epoutp02ce2007ee08a115f056a6a5d4644747ca~cDCK9V_ir0287602876epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701248102;
	bh=uIEGL0gcsDR2YzrSZo04wXyD0A1Wl+3Z8PNSrO937ug=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TlLOWeuL5XCVE2ZlD2nKK/+vgTwYqlj6VRCCCRFqlpzHeTDolNviOvQA2bhbZSfqi
	 IE3be3MykuZmlTwMMrIpi2TxSwW7Bq4IuTv7rHbNfR2iTb6k9I1npDgIbLWmHyHyAX
	 SsVURGrZhZFzNJDrdbkzaah9Dc0HO48h14eVk3uc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231129085502epcas1p224b11fc1bd9dfcca522c9f3f8fe06bb9~cDCKg3TFX2366223662epcas1p22;
	Wed, 29 Nov 2023 08:55:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp1.localdomain
	(Postfix) with ESMTP id 4SgCnf0Wjvz4x9Q5; Wed, 29 Nov 2023 08:55:02 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20231129085022epcas1p4eb9616180ffe4529b85fd7f2ace5c257~cC_GGC6xG0668506685epcas1p4E;
	Wed, 29 Nov 2023 08:50:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231129085022epsmtrp228fb95fe8e41b26eefcb3b2e61f3ccf6~cC_GEvddw0599605996epsmtrp2H;
	Wed, 29 Nov 2023 08:50:22 +0000 (GMT)
X-AuditID: b6c32a28-a2ffe70000001cc8-b8-6566fb4e8870
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.9A.07368.E4BF6656; Wed, 29 Nov 2023 17:50:22 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231129085022epsmtip2677171620ae44fda43d1e0d9647896c1~cC_F89Kur1305513055epsmtip2f;
	Wed, 29 Nov 2023 08:50:22 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316FDA1CB1C7862C179F2CF8183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v4 1/2] exfat: change to get file size from DataLength
Date: Wed, 29 Nov 2023 17:50:22 +0900
Message-ID: <664457955.21701248102069.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIfTJ4sSqFtaLGW5XdKkwFe5OsxkQHvqZQxAoF3uZkC5WphWwFdF0n1r8EIvQA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvK7f77RUg5Y3khatR/YxWrw8pGkx
	cdpSZos9e0+yWGz5d4TV4uOD3YwW1988ZHVg99i0qpPNo2/LKkaP9gk7mT0+b5ILYInisklJ
	zcksSy3St0vgyljR3M9c0Clf8X//bKYGxnPiXYycHBICJhI/z51i6mLk4hAS2M0oMeHkFMYu
	Rg6ghJTEwX2aEKawxOHDxRAlzxklrn3dywzSyyagK/Hkxk8wW0TAVOLL5RNsIDazQDujxLtv
	sRANLcwSb29tBiviFIiV2DJ7GpgtLOAl8fnsdEYQm0VAVeJ95xd2EJtXwFJi56qnrBC2oMTJ
	mU9YIIZqSzy9+RTKlpfY/nYOM8QDChK7Px1lhTjCT6L1xh1WiBoRidmdbcwTGIVnIRk1C8mo
	WUhGzULSsoCRZRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnAEaWnsYLw3/5/eIUYm
	DsZDjBIczEoivHofk1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoE
	k2Xi4JRqYOrctLtKS0y3Rz6g1JkrU9b8HuOtr41Zuzu45fyeHdv6abXBI6146zCl8J0VJ4qs
	dXN52RzvyEhKik/9bPzxkovONNHLV3VNu24I7I1l0G1Tq7+19bPaeZseh9gLM2zCPkc+SLsU
	5riHNyP59JyF0r0pBXZnpc4tCdo/x9M4PGry4e3iL9bXrveZwLdrbsz5p62nNx/ceDr522eO
	6FLjkrk9yvNbd+3eHRzVJDrt80/hmHeTHDf4rF0cEnpqvvFJkyXJ97edaVIVm5nfdc9m8sU/
	K2UuG6vcyjr1YIe+pV5TMtP8vtbs5X8P37Hs6FCKfM71R/FeAePaf9FPjl7wefV/RhW3WVO/
	6STGqEWOE5RYijMSDbWYi4oTAVrllJkPAwAA
X-CMS-MailID: 20231129085022epcas1p4eb9616180ffe4529b85fd7f2ace5c257
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b
References: <CGME20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b@epcas1p1.samsung.com>
	<PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<1296674576.21701163681829.JavaMail.epsvc@epcpadp4>
	<PUZPR04MB6316FB0EDA2C6B92617CD4538183A@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<PUZPR04MB6316FDA1CB1C7862C179F2CF8183A@PUZPR04MB6316.apcprd04.prod.outlook.com>

[snip]
> > > +	if (pos > valid_size && iocb_is_dsync(iocb)) {
> > > +		ssize_t err = vfs_fsync_range(file, valid_size, pos - 1,
> > > +				iocb->ki_flags & IOCB_SYNC);
> > If there is a hole between valid_size and pos, it seems to call sync
> twice.
> > Is there any reason to call separately?
> > Why don't you call the vfs_fsync_range only once for the merged scope
> > [valid_size:end]?
> 
> For better debugging, I kept the original logic and added new logic for
> valid_size.
> For now, it is unnecessary, I will change to sync once.
Thanks.

> 
> >
[snip]
> > Is there any reason to not only change the value but also move the line
> down?
> 
> I will move it back the original line.
Sounds good!

> 
> >
> > > +
> > >  	exfat_update_dir_chksum_with_entry_set(&es);
> > >  	return exfat_put_dentry_set(&es, sync);  } @@ -306,17 +307,25 @@
> > > static int exfat_get_block(struct inode *inode, sector_t iblock,
> > >  	mapped_blocks = sbi->sect_per_clus - sec_offset;
> > >  	max_blocks = min(mapped_blocks, max_blocks);
> > >
> > > -	/* Treat newly added block / cluster */
> > > -	if (iblock < last_block)
> > > -		create = 0;
> > > -
> > > -	if (create || buffer_delay(bh_result)) {
> > > -		pos = EXFAT_BLK_TO_B((iblock + 1), sb);
> > > +	pos = EXFAT_BLK_TO_B((iblock + 1), sb);
> > > +	if ((create && iblock >= last_block) || buffer_delay(bh_result)) {
> > >  		if (ei->i_size_ondisk < pos)
> > >  			ei->i_size_ondisk = pos;
> > >  	}
> > >
> > > +	map_bh(bh_result, sb, phys);
> > > +	if (buffer_delay(bh_result))
> > > +		clear_buffer_delay(bh_result);
> > > +
> > >  	if (create) {
> > > +		sector_t valid_blks;
> > > +
> > > +		valid_blks = EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
> > > +		if (iblock < valid_blks && iblock + max_blocks >= valid_blks)
> > > {
> > > +			max_blocks = valid_blks - iblock;
> > > +			goto done;
> > > +		}
> > > +
> > You removed the code for handling the case for (iblock < last_block).
> > So, under all write call-flows, it could be buffer_new abnormally.
> > It seems wrong. right?
> 
> Yes, I will update this patch.
> 
> Without this patch, last_block is equal with valid_blks,
> exfat_map_new_buffer() should be called if iblock + max_blocks >
> last_block.
> 
> With this patch, last_block >= valid_blks, exfat_map_new_buffer() should
> be called if iblock + max_blocks > valid_blks.
Okay.

> 
> >
> > >  		err = exfat_map_new_buffer(ei, bh_result, pos);
> > >  		if (err) {
> > >  			exfat_fs_error(sb,
> > [snip]
> > > @@ -436,8 +485,20 @@ static ssize_t exfat_direct_IO(struct kiocb
> > > *iocb, struct iov_iter *iter)
> > >  	 * condition of exfat_get_block() and ->truncate().
> > >  	 */
> > >  	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
> > > -	if (ret < 0 && (rw & WRITE))
> > > -		exfat_write_failed(mapping, size);
> > > +	if (ret < 0) {
> > > +		if (rw & WRITE)
> > > +			exfat_write_failed(mapping, size);
> > > +
> > > +		if (ret != -EIOCBQUEUED)
> > > +			return ret;
> > > +	} else
> > > +		size = pos + ret;
> > > +
> > > +	if ((rw & READ) && pos < ei->valid_size && ei->valid_size < size) {
> > > +		iov_iter_revert(iter, size - ei->valid_size);
> > > +		iov_iter_zero(size - ei->valid_size, iter);
> > > +	}
> >
> > This approach causes unnecessary reads to the range after valid_size,
> right?
> 
> I don't think so.
> 
> If the blocks across valid_size, the iov_iter will be handle as 1. Read
> the blocks before valid_size.
> 2. Read the block where valid_size is located and set the area after
> valid_size to zero.
> 3. zero the buffer of the blocks after valid_size(not read from disk)
> 
> So there are unnecessary zeroing here(in 1 and 2), no unnecessary reads.
> I will remove the unnecessary zeroing.

You are right. There might be no need to change.
It could be handled in do_direct_IO() with get_block newly modifed.

Thanks.

B. R.
Sungjong Seo



