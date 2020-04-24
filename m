Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9E1B827D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 01:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXXlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:41:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311CC09B049;
        Fri, 24 Apr 2020 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WxK8Rb0X2k+JQt/gEfPjjJEwVKjrTPs7QnwkljElXIk=; b=LXhSKDmKbYZ9Av9HB4KZYhMCIS
        1hFh8iQi+Jo4TcNrwTPQAjVmdTKyQ0xcoJ2vLnb1IL/zrkY3WB48c3OF2R3yvGUBP5pswlKeKUOOX
        iWi+UbJ2rumi0PNQI6WaBJU/qCWF+0csDIf9U1yuJn3cYvmjRbeDUJs7+IIGS37fmIw92IqyLQ8Qs
        2CN4sVNcKs2k2mLe3rq7fLy5+OmD80RVXkctoFO+eJC3RzFL9oCZ/2pEDqq4F3WS6zqVab8zqs3RY
        xCu2x13ZJVRQCW68xwGK3aQhrvCeAPodGTrnvxfKo0BPmkIkMVb9UwuwMQvOk+ouoGinwvL4WlpbR
        E4AnfuTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS7wI-0005hv-Sh; Fri, 24 Apr 2020 23:40:58 +0000
Date:   Fri, 24 Apr 2020 16:40:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200424234058.GA29705@bombadil.infradead.org>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
 <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 04:24:24AM +0530, Ritesh Harjani wrote:
> Ok, I see.
> Let me replace WARN() with below pr_warn() line then. If no objections,
> then will send this in a v2 with both patches combined as Darrick
> suggested. - (with Reviewed-by tags of Jan & Christoph).
> 
> pr_warn("fibmap: this would truncate fibmap result\n");

We generally don't like userspace to be able to trigger kernel messages
on demand, so they can't swamp the logfiles.  printk_ratelimited()?
