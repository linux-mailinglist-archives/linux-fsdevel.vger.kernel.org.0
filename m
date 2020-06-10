Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9D1F5741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgFJPGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJPGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:06:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6CC03E96B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZDjk3L6WcZzdrntDgNva3FmGjCKYaBSvu1VEO2v/KM=; b=q7eBynAbllL7QhFUYbufsZSt/s
        fZ39qf98PJ+Svge06z03WOBbqoTneEFrNzlQ4o1bw1C8YtC21gdA2TplbJJjuFaR67g4Ol105JvpV
        trAtaYpC1w4dTbp9U9U3PrT9bbTwdrdAbaKJvKEhdOCZE46+eucj9vh5XsIow32HSYEglLs8RhSlw
        8oJ+NWXimLMjBLW21gHxnWc3iLqyoObzA47zzzyW4IlaFAuF9cOHvHw+GBOuiukQI5hMEFwgLN0cE
        Uotrwh3nkgFw382o0nHj/80oJ1eXTurGqUct4c8NfyHBWM03T84VPnLw5UvOf9NLce8JLKe4wbWES
        7b//lc4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj2Iw-0006E9-9P; Wed, 10 Jun 2020 15:06:14 +0000
Date:   Wed, 10 Jun 2020 08:06:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Martijn Coenen <maco@android.com>, tj@kernel.org
Subject: Re: [PATCH 2/3] writeback: Fix sync livelock due to b_dirty_time
 processing
Message-ID: <20200610150614.GB21733@infradead.org>
References: <20200601091202.31302-1-jack@suse.cz>
 <20200601091904.4786-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601091904.4786-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:18:56AM +0200, Jan Kara wrote:
> When we are processing writeback for sync(2), move_expired_inodes()
> didn't set any inode expiry value (older_than_this). This can result in
> writeback never completing if there's steady stream of inodes added to
> b_dirty_time list as writeback rechecks dirty lists after each writeback
> round whether there's more work to be done. Fix the problem by using
> sync(2) start time is inode expiry value when processing b_dirty_time
> list similarly as for ordinarily dirtied inodes. This requires some
> refactoring of older_than_this handling which simplifies the code
> noticeably as a bonus.

Looks sane, but if you touch all the older_than_this users can we
rename it to something more reasonable like oldest or oldest_jif?
