Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B8679F17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjAXQpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjAXQo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:44:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FAB172B;
        Tue, 24 Jan 2023 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uF0axQznaLLzT1o+qlzPR5UW2G9GEhXvNq93Ci6vsQI=; b=O0gy0ZqSFby9QJvWGBYgwkLVbk
        3JJ8HNWudzHiIh7Xlz/8vlaJcDa9JbO3OBbL7q2RPfisWNq29cO1VFqg0RMbhd+Kx+EPRRPU8Mqb+
        NrxFlN/dt0pkirEqgSo6BOrHod3HoecMBqfm7XusbtMrtKH39rEwLmVcRnwENf96Lzg05UZnIQtIs
        WsBafmY+/WkMU1vrunNLLm/BPmX6tz4pehRE8TO/gC0ZrmBaePx3r02i+fUV+ApWX374/0e3DIjtS
        7d4KE/YVSPyVDuKvKHb2o3q6enpmDCPeSNofSSiIttY7JF95aC7MCtv7xUHePylYNJ1ogmnz6zYw3
        rW5d3iMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKMPb-004iS7-16; Tue, 24 Jan 2023 16:44:43 +0000
Date:   Tue, 24 Jan 2023 08:44:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Message-ID: <Y9AK+yW7mZ2SNMcj@infradead.org>
References: <Y8/xApRVtqK7IlYT@infradead.org>
 <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
 <874829.1674571671@warthog.procyon.org.uk>
 <875433.1674572633@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875433.1674572633@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:03:53PM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > It can't.  Per your latest branch:
> 
> Yes it can.  Patch 6:

This never involves the cleanup mode as input.  And as I pointed out
in the other mail, there is no need for the FOLL_ flags on the
cleanup side.  You can just check the bio flag in bio_release_apges
and call either put_page or unpin_user_page on that.  The direct
callers of bio_release_page never mix them pin and get cases anyway.
Let me find some time to code this up if it's easier to understand
that way.
