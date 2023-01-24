Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4FA679924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjAXNVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjAXNVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:21:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E02710;
        Tue, 24 Jan 2023 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7VDifRwWpYsYHhcQ6fHHUTl8MrzfI7GmqknnA4JY6VE=; b=wYMBDKaGEyC/g4xYvrGHMyXR0Q
        WsjYAYN9PtOxLTAgD0T/9LexqJJ5uKs6j+feKZ77HSJF4hUYcZbl9HdP4IfeHGEGx3YwtLy8Z727A
        R1yb0bFbHzn87jRqOk6KMc9lvX/1WLAZyWTE7QTgic5m0h3hkwKJUa5Ql5bDmdSAuqDn1VPPdrSaj
        UXjbuj3VnAPl+LZMlF1fJn7KpoIdUpo5Zj2u6Q8H/5ab4A+Ax+3sNDWdeu52DybUEgxj7S2A4hXYR
        libnqhN/Epp6Iy0g7Gh7Q9ELpLGcCi2tzX211faU6XBVUxjhcmVNITFNjNT+Is0BIGhgMF1Uvh2aN
        XPZwzdTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJEu-003wq4-L8; Tue, 24 Jan 2023 13:21:28 +0000
Date:   Tue, 24 Jan 2023 05:21:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <Y8/bWF6s8oPJdNRs@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230123164218.qaqqg3ggbymtlwjx@quack3>
 <Y87E5HAo7ZoHyrbE@casper.infradead.org>
 <20230124102931.g7e33syuhfo7s36h@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124102931.g7e33syuhfo7s36h@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:29:31AM +0100, Jan Kara wrote:
> True but as John said sometimes we need to writeout even pinned page - e.g.
> on fsync(2). For some RDMA users which keep pages pinned for days or
> months, this is actually crutial...

I think we have to distinguish between short term (just FOLL_PIN)
and long term (FOLL_PIN | FOLL_LONGERM) pins.

For short term ones the proper thing to do in data integrity writeback
is to simply wait for the unpin.  For the long term pins that obviously
can't work.  The right answer for that is complicated and I don't have
a good answer yet.  The best one would probably to probibit them on
MAP_SHARED file backed mappings - this might break some existing
software, but that software is already so broken that this might be
best.
