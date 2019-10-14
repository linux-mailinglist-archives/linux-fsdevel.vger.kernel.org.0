Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DED5DC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfJNIqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 04:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJNIqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AS+vOpGBm4Y0V3guxdRRNronYLbqZeSo4UeGsyrmyY4=; b=ezhPnVWf9CcaO1Cx9AlYyxBFq
        oTYZrWKtxLHXd4YuxOAYcgYUTsi4IssRCELmEOl5FsJdnivdLrLGjh9Gz/TB2q7KjeSG/f6Hwbyb9
        uPUgTUzv/iinKHOSn0lQaG5K+foOWlhHqqcuR4lhsn/wd6pYwCyef2yj0IOZcc5FkfANY1S8xGyJI
        aQlDL8W5OsWZK9Vy5D44EfR4NHx8erlSdnrHJQF6KVBqRC25OP8HBLyKMsYIZODFjRgrE12vSGHGc
        SJkiHx6Tq6WHifjdn0sCVv7wwriMesfb9i7gVRUZ8v2fB4//DprtMEfdu3QAIdUtZj5kU6pQ0Zv0k
        3mOJQWj1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJvzQ-0004Yp-2Y; Mon, 14 Oct 2019 08:46:04 +0000
Date:   Mon, 14 Oct 2019 01:46:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/26] mm: directed shrinker work deferral
Message-ID: <20191014084604.GA11758@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-9-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:06PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Introduce a mechanism for ->count_objects() to indicate to the
> shrinker infrastructure that the reclaim context will not allow
> scanning work to be done and so the work it decides is necessary
> needs to be deferred.
> 
> This simplifies the code by separating out the accounting of
> deferred work from the actual doing of the work, and allows better
> decisions to be made by the shrinekr control logic on what action it
> can take.

I hate all this boilerplate code in the scanners.  Can't we just add
a a required_gfp_mask field to struct shrinker and lift the pattern
to common code?
