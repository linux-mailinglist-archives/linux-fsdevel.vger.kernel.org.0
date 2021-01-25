Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CE302CDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 21:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbhAYUol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 15:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbhAYUoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:44:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50144C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=50rdGGRcUaSkPpis7lUfu3LrVnBfoRkaHShYQAQljW4=; b=rNyfrzJJFlsslQGGX976kUrj14
        qY5AVfDFICTZjzTsCoZ+4TO735fTLbAkzmOdCHo/KD2vt65u/osgVXyZ0DOOGv4mkGv9xyHfQXx8j
        PTgGQ3jlJPKhk4cNtju5TmP4PVpeEKNjEJeyRH1WD9hQC/AKp8y9BgH1uUorzbFRGiMwGrWaycJI/
        q5Hr/5PcoHLYfc2na36Wo3deya2bFao1a3cOU+F3fvgzlu1fAddpTT+JYJjqXkzcnlcYpZ3UQL2vw
        CjbPG9gIMd9yhih2uo16nLMCI9lrX1hRDG+akVoxmLE5q9QUnYK9uABcW0QyurnmFX4n4poy6L//a
        W15JiESg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l48hF-004ddP-FH; Mon, 25 Jan 2021 20:42:54 +0000
Date:   Mon, 25 Jan 2021 20:42:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210125204249.GA1103662@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125154507.GH1175@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:45:07PM +0100, Jan Kara wrote:
> > What do you mean by "take"? Take the superblock as an argument to
> > quotactl_sb() or take a reference to the superblock?
> > Sorry, I don't really get where you aiming at.
> 
> I think Christoph was pointing at the fact it is suboptimal to search for
> superblock by device number when you already have a pointer to it.  And I
> guess he was suggesting we could pass 'sb' pointer to quotactl_sb() when we
> already have it. Although to be honest, I'm not sure how Christoph imagines
> the refactoring of user_get_super() he mentions - when we have a path
> looked up through user_path(), that pins the superblock the path is on so
> it cannot be unmounted. So perhaps quotactl_sb() can done like:

I don't think we need a quotactl_sb at all, do_quotactl is in fact a
pretty good abstraction as-is.

For the path based one we just need to factor out a little helper
to set excl and thaw and then call it like:

	sb = path.dentry->d_inode->i_sb;

	if (excl)
		down_write(&sb->s_umount);
	else
		down_read(&sb->s_umount);
	if (thawed && sb->s_writers.frozen != SB_UNFROZEN)
		ret = -EBUSY;
	else
		ret = do_quotactl(sb, type, cmds, id, addr, &path);
	if (excl)
		up_write(&sb->s_umount);
	else
		up_read(&sb->s_umount);

as there is no good reason to bring over the somewhat strange wait until
unfrozen semantics to a new syscall.
