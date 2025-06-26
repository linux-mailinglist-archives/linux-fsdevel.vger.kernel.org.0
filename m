Return-Path: <linux-fsdevel+bounces-53049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77DAE9491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 05:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1623D1C25141
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B51C4A24;
	Thu, 26 Jun 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="syGYz0q1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACD282EB;
	Thu, 26 Jun 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908860; cv=none; b=Omn5LSUjIKtw+L8R6YEOrW8rY6fScp1l9iYukyDmYIbDwccSemgTG7rx9+vEWN64xYQcgvJEgtHlxBW2XeQ0CQ/m49OjX2k7CVCRv7A8eW+JA4FFftFprEs9PnxeK8eM4TQ8VVPVE9CggdHHvA1vYIREe1fJW9lUyOrkrhMi16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908860; c=relaxed/simple;
	bh=JdFL+DurqCH71s/6ds1Pl9Z4B1ZcvOyBExK7IPWkSxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaRF+n3M7Bl96GA/Qe5Lg2oShX1fvA/rbLU8kTEPBAWnWNeQmi6JVRbz2FdVz7DPUUIrICfxojb90HalFaCm5lndotAjfmnpN/33TXFmQtnNLlJJAOyGVxkYfMvMdwGhYP/9TIoa6VVP1pDoeF4potxiKgNVvguLsjSaE38s04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=syGYz0q1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xjFDA2GkJiXpWNrvkJ64etUEx2N5io25QFzgQ0wijOM=; b=syGYz0q177vJXqMXDy0hAzhc+a
	TLcaB0r9spkI4eQJi/VE79xl8AMD/rXV7mfvqSp0SVKra/nqqxpxox4bTAJZTHklFbaimO8JBSFmj
	bdbp4r5HfV1lxPaCPTR2Q1QUbFCvllySeDeoGzzVxxQlE6zMTqjPRTEuRxmVv33yRS+LIMLuWMZMc
	8DMCgSgCGQq4wxRuTgVKBmZ/9Dma+0m1k68mVD1T9TNbrf3w4uGpU3qgNlmVuKLjqo+7Jlr/HjmvW
	D9BUka2OpLEbCnjfHZTQO2k5v9zje8ikXEW2YiSBOk2si4DlLZQ1SHij358LNWiP8ndX/rFz4l/h5
	SzbGEOnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUdNL-0000000B2G8-0WRT;
	Thu, 26 Jun 2025 03:34:11 +0000
Date: Thu, 26 Jun 2025 04:34:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>, ocfs2-devel@lists.linux.dev,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ocfs2: update d_splice_alias() return code checking
Message-ID: <20250626033411.GU1880847@ZenIV>
References: <d689279f-03ed-4f9b-8fde-713b2431f303@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d689279f-03ed-4f9b-8fde-713b2431f303@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 26, 2025 at 11:14:59AM +0900, Tetsuo Handa wrote:

> But when commit b5ae6b15bd73 ("merge d_materialise_unique() into
> d_splice_alias()") was merged into v3.19-rc1, d_splice_alias() started
> returning -ELOOP as one of ERR_PTR values.
> 
> As a result, when syzkaller mounts a crafted ocfs2 filesystem image that
> hits d_splice_alias() == -ELOOP case from ocfs2_lookup(), ocfs2_lookup()
> fails to handle -ELOOP case and generic_shutdown_super() hits "VFS: Busy
> inodes after unmount" message.
> 
> Don't call ocfs2_dentry_attach_lock() nor ocfs2_dentry_attach_gen()
> when d_splice_alias() returned -ELOOP.
> 
> Reported-by: syzbot <syzbot+1134d3a5b062e9665a7a@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=1134d3a5b062e9665a7a
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch wants review from maintainers. I'm not familiar with this change.

Not the right fix.  If nothing else, -ELOOP is not the only possible value
there.

This
                status = ocfs2_dentry_attach_lock(dentry, inode,
                                                  OCFS2_I(dir)->ip_blkno);
                if (status) {
                        mlog_errno(status);
                        ret = ERR_PTR(status);
                        goto bail_unlock;
                }
looks like pretty obvious leak in its own right?  What's more, on IS_ERR(ret)
we should stop playing silly buggers and just return the damn error.

So basically
        ret = d_splice_alias(inode, dentry);
	if (IS_ERR(ret))
		goto bail_unlock;
	if (inode) {
		if (ret)
			dentry = ret;
                status = ocfs2_dentry_attach_lock(dentry, inode,
                                                  OCFS2_I(dir)->ip_blkno);
		if (unlikely(status)) {
			if (ret)
				dput(ret);
			ret = ERR_PTR(status);
		}
	} else {
                ocfs2_dentry_attach_gen(dentry);
	}
bail_unlock:

