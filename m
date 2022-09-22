Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C95E65E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiIVOhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiIVOhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:37:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301FF8592;
        Thu, 22 Sep 2022 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PnZrxUy9P5w7rj/UPAer5HPpUVVqgQM8T4IHUrrMARE=; b=O7Uf24ePDbCW3jV0DTEkbSSKYV
        bNiC//IcuLghSDMf1uFDPey4RLVLwwCExs21sumSsTXYpYORgU/MicluPYCOVTW1mvwXGxbHoUoyb
        hvFqRT9d5TfP8fIU6zKHuYi6PXuDzliIxGLb2IQfA3s0ynJtZBb8Jv9VIne13C04DE5XVQb9h/52c
        ya9BAq7upUONaIemf1jZZnpjTXDvLIIgYS48eqPW7VgIiGjewfoZPXY6TLKJwcighU/a5igF7Im+I
        Ike3xVTI4+UN4EM7aNEe7DRcPuEO+kmLbq/9t/mfrlniEimUkLt7/v7drU6tlGY0lvzfihrTSJZtA
        UNsO2dog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obNJs-002RKQ-1W;
        Thu, 22 Sep 2022 14:36:52 +0000
Date:   Thu, 22 Sep 2022 15:36:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <YyxzBPZRp/uulRmf@ZenIV>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <YyxxyMk0IR2hMjgv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxxyMk0IR2hMjgv@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:31:36AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 14, 2022 at 04:51:17AM +0100, Al Viro wrote:
> > Unless I'm misreading Jan, the question is whether they should get or
> > pin.
> 
> And I think the answer is:  inside ->read_iter or ->write_iter they
> should neither get or pin.  The callers of it need to pin the pages
> if they are pagecache pages that can potentially be written to through
> shared mappings, else a get would be enough.  But the method instance
> should not have to care and just be able to rely on the caller making
> sure they do not go away.

The interesting part, AFAICS, is where do we _unpin_ them and how do
we keep track which pages (obtained from iov_iter_get_pages et.al.)
need to be unpinned.

> > I'm really tempted to slap
> > 	if (WARN_ON(i->data_source))
> > 		return 0;
> > into copy_to_iter() et.al., along with its opposite for copy_from_iter().
> 
> Ys, I think that would be useful.  And we could use something more
> descriptive than READ/WRITE to start with.

See #work.iov_iter; done, but it took a bit of fixing the places that
create iov_iter instances.
