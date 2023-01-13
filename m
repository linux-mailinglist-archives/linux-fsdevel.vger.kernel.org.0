Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A216668B65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 06:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAMFdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 00:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjAMFcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:32:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3C62196;
        Thu, 12 Jan 2023 21:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ZokzrN3drri2VnDFvX4Yx8up6Mxws4RudIL/WSG8j4=; b=Ec8rKXY99njoRlW0Xn2VbcvkRw
        IQweKuBEzdzi+UtfUbaQzhw+hA8gXzoU5dvgjLOIurHhfsTAD6WxEfrzMm8vYDsQFLWsnCYPBVmQ+
        MhNp6imDiqrd2SF3umPbVCyUs0KJD2bj1m9OPPJuGRwx6HAO5e1okebU+TWe8+qJfArF7AZDfE2bB
        5Lsct7A0rCgMmrKTeeskDFyN1Uv2WgqWeqy0zQ/y4LomEz/aA8MCx+cSdNdfxb+/STTrVqvynmW4b
        5B5RvZ/8f2KfNWjNv4Pdf8vsHyrX1N+mO5BRvNtTj4WVLQBnrwDdd/VNi+M/GfffJ5xbFqv+la+WL
        AjASTIlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGCg8-000VRY-BD; Fri, 13 Jan 2023 05:32:36 +0000
Date:   Thu, 12 Jan 2023 21:32:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bart.vanassche@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8Ds9JbWNGlWnoj9@infradead.org>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk>
 <Y8AUTlRibL+pGDJN@infradead.org>
 <Y8BFVgdGYNQqK3sB@ZenIV>
 <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:49:14PM -0800, Bart Van Assche wrote:
> I'm not sure that we still need the double copy in the sg driver. It seems
> obscure to me that there is user space software that relies on finding
> "0xec" in bytes not originating from a SCSI device. Additionally, SCSI
> drivers that do not support residuals should be something from the past.
> 
> Others may be better qualified to comment on this topic.

Yeah.  And that weird (ab)use of blk_rq_map_user_iov into preallocated
pages in sg has been a constant source of pain.  I'd be very happy to
make it match the generic SG_IO implementation and either do
get_user_pages or the normal bounce buffering implemented in the
common code.

