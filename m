Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FDF11C9DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfLLJup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:50:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfLLJup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y6+hXmrMwI7HSNQJYQnnyz+cMY2EG82u3RNWSxKZkoU=; b=qjBTtwgCdMX90dNElGL0hqVAH
        w0js+bnF08cEA4u+Ub3PQITrC1Zk90ulGyUfODvbnTvdpCbZCXu/ecUxkS2k7NeRSaQ6K1s6/sbL2
        g4OEJ7FfRgS6U31vWcygcSP6ecd75bjy259ahbflLeqafqBv0KwRewBDG4SgsMrlWwrZDpMbsM9AK
        koQwfGSuYL5H7xAXSftKHXj6UdzO0jYEO02Ogf5Baoz8S87KqmBsPMXBjaS6mPIeun2SyKzWhEJc4
        QLAmnWmZwxdFDYvgXXPpNtYw2n5kTsYvcGOPlEFXjdLMTvgvTUEp7+0T85XLUQ+j9UHhrPLBBKumM
        Ghl2QUF6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifL7M-0005s7-Dr; Thu, 12 Dec 2019 09:50:44 +0000
Date:   Thu, 12 Dec 2019 01:50:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        dsterba@suse.cz, jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191212095044.GD15977@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212003043.31093-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:30:39PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as btrfs can perform direct I/O without holding the
> inode->i_rwsem in some of the cases like writing within i_size.

How is that safe?  

> +	lockdep_assert_held(&file_inode(file)->i_rwsem);

Having the asserts in the callers is pointless.  The assert is inside
the iomap helper to ensure the expected calling conventions, as the
code is written under the assumption that we have i_rwsem.
