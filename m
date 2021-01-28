Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7330783C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhA1Ogl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhA1Ogk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:36:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC9C061574;
        Thu, 28 Jan 2021 06:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMiQNUP0n0G3ycNQCqSn5IKupnPYtgpP83gkRapKZ50=; b=PMiKegf7nFbAFT7A/yr6S9Of3X
        l/Tk50wVtTWJIGj4Q0IZ4rjAIV73GsoECACwNWr7h+YhkNRSbvUDq4F/bJfnzHrhk3nb+qcnXNebO
        VGNP8wNtHM3gxw1q7/fwbpEVTUAobA4QCthEcpZMN1r8WVhyw78OmaOiAgUzI3pBeo++t+hGOdeij
        S29uWoYTnNSWbrAK6BFR+Jvln3HWZH4BQa6UgyrFErixYBrarbew1NlgBgMH3xSGDf266CO9Rt/xU
        Vr0k35uDqf3Z80jANglxmxSlQIqrKLg3snXIYipVpU4d87PF54WogWf2ZA733U//kjiRJjjrLAiKo
        96Cg1ipg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l58Om-008ZaH-KK; Thu, 28 Jan 2021 14:35:54 +0000
Date:   Thu, 28 Jan 2021 14:35:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210128143552.GA2042235@infradead.org>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128141713.25223-2-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	uint cmds, type;
> +	struct super_block *sb = NULL;

I don't think sb needs the NULL initialization.

> +	struct path path, *pathp = NULL;
> +	struct path mountpath;
> +	bool excl = false, thawed = false;
> +	int ret;
> +
> +	cmds = cmd >> SUBCMDSHIFT;
> +	type = cmd & SUBCMDMASK;

Personal pet peeve: it would be nice to just initialize cmds and
type on their declaration line, or while we're at it declutter
this a bit and remove the separate cmds variable:

	unsigned int type = cmd & SUBCMDMASK;


	cmd >>= SUBCMDSHIFT;

> +	/*
> +	 * Path for quotaon has to be resolved before grabbing superblock
> +	 * because that gets s_umount sem which is also possibly needed by path
> +	 * resolution (think about autofs) and thus deadlocks could arise.
> +	 */
> +	if (cmds == Q_QUOTAON) {
> +		ret = user_path_at(AT_FDCWD, addr,
> +				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &path);
> +		if (ret)
> +			pathp = ERR_PTR(ret);
> +		else
> +			pathp = &path;
> +	}
> +
> +	ret = user_path_at(AT_FDCWD, mountpoint,
> +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
> +	if (ret)
> +		goto out;

I don't think we need two path lookups here, we can path the same path
to the command for quotaon.


> +	if (quotactl_cmd_onoff(cmds)) {
> +		excl = true;
> +		thawed = true;
> +	} else if (quotactl_cmd_write(cmds)) {
> +		thawed = true;
> +	}
> +
> +	if (thawed) {
> +		ret = mnt_want_write(mountpath.mnt);
> +		if (ret)
> +			goto out1;
> +	}
> +
> +	sb = mountpath.dentry->d_inode->i_sb;
> +
> +	if (excl)
> +		down_write(&sb->s_umount);
> +	else
> +		down_read(&sb->s_umount);

Given how cheap quotactl_cmd_onoff and quotactl_cmd_write are we
could probably simplify this down do:

	if (quotactl_cmd_write(cmd)) {
		ret = mnt_want_write(path.mnt);
		if (ret)
			goto out1;
	}
	if (quotactl_cmd_onoff(cmd))
		down_write(&sb->s_umount);
	else
		down_read(&sb->s_umount);

and duplicate the checks after the do_quotactl call.
