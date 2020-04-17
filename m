Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C81AD82E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgDQIGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729495AbgDQIGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:06:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728CC061A0C;
        Fri, 17 Apr 2020 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GdTc/Zzu7raszzr4RX7T2guEFF3lDB9CYabZTEfgBXY=; b=QEuXKVnz/XP2KY6qvCoCoaxFZL
        YwfX8YOjMokAprB4nQ8NvkRK6Y7bq+HQj7ySjWENQUmqgjWp0Dyd40wFTB93WA0h1/EkJTY0PlArV
        1RnVEggjkzQnKMr6CiIMwXPzvEyacIoHPOZm0owh/M0tBuS8aYB8th13ZpJhGGaTvDJUXLvDKapSN
        AVegpSoGABDu6ZPjFVK5MKczDpqh7hhQbKXTWXU3Ne73CJspy8uLw2Et0VKGNC68byShygHd5meEG
        hVUgUPYhWnYBbTJYPHw/n5U1wSTJ7ctlldij8PpHRRBT6w4Dz1CyX/r9eby2Jagy4Ld0jr+GkAsmD
        oiPBO0cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPM0t-00019y-2j; Fri, 17 Apr 2020 08:06:15 +0000
Date:   Fri, 17 Apr 2020 01:06:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: implicit AOP_FLAG_NOFS for grab_cache_page_write_begin
Message-ID: <20200417080615.GA26880@infradead.org>
References: <20200415070228.GW4629@dhcp22.suse.cz>
 <20200417072931.GA20822@infradead.org>
 <20200417080003.GH26707@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417080003.GH26707@dhcp22.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:00:03AM +0200, Michal Hocko wrote:
> > commit aea1b9532143218f8599ecedbbd6bfbf812385e1
> > Author: Dave Chinner <dchinner@redhat.com>
> > Date:   Tue Jul 20 17:54:12 2010 +1000
> > 
> >     xfs: use GFP_NOFS for page cache allocation
> > 
> >     Avoid a lockdep warning by preventing page cache allocation from
> >     recursing back into the filesystem during memory reclaim.
> 
> Thanks for digging this up! The changelog is not really clear whether
> NOFS is to avoid false possitive lockup warnings or real ones. If the
> former then we have grown __GFP_NOLOCKDEP flag to workaround the problem
> if the later then can we use memalloc_nofs_{save,restore} in the xfs
> specific code please?

As far as I can tell we are never in a file system transaction in XFS
when allocating page cache pages.  We do, however usually have i_rwsem
locked (or back in the day the XFS-specific predecessor).  I'm not
sure what the current issues are, but maybe Dave remembers.  In doubt
we should try removing the flag and run heavy stress testing with
lockdep enabled and see if it screams.
