Return-Path: <linux-fsdevel+bounces-14108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D87877B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 08:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8272B20CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D8101C6;
	Mon, 11 Mar 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uiUgce61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383C10FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710140422; cv=none; b=XfcPN4neTIRSIAgWPaujtY2+HgbiMixf9TTDrb+n5do7ytq3pYEK8VjSQG/TrmnZ/NMOa5dqiF/eozBHPMPZ/Wg+XR5W7BH7zVTXAB5/nDsdEkafH9PIKodCrqv+3bR46Jz+0grzUiz0c8Y1SarcwPtKG5t668/d6tDh3FwS2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710140422; c=relaxed/simple;
	bh=MlBtdpPBb/LRb1mlpc2WRXNcW7cg2as7b/mC2/Bx3e0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=m1DQ1oSrlDmqR04CnlVRywkTZs9yx1IzgOLqFYUEYy2MwmHZHRKnmVBC1srWfUba1KGOJR2/glt5zBbkW8no6tGlZ7KkO1vPcRDySCi2V7c3ATifdj7Wngb2E5L7TNHnpIq+q2Lb4V5uM0gFvCorI6gnbFROJqRx5StjveTVITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uiUgce61; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240311070002epoutp03b10f22538f3017df97801bbad8f2dc58~7o6KgQC2F2296522965epoutp03g
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 07:00:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240311070002epoutp03b10f22538f3017df97801bbad8f2dc58~7o6KgQC2F2296522965epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710140402;
	bh=T7/4YwN5VH9oNEDHf8lmKv6QWYV9HqkGr9EBArwabM4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=uiUgce61L6mNVXQg8WUItDRl1XL29hTAHEdG+or8Jf0hjDOfwMhRyBYZp+fSjxVjl
	 w5FAP03BQX8MC0w3oKfUxzeTDMEvCo1bEuCoJd8mKk5kPtGAYPNYFJ2klLPOHfS+j5
	 xdcCi09DLNH55rf23+elDJNHCaB7p2boOWJ3n+RI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240311070001epcas1p4879fb9a51c6f3b68b26f9bd7f03e7dea~7o6KGBlZ22467724677epcas1p4A;
	Mon, 11 Mar 2024 07:00:01 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp2.localdomain
	(Postfix) with ESMTP id 4TtSMP6RV5z4x9QN; Mon, 11 Mar 2024 07:00:01 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240311062134epcas1p48e4fc2d4af9a73c943b134867faf0579~7oYledmIg1021510215epcas1p4E;
	Mon, 11 Mar 2024 06:21:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240311062134epsmtrp1b0798b9f166aa3e4f65973ac79f68d82~7oYldyUyf2948229482epsmtrp1f;
	Mon, 11 Mar 2024 06:21:34 +0000 (GMT)
X-AuditID: b6c32a28-a2ffe70000001cc8-10-65eea2eec72d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.E2.07368.EE2AEE56; Mon, 11 Mar 2024 15:21:34 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240311062134epsmtip173893161582385dec902460d19c58d19~7oYlOvfP81787917879epsmtip1Q;
	Mon, 11 Mar 2024 06:21:34 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>
In-Reply-To: <TY0PR04MB6328049134D3D769E12E607F81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v3 00/10] exfat: improve sync dentry
Date: Mon, 11 Mar 2024 15:21:34 +0900
Message-ID: <1891546521.01710140401877.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ7Ie+ktb+Q53uNwxlaF++J1stZeAIPdAWMr+A4A2A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnO67Re9SDa7+1bFoPbKP0eLlIU2L
	idOWMlvs2XuSxWLLvyOsFh8f7Ga0uP7mIasDu8emVZ1sHn1bVjF6tE/YyezxeZNcAEsUl01K
	ak5mWWqRvl0CV8bZtj9MBdvFKh5c/c7YwDhToIuRk0NCwETiQF83YxcjF4eQwG5GiV/nuli7
	GDmAElISB/dpQpjCEocPF0OUPGeU6Pu+mhmkl01AV+LJjZ9gtoiAqcSXyyfYQGxmgVCJn3d2
	sUM0rGOU2PJ7NViCUyBW4t7WFjBbWMBCYu7j/4wgC1gEVCV+tuSDhHkFLCV+P93KAmELSpyc
	+YQFYqa2xNObT6FseYntb+cwQ9yvILH701FWiBusJJZN72eGqBGRmN3ZxjyBUXgWklGzkIya
	hWTULCQtCxhZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBMePlsYOxnvz/+kdYmTi
	YDzEKMHBrCTC+1rnbaoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotg
	skwcnFINTJzrdf1+cP7IVtxbmaF67NDj3bmsGufPJV9r3cvz8cF1mX/hSal3IjtSdLobTTYY
	76y0WGXMzM315NPVz7UZAl/knJ64LmD13/A/5t960ZwPC16p6DSd1Wq2yjEIXnW7j21/0YJK
	03T/7QH6rtku9z05qpKrjUs4T7AK+plptnEt23IoMvnMllhW5u09EyvuO2R5RkvKWxrM+uf4
	fsvaZoOOC3ns++bd7eXby6Zw//vSy98enTiQm8V7hfdHyDnjlkldwk1hN0/FvNGMuJLx73f+
	on06jNG/Td/tmdVQuFCJzfTXK/011sFT7dS/nuVOZCxYcv2MoX2cXmT8qxn1a8+tWXbv+EcV
	1mU6Hr7pSizFGYmGWsxFxYkABhGZSg4DAAA=
X-CMS-MailID: 20240311062134epcas1p48e4fc2d4af9a73c943b134867faf0579
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20240311042501epcas1p34655f4bf93feafb952ba35534b516c7e
References: <CGME20240311042501epcas1p34655f4bf93feafb952ba35534b516c7e@epcas1p3.samsung.com>
	<TY0PR04MB6328049134D3D769E12E607F81242@TY0PR04MB6328.apcprd04.prod.outlook.com>

> This patch set changes sync dentry-by-dentry to sync dentrySet-by-
> dentrySet, and remove some syncs that do not cause data loss. It not only
> improves the performance of sync dentry, but also reduces the consumption
> of storage device life.
> 
> I used the following commands and blktrace to measure the improvements on
> a class 10 SDXC card.
> 
> rm -fr $mnt/dir; mkdir $mnt/dir; sync
> time (for ((i=0;i<1000;i++));do touch $mnt/dir/${prefix}$i;done;sync $mnt)
> time (for ((i=0;i<1000;i++));do rm $mnt/dir/${prefix}$i;done;sync $mnt)
> 
> | case | name len |       create          |        unlink          |
> |      |          | time     | write size | time      | write size |
> |------+----------+----------+------------+-----------+------------|
> |  1   | 15       | 10.260s  | 191KiB     | 9.829s    | 96KiB      |
> |  2   | 15       | 11.456s  | 562KiB     | 11.032s   | 562KiB     |
> |  3   | 15       | 30.637s  | 3500KiB    | 21.740s   | 2000KiB    |
> |  1   | 120      | 10.840s  | 644KiB     | 9.961s    | 315KiB     |
> |  2   | 120      | 13.282s  | 1092KiB    | 12.432s   | 752KiB     |
> |  3   | 120      | 45.393s  | 7573KiB    | 37.395s   | 5500KiB    |
> |  1   | 255      | 11.549s  | 1028KiB    | 9.994s    | 594KiB     |
> |  2   | 255      | 15.826s  | 2170KiB    | 13.387s   | 1063KiB    |
> |  3   | 255      | 1m7.211s | 12335KiB   | 0m58.517s | 10004KiB   |
> 
> case 1. disable dirsync
> case 2. with this patch set and enable dirsync case 3. without this patch
> set and enable dirsync
> 
> Changes for v3
>   - [2/10] Allow deleted entry follow unused entry

looks good. Thanks for your patch.
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
> Changes for v2:
>   - Fix typoes in patch subject
>   - Merge [3/11] and [8/11] in v1 to [7/10] in v2
>   - Update some code comments
>   - Avoid else{} in __exfat_get_dentry_set()
>   - Rename the argument type of __exfat_get_dentry_set() to
>     num_entries
> 
> Yuezhang Mo (10):
>   exfat: add __exfat_get_dentry_set() helper
>   exfat: add exfat_get_empty_dentry_set() helper
>   exfat: convert exfat_add_entry() to use dentry cache
>   exfat: convert exfat_remove_entries() to use dentry cache
>   exfat: move free cluster out of exfat_init_ext_entry()
>   exfat: convert exfat_init_ext_entry() to use dentry cache
>   exfat: convert exfat_find_empty_entry() to use dentry cache
>   exfat: remove unused functions
>   exfat: do not sync parent dir if just update timestamp
>   exfat: remove duplicate update parent dir
> 
>  fs/exfat/dir.c      | 288 ++++++++++++++++++------------------
>  fs/exfat/exfat_fs.h |  25 ++--
>  fs/exfat/inode.c    |   2 +-
>  fs/exfat/namei.c    | 352 +++++++++++++++++---------------------------
>  4 files changed, 291 insertions(+), 376 deletions(-)
> 
> --
> 2.34.1




