Return-Path: <linux-fsdevel+bounces-21582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B391F90616F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 03:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C0B21FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997B17BBB;
	Thu, 13 Jun 2024 01:53:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C57F9;
	Thu, 13 Jun 2024 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243600; cv=none; b=g4E+HSpf60PRCUYPE+1FSpj7zpWBaiCWmAcp6AQN2PO1gG+st86L0yufA8cH3fwEZUi1OlX90244MxAosD30naCQNQyrznY4ew+MEkrOTeeTeLSaqhrLtpE79clsrMDEtgUM2LL3Ak9299VyZSwTrc9yELaGlqq0qYFsSXcazGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243600; c=relaxed/simple;
	bh=08mouqv6dBOKj5PdWDUTOovkDkaA1fRX+axPfgiUQWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF+2jA1v4ofLLwhkL24Xy/zL/RM24YW/cq4vbJRnNhT940ecJSqO41NY9V8dMerYh+pjnye/v1orxq9w9Szg0+Sw+nw0s4Wie1ohoqHVmhuG8LjuMhAHSjNanqy07gZnlnGw8KZHdBw1ZPAb6Co2vaW66FdQE4RNNf9QG3CA4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W051y6q1czPqTg;
	Thu, 13 Jun 2024 09:49:42 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id ABD9A18007E;
	Thu, 13 Jun 2024 09:53:08 +0800 (CST)
Received: from localhost (10.175.127.227) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 09:53:08 +0800
Date: Thu, 13 Jun 2024 10:04:53 +0800
From: Long Li <leo.lilong@huawei.com>
To: "Darrick J. Wong" <djwong@kernel.org>, John Garry
	<john.g.garry@oracle.com>
CC: <david@fromorbit.com>, <hch@lst.de>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <chandan.babu@oracle.com>,
	<willy@infradead.org>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <jbongio@google.com>, <ojaswin@linux.ibm.com>,
	<ritesh.list@gmail.com>, <mcgrof@kernel.org>, <p.raghav@samsung.com>,
	<linux-xfs@vger.kernel.org>, <catherine.hoang@oracle.com>
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240613020453.GA2926743@ceph-admin>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <20240612021058.GA729527@ceph-admin>
 <82269717-ab49-4a02-aaad-e25a01f15768@oracle.com>
 <20240612154342.GC2764752@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240612154342.GC2764752@frogsfrogsfrogs>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500009.china.huawei.com (7.221.188.199)

On Wed, Jun 12, 2024 at 08:43:42AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 12, 2024 at 07:55:31AM +0100, John Garry wrote:
> > On 12/06/2024 03:10, Long Li wrote:
> > > On Mon, Apr 29, 2024 at 05:47:33PM +0000, John Garry wrote:
> > > > From: "Darrick J. Wong"<djwong@kernel.org>
> > > > 
> > > > Add a new inode flag to require that all file data extent mappings must
> > > > be aligned (both the file offset range and the allocated space itself)
> > > > to the extent size hint.  Having a separate COW extent size hint is no
> > > > longer allowed.
> > > > 
> > > > The goal here is to enable sysadmins and users to mandate that all space
> > > > mappings in a file must have a startoff/blockcount that are aligned to
> > > > (say) a 2MB alignment and that the startblock/blockcount will follow the
> > > > same alignment.
> > > > 
> > > > jpg: Enforce extsize is a power-of-2 and aligned with afgsize + stripe
> > > >       alignment for forcealign
> > > > Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
> > > > Co-developed-by: John Garry<john.g.garry@oracle.com>
> > > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > > > ---
> > > >   fs/xfs/libxfs/xfs_format.h    |  6 ++++-
> > > >   fs/xfs/libxfs/xfs_inode_buf.c | 50 +++++++++++++++++++++++++++++++++++
> > > >   fs/xfs/libxfs/xfs_inode_buf.h |  3 +++
> > > >   fs/xfs/libxfs/xfs_sb.c        |  2 ++
> > > >   fs/xfs/xfs_inode.c            | 12 +++++++++
> > > >   fs/xfs/xfs_inode.h            |  2 +-
> > > >   fs/xfs/xfs_ioctl.c            | 34 +++++++++++++++++++++++-
> > > >   fs/xfs/xfs_mount.h            |  2 ++
> > > >   fs/xfs/xfs_super.c            |  4 +++
> > > >   include/uapi/linux/fs.h       |  2 ++
> > > >   10 files changed, 114 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> > > > index 2b2f9050fbfb..4dd295b047f8 100644
> > > > --- a/fs/xfs/libxfs/xfs_format.h
> > > > +++ b/fs/xfs/libxfs/xfs_format.h
> > > > @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
> > > >   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
> > > >   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
> > > >   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> > > > +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
> > > Hi, John
> > > 
> > > You know I've been using and testing your atomic writes patch series recently,
> > > and I'm particularly interested in the changes to the on-disk format. I noticed
> > > that XFS_SB_FEAT_RO_COMPAT_FORCEALIGN uses bit 30 instead of bit 4, which would
> > > be the next available bit in sequence.
> > > 
> > > I'm wondering if using bit 30 is just a temporary solution to avoid conflicts,
> > > and if the plan is to eventually use bits sequentially, for example, using bit 4?
> > > I'm looking forward to your explanation.
> > 
> > I really don't know. I'm looking through the history and it has been like
> > that this the start of my source control records.
> > 
> > Maybe it was a copy-and-paste error from XFS_FEAT_FORCEALIGN, whose value
> > has changed since.
> > 
> > Anyway, I'll ask a bit more internally, and I'll look to change to (1 << 4)
> > if ok.
> 
> I tend to use upper bits for ondisk features that are still under
> development so that (a) there won't be collisions with other features
> getting merged and (b) after the feature I'm working on gets merged, any
> old fs images in my zoo will no longer mount.
> 

I get it, thank you very much for your response.

