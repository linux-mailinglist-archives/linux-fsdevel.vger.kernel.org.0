Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D37828DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjHUMVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 08:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHUMVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:21:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33784E2;
        Mon, 21 Aug 2023 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5IiWcS1pGUM8RhlF+xFAzuOei17PLjfs94NmDiNvo6g=; b=MR/QHwNqCgmOxVS7c6EPkcvTOM
        ewCAH+I5VyIrZrxJzwYfZLZdCgL8s90TQvZ+npslaTk64GCHlebjy/zTEFSP1XKvpvz0F1mp04dGb
        Q4Mw4xNqTcDxevU3YZo9ZuZG7u7901KOLFAZQFBrfJj6DTvFoLmKqeOrbe9EGAWJD80G+5oUvjC9E
        GE7/tDN7WYGjkchDeLjeoEXqx63p+j9VqmffpAwOVP34B8h7G2NH+m2Ijbr5WZl9m60lEmymGlSTH
        3KMB/ugwe8njVx8yVWKJI7O8kZmYJA5QdxgWpCri1u728bx/fA3oJh+UCaWAdHAzd3/DRUeZhFvtJ
        MESTOvHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY3tZ-00A7pc-KQ; Mon, 21 Aug 2023 12:20:33 +0000
Date:   Mon, 21 Aug 2023 13:20:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Xueshi Hu <xueshi.hu@smartx.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        jayalk@intworks.biz, daniel@ffwll.ch, deller@gmx.de,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        miklos@szeredi.hu, mike.kravetz@oracle.com, muchun.song@linux.dev,
        djwong@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: clean up usage of noop_dirty_folio
Message-ID: <ZONWka8NpDVGzI8h@casper.infradead.org>
References: <20230819124225.1703147-1-xueshi.hu@smartx.com>
 <20230821111643.5vxtktznjqk42cak@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821111643.5vxtktznjqk42cak@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 01:16:43PM +0200, Jan Kara wrote:
> On Sat 19-08-23 20:42:25, Xueshi Hu wrote:
> > In folio_mark_dirty(), it will automatically fallback to
> > noop_dirty_folio() if a_ops->dirty_folio is not registered.
> > 
> > As anon_aops, dev_dax_aops and fb_deferred_io_aops becames empty, remove
> > them too.
> > 
> > Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
> 
> Yeah, looks sensible to me but for some callbacks we are oscilating between
> all users having to provide some callback and providing some default
> behavior for NULL callback. I don't have a strong opinion either way so
> feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> But I guess let's see what Matthew thinks about this and what plans he has
> so that we don't switch back again in the near future. Matthew?

I was hoping Christoph would weigh in ;-)  I don't have a strong
feeling here, but it seems to me that a NULL ->dirty_folio() should mean
"do the noop thing" rather than "do the buffer_head thing" or "do the
filemap thing".  In 0af573780b0b, the buffer_head default was removed.
I think enough time has passed that we're OK to change what a NULL
->dirty_folio means (plus we also changed the name of ->set_page_dirty()
to ->dirty_folio())

So Ack to the concept.  One minor change I'd request:

-bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
+static bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
 	if (!folio_test_dirty(folio))
 		return !folio_test_set_dirty(folio);
 	return false;
 }
-EXPORT_SYMBOL(noop_dirty_folio);

Please inline this into folio_mark_dirty() instead of calling it.
