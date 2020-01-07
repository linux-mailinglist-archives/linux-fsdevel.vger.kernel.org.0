Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45100132CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgAGRVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGRVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uevi7FbC9uBZD1v14GIl5YIUfGl71X79PMn1NLKpP9U=; b=BTDzV9+CaTu/8amNad4ljWtas
        BB1ii77dgdq7SGFcXyMYg4/4GmPmDUzhMRArJyjbI/71G6anu29CiI2XbxFMGBxZjU0MQh0XAu/24
        PIhEga4eyKRR4B5G3QA5U/ojHQAXWLfD5sfPpXjSjX2jUXnx5jbKV5pGqaW8UopwhcbMxpC/w9bCx
        NLqiWNt2+xfM04cqwyWhoIlJNDKayH4qsriQ/fNOXQFmKtaBjOt37j79fdyt6Sv8kypnN4P7mwvt/
        ErUBWcsuzPYTzB7GK7rgVQ1TZpAqD0fstW5Ow0Z9dsVJk7c99ZnG1Tb98DPjJIsgaNib3pcC/wJVw
        /whRGWbNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iosXb-0004NA-GS; Tue, 07 Jan 2020 17:21:15 +0000
Date:   Tue, 7 Jan 2020 09:21:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200107172115.GA11624@infradead.org>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-5-rgoldwyn@suse.de>
 <20191221144226.GA25804@infradead.org>
 <20200107115909.h6zdojchvpvqbi2z@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107115909.h6zdojchvpvqbi2z@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:59:09AM -0600, Goldwyn Rodrigues wrote:
> Testing revealed that removing check_direct_IO will not work. We try and
> reserve space as a whole for the entire direct write. These checks
> safeguard from requests unaligned to fs_info->sectorsize.

Ok.  The fact that a wrong sector size falls back to buffered I/O
instead of failing the I/O is still bogus, though.  Btrfs should align
with all other file systems there.

> 
> I liked the patch to split and fold the direct_IO code. However to merge
> it into this will make it difficult to understand the changes since we
> are moving it to a different file rather than changing in-place. A
> separate patch would better serve as a cleanup.

Sure, this can be added on top.
