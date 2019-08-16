Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED7A8FB5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfHPGrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oMkOUDjTUd1VToHv7m4QacH8p7Ifbrlf3oQ3MuJNpcs=; b=hn1Gc8kX1BWhGsN1qD+TPXf84
        rWNpDhqz77k60FzotDmstKOa3yRv8HzWco0b1YlP46fk9SPSmFrHuc0MaIO/lKtFWPyE1dldkrjsL
        PuP+3ypz4uDswLRmqUowy76CqFwH6ju8OzWJT7V3Wh0W3JoVFnfwmf2wrAF15RsVMLCYMiFjnYvNo
        z9WwActMgm994JExSf8N3gO8cfLeWAmNx1hE8qLfe7rkeSAKAERAic+aRtxvynU7pOd2HQCFpzapM
        DIcYq+KyX3sE6W9KCxTys+6zBAXu7+UCURXtm/xoaBPdTIIbUVmMf4MVBui2XW/veiSmNm78Y4L7k
        okfJMfvqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyW1h-0005Lq-JD; Fri, 16 Aug 2019 06:47:53 +0000
Date:   Thu, 15 Aug 2019 23:47:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fdmanana@gmail.com, gaoxiang25@huawei.com
Subject: Re: [PATCH v4] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190816064753.GD2024@infradead.org>
References: <20190815164940.GA15198@magnolia>
 <20190815181804.GB18474@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815181804.GB18474@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:18:04AM -0700, Matthew Wilcox wrote:
> But I don't think read_mapping_page() can return a page which doesn't have
> PageUptodate set.  Follow the path down through read_cache_page() into
> do_read_cache_page().

read_mapping_page() can't, but I think we need the check after the 
lock_page still.
