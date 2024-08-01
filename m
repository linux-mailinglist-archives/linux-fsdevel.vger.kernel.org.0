Return-Path: <linux-fsdevel+bounces-24741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AC944711
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B928285CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D316EC16;
	Thu,  1 Aug 2024 08:52:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19082161326;
	Thu,  1 Aug 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502344; cv=none; b=Dr0KyEnCqLykec4BLZEZtCuuGMNdsdUjeNNlc3Ql2Fx2kr31EeZPuob0RGxDVLErVJM/poxSP2fz30MIGIFSJhdSabCU0LznNTAiNsazjKDnZgVV1IHbqZsvNPBBFnGtYwkmnxLOrVMI62eSUMU8Tzdc+uM8aueEaczFQvZjwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502344; c=relaxed/simple;
	bh=pUi9pGHk3hkbw6N8AbNReAqAjSKpToNv3GdDcSz0WtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiB2F3rnIRdUaI3ME28fMMY7c4UuZ8c/nwVb/X+yau8TjjLORUC8/z7sgtqaOqUGi1JcrjznONKdPwPLbZAXWpAKQ4H01geoNwB9SD8HZ6MwiiWAmyBYM5XSr9sEL11hzJmH8MhUpncrQ1maIS3cJsA5UIMKVa9MC0MKifPmhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4715sK0d016242;
	Thu, 1 Aug 2024 01:12:28 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40n0dfvmky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 01 Aug 2024 01:12:28 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:12:27 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 01:12:25 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for the filemap
Date: Thu, 1 Aug 2024 16:12:24 +0800
Message-ID: <20240801081224.1252836-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801071016.GN5334@ZenIV>
References: <20240801071016.GN5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aeu4VXTKAxAVyBGFas6fMwPTGQQDqb18
X-Proofpoint-ORIG-GUID: aeu4VXTKAxAVyBGFas6fMwPTGQQDqb18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408010048

On Thu, 1 Aug 2024 08:10:16 +0100, Al Viro wrote:
> > > > syzbot report KMSAN: uninit-value in pick_link, this is because the
> > > > corresponding folio was not found from the mapping, and the memory was
> > > > not initialized when allocating a new folio for the filemap.
> > > >
> > > > To avoid the occurrence of kmsan report uninit-value, initialize the
> > > > newly allocated folio memory to 0.
> > >
> > > NAK.
> > >
> > > You are papering over the real bug here.
> > Did you see the splat? I think you didn't see that.
> 
> Sigh...  It is stepping into uninitialized data in pick_link(), and by
> the look of traces it's been created by page_get_link().
> 
> What page_get_link() does is reading from page cache of symlink;
> the contents should have come from ->read_folio() (if it's really
> a symlink on squashfs, that would be squashfs_symlink_read_folio()).
> 
> Uninit might have happened if
> 	* ->read_folio() hadn't been called at all (which is an obvios
> bug - that's what should've read the symlink contents) or
> 	* ->read_folio() had been called, it failed and yet we are
> still trying to use the resulting page.  Again, an obvious bug - if
> trying to read fails, we should _not_ use the results or leave it
> in page cache for subsequent callers.
> 	* ->read_folio() had been called, claimed to have succeeded and
> yet it had left something in range 0..inode->i_size-1 uninitialized.
> Again, a bug, this time in ->read_folio() instance.
read_folio, have you noticed that the file value was passed to read_folio is NULL? 
fs/namei.c
const char *page_get_link(struct dentry *dentry, struct inode *inode
...
5272  read_mapping_page(mapping, 0, NULL);

So, Therefore, no matter what, the value of folio will not be initialized by file
in read_folio. 

