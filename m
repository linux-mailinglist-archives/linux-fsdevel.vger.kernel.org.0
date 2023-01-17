Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6F66D876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjAQIpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjAQIpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:45:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B02CFF1;
        Tue, 17 Jan 2023 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SaB++xvXHwAfFw7T6p++KA81QX2bKnVNppi3/0l0wi8=; b=bjT5FfIFMPoAEwdbNbeOUq627N
        ddU2muMk+HILzP51F3tH79ZRkFe3Vh486bkosFXHREUqSmK5MZW+WAYu+HYHlXgn79UqAw4/bw9k4
        R6Wq2XBCte1YDZ3Rri54Pi6w0T/BG/PbsF/wcjXVIVgwUlNECzWnoZ1NE/nxlBt4HEg6n/ifDKwIX
        d+Ek05x+zQZ6AqezVLxU9OH2YyCtBBnBNESEcerbvZKAtEu8LiLadeAiE1Q3t5zqD46++lL+045y1
        Wl41sm414DuE8A/HODG2a3XI2rZm3z4+ZAX6Odx5D3koIN1OF7/eaSHReehLU/4OGEH5awyIieI6y
        IEMUNOOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHhaS-00DMfV-8l; Tue, 17 Jan 2023 08:44:56 +0000
Date:   Tue, 17 Jan 2023 00:44:56 -0800
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
Message-ID: <Y8ZgCA90yNOYpDZG@infradead.org>
References: <Y8ZTyx7vM8NpnUAj@infradead.org>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <2330920.1673944104@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2330920.1673944104@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:28:24AM +0000, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > I suspect the best is to:
> > 
> >  - rename init_sync_kiocb to init_kiocb
> >  - pass a new argument for the destination
> 
> Do you mean the direction rather than the destination?

Yes.
