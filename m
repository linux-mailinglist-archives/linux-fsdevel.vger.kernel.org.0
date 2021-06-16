Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD01C3A9964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhFPLlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhFPLlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E720C061574;
        Wed, 16 Jun 2021 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D1qCShTegkiKXfeRGE/Ybh2LSj5qfntvYDg+dzBddB4=; b=VBLAe4bSut2RBuKcy555gk7J/W
        2/rSWRJ1fSZvP9oZvQ1tVqbhUcB+iUNYjy1WgonvwwO1LGpdPyioOXCesc/xehHiDdujcOqq9RBA8
        BNj1KpDFgXGjZFoUm0oobdxqDwJ4gJXhAwlo2D9zjjtMwGkeVbbA/6WYFEchhSnUGFk9jGOj9a6y/
        19msLB8mQNEaP3Ugi5iVxd0Gai321ltt7yOz6/SE5VrWC79S5i8LF2RdySlaV3h8wo3rmjV2FjJEe
        di0oc/1qg6Bp/R3xHP5ckQqCZXlN8Fr5Vn/MIJM4s3O2AbO5NwEP7PPuwqwynE19Ckhz9uJMgcZSG
        70MLbxRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltTsc-007z6Y-0K; Wed, 16 Jun 2021 11:38:52 +0000
Date:   Wed, 16 Jun 2021 12:38:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 13/33] mm/filemap: Add folio_index(),
 folio_file_page() and folio_contains()
Message-ID: <YMnixTMzdstg81Fh@casper.infradead.org>
References: <20210614201435.1379188-14-willy@infradead.org>
 <20210614201435.1379188-1-willy@infradead.org>
 <814131.1623837803@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814131.1623837803@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:03:23AM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > folio_index() is the equivalent of page_index() for folios.
> > folio_file_page() is the equivalent of find_subpage().
> > folio_contains() is the equivalent of thp_contains().
> > 
> > No changes to generated code.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Jeff Layton <jlayton@kernel.org>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> 
> folio_subpage() might be a better name than folio_file_page().

I want it to be clear that you can't call this for folios which
aren't part of a file.  For example, anonymous memory.
