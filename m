Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A6B351D1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhDASXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbhDASOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:14:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E4C0617AA;
        Thu,  1 Apr 2021 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vwT6t1XvIjaj4QuAa3P4UOmWUFIFgnQBx4zLk2dwX9Q=; b=tG/03x14U8fbdXage3fW66lH1Z
        1G0mXooyTO3KydM/F+4rMb04dSOqZVGhkjpeJtXZAGlsadb5YzqJGHJpeTbtlRlCkxpUN3MQVZVEI
        leehL8npa4veAd5L9meSprBxQ3kZnbFXpgBgp5cglolIe71eSxiGzEhSaWk+4UudJDi3NvlYXFtAD
        rwmdCcG8VXQnvAd6fsVV+hkQLY9m0N+hb3KrIIQsFmXvEib5ZsAR5ZrIhRlL5JnGsFQ2dblObvj0G
        HsSc4WOyPXM2wEqm2cLWzMlXPkSTwYf+CcVRVa2S+24Gg/VXb3Cf3fYQMd3IYzkoQEx5+7+6+3DNg
        5NQNjpPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRvTU-0063dK-Sb; Thu, 01 Apr 2021 11:26:57 +0000
Date:   Thu, 1 Apr 2021 12:26:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <20210401112656.GA351017@casper.infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210401070537.GB1363493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401070537.GB1363493@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:05:37AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> >  - Mirror members of struct page (for pagecache / anon) into struct folio,
> >    so (eg) you can use folio->mapping instead of folio->page.mapping
> 
> Eww, why?

So that eventually we can rename page->mapping to page->_mapping and
prevent the bugs from people doing page->mapping on a tail page.  eg
https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2103102214170.7159@eggly.anvils/

