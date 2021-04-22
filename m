Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4513677DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhDVDWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 23:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbhDVDWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:22:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78035C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 20:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Pis/koNGfUSilCi9c4j/EPd8Vdh4HXizXmi3IG9jqsA=; b=coD7V8VpadUZ1WoZ9O5G46fBgM
        vQvZVCAfo/WaUJa8RxRFQRYA509rXJtesl6z9iEXDySlDKbyJaJph2T4mLpf5AtorPDbqEM31Ze7M
        sbyLjkVCr88+MKs96OU+IjNYuRNznjZRaAcmNOp7vhrLYpKGolU0DPbonpYI7MRTTqAxkdWpZr9CH
        d01XcPve0ZlZIUeiQ89ZwzV7h6NuiUd7pd+DXpK0eNVkTGWnvTagt4HgkmsnGzyyFiygW2SkG8c9r
        M5DNV3/siufjJckZdXEIbtanFNJAxErJYm2PNRVrjcrO+YiP+ZDWIWHcn2yQnuhHufKVPJziP0G8c
        /KQY5Ekw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZPtb-00HN68-RM; Thu, 22 Apr 2021 03:20:59 +0000
Date:   Thu, 22 Apr 2021 04:20:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: (in)consistency of page/folio function naming
Message-ID: <20210422032051.GM3596236@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I'm going through my patch queue implementing peterz's request to rename
FolioUptodate() as folio_uptodate().  It's going pretty well, but it
throws into relief all the places where we're not consistent naming
existing functions which operate on pages as page_foo().  The folio
conversion is a great opportunity to sort that out.  Mostly so far, I've
just done s/page/folio/ on function names, but there's the opportunity to
regularise a lot of them, eg:

	put_page		folio_put
	lock_page		folio_lock
	lock_page_or_retry	folio_lock_or_retry
	rotate_reclaimable_page	folio_rotate_reclaimable
	end_page_writeback	folio_end_writeback
	clear_page_dirty_for_io	folio_clear_dirty_for_io

Some of these make a lot of sense -- eg when ClearPageDirty has turned
into folio_clear_dirty(), having folio_clear_dirty_for_io() looks regular.
I'm not entirely convinced about folio_lock(), but folio_lock_or_retry()
makes more sense than lock_page_or_retry().  Ditto _killable() or
_async().

Thoughts?
