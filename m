Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78467A22B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjAXTDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjAXTDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:03:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F324DE1E;
        Tue, 24 Jan 2023 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0SH45SVgMg0MVm7su4sOvZwdF6og3mhYFW/JlCFrnjk=; b=yLRT42q14S/egIeQ7NW57Vn4yk
        R+0TDq0k+vRvOFcf8fGWhe5Cmx3Urq+Bh83PJgTk/HkTBzNbIUgoSNFGWZ2eNJLDw5FTtvU5EVRpM
        D73BL/6pKsjZoV2zdUxPAs15sp5+N9YdMT17BtfokRgeqUxNYUb4jDIZieEGwNcoMSjiHLthIZN2t
        G352ywVKcw/uhF2RBnC9mW7qzp0yUsw6Zr8uNI3Gsjz6COjzDcbKiNehZyeQfuc6UVi8V96MsfSyE
        k2gEfAJr53mX8YT1hdMVxHfcghcmR82QUtDRV7xfrZuNFwl2AsCU8DeKvo7hlas+fNo5vRaCghYiP
        oHFNEzSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKOZt-0050KB-7t; Tue, 24 Jan 2023 19:03:29 +0000
Date:   Tue, 24 Jan 2023 11:03:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 7/8] block: Convert bio_iov_iter_get_pages to use
 iov_iter_extract_pages
Message-ID: <Y9Argcd3aSUQFk15@infradead.org>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124170108.1070389-8-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:01:07PM +0000, David Howells wrote:
> This will pin pages or leave them unaltered rather than getting a ref on
> them as appropriate to the iterator.
> 
> The pages need to be pinned for DIO rather than having refs taken on them to
> prevent VM copy-on-write from malfunctioning during a concurrent fork() (the
> result of the I/O could otherwise end up being affected by/visible to the
> child process).


Reviewed-by: Christoph Hellwig <hch@lst.de>
