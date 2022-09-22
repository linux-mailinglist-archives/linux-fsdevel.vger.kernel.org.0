Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C767A5E65A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiIVOcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIVOcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:32:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66770F684F;
        Thu, 22 Sep 2022 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/mtTNf4PXC+ykYPVOfxIiGXI0dE7me4fgbHt4EcB8iA=; b=n2t0Tta3S2zKp9yZTFKbZ9rphf
        NyKlU4nGzFCh/vtSf0VjfGGOZyYnQmAY6C2VSWMuh1lYMGzKJfdlihT87q7rgO+yN8QSP3acrnf0O
        pzK3CUy1uAzfs5PUdi36ROvFDkKPOS+9GBFBRhkfqa0BIh/fIDCxCX4SQpc61HTRFrHYmF+e5T4wE
        hzpecbbxEXy5fYxSKCWMbo0z4+lT106+/wRSystE+ajPaTGAL6qsCSOqyIv4AWcyAhZbLzDR/0uZu
        IDrNucF+k2FAFp84QyXEI2UfPseFKFQNUKimNMSO5wtOMgwXFNWpTYDz5VnHE74/7HxxkYr+vQUNO
        sxjfGb6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNEm-00G32R-Cq; Thu, 22 Sep 2022 14:31:36 +0000
Date:   Thu, 22 Sep 2022 07:31:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YyxxyMk0IR2hMjgv@infradead.org>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyFPtTtxYozCuXvu@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:51:17AM +0100, Al Viro wrote:
> Unless I'm misreading Jan, the question is whether they should get or
> pin.

And I think the answer is:  inside ->read_iter or ->write_iter they
should neither get or pin.  The callers of it need to pin the pages
if they are pagecache pages that can potentially be written to through
shared mappings, else a get would be enough.  But the method instance
should not have to care and just be able to rely on the caller making
sure they do not go away.

> I'm really tempted to slap
> 	if (WARN_ON(i->data_source))
> 		return 0;
> into copy_to_iter() et.al., along with its opposite for copy_from_iter().

Ys, I think that would be useful.  And we could use something more
descriptive than READ/WRITE to start with.
