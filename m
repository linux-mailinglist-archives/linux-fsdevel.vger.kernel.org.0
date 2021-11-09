Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259AE44A9A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbhKIIuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhKIIuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:50:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16683C061764;
        Tue,  9 Nov 2021 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PBOzNrsV4A9wCCmGrmISDgCyMiVuWn8YI6+FumKvyYY=; b=w5Js4Qtqeb8DD52GUAhXFFCIzH
        yn9zTTHj0In3cqCKoaJmO8IPGTHZWeYRwWQRGA2p+7F+YS1aPGKQk9XjY0hvv+FAigqIkUM4dRvxF
        nKvLYrIQKr/wb+pE+ZfLo/ogJcbnK4dNw5SVYg0v10ySIfIceUwfA4SkZPQnhYBRK1L2o/kf/VoHq
        DZMLmmFyGv/OsWuTTamQDSdU5/vKJ35tctsb5eWXyXpH/Ca9AM+6Axt+X1e9NrGhxMFOuEVy5ikhw
        NuMqWoDSeDuW0tg3iOKqr9fVI8w5v47yKpVk2JSTDNOhMn534LCzoOrOb6rREJ6XnmQvJqHL2Jwgz
        FZg+821w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMmw-00159k-6K; Tue, 09 Nov 2021 08:47:30 +0000
Date:   Tue, 9 Nov 2021 00:47:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <YYo1ony4/ds5C7Nd@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:42AM +0000, Matthew Wilcox (Oracle) wrote:
> The zero iterator can work in folio-sized chunks instead of page-sized
> chunks.  This will save a lot of page cache lookups if the file is cached
> in multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

but it will clash with my just sent series that decouples DAX
zeroing from buffered I/O zeroing and folds __iomap_zero_iter into
the caller.
