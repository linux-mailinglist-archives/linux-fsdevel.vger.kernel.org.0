Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892EB690E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBIQRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBIQRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:17:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6595C4B2;
        Thu,  9 Feb 2023 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GaOJeaNBE+cIRwIe31pgWfnt4opg4KFpYb7y7dc6AyU=; b=iFCPEi1CVEGYffbsj1sABUlDMe
        5VqyIyJRJHLYEHF6kEv9sc5Qb6nn5XDAYbBZ3oJyWBrg9mMa6y1NXHbL5p+m875/1x3iIrWLoxlcw
        hZnwkWDd+OifKrfhcYTwt12Igm63qGuTwuPwSAdB178IbOthgZcbmw94Kz5DoC26Bkmln9QxbsSiC
        /JCE8c9CV36MulwRAzxdSwp/Re5OIj+SFTKL8wTcmEtfC2CMEiWpWo4px06YyEUR7YjkCb9pxMshP
        YpR6CmsJO51+ElRv82d740/Ntc4ACNJ4DJZWON5nTEpCp04f31vLCgSNE4v5ISye8CTpCZFjjjTMP
        6sq0tWZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ9cJ-002Kgx-LM; Thu, 09 Feb 2023 16:17:47 +0000
Date:   Thu, 9 Feb 2023 16:17:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <Y+Ucq8A+WMT0ZUnd@casper.infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209123206.3548-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 01:31:53PM +0100, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz

OK, but now I'm confused.  I've been told before that the reason we
can't take pinned pages off the LRU list is that they need to be written
back periodically for ... reasons.  But now the pages are going to be
skipped if they're found on the LRU list, so why is this better than
taking them off the LRU list?
