Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05210A22F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 17:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfKZQdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 11:33:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKZQdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cP6D8d93btaoA8qKKMvE5cAQ11moEVEbDuB/dLF9EyE=; b=O865r2R5Df3+XvnupVgKsHKR7
        N+KUqyQTu01ck0k+RGuNCnvWDOXz7KHLCfS8l/GsJyvXcmIQ6RBDborEb6f0ta0fPiQDiIaVtsl2n
        iFvwBw8eA0/Z0sQ4qintTOrKzZbOzr56Rd/Jn15ThIhKWQ8N9HfajwHZ4vLTBm2ee7++zRj7QcnGD
        ROfwSDHIaVb7+UFgFQxUgequQ6/OY0xQGr0ihFwX+MqOJ9Di0d6e3TbsmfDPWrAj0KX+AFWh4ffv7
        Vug3oVJnr52Eav3PwickrC1puoquU+b/ti23rL5+SsQa6lYYe6uM3Je87dd9aoAKevQCasRMROtcX
        jyBhJcMWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZdm7-0005YJ-4G; Tue, 26 Nov 2019 16:33:15 +0000
Date:   Tue, 26 Nov 2019 08:33:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, linux-fsdevel@vger.kernel.org,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] f2fs: Fix direct IO handling
Message-ID: <20191126163315.GB3794@infradead.org>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126075719.1046485-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 04:57:19PM +0900, Damien Le Moal wrote:
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5755e897a5f0..8ac2d3b70022 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  	int flag;
>  	int err = 0;
>  	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
> +	bool do_direct_io = direct_io &&
> +		!f2fs_force_buffered_io(inode, iocb, from);

I don't think this is the right fix.  The proper fix is to clear
IOCB_DIRECT when falling back to buffered I/O, preferably in the
filemap.c helpers as well.
