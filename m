Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513E35A3A54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiH0WtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0WtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:49:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC057276;
        Sat, 27 Aug 2022 15:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1/n2J4xjTn1ap1GZ0mLWYdRRj9CyoF5AMUAXfowIlzs=; b=VQB77bVgY7MH7hA2Hn3yJithb+
        V8KT+xXMkNvkM+W2DGKX82e0A//vw316FKFIHqRgk6O9CrA+C8zHxRnwqm3nyPoPu2WsJ+waOhMCF
        Jnu8m8s49cvLx5ENkFjAm1TdMp3ZE0MRVDKJbYSsQYLiOGvnfJ6mb1K+Z+f4IEUhM7KDDrzltYylA
        +0t+Uh80kIBihaZu9HvaQ08CmO7adGSLmcf0ZPEc7ja0f6I/3SecgrPVuaTf1fw7VDEx9C+/tJpcz
        rvUQFTFaQoN0wFFapShfTahamvtb7K5Lz1xDtw4WVMyy8CWWC8ek6iSD85/zn97COw4JQpWjM+6g0
        2x4NUq3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oS4bq-0097kK-Eb;
        Sat, 27 Aug 2022 22:48:58 +0000
Date:   Sat, 27 Aug 2022 23:48:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Message-ID: <YwqfWoAE2Awp4YvT@ZenIV>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827083607.2345453-6-jhubbard@nvidia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
> unpin_user_page(), instead of get_user_pages_fast() and put_page().

Again, this stuff can be hit with ITER_BVEC iterators

> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
>  						  rsize, &pgbase);

and this will break on those.
