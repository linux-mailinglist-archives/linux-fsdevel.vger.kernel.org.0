Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA656784DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 19:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjAWS0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjAWS0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:26:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6634C04;
        Mon, 23 Jan 2023 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6EOVY6SKDpVNBWVBudK+TQ9cc0UWwwrMEBxJOxzFPT0=; b=NkXGbij0JfLFUQqo5akQ/FkgFc
        gF+H7evV7Z8H9M7rb+FmZFI7dWPeVK/x8kjkM3xV+pkOkafDKkoLa+k5zAbZ9LKA6ljPFEKWhxxcI
        z5ak0fz5b+SM42E4N6rzTUNXgLxNXrULNGTicwjxoplVKq4n1qw/lBO42L07+zFq9Ay+YN7rX4ftM
        PEdEe/e3fI027QEMJf2wTp6r2kOLbfZEeLbG5Fvl2Cu+PldQUHGrQE24vvjbsgCAC5hEbE62Ly1qH
        HRpGF9PpSwUIQyP8bdkBC+ljVlDptzw+f7L+jhgxmJHkaOkyrVwEzz1Jp6wLOOKflSICbI6cQG9Ke
        287rRxDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1VV-0010np-4N; Mon, 23 Jan 2023 18:25:25 +0000
Date:   Mon, 23 Jan 2023 10:25:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Message-ID: <Y87RFUQcN4my7pa9@infradead.org>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-11-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123173007.325544-11-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:30:07PM +0000, David Howells wrote:
> Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so that
> they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFED and
> also so that they can be stored in the bottom two bits of a page pointer
> (something I'm looking at for zerocopy socket fragments).
> 
> (Note that BIO_PAGE_REFFED should probably be got rid of at some point,
> hence why FOLL_PIN is at 0.)
> 
> Also renumber down the other FOLL_* flags to close the gaps.

Taking the risk of having a long bikeshed:  I much prefer (1U << bitnr)
style definition that make it obvious where there are holes, but
otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
