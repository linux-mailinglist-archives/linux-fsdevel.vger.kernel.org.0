Return-Path: <linux-fsdevel+bounces-32540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 800719A937F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 00:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE81B220B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E61FDFAF;
	Mon, 21 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OarAQFyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18C1E0DE9
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550598; cv=none; b=E34ZQytY2+jUTD1UsbXj36G5SXC+iyBYnTF7otGmhvv+S7ak7t/i+JBC/0W8DYnmt/NoCthXev63P4ohT2aYtOhSthV1cPTbEfv88JZoCuCFTfyCCC5V6F8+WEk0FW4+YoLhv5BNrQxTLUJlYcnzfuvEif2WkQ4F7IidV44TpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550598; c=relaxed/simple;
	bh=xUquGqeeCI6keZ0P5afO0oD7T7EAVeLsVrpc+skbuRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMX3T/8OMQJtdistUhAKhKymSHxIBiLxvT4lh+WsHsL7Lv57dsRBnEywkcWIVps2PYcBa2h+Zb2MY39U4vwoWsc8rIo9l9f1wTAjhO8zOz+8ZzoyGh16HB7BVy2P1Hji/bZw7NbghSItX8fFcgMrOFDKXSDX9wQvR/jU9fzgaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OarAQFyL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Si/mtlbKR1W17i43fi0Brb28YOzgyUf/0vcjcHKFS+I=; b=OarAQFyLsixS1QRQ2NGftayl+G
	qLNjii2VFQEZn3qWpyheLVqMzvBbVn0HDmj91xTuTy8xSOY5VSwgvKV5GPMjAsokn4kGC4HYRpDKu
	N6Vr7w2MQwXqHHzYkCuspx4wsnaybGAbQA0mDMdCO2ZjhgtfY+qKw3cCqp3aeCLeLrNh3ijx0Ps8b
	sAI6QnH/KtRko4RLEgrrscrIR/ZipYdI2+FtwmnddQw5vhMqBeWt+YnsvDf6YKpduVu5ZKld5OVfw
	eqVDFgKTfTWIBQCxdvtky1fE+K1aIv7ZLhIV6sYsH+gwuhddSFI3Bz0iOHXpBT+agzz6x2r2+1XSN
	lgmgmmZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t317J-000000063Mi-30bm;
	Mon, 21 Oct 2024 22:43:13 +0000
Date: Mon, 21 Oct 2024 23:43:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021224313.GC1350452@ZenIV>
References: <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
 <20241021170910.GB1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021170910.GB1350452@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 21, 2024 at 06:09:10PM +0100, Al Viro wrote:
> On Mon, Oct 21, 2024 at 02:39:58PM +0200, Christian Brauner wrote:
> 
> > > See #getname.fixup; on top of #base.getname and IMO worth folding into it.
> > 
> > Yes, please fold so I can rebase my series on top of it.
> 
> OK...  What I have is #base.getname-fixed, with two commits - trivial
> "teach filename_lookup() to accept NULL" and introducing getname_maybe_null(),
> with fix folded in.
> 
> #work.xattr2 and #work.statx2 are on top of that.

BTW, speaking of statx() - I would rather lift the call of cp_statx() out
of do_statx() and do_statx_fd() into the callers.  Yes, that needs making
it non-static, due to io_uring; not a problem, IMO - it fits into the
"how do we copy internal objects to userland ones" family of helpers.

Another fun issue: for by-pathname case vfs_fstatat() ends up hitting
the same vfs_statx_path() as statx(2); however, for by-descriptor case
they do vfs_getattr() and vfs_statx_path() resp.

The difference is, vfs_statx_path() has
        if (request_mask & STATX_MNT_ID_UNIQUE) {
                stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
                stat->result_mask |= STATX_MNT_ID_UNIQUE;
        } else {
                stat->mnt_id = real_mount(path->mnt)->mnt_id;
                stat->result_mask |= STATX_MNT_ID;
        }

        if (path_mounted(path))
                stat->attributes |= STATX_ATTR_MOUNT_ROOT;
        stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;

        /*
         * If this is a block device inode, override the filesystem
         * attributes with the block device specific parameters that need to be
         * obtained from the bdev backing inode.
         */
        if (S_ISBLK(stat->mode))
                bdev_statx(path, stat, request_mask);
done after vfs_getattr().  Questions:

1) why is STATX_MNT_ID set without checking if it's in the mask passed to
the damn thing?

2) why, in the name of everything unholy, does statx() on /dev/weird_shite
trigger modprobe on that thing?  Without even a permission check on it...

