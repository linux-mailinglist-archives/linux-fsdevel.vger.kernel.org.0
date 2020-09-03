Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A625C2A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgICOan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgICO1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:27:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70147C061245;
        Thu,  3 Sep 2020 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNFw25jVlcdo2HOeyRWdNvqHRP3XxNhZ9gh8UR9BP6c=; b=V3e5uAFr2pYrWuAxT18Z6Ya4Mt
        AbeWXjbfVj6/jUD82K1+56y+g7jOzYnahDWdf04czK+ngUIoEf1Dwymk6RuN634VptJHYaKxPbimj
        Zc8rwOLhZD01rAPBVOcpOgr5+zad9skPXEfa3fpHiyyF/199sF0MxE+Q5RPs7BbEeDQChAH+elQV6
        w51gPFqkVNEGqsGO/xrQ2Ywe7Qw+mzCvgnovuF3NrdkDsyDtxJye4oulORgfusPZw1FxQZ4Twubo5
        Khxy6HJUi5Rkh6fGV3Hw3j/y9v7Z0N2EA/4SyaxDXS9vSXPOcY+hqIOkUk/cAcQ3oLwTEy5mqBrX9
        lzNEc6Ww==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDqCz-0004uM-1q; Thu, 03 Sep 2020 14:27:25 +0000
Date:   Thu, 3 Sep 2020 15:27:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2 list <ocfs2-devel@oss.oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: Broken O_{D,}SYNC behavior with FICLONE*?
Message-ID: <20200903142724.GA18478@infradead.org>
References: <20200903035225.GJ6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903035225.GJ6090@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:52:25PM -0700, Darrick J. Wong wrote:
> Hi,
> 
> I have a question for everyone-- do FICLONE and FICLONERANGE count as a
> "write operation" for the purposes of reasoning about O_SYNC and
> O_DSYNC?

They aren't really write operations in the traditional sense as they
only change metadata.  Then again the metadata is all about the file
content, so we'd probaby err on the safe side by including them in the
write operations umbrella term.
