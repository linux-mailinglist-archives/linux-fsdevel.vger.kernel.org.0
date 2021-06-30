Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081A53B84C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhF3OMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:12:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448EC061756;
        Wed, 30 Jun 2021 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A3llWSJyBwsjhXoBVgIE0Mwln9OHuVCgoAImdSXn3nY=; b=CVRIyWQQ8wWaRdbyZaBZnrY/8D
        52Nm3qWgN3idELMwtumo0VRdlCasg5YE5BbjnsCTd/MTbTa2rNepHJocnF4S9sjGa63HD1PX8WSNM
        kZAcG1G5Y5dAV900GN601KjQPe0Ni2W5xNgSBMimHIsV+DfJpr68s5uZMzFNuXidjmSCiIe1Mip/J
        gjcFpCfnWdcuSG2jtzpnFfZPO/C0WVj5BlQbGu3HJvZhDcX+1p5aoFukKUk8ZKrCgjZcHwdZNbtby
        Er3vj/OMVQd1WAUoJBv6nN/QgLDQEuMj8Nc/8IO+6pjCbNLkunFW1F5k8Mua+S1ikZvwGZIhh8Yd7
        W9kFtkCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyata-005Qpq-4r; Wed, 30 Jun 2021 14:09:09 +0000
Date:   Wed, 30 Jun 2021 15:08:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNx69luCAxlLMDAG@casper.infradead.org>
References: <YNoJPZ4NWiqok/by@casper.infradead.org>
 <20210628172727.1894503-1-agruenba@redhat.com>
 <20210629091239.1930040-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629091239.1930040-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:12:39AM +0200, Andreas Gruenbacher wrote:
> Below is a version of your patch on top of v5.13 which has passed some
> local testing here.
> 
> Thanks,
> Andreas
> 
> --
> 
> iomap: Permit pages without an iop to enter writeback
> 
> Permit pages without an iop to enter writeback and create an iop *then*.  This
> allows filesystems to mark pages dirty without having to worry about how the
> iop block tracking is implemented.

How about ...

Create an iop in the writeback path if one doesn't exist.  This allows
us to avoid creating the iop in some cases.  The only current case we
do that for is pages with inline data, but it can be extended to pages
which are entirely within an extent.  It also allows for an iop to be
removed from pages in the future (eg page split).

> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

