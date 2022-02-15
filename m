Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D94B7860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiBOUJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 15:09:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242694AbiBOUJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:09:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC2BB092
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 12:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KQX3ZqOWXcG/3O/Gh0GTURDssFoJ1a3or/9OceS26E=; b=rbB7JRyQFJ/jgIJcJQyNMyc2t2
        EoY85nSHooSpI246/gddkgdpg2tRu/kt/Hax6Ve6xtSeK/mvUR5KK43fMZ6fZz69F4yzq+MnxHQ4A
        wLr6QAscYDgb8MX+QmBHMEAu0jE8yQayq0Pmthg6dOCxQdNb3Me9X43/Me+CL9hm0cC0jxdoSZhbt
        RJb2NGo0xD1PeqJIsVzPO+J1LbaJy1PP7q4GyhyQMLCdRasmA+Z/cKWYYUWYPxcdy7PTuPnrx4E5D
        hE7jl1/OeXLD5XhBkAUnUVp+0XjFLENpyWjqT34GanLUw6xPo4gV5Qck9QqCUbpbQlR+/hCN3Zb7M
        V+ljUSPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK48n-00E8hH-1K; Tue, 15 Feb 2022 20:09:37 +0000
Date:   Tue, 15 Feb 2022 20:09:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page()
 into its one caller
Message-ID: <YgwIgUIeWyOVeORI@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
 <71259221-bc5a-24d0-d7b9-46781d71473a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71259221-bc5a-24d0-d7b9-46781d71473a@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:45:34PM +0800, Miaohe Lin wrote:
> > @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
> >  		return 0;
> >  	if (page_mapped(page))
> >  		return 0;
> > -	return invalidate_complete_page(mapping, page);
> 
> It seems the checking of page->mapping != mapping is removed here.
> IIUC, this would cause possibly unexpected side effect because
> swapcache page can be invalidate now. I think this function is
> not intended to deal with swapcache though it could do this.

You're right that it might now pass instead of being skipped.
But it's not currently called for swapcache pages.  If we did want
to prohibit swapcache pages explicitly, I'd rather we checked the
flag instead of relying on page->mapping != page_mapping(page).
The intent of that check was "has it been truncated", not "is it
swapcache".

