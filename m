Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9668A316F60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhBJS66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhBJS44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:56:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5BC0613D6;
        Wed, 10 Feb 2021 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+PqtmptnFGsbV5QuCubckX51ZacoPWPqb6Ggw8fQ4tM=; b=HhdIIz1GYcu+wUpQbO4kQ5DGRJ
        fENxXrxsslWnmQEh482trsnd1DTShiTGAHLHs0aGjt5ONxjDR4g4tcWaWfGLLQ3dkWcYwmyBqq/xz
        zu5sQyOo2ikkXGvISKiY1NCW5r1iWkzN83Q2D6ElXO2FAVYxsFkZYB0HTczJlc2ZzGkm6jpkJkACT
        rqEzNUHnCe4i+aPKbhFisIyGNxO4+/c9gIKLEinDK4JkfpGZxuawKXj5+XgUn57QLf0l9psxEZSwP
        PZPL0k8l5kC6hwjqNYNw4GQBbbOpQCWUB40SVRxvaMvXvkT1NHALASp8S9Msr1tKWjWKvvLicDqFi
        gisCfInQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9uek-009G0l-HW; Wed, 10 Feb 2021 18:56:07 +0000
Date:   Wed, 10 Feb 2021 18:56:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210185606.GF308988@casper.infradead.org>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
 <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:29:01AM -0800, Ira Weiny wrote:
> And I thought it was a good idea.  Any file system development should have
> tests with DEBUG_VM which should cover Matthew's concern while not having the
> overhead in production.  Seemed like a decent compromise?

Why do you think these paths are only used during file system development?
They're definitely used by networking, by device drivers of all kinds
and they're probably even used by the graphics system.

While developers *should* turn on DEBUG_VM during development, a
shockingly high percentage don't even turn on lockdep.
