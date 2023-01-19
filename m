Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D9673F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjASQrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 11:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjASQrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:47:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB11705;
        Thu, 19 Jan 2023 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qOrQSG3CyNZqwNHCXUk4cZILY4WBWB5Fk6DMsXQZlPI=; b=dv+Q8SRNlAfNqBSRp0Em8Jl7aw
        Be+1BVlHWVF6wRCWnsXlbeIMihy5C7kPU2q8GprKUxGcQjgXLPudigh9CPmjNy2WGkGW9c6Zf+U9i
        Q+wtAw77ceVRrazH0CUWMfguys9eO9/6Qxz2s+xic93pxjUdBDSxa8X+Ly5PgfEYULETqEPmE1Fse
        FE3QET0fgAXuBcE/l8CBYCKNz3qd5XBowMXBtKMwhBzK/QeYreAvHemxuRQQ2Wv3lOPxpkrGXFhs6
        hjjxQnLlW47WVrXrmsES3q8tt3JuKOyMCV/yXzY49BIJ/AEqkNxceraqCnmPFhPSUmK2wPvYLGEKk
        EgjkChsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIY3t-0065Hq-3l; Thu, 19 Jan 2023 16:46:49 +0000
Date:   Thu, 19 Jan 2023 08:46:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in
 call_write_iter()
Message-ID: <Y8lz+dylIUoMzckI@infradead.org>
References: <Y8htMvG33I73oG9z@ZenIV>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
 <2724947.1674122486@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2724947.1674122486@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:01:26AM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > 	Which does nothing for places that do not use call_write_iter()...
> > __kernel_write_iter() is one such; for less obvious specimen see
> > drivers/nvme/target/io-cmd-file.c:nvmet_file_submit_bvec()
> 
> Should these be calling call_read/write_iter()?  If not, should
> call_read/write_iter() be dropped?

I wish they'd just go away, they are a bit of a distraction.
