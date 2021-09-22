Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F37414138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhIVF16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhIVF14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:27:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FBAC061574;
        Tue, 21 Sep 2021 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E4QmGfF8PZSooK1M54CX3ENwACNcGJeNerat+O5YjO4=; b=QpyRbwQS1oTQwsC5euvirJgCBw
        keBMcROQSMtHTMrynH3d96bmqnrLfigJdMdXxUpe71Zwx7WQHxnmyS4XzNjP6SmmfOsKhbtFLeWUj
        +tdgixCGUHoFv74yqAfbHUHZghnl7lIlu2cXocAQ40qp5NnWQE7AigssJdJAtnJPTyRdwZaCh00/+
        JwqOmYYQWN+dlQhj4hXhu43qSg9gjSvKRP4pCc/8UgWuWLgcF6Mvnf3iesHrMggAX70H5SvZo4u3P
        yP1AQazdOMXTIw18zkB3k/E+vJen7brfoTCEE52EnwC+X7CGuYbz/qy0GHcizuSzgKO172K1FbpRz
        2PkkYvGw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSukx-004TQ5-6I; Wed, 22 Sep 2021 05:25:27 +0000
Date:   Wed, 22 Sep 2021 06:25:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH 3/3] ext2: remove dax EXPERIMENTAL warning
Message-ID: <YUq+P/5NG61CqszV@infradead.org>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <1631726561-16358-4-git-send-email-sandeen@redhat.com>
 <20210917094707.GD6547@quack2.suse.cz>
 <YUSRHjynaozAuO+P@infradead.org>
 <20210922023622.GC570615@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922023622.GC570615@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:36:22PM -0700, Darrick J. Wong wrote:
> 'still a mess' isn't all that useful for figuring out what still needs
> to be done and splitting up the work.  Do you have items beyond my own
> list below?
> 
>  - still arguing over what exactly FALLOC_FL_ZERO_REINIT_WHATEVER_PONIES
>    should be doing
>  - no reflink support, encompassing:
>  - hwpoison from mmap regions really ought to tell the fs that bad stuff
>    happened
>  - mm rmap can't handle more than one owner

My main really big item is that we're still mounting through a fake
block device, suporting partitions and all that crap.  We need to sort
out the whole story of how pmem/nvdimm is actually treated, because
what we have right now is not sustainable at all.
