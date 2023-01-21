Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FA676685
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAUNd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAUNd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:33:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320B49015;
        Sat, 21 Jan 2023 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pj/DkEfwFIRHofLn9X6ceYNaPqlltRYtSVaPq4r62E4=; b=Gss5I1H4QuD52ATdNFbRLH7ko7
        df0aAA4w+7gzuFEHy7vue8kT7qXA40IZYbsQ5nKMG6hMqMqn4ehfu7KLeDJuC5mSDbqaydZ/7y354
        tmRtEzVkWibDXrXBH7DgCaInzHLy6C7tqdbD6xhng/4er1qngOmfzSYKWK590TNgk2avxpQ18/lMv
        0Ky+pKRypEGf6QBk/Ev0iXsreYF8oFGYB/OxV32g9tQ+AaI45NisgZeVlZxBrPgSagR4ICGhnl5eW
        /T6GhWe0HOrsHLB7yuEabUaxP7DE23n0oDvaC8F4R8rCOGjWxd+pQS1pCl84hIkEOf41jlYSKNEws
        eOCqD9NA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDzi-00DuND-Gf; Sat, 21 Jan 2023 13:33:18 +0000
Date:   Sat, 21 Jan 2023 05:33:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y8vpnoN13Bvn8yWk@infradead.org>
References: <Y8vkOk68ZFWPr9vq@infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3598255.1674307847@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3598255.1674307847@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:30:47PM +0000, David Howells wrote:
> So just drop the check?  Or do I actually need to do something to the pages to
> make it work?  If I understand the code correctly, it's not actually operable
> right now on any page that doesn't have an appropriately marked PTE.

Yes, just drop the check. The flag just signals that the caller can
deal with p2p pages.  If it gets any or not is a totally different
story.
