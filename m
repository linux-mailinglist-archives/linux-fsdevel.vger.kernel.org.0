Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422363247AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhBXX4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 18:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhBXXz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:55:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F0C06174A;
        Wed, 24 Feb 2021 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKtbljNjRDo6cY0QPHsZ6Rnq2DeZQM19dzIHGg5f4PY=; b=R11gkp4K6rehkkXSl4PSRzx65l
        omOs9KB4haZFN5IszYClFTlIXNmakpAsz4fAxZC7AP4NT0be48ChODM8fR9s0/eXa/4Ty3HZvM4gt
        6lHCl7SJswDAajgVgHI2iVL4pUKvNycpwzbn5KTaT/ENMXWr5tq2GMvgVbbwKIMXRywuv/Ful5xhu
        dCtFqPDsR9IhaO+ztDoHOy2wHWc42wdSRaZ4WQzmlL79HDrh2j26nL25+BanEl5FxoMxfOgGAMVT0
        NhWxnqlvn8KV9j6D0BCcqR4RJuPlTFObo0dTO2Kd5vzwZhGp+60qiUC+RVhmrTZBXgKvRn100zgST
        WvXhqM/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF3za-00A2mh-3j; Wed, 24 Feb 2021 23:54:57 +0000
Date:   Wed, 24 Feb 2021 23:54:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [RFC] Better page cache error handling
Message-ID: <20210224235454.GV2858050@casper.infradead.org>
References: <20210205161142.GI308988@casper.infradead.org>
 <20210224123848.GA27695@quack2.suse.cz>
 <20210224134115.GP2858050@casper.infradead.org>
 <DC74377C-DFFD-4E26-90AB-213577DB3081@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC74377C-DFFD-4E26-90AB-213577DB3081@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:41:26PM -0700, Andreas Dilger wrote:
> Since you would know that the page is bad at this point (not uptodate,
> does not contain valid data) you could potentially re-use some other

Oh, we don't know that.  We know _a_ read has failed.  There could be
up to 128 blocks that comprise this (64kB) page, and we don't want to
prevent reads to those other blocks in the page to fail unnecessarily.

> fields in struct page, or potentially store something in the page itself?
> That would avoid bloating struct page with fields that are only rarely
> needed.  Userspace shouldn't be able to read the page at that point if
> it is not marked uptodate, but they could overwrite it, so you wouldn't
> want to store any kind of complex data structure there, but you _could_
> store a magic, an error value, and a timeout, that are only valid if
> !uptodate (cleared if the page were totally overwritten by userspace).
> 
> Yes, it's nasty, but better than growing struct page, and better than
> blocking userspace threads for tens of minutes when a block is bad.

The current state blocks threads for tens of minutes.  I'm proposing
reducing it down to 30 seconds.  I'd want to see a more concrete
proposal than this ...

(also, a per-page data structure might blow up nastily if the entire
drive is inaccessible, rather than just a single bad block)
