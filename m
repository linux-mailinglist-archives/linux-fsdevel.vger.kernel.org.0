Return-Path: <linux-fsdevel+bounces-24742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F19447FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C61C24632
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F598187FFB;
	Thu,  1 Aug 2024 09:14:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D71170A3B;
	Thu,  1 Aug 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503643; cv=none; b=a3xQgMQumwRHi7ccFBRbM0TH7qaArauNZi2DX4TLi1uiOtzQXq4RKGsWK+14zsRHTDe6Qj3TAzHmIWlM8kU4jP5Mvs6zOfDVT/Iut4iRaEqVuEK1zlnWDdcot1Pa4pfqjq9cp7WFeBVYyyi5UM/g4ZERmVvAybA4EWnRuHiXpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503643; c=relaxed/simple;
	bh=Huk9WOkumH8pZG1eFJE2P3LnQQp0668fi6xSMVsYEkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/hyW+x/tL0aDHMXwgHK6xWiPUMNGR/GEQT7TvolHnBvS2edtysQ4XxQZ9QiyiYYaML7yEnQlPZwnmvYnghud+CirUFlah6VxIGbcgAKMIKqlx461gtb7LChhyBj6H7uiUw02cIhd8Xw4pJ5r5qbopCXbLsmPN1L/x0in4BOTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4715U2QJ010067;
	Thu, 1 Aug 2024 02:13:47 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mv61cub2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 01 Aug 2024 02:13:47 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 02:13:46 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 02:13:44 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for the filemap
Date: Thu, 1 Aug 2024 17:13:43 +0800
Message-ID: <20240801091343.3282053-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801081224.1252836-1-lizhi.xu@windriver.com>
References: <20240801081224.1252836-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mFvhJLD3O1YDjjqz8rdvAt6xCohf7Cmm
X-Proofpoint-ORIG-GUID: mFvhJLD3O1YDjjqz8rdvAt6xCohf7Cmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408010056

On Thu, 1 Aug 2024 16:12:24 +0800, Lizhi Xu wrote:
> > > > > syzbot report KMSAN: uninit-value in pick_link, this is because the
> > > > > corresponding folio was not found from the mapping, and the memory was
> > > > > not initialized when allocating a new folio for the filemap.
> > > > >
> > > > > To avoid the occurrence of kmsan report uninit-value, initialize the
> > > > > newly allocated folio memory to 0.
> > > >
> > > > NAK.
> > > >
> > > > You are papering over the real bug here.
> > > Did you see the splat? I think you didn't see that.
> > 
> > Sigh...  It is stepping into uninitialized data in pick_link(), and by
> > the look of traces it's been created by page_get_link().
> > 
> > What page_get_link() does is reading from page cache of symlink;
> > the contents should have come from ->read_folio() (if it's really
> > a symlink on squashfs, that would be squashfs_symlink_read_folio()).
> > 
> > Uninit might have happened if
> > 	* ->read_folio() hadn't been called at all (which is an obvios
> > bug - that's what should've read the symlink contents) or
> > 	* ->read_folio() had been called, it failed and yet we are
> > still trying to use the resulting page.  Again, an obvious bug - if
> > trying to read fails, we should _not_ use the results or leave it
> > in page cache for subsequent callers.
> > 	* ->read_folio() had been called, claimed to have succeeded and
> > yet it had left something in range 0..inode->i_size-1 uninitialized.
> > Again, a bug, this time in ->read_folio() instance.
> read_folio, have you noticed that the file value was passed to read_folio is NULL? 
> fs/namei.c
> const char *page_get_link(struct dentry *dentry, struct inode *inode
> ...
> 5272  read_mapping_page(mapping, 0, NULL);
> 
> So, Therefore, no matter what, the value of folio will not be initialized by file
> in read_folio. 
Oh, in read_folio, it will use mapping->host to init folio, I will research
why not init in do_read_cache_folio.

--
Lizhi

