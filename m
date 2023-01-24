Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466B679B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjAXONp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjAXONn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:13:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF51745F62;
        Tue, 24 Jan 2023 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rcyFieaj2XOOsofCvU7y1xHAwVe0v5mydjXDAnhuzGo=; b=UJ+N9CzW9decQUujnjN7assLKh
        A7IS6vQnbv0C+ZMjrp5CmZqiXdQ6zcD96oxF2TQCjaPbn4lUPpYJdi7iuoF0ouyKg2ntWNIdC7yrV
        5FzHnA3+G6+R9HF+GHo2fNsPYPbiqE3aOzy3BW7BC6YwkBvkOvlpmoNkNaNdMEOlz8gRLgsOPJ/3/
        Na3+LkJQMjcTjw6FiryNWPcDLTTPr6wOHi7lGrfrUet3H9CRvErnAUA6mu7JjRlGew70ns3sFpGDN
        Th5BpvYWaBIBpXXRNq651o/kvkUhXuwUIYl3wrZjXu9dRRq7l271a/tjPCrKzVXPhezAg2wOyiLeG
        fQQL0TNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKK3K-004FNS-Lp; Tue, 24 Jan 2023 14:13:34 +0000
Date:   Tue, 24 Jan 2023 06:13:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/njtHRF/dXM+cx@infradead.org>
References: <Y8/lEVirzumLn4OG@infradead.org>
 <Y8/hhvfDtVcsgQd6@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
 <859186.1674569545@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859186.1674569545@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:12:25PM +0000, David Howells wrote:
> > With the latest series we don't need PAGE_CLEANUP_PUT at all.
> 
> We will when it comes to skbuffs.

I'm a little doubtful of that.  But IFF skbuffs need it, we can
just change the interface at that point.
