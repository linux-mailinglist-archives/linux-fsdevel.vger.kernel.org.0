Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B957A67812A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAWQRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjAWQRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:17:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0917EF3;
        Mon, 23 Jan 2023 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2oyH4uwBJfH4CW8T0wxFC0vvZrlsbUBreyPfi1FyKZs=; b=EntaRPhadqA1Nj+d1RMtgBU1gv
        BTJ28jeBqspXGCTAIYeRU1734xb3P9i47y201NwcFak3c5RTGE41kILunmTh9PWr8pD3mV85aOxRO
        0QLKCBLiBkm7KGN3QVc1uuWksmF2xeHJjUO/NoXPQpGVe25TSgydXvlvB3DBW5WENfBOznv8I0nE5
        xMi6zoS+rsYjqh6f/iG3h+4urXOduIcoos7c/Gze8gXngrPez1wOZZ+czO+mlZwBxxQZpbrPaRdyJ
        ufY9MbDlkDoqdEunTbZj1wNtUr+/um8xEzsG/uugCCDkwfg9ePTqNmtvxrKfsNmlQXB2FAQiqqfnI
        6KnjNNPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJzVl-000U36-2B; Mon, 23 Jan 2023 16:17:33 +0000
Date:   Mon, 23 Jan 2023 08:17:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y86zHQ2GKzmPA7vI@infradead.org>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
 <20230123161114.4jv6hnnbckqyrurs@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123161114.4jv6hnnbckqyrurs@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:11:14PM +0100, Jan Kara wrote:
> I'm all for using only pin/unpin in the end. But you'd still need to handle
> the 'put' for the intermediate time when there are still FOLL_GET users of
> the bio infrastructure, wouldn't you?

Yes, we need it for the transition.  But Dave already has a patch to
convert the legacy direct-io code as well, at which point we can
the retire the get bit.

