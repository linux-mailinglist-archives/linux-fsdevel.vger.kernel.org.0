Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF03B34E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhFXRkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXRko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:40:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EDCC061574;
        Thu, 24 Jun 2021 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2CrBXZN94UanW7Z9wbxJJ19Ik2XzepvUm7qpu+EStk0=; b=jBQ0NmZKRLHKjDQc9jvD3aDUNp
        GR1n7RIIEIJxc7aqo9Iey0Z3VDbjtjG+RFJAjM6Rj37cXXF0S/uDHWuh67kp9PoTSTcQAAGHF0qOJ
        nsEBM6acW7i4XA1lZMSltDK7xft6gXjXGxQB22wfNg/M+Ql1MoBPG2Xj7QXGZXQE9WsHe1lBg2Xc4
        iYlT21yUploEw+7s5BsHk76qt6G2wKLp5ppjmHOZ0wF/7MYsLjTM0GVod6ADQy9RcDb+HMo148mOq
        VFndPkGbwHRjm1ZgC++Nr3y/fJNxeVF7B+4nwlEoYsiairK88dsXFpw4jOmAlmKanrxufNAnLxKSX
        3jbEo0kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwTIR-00GpHA-RT; Thu, 24 Jun 2021 17:37:52 +0000
Date:   Thu, 24 Jun 2021 18:37:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/46] mm/memcg: Convert
 mem_cgroup_track_foreign_dirty_slowpath() to folio
Message-ID: <YNTC67V2192OBiJ2@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-18-willy@infradead.org>
 <YNLvBjx3mqXTjj+b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLvBjx3mqXTjj+b@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:21:26AM +0200, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although I wish we could come up with a shorter name for
> mem_cgroup_track_foreign_dirty_slowpath somehow..

It is quite grotesque!

How about folio_track_foreign_writeback() as a replacement name for
mem_cgroup_track_foreign_dirty() and have it call
__folio_track_foreign_writeback()?

Although 'foreign' tends to be used in MM to mean "wrong NUMA node",
so maybe that's misleading.  folio_track_dirty_cgroup()?
folio_mark_dirty_cgroup()?  (the last to be read in context of
__set_page_dirty() being renamed to __folio_mark_dirty())
