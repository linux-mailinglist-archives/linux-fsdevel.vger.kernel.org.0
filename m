Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8B709153
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjESIGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjESIGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:06:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3CDC;
        Fri, 19 May 2023 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kd5z80OJj0dUJeDURr2Zi4Eua7ZzLvvTOjXs2zK93gI=; b=LAMUe46zdzmbVFG55DnnX4RtSF
        4UrKdMQ97G7nP+GvDW6AS9tuP3lrT87WlHTyqfIesu/MMCSA7BKfNZhRWwQX2GMEn4QaCYW2N0+b5
        Df76lHAk8f8BQxbYYaFB1tdNxJX4SG1adc66FG9zMz1gVPp+N0iygK9LW3rLnudfcWkijwBGHGb7s
        5LiU0MGiY2lVXBEGJcrY83ehpzF8y/Zd2Yrrz5K8/vIxUiaWnNm463hkoriYQhLgeaEZf7iPJKZju
        k6VA8+bdI45OyAbPbYSF6kjLYn9FX09OKNrAQbWy4lj/Z14ED+XDFPbIipYavw2yGE+TYeC0RHeBT
        x7TtPPPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzv7y-00FSh2-2h;
        Fri, 19 May 2023 08:06:18 +0000
Date:   Fri, 19 May 2023 01:06:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 00/32] splice, block: Use page pinning and kill
 ITER_PIPE
Message-ID: <ZGct+qt/cHRcgJ+Y@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:40:15AM +0100, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> The first half of this patchset kills off ITER_PIPE to avoid a race between
> truncate, iov_iter_revert() on the pipe and an as-yet incomplete DMA to a
> bio with unpinned/unref'ed pages from an O_DIRECT splice read.  This causes
> memory corruption[2].  Instead, we use filemap_splice_read(), which invokes
> the buffered file reading code and splices from the pagecache into the
> pipe; direct_splice_read(), which bulk-allocates a buffer, reads into it
> and then pushes the filled pages into the pipe; or handle it in
> filesystem-specific code.

If there's a clearly separate first and second half of a 32 patch
series, it might really make sense to just split it instead of exceeding
every normal attention window..
