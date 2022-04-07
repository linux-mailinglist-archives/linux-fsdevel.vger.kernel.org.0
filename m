Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3359C4F899E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 00:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiDGVYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiDGVYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:24:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0E74DCE;
        Thu,  7 Apr 2022 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AP3ckG/WzqkXC8+7CiECPH3yRSiA3cIEW4UGrQf10jo=; b=VHt28AgNNEbERQekujzfAhepuF
        yRUYEupZiZ63Q+FrJIO2VhPpxfdNELTdKXP3+AqQFnU7rCKdEJdALxf3FU3evxIYXSXF5qigkZrCN
        hJ2PkDlk56mtFwIBQt+Wcm+whEwtTQzXVP8sPrwHhvwiWDHePrly6T//aWyDaG0AMqR6tqsYcNBW6
        EE3PuIlV9s7etoCXhZEscei648aysaUd70wbuBhBsYUk0CEv30is5bj5UILJer52psJMA5shwPTWh
        2TTpNIKotN1lTBYaXzA74xnVD6UIwQMzFY6+9u0c0nb4dBiv2sKLiNcqA/zijCmh3M/ZERhyo/oUa
        ITnXj9yA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncZZv-009Ciz-Cj; Thu, 07 Apr 2022 21:22:07 +0000
Date:   Thu, 7 Apr 2022 22:22:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <Yk9V/03wgdYi65Lb@casper.infradead.org>
References: <Yk5W6zvvftOB+80D@casper.infradead.org>
 <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
 <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
 <469869.1649313707@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469869.1649313707@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 07:41:47AM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Apr 07, 2022 at 12:05:05AM +0100, David Howells wrote:
> > > Fix this by adding an extra address_space operation, ->removing folio(),
> > > and flag, AS_NOTIFY_REMOVING_FOLIO.  The operation is called if the flag is
> > > set when a folio is removed from the pagecache.  The flag should be set if
> > > a non-NULL cookie is obtained from fscache and cleared in ->evict_inode()
> > > before truncate_inode_pages_final() is called.
> > 
> > What's wrong with ->freepage?
> 
> It's too late.  The optimisation must be cancelled before there's a chance
> that a new page can be allocated and attached to the pagecache - but
> ->freepage() is called after the folio has been removed.  Doing it in
> ->freepage() would allow ->readahead(), ->readpage() or ->write_begin() to
> jump in and start a new read (which gets skipped because the optimisation is
> still in play).

OK.  You suggested that releasepage was an acceptable place to call it.
How about we have AS_RELEASE_ALL (... or something ...) and then
page_has_private() becomes a bit more complicated ... to the point
where we should probably get rid of it (by embedding it into
filemap_release_folio():

+++ b/mm/filemap.c
@@ -3981,6 +3981,9 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
        struct address_space * const mapping = folio->mapping;

        BUG_ON(!folio_test_locked(folio));
+       if (!mapping_needs_release(mapping) && !folio_test_private(folio) &&
+           !folio_test_private_2(folio))
+               return false;
        if (folio_test_writeback(folio))
                return false;



