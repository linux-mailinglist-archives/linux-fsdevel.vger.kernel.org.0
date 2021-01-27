Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCA3060F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 17:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhA0Q1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhA0Q1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:27:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C78C061574;
        Wed, 27 Jan 2021 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XeayQu8Z7eVgXskFL8EGTZVPJCUNtquB2mc3XL06JbM=; b=Qw9sgKIECO6GIPDIPG6CIQTiA9
        4fIDaVX2zjwK56xMBXxpb0Zh+vV210bcNgERKA7qc5xiNec8aMhzm2BA922Mkrxh7BdPLHiUD05Vd
        PL0BUHM9SksSjCfj38UwYk5xcrxQOdwsGCaxivj8l0RpP1q3bphG0DeQWGGKCef9xrjDas8PQk1N5
        +XuDEbz5a7AjC2iNcjv4vlXoQL1QMpedmt0NJIyzXCusO/ziVTbWnrmMeOl9/Fhp4h7OntcP7dmNA
        8qnkj6DPLwcJzNjz8XKaYuKGPv73/fGA3ZR43greZSL0KUe+lUuLPxFXPhIzDAkOBNOlLhR/0faSq
        9JiAiw0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4ndk-007ES0-SR; Wed, 27 Jan 2021 16:25:58 +0000
Date:   Wed, 27 Jan 2021 16:25:56 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210127162556.GA1721964@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210126104557.GB28722@pengutronix.de>
 <20210127144646.GB13717@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127144646.GB13717@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:46:46PM +0100, Jan Kara wrote:
> In a puristic world they'd be 9 different syscalls ... or somewhat less
> because Q_GETNEXTQUOTA is a superset of Q_GETQUOTA, we could drop Q_SYNC
> and Q_GETFMT because they have dubious value these days so we'd be left
> with 6. I don't have a strong opinion whether 6 syscalls are worth the
> cleanliness or whether we should go with just one new quotactl_path()
> syscall. I've CCed linux-api in case other people have opinion.
> 
> Anyway, even if we go with single quotactl_path() syscall we should remove
> the duplication between VFS and XFS quotactls when we are creating a new
> syscall. Thoughts?

I thunk the multiplexer is just fine.  We don't really need Q_SYNC
for a new syscall.  For XFS vs classic VFS quota we probably don't
need to duplicate the two data structure, but we need to make sure we
catch the superset of the information if we want to disable the old
ones.

So I suspect just supporting evrything excpt for the global Q_SYNC
and reusing do_quotactl as-is is the most maintainable and easiest
to understand way forward.
