Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEED672B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjARWLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjARWLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:11:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8815F3A0;
        Wed, 18 Jan 2023 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UoquC9whzc3rr7eP+HxcCPXYruQxRORFQZRxln0GZAk=; b=tdyxMPfbMamU2hv4bCllGQkZMy
        MaoY47at6HR2JrbmHOz0Lk08xi5kgun5ZqIGY5MF++llzkFAtPrJgMzPfx229u9HcE59rRqif8rv/
        t1r8gnNCgiqE7iwTNohtlGsy3aBfkO3b8W1I4kJEdKo4IPX9fjCPHm5GhM49MybwVCPXJj25wP0Bm
        sRgfA0M+yA+4scwxjk1nu0h4ZaEZtj9BNbuMSAuPtyDPdQlH9ACUIbZW/vPcfbqn8u8IF9V9ja4T8
        n/DnR7SFX1gRfVShJvTBEHgOKVrmY3peq8dze12Zp2UdTLfCV15uRnPERuoeQIvGnp67UtS3qD39l
        VEJXeVqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIGen-002d0k-2W;
        Wed, 18 Jan 2023 22:11:45 +0000
Date:   Wed, 18 Jan 2023 22:11:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8huoSe4j6ysLUTT@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <Y8ZTyx7vM8NpnUAj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZTyx7vM8NpnUAj@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:52:43PM -0800, Christoph Hellwig wrote:

> This doesn't remove the existing setting of IOCB_WRITE, and also
> feelds like the wrong place.
> 
> I suspect the best is to:
> 
>  - rename init_sync_kiocb to init_kiocb
>  - pass a new argument for the destination to it.  I'm not entirely
>    sure if flags is a good thing, or an explicit READ/WRITE might be
>    better because it's harder to get wrong, even if a the compiler
>    might generate worth code for it.
>  - also use it in the async callers (io_uring, aio, overlayfs, loop,
>    nvmet, target, cachefs, file backed swap)

Do you want it to mess with get_current_ioprio() for those?  Looks
wrong...
