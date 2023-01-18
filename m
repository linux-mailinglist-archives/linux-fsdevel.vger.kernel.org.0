Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C778B671574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 08:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjARHxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 02:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjARHxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02C530287;
        Tue, 17 Jan 2023 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ic7xbtoXFuR48dKsp0e0dJrkGYZD5VMPIbRdeVrUZo=; b=mWSXUvuOQdsjyuKEbbFQ3YPAem
        d1BRSFrlyIuV6OzlZAMHLBGFJKi3Oqh8I0TkN/VztaUQybNWQe0EQm5DYYPknzdvoqjvUHWLcsY48
        Xu0sUE6Xv4D34Mt37FfaPre7B39AYL5MgX+bOsbYb4wHhFLqtdf32hJTMFLGbdHsmLAanNGuXK/dV
        k06GSycvQtDVquv7BDuZLI/6SUHRqil0UMy10kj97/SA8Uy8LWNBnkvRiATdpz9Q6t5XQ72zG2CiC
        Du/XHBfh7QyZe0887fzxQbbtKa7DJR2c4yWYRuPAFgEdEvPQmKLuc/qfk1FpIzcl8xWhLtqxHyIKI
        6VlMjTJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI2lO-00HBCI-KB; Wed, 18 Jan 2023 07:21:38 +0000
Date:   Tue, 17 Jan 2023 23:21:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y8eeAmm1Vutq3Fc9@infradead.org>
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
 <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
 <20230109225453.GQ1971568@dread.disaster.area>
 <CAHpGcM+urV5LYpTZQWTRoK6VWaLx0sxk3mDe_kd3VznMY9woVw@mail.gmail.com>
 <Y8Q4FmhYehpQPZ3Z@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Q4FmhYehpQPZ3Z@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 15, 2023 at 09:29:58AM -0800, Darrick J. Wong wrote:
> I don't have any objections to pulling everything except patches 8 and
> 10 for testing this week. 

That would be great.  I now have a series to return the ERR_PTR
from __filemap_get_folio which will cause a minor conflict, but
I think that's easy enough for Linux to handle.

> 
> 1. Does zonefs need to revalidate mappings?  The mappings are 1:1 so I
> don't think it does, but OTOH zone pointer management might complicate
> that.

Adding Damien.

> 2. How about porting the writeback iomap validation to use this
> mechanism?  (I suspect Dave might already be working on this...)

What is "this mechanism"?  Do you mean the here removed ->iomap_valid
?   writeback calls into ->map_blocks for every block while under the
folio lock, so the validation can (and for XFS currently is) done
in that.  Moving it out into a separate method with extra indirect
functiona call overhead and interactions between the methods seems
like a retrograde step to me.

> 2. Do we need to revalidate mappings for directio writes?  I think the
> answer is no (for xfs) because the ->iomap_begin call will allocate
> whatever blocks are needed and truncate/punch/reflink block on the
> iolock while the directio writes are pending, so you'll never end up
> with a stale mapping.

Yes.
