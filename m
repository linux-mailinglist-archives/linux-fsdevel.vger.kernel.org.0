Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1803145A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBIBaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBIBaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:30:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC629C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ksGZv+iRydT2obL4p+KtH/YlwRcB+Fs/ykrdhbdj0GY=; b=ZmgQ0rVf4z8YjlOphNi/VUpOSY
        yBwwtNQtCark/Vod8BT+2vK+ZzQrOXG+B3rmKHX+Hc1ewKVtuFIkAOwcEJc8p6S1HyylekrFnfIUQ
        twTOhXNQ/n4yPX9FzFt/TPqE/cu9pIay+igGvHpEdyE8Gxzpjq0B7k1H4ONWCWlyDxvjAPcUlHucB
        se+mVoBy8mbrqephcyQQqwfScJvlZ3MD91KPl1dFpWP4ELNLsdfmcZnERiD/FGL6YDTbe6/W9d4/z
        NBuBBId0QvCDSb1E5PLm9Cm7k41ukvT1YJ/HkU5F7D2bA9eo8Ea34LepDA1WtRfPY5v71E4uoh9sQ
        Q5XIZEnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9HqE-006nBU-Ju; Tue, 09 Feb 2021 01:29:23 +0000
Date:   Tue, 9 Feb 2021 01:29:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210209012922.GW308988@casper.infradead.org>
References: <20210208163918.7871-1-jack@suse.cz>
 <20210208163918.7871-2-jack@suse.cz>
 <20210209011258.GQ4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209011258.GQ4626@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:12:58PM +1100, Dave Chinner wrote:
> On Mon, Feb 08, 2021 at 05:39:17PM +0100, Jan Kara wrote:
> > +++ b/mm/filemap.c
> > @@ -2257,16 +2257,28 @@ static int filemap_update_page(struct kiocb *iocb,
> 
> What tree is this against? I don't see filemap_update_page() in a
> 5.11-rc7 tree...

It's in mmotm or -next.
