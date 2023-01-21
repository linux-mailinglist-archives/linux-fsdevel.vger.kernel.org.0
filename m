Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21BB676655
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAUNFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUNFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:05:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034429144;
        Sat, 21 Jan 2023 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s1Q5e085clIsV3PVum3lXcgIxl15MvZT6rwMsx9v3V8=; b=u5sCxbKgnrP0/MSPcRZ4zYLP8Y
        PZGMPuq58CgQRKw1UVcMT2luKVkOzBZ3TNbLDPJtoEllXV0mKhnHpCdvNKjc9JG4hfysYVJN5g4Wr
        T+v6ZpOxE7AF8/TozQIMx0m3Ukaj5KeT3598Xhrv/azryWX+++7PFkkwcvwWcZ2YRfnbujnCy6iwF
        vPn7hoKK7NzS/ujDN6zDJAhg+5FmynKqDc0qKUXe9Ns14cSJ5IMCNYIgHh3AIKF6azdTrJM3YJA5K
        8rCLmY7EEHu6d1naI7gv549NCc5H07HEIaV3P2jpKm5URDtOQ1KyAiB722ws5tQgK92JJOMQhG59b
        /WSwAmHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDYB-00DsbC-49; Sat, 21 Jan 2023 13:04:51 +0000
Date:   Sat, 21 Jan 2023 05:04:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 4/8] block: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED
 and invert the meaning
Message-ID: <Y8vi8/sCvOxvLzzc@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-5-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:52PM +0000, David Howells wrote:
> Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the meaning.  In a
> following patch I intend to add a BIO_PAGE_PINNED flag to indicate that the
> page needs unpinning and this way both flags have the same logic.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

As pointed out last time, we really should not set the flag by default.
When a bio is allocated there are no pages to be released, that only
happens when we add dio-like pages to the bio.  Instead of explaining
why I mean again, I've put together a version of this series that
implements this and my other suggestions here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dio-pin-pages

This also tests fine with xfs and btrfs and nvme passthrough I/O.
