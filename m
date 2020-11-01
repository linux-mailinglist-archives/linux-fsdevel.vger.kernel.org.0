Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3232A1D90
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKALS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKALS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0960BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2020 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwiUrGLJh7vpDTgkHnkge31fEnfLKcd4qo1N7sa0DMo=; b=sDUXIFsSh+fz0Ivt6P5r/sVgLh
        TZOqxS3foFxO7m/WJYmmd+f/5Ibnd4iUWT+8R/gN0VViq7x3j3uuQ+z27srTSa7wTmjxJzoFvp6aS
        kbUtTJM5nR/3k4WFfpeNapqZUzhSb6cX3t49CBC/NQL3R24EgLBU4r7d5FmxS7E6ocLJvjmnwoe7k
        2Mo5oIy12NpYFgoa9Fo+9q0vWZpUBfn88KUlbLhQjoBNrqr2mSN2TbnszEhp62VmplTExRa/anTjj
        I1Vh67lRoasSkYv0EA2TqUvTKd7BY+x2rs2vLJfynTnkRpZYIKyR6Vbxr/ZtAVSny5ccS1FGxtlF6
        FypLJBIg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZBNP-0003n5-0k; Sun, 01 Nov 2020 11:18:23 +0000
Date:   Sun, 1 Nov 2020 11:18:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/13] mm: refactor generic_file_buffered_read_get_pages
Message-ID: <20201101111822.GW27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:59:58AM +0100, Christoph Hellwig wrote:
> Move the call to filemap_make_page_uptodate for a newly allocated page
> into filemap_new_page, which turns the new vs lookup decision into a
> plain if / else statement, rename two identifier to be more obvious
> and the function itself to filemap_read_pages which describes
> it a little better while being much shorter.

We don't need to do this -- filemap_read_page waits for the page to
become unlocked, so we already know that it's uptodate (or an error!)
and we know it isn't going to have the readahead bit set.

