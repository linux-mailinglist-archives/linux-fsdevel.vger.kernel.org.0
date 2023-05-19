Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E70915B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjESIJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjESIJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:09:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559C98;
        Fri, 19 May 2023 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rN0X/XLgI1H9n9vRzMaxHiNIPrJVP5jdj7ESUMoVA4c=; b=3hkfsW6g5HJxxVvstAtx/nMk9k
        S37soTRQSDBNY5Q4G5cPwMXY4bgc4us5+JjZcJG7uw/6MmP7PkyGvXkqONdegb+V/pAkJ/7Y5sLDa
        Ga3jgFmYcGMC8zy9e6p8PoCsVwquDIJT/bCvUNXxBJ+Y1s3YEBP66qv5uYClVIizRRcxxiKIv8G7n
        IycPJ6ii3xtOcd0Tsx/K0+BTGkPB6BYhH8YB3gc5M2sFWr/S879sO0eHIvyEW/snkhfXI4BBUWzIE
        TG+EUq3Q4VT1cWiJUW42c2abfWbOxmnEqwUzoJFo/VUc3nSaTAk6mtAnNBaQtMhT3lup4wCRMQISY
        BFYggVOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzvAu-00FTRH-1c;
        Fri, 19 May 2023 08:09:20 +0000
Date:   Fri, 19 May 2023 01:09:20 -0700
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
Message-ID: <ZGcusJQfz68H1s7S@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519074047.1739879-4-dhowells@redhat.com>
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

On Fri, May 19, 2023 at 08:40:18AM +0100, David Howells wrote:
> Make direct_read_splice() limit the read to the end of the file for regular
> files and block devices, thereby reducing the amount of allocation it will
> do in such a case.
> 
> This means that the blockdev code doesn't require any special handling as
> filemap_read_splice() also limits to i_size.

I'm really not sure if this is a good idea.  Right now
direct_read_splice (which also appears a little misnamed) really is
a splice by calling ->read_iter helper.  I we don't do any
of this validtion we can just call it directly from splice.c instead
of calling into ->splice_read for direct I/O and DAX and remove a ton
of boilerplate code.

How often do we even call into splice beyond i_size and for how much?

> +	if (S_ISREG(file_inode(in)->i_mode) ||
> +	    S_ISBLK(file_inode(in)->i_mode)) {

Btw, having these kinds of checks in supposedly generic code is always
a marked for a bit of a layering problem.
