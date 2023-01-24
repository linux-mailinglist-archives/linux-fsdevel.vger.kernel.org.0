Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35387679AFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjAXODW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjAXODV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:03:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82747EF85;
        Tue, 24 Jan 2023 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYKGL6jdW48jjLGtQGlo55UCRBRwJlq9pwc27T0p/Fw=; b=uzqa9ZQSlszDjcu6uDXWUFQU6g
        7BWFS8WeyYycIR8/yV1oPiCkXkIbUdIrFRugUUl6frhM3lLNixOqXnylZ9u0sK4Jb25zT+Z/iun8/
        z9G2P3jznLcBVcHpZWp0P2N8AqYz2bcdCYsS7hviWclG71eCIP8z7xO100DANWwiOaMw8FsYVwdB8
        CKtr0IabzAMwXEoBbeQ/Y44NO5jEjlF80/mn5IEptD8E1VCmfQ1Q8txYzgeyde7UtmkYPfPA+aWOt
        dCyb+zeQmorRLkRRIjmcZa/BDqT0SKJwlW3z5AGl0OQXTn/+7CQGTGLGy+jqqtW9kjlPUujPJtOnD
        pNrvrT7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJt3-004AUs-72; Tue, 24 Jan 2023 14:02:57 +0000
Date:   Tue, 24 Jan 2023 06:02:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y8/lEVirzumLn4OG@infradead.org>
References: <Y8/hhvfDtVcsgQd6@nvidia.com>
 <Y8/ZekMEAfi8VeFl@nvidia.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
 <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
 <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
 <852117.1674567983@warthog.procyon.org.uk>
 <852914.1674568628@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852914.1674568628@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:57:08PM +0000, David Howells wrote:
> 	[include/linux/mm_types.h]
> 	#define PAGE_CLEANUP_UNPIN	(1U << 0)
> 	#define PAGE_CLEANUP_PUT	(1U << 0)

With the latest series we don't need PAGE_CLEANUP_PUT at all.
