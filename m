Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF98674B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjATFAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjATE7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:59:40 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9873ED4;
        Thu, 19 Jan 2023 20:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cov0rXHHoLE4f+kl9R89J62b4kSvWbnh7UW1AJK9oFk=; b=fd/Fa82p/WURC4xtDBGJlEnjNk
        P+W1YpsqDnMKJRTzWBju+9CRa90zk1D3D8puiwFkAVT8PCiBVUJEDAzh4Jbw8hc3JLfNh50C5wGTx
        qGx3VH3l9C8wqaIT8Y7/L2LWQLDwX6x/t7TBiFwjhdSZd4zIy3BbnKtK0vM+nc1yC+fBmTg20nRHn
        S8+/nV5Z3jM+vmet9ZuuK9TgrgzE6JP+Hh6ckcBDS6aQ0FcCD5IYL/yUVwAXl/lHFYx1GZLVtLWXR
        XufUARJ+l3QPAlA1+UIsKjOoCMrlH1ObmNAFBnQNNzT65/KhSwg4mztJWCZJnD68JvwPv/z8lWflE
        MznE6u9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIjHB-002vQx-1p;
        Fri, 20 Jan 2023 04:45:17 +0000
Date:   Fri, 20 Jan 2023 04:45:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8ocXbztTPbxu3bq@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8oYXEjunDDAzSbe@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:28:12AM +0000, Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 04:21:06AM +0000, Al Viro wrote:
> > On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> > 
> > > -inline void dir_put_page(struct page *page)
> > > +inline void dir_put_page(struct page *page, void *page_addr)
> > >  {
> > > -	kunmap(page);
> > > +	kunmap_local(page_addr);
> > 
> > ... and that needed to be fixed - at some point "round down to beginning of
> > page" got lost in rebasing...
> 
> You don't need to round down in kunmap().  See:
> 
> void kunmap_local_indexed(const void *vaddr)
> {
>         unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
> 

Sure, but... there's also this:

static inline void __kunmap_local(const void *addr)
{
#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
        kunmap_flush_on_unmap(addr);
#endif
}

Are you sure that the guts of that thing will be happy with address that is not
page-aligned?  I've looked there at some point, got scared of parisc (IIRC)
MMU details and decided not to rely upon that...
