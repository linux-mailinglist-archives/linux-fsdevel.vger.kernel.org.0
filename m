Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5D68C226
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBFPsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 10:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjBFPst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:48:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A9EB40;
        Mon,  6 Feb 2023 07:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZM4SLufXDDu44KxKnGy/pqFAr7hmVOIRITrZRFpLfF8=; b=eg4ZHygFr0KgRTE9pJp5IgzGhU
        EGn02BEAI3bGZRsOV3hkZHeIuAwo3heZvgKULzbxONSbOFi+/Nq/FFJzB/ecdbCLYt1EcJRi92+Ho
        JzM6tjZ+LOuHEq+W2zcv3sZb4nqP2hIMGm2AZxzt/lzss18yfY8PADZbjJH/7DEFoD/JZ0YHOtJpx
        CnrzQjj8zaoeMXqzCf8I/GXMkqL5kfpDpP0mmxlo9C3wDtWlQwG7rxU4BnJKe+vNx3ZK4NE6FNX14
        0AcJEGMGxJ66jb+VkPishYzAe1BgE5Ql7F6BufMCe/aDvUqKvxc3RTs3u53j1mzLIbeYVzVcXXrh/
        N+BzEc1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP3iy-0092qr-A4; Mon, 06 Feb 2023 15:48:08 +0000
Date:   Mon, 6 Feb 2023 07:48:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 03/11] cifs: Implement splice_read to pass down ITER_BVEC
 not ITER_PIPE
Message-ID: <Y+EhOHVZWLjTq26h@infradead.org>
References: <20230203205929.2126634-1-dhowells@redhat.com>
 <20230203205929.2126634-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203205929.2126634-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:59:21PM +0000, David Howells wrote:
> Provide cifs_splice_read() to use a bvec rather than an pipe iterator as
> the latter cannot so easily be split and advanced, which is necessary to
> pass an iterator down to the bottom levels.  Upstream cifs gets around this
> problem by using iov_iter_get_pages() to prefill the pipe and then passing
> the list of pages down.

Just as last time:  if cifs has a problem with splitting these iters
so does everyone else.  What about solving the root cause here?

If the splice isn't actually a splice you might as well not implement
it.
