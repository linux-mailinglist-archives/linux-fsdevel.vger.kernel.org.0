Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABF4698106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBOQin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 11:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBOQil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:38:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14F3646A;
        Wed, 15 Feb 2023 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QZeyTraFcbeI8aImDYPVhypwmRLT7NN7Q/wvF36P66g=; b=BHsVl7A524f3kv4ggnOjMEgTCt
        nTWCHvpzbdA7vN5WRjbrUIP8FKU6vrfpCJOMyxWbLsZdVI37pR6sLVkuPkp7L+vzrc2DTQe+ewmoW
        8/tGaxmbdcq0ZcCr0I9zU4lwsAHnWlvZUEEyRneL8dU/T31xB7LGcsqAUbiyQyuV5s7DxKLpCB70M
        aeAWNtUxxh9pjh5jWbSp7lksq3T/ijwisTgu/jqhocFzpJy16H2S2PlwjGkF6oksn2ygpTPXMF47z
        vw726UOpzqbPcNE5o0tKli9d/JFmVhUbU6hV1c0b3zJEqg40h6jWlg6oA7JTCuxDYODGVfF/jWoGM
        LgjZpHUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSKnB-006Y5G-Rx; Wed, 15 Feb 2023 16:38:01 +0000
Date:   Wed, 15 Feb 2023 08:38:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v15 05/17] overlayfs: Implement splice-read
Message-ID: <Y+0KaXocK57OrGTS@infradead.org>
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <20230214171330.2722188-6-dhowells@redhat.com>
 <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com>
 <3370085.1676475658@warthog.procyon.org.uk>
 <CAJfpegt5OurEve+TvzaXRVZSCv0in8_7whMYGsMDdDd2EjiBNQ@mail.gmail.com>
 <Y+z/85HqpEceq66f@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+z/85HqpEceq66f@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:53:23PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 15, 2023 at 04:50:04PM +0100, Miklos Szeredi wrote:
> > Looks good.  One more suggestion: add a vfs_splice() helper and use
> > that from do_splice_to() as well.
> 
> I really hate call_read_iter() etc.  Please don't perpetuate that
> pattern.

I think it's time to kill it.  I'll prepare a patch for it.

