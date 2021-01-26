Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19936303ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404788AbhAZNgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 08:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404817AbhAZNgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:36:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CB9C0611C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DdoWWj+OR2RUxvl/HiHdpv/96nfXkBt9+md+RxXslZk=; b=O++offQw8+5Ln73s8HS/jxxWwQ
        yuxTRE78DSLc7W5O58jbaX5wGJ5WX9PDN23fEZikMN5F3NUqA+LLYowoBC30URq6wK/3bmj91kSk1
        4hD+Hb9ftW1vGvVQBbDHDdkcC5zMA6fUhcg5MSuC0Luh+VbnU4K6zEOpMtNs9Qml5bfdrVxCbkVIU
        Xu0EKCs5j8B+MF+PGyjwr60ZrVzw3Q8rhlbY/7uwr3OJa3FOMaDuu9quKMXI77sHjirwFQVFxR4Sf
        Nk/8iXSjTSGLd1ZL5bNDm7nIR0wGu+IGkK/AjTjj0HiW9gISItFOAjFvHd/A7P866Lh2QVCI7Bctw
        LW5szJCA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4OTu-005eqI-E6; Tue, 26 Jan 2021 13:34:19 +0000
Date:   Tue, 26 Jan 2021 13:34:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210126133406.GA1346375@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
 <20210122171658.GA237653@infradead.org>
 <20210125083854.GB31738@pengutronix.de>
 <20210125154507.GH1175@quack2.suse.cz>
 <20210125204249.GA1103662@infradead.org>
 <20210126131752.GB10966@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126131752.GB10966@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:17:52PM +0100, Jan Kara wrote:
> Well, I don't think that "wait until unfrozen" is that strange e.g. for
> Q_SETQUOTA - it behaves like setxattr() or any other filesystem
> modification operation. And IMO it is desirable that filesystem freezing is
> transparent for operations like these. For stuff like Q_QUOTAON, I agree
> that returning EBUSY makes sense but then I'm not convinced it's really
> simpler or more useful behavior...

If we want it to behave like other syscalls we'll just need to throw in
a mnt_want_write/mnt_drop_write pair.  Than it behaves exactly like other
syscalls.
