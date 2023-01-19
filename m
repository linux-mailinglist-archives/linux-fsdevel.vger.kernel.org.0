Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D498673F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjASQsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 11:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjASQsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:48:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5436A4C;
        Thu, 19 Jan 2023 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UMt9EKesgL1ePG0Sq6eLmj2qeGzJmamxNy+mPAEw4gc=; b=kZPuFI59lmrfWVhbJpxAYh9PJC
        ozV0VqYFVGkdTIood/rEI9TKA3HZH4lbOeZwoIyOSTfNZb92JUcQCk/Zs/iK4aBB1fFqQPo3GFlUu
        kXtKyCQ9UkSQJO8kBg4x5U4hekdnCsdhdd+ArkdE3l57pxL2LcG/50WdgeNL7Jl0yEQyucFxYpQPA
        yIriW03rHAY/v/8pP4rPWH2UOivLUwnB2deKFcPa1tS7fddtZZOOKl+K6ZBgmgS4xXtU5POGSdxAT
        WMIQvSrXG5OwzSBRGpAX0ddATqWpqj20KPOF3bkY25IpzdXiFdvRXQ6fBhmz2KJ35Pf6FQfaYMmaJ
        PDPxsKbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIY5V-0065fR-7t; Thu, 19 Jan 2023 16:48:29 +0000
Date:   Thu, 19 Jan 2023 08:48:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8l0Xdd0MKbuVa7z@infradead.org>
References: <Y8jYrahu45kkCRlq@infradead.org>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <Y8ZTyx7vM8NpnUAj@infradead.org>
 <Y8huoSe4j6ysLUTT@ZenIV>
 <2731230.1674128066@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2731230.1674128066@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:34:26AM +0000, David Howells wrote:
> io_uring is a bit problematic in this regard.  io_prep_rw() starts the
> initialisation of the kiocb, so io_read() and io_write() can't just
> reinitialise it.  OTOH, I'm not sure io_prep_rw() has sufficient information
> to hand.

It could probably be refactored.  That being said, I suspect we're
better off deferring the whole iov_iter direction cleanup. It's a bit
ugly right now, but there is nothing urgent.  The gup pin work otoh
really is something we need to get down rather sooner than later.

So what about deferring this whole cleanup for now?
