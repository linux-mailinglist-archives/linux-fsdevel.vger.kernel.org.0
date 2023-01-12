Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D44666CB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 09:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbjALIoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 03:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbjALIng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:43:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551C3DBF7;
        Thu, 12 Jan 2023 00:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhzoXJd8QLSlSJS1DqxUvN7zM6XlenXjXRqQOg3se84=; b=B6HF5bEx6iqEqIAEHf2KINLTzb
        kw9Iebu5wNTWnbBag/0Id0Fod+g8oVrFealLYYHlZkdcuro4LzIyMwsxEsEgwqA64cHt6gBru07Wi
        N5Sr26uvf7bx7QE8WLvoRr/le712HeIsmQzOEuOgkKzM18YXEwm51xjUI1tjei3SxiNxUF9Arg5aM
        v7mkqZfg+74uPpIeA+khsFr6LUG8fYSZQJzK6dRbYkoG80/bhxy19B+J0+q3eiUXZvDyhBWZbGOna
        ixysnyYIGf74Otb4knAoAeVYO+V1/l5hePKQmFMLEAcLIcpVIAhFbmWQkd5YR4UxIuCe8u3y32R+Z
        sxkp/04A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFt9B-00EALM-Ff; Thu, 12 Jan 2023 08:41:17 +0000
Date:   Thu, 12 Jan 2023 00:41:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y7/HrZCARD9zRvEe@infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y72DK9XuaJfN+ecj@infradead.org>
 <Y78PunroeYbv2qgH@casper.infradead.org>
 <20230111205241.GA360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111205241.GA360264@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 07:52:41AM +1100, Dave Chinner wrote:
> Exposing internal implementation details in the API
> that is supposed to abstract away the internal implementation
> details from users doesn't seem like a great idea to me.

While I somewhat agree with the concern of leaking the xarray
internals, at least they are clearly documented and easy to find..

> Exactly what are we trying to fix here?  Do we really need to punch
> a hole through the abstraction layers like this just to remove half
> a dozen lines of -slow path- context specific error handling from a
> single caller?

While the current code (which is getting worse with your fix) leaks
completely undocumented and internal decision making.  So what this
fixes is a real leak of internatal logic inside of __filemap_get_folio
into the callers.

So as far as I'm concerned we really do need the helper, and anyone
using !GFP_CREATE or FGP_NOWAIT should be using it.  The only question
to me is if exposing the xarray internals is worth it vs the
less optimal calling conventions of needing an extra argument for
the error code.
