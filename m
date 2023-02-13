Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF7694861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 15:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBMOoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 09:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMOop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:44:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36881ABED;
        Mon, 13 Feb 2023 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JSxK9rMVsZmKsqSOdmHwtno2awdrOzMA4imgfyeBPO4=; b=nUOjCA8P8jLHCHicL2DJLV93MO
        8Wv93GntU4fvktAa3LhaWZ5d+DuDwMb7JJuI5QrIQ8xcPOJPKT70DhqclKb1xPKuj0B3pvadse3RH
        JN+4yLNsFXphcGl3bGF/j5d/9KCu65fB3fKW8D0Ffyk0XeKoyZcP3xKxIXypJK5BJuir7Cvvk/BxW
        G6s70GmWbDdnXosddZtKLDzN+KErM1PNyM2jm/htodVA3BcfSnPvRaUAUuZDfraTYXnSmLPiFaRlm
        Eto2PfXFH0+lk3iwWzun1z0RXM4CFpmSXF1w3GtDAG9BWqs72eqq7C8ZNPOUlOwrsy+pFRwcWG2il
        e2mQQ4HQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRa47-00F1gX-DK; Mon, 13 Feb 2023 14:44:23 +0000
Date:   Mon, 13 Feb 2023 06:44:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
Message-ID: <Y+pMx2HhY0dOiRl3@infradead.org>
References: <Y+oOa3bbJZallKtl@infradead.org>
 <Y+n0n2UE8BQa/OwW@infradead.org>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
 <1753989.1676283061@warthog.procyon.org.uk>
 <1830953.1676286937@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1830953.1676286937@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:15:37AM +0000, David Howells wrote:
> I'm not sure I want ki_flags setting from f_iocb_flags I should've said.  I'm
> not sure how the IOCB_* flags that I import from there will affect the
> operation of the synchronous read splice.

The same way as they did in the old ITER_PIPE based
generic_file_splice_read that uses init_sync_kiocb?  And if there's any
questions about them we need to do a deep audit.

> IOCB_NOWAIT, for example, or, for

I'd expect a set IOCB_NOWAIT to make the function return -EAGAIN
when it has to block.

> that matter, IOCB_APPEND.

IOCB_APPEND has no effect on reads of any kind.
