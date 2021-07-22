Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D83D2AAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhGVQSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhGVQRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:17:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E5C0617A1;
        Thu, 22 Jul 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fY1GU33NdlDCFwWGiRlEzVzzUv/E61mi0egIUEebmpo=; b=F5eMUIgNSgTJAoMmkWgV7WEaGk
        SyNUL6h+5z5WIgAKB5tCR1lkqGE3SxjCuK5WMPc8OMeVu+eRh6kAWuAa9nw9xl+4hE1AG6ioLCA3E
        nsKtOKkZ0LrfrTD3baDwTn9nGp0WrYzQ6fmaUjEBIX7+Y63IU2TbEdFB6iT6hXmBUq+1s0Fw9ig5B
        nGN36cEvC0sYRIGb9q0I80Y3l2Fx0ZCabOKq4WDAzLvquEO8JwXD4UmOQsp1f8aMGNWyeGtF/g+iD
        03p2q4UXX9Pr84W+9WN75zicYa5nvTQEPOxczUrjSBFOTt1MixsMTewOzxUvEDbPmCMIPW8zWvoqP
        DNYGIM0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6c0Q-00AUeF-Ty; Thu, 22 Jul 2021 16:57:16 +0000
Date:   Thu, 22 Jul 2021 17:57:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPmjYieZ57WVsQx9@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
 <20210722165109.GD8639@magnolia>
 <20210722165342.GA11435@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722165342.GA11435@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:53:42PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 22, 2021 at 09:51:09AM -0700, Darrick J. Wong wrote:
> > The commit message is a little misleading -- this adds support for
> > inline data pages at nonzero (but page-aligned) file offsets, not file
> > offsets into the page itself.  I suggest:
> 
> It actually adds both.  pos is the offset into the file.

If you want to add support for both, then you need to call
iomap_set_range_uptodate() instead of SetPageUptodate().  Otherwise,
you can set the page uptodate before submitting the bio for the first
half of the page.
