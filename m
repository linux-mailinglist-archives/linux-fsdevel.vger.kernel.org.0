Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454F26B5BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfGQFFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:05:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cO7d/Le5SoHQ3INToywYmVf9xeJSGSyZ/NWV26VS9pE=; b=XpuwI4p/JllT/9etN49LmPPzJ
        5Q44/TDIgb4lYe7Dqe9Fn3yEE7285ei8m5ioa7xxSNbm5GXcfkxiQ8onayy831EqckdnlhpFbE1EI
        tK4Zat4kuAZ1zRqXvJrLAH1Da/Nk2oux6jQliAsREAJRgSceLv0hcsqJrOgqWCoPcEePOiQ6ZTblg
        rxzJIksWEhZVZeN0i+MeOi1w1QKUWY1qnSS8iR3V6s++V2gklcf8Msc8lldCGUkMx8DIxIDcyEioL
        iW2v4EGI98vqRMdzgqEh+h0e46uGXYSfHAnDNVAaaMPSCJCNfRgGMgTS8czMQrpaSw4pgXoJg2jaC
        Nv6u7AOhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc7j-0003nJ-CN; Wed, 17 Jul 2019 05:05:03 +0000
Date:   Tue, 16 Jul 2019 22:05:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 7/9] iomap: move the page migration code into a separate
 file
Message-ID: <20190717050503.GG7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321360519.148361.2779156857011152900.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321360519.148361.2779156857011152900.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I wonder if this should go with the rest of the buffered I/O code into
buffered-io.c?  Yes, it would need an ifdef, but it is closely related
to it in how we use the page private information.

> diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
> new file mode 100644
> index 000000000000..d8116d35f819
> --- /dev/null
> +++ b/fs/iomap/migrate.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2010 Red Hat, Inc.
> + * Copyright (c) 2016-2018 Christoph Hellwig.
> + */

Bit if you don't want to move it, this is all new code from me from
2018.
