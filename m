Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8082B8045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKRPSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgKRPSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:18:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE094C0613D4;
        Wed, 18 Nov 2020 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E5AWr005ZKFbj0xARuPSwpcPr63RRv1/s0GYEoynaDs=; b=UQTdS4lz7RdwKWWIgtMBMQ1+94
        EYYX9vjZJ73KleKO1k3dSus0T2TpUbs23iRbpKidfOCx8+M59jJ+tf4yJuMUOy3dQUg10JWBqopEH
        P32VgTOKCTxTwbETMy53ukX/cJ4J59SDLRwI+oRrHhTtpXUr37FyigVMIolrGaUzGUMawxJLHLO2d
        RWa1OouI62+Kllslsb+CubbOARYbRtPHDB6GRtARxGWFHlAG6lixtJHa3FND8TJHORFipJZuyZwxr
        5W5rdcvby3IS1P6ItpkIL5haQB4tYIY5JpDfcXwq7r7hRYHXmDvF2E0V/5BU2cLyBwLsFCtQIKqc2
        tMtnsiUA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfPDi-0006mk-KJ; Wed, 18 Nov 2020 15:18:06 +0000
Date:   Wed, 18 Nov 2020 15:18:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: convert to ->write_iter()
Message-ID: <20201118151806.GA25804@infradead.org>
References: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:19:17AM +0100, Michal Kubecek wrote:
> While eventfd ->read() callback was replaced by ->read_iter() recently,
> it still provides ->write() for writes. Since commit 4d03e3cc5982 ("fs:
> don't allow kernel reads and writes without iter ops"), this prevents
> kernel_write() to be used for eventfd and with set_fs() removal,
> ->write() cannot be easily called directly with a kernel buffer.
> 
> According to eventfd(2), eventfd descriptors are supposed to be (also)
> used by kernel to notify userspace applications of events which now
> requires ->write_iter() op to be available (and ->write() not to be).
> Therefore convert eventfd_write() to ->write_iter() semantics. This
> patch also cleans up the code in a similar way as commit 12aceb89b0bc
> ("eventfd: convert to f_op->read_iter()") did in read_iter().

A far as I can tell we don't have an in-tree user that writes to an
eventfd.  We can merge something like this once there is a user.
