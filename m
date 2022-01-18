Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E37491E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 04:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347579AbiARDr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 22:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348788AbiARDpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:45:49 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF475C03DD8C;
        Mon, 17 Jan 2022 19:17:21 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9ezh-002iFx-FH; Tue, 18 Jan 2022 03:17:13 +0000
Date:   Tue, 18 Jan 2022 03:17:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118030041.GB59729@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 02:00:41PM +1100, Dave Chinner wrote:
> > IOW, how far is xfs_inode_mark_reclaimable() from being callable in RCU
> > callback context?
> 
> AIUI, not very close at all,
> 
> I'm pretty sure we can't put it under RCU callback context at all
> because xfs_fs_destroy_inode() can take sleeping locks, perform
> transactions, do IO, run rcu_read_lock() critical sections, etc.
> This means that needs to run an a full task context and so can't run
> from RCU callback context at all.

Umm...  AFAICS, this
	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
	spin_lock(&pag->pag_ici_lock);
	spin_lock(&ip->i_flags_lock);

	trace_xfs_inode_set_reclaimable(ip);
	ip->i_flags &= ~(XFS_NEED_INACTIVE | XFS_INACTIVATING);
	ip->i_flags |= XFS_IRECLAIMABLE;
	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
	XFS_ICI_RECLAIM_TAG);

	spin_unlock(&ip->i_flags_lock);
	spin_unlock(&pag->pag_ici_lock);
	xfs_perag_put(pag);
in the end of xfs_inodegc_set_reclaimable() could go into ->free_inode()
just fine.  It's xfs_inodegc_queue() I'm not sure about - the part
about flush_work() in there...

I'm not familiar with that code; could you point me towards some
docs/old postings/braindump/whatnot?
