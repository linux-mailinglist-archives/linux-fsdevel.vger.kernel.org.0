Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C7E5A3AAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 02:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiH1AjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 20:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiH1AjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:39:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F53DF35;
        Sat, 27 Aug 2022 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fWJjSzITkBG3hjEOwPDs6x02IB74YxIK99jfuPfRgtE=; b=ru9svlqk7oodiK4rpSP9SpxxO5
        +mWWuOTBieeTjM+ZqkmhYVaiEfMZjbKOtmbD1AY6Uv1d+Xzt4wncGjqEECuJigrzUE5p0VS0YnUwf
        /SyRLlOsEMG+vcd9jDUjktE9ILyGqQDY5mjK+KlKMv8zmi60TtedCdQernDRe4dJFUOzScyacEkEp
        7hCk8/3RaHut5zlN7ZGk7MuByZ/UbzflwUeX2VW/EL+z/aMg+ZHwnvpLx6bh3qpYkOVdmuJS5T4/j
        wGiVqG+cnyHVsazHx0Vvy6x8tgo7afDfbKDBjZ6G/mj5AoFr62XM4JuQue10O2DTMvcGEeI/PIibf
        4yZi1hJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oS6KH-0099dP-0G;
        Sun, 28 Aug 2022 00:38:57 +0000
Date:   Sun, 28 Aug 2022 01:38:56 +0100
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
Message-ID: <Ywq5ILRNxsbWvFQe@ZenIV>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com>
 <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 27, 2022 at 04:55:18PM -0700, John Hubbard wrote:
> On 8/27/22 15:48, Al Viro wrote:
> > On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
> >> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
> >> unpin_user_page(), instead of get_user_pages_fast() and put_page().
> > 
> > Again, this stuff can be hit with ITER_BVEC iterators
> > 
> >> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
> >> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
> >>  						  rsize, &pgbase);
> > 
> > and this will break on those.
> 
> If anyone has an example handy, of a user space program that leads
> to this situation (O_DIRECT with ITER_BVEC), it would really help
> me reach enlightenment a lot quicker in this area. :)

Er...  splice(2) to O_DIRECT-opened file on e.g. ext4?  Or
sendfile(2) to the same, for that matter...
