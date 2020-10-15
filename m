Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606AA28EF94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbgJOJuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388789AbgJOJub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:50:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE7C061755;
        Thu, 15 Oct 2020 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SmhPOEKlg8B9Ue4+tpOAHnyB1Q0cAYxCWwGQMonkZRo=; b=ZKpAiKInggcUILdKOs6fbLqRMg
        DRqB959WGnrr4svCrtl4yj/P8OYVYt3aEoe7A3KiurmT5taMM50g/w+jvAVbXuA9ulMZvJzPcJnUB
        b5Ruo0Y4tn4mMTg2DC4UMxe/ixzFTxfBNHEtREcSZDjL/gwfHAzPJC2xS4D4/5MbKf4p2jiOAclZL
        74vbF807sv6Cd7cOfUOuYrVQadd1RvbXjJEqedppv1Sw9WQ/VBPcsWUsDfXE7K+CPkutnmu+BZdDU
        6OqFiwo0OB+LU63OgaYVYO5jqXihm2tcbsmIh3OCoTQDSsXnzccbpIZ40YLHNIUlZ7reMvWY9+kS7
        +P7LffJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzu1-0006Cv-FC; Thu, 15 Oct 2020 09:50:29 +0000
Date:   Thu, 15 Oct 2020 10:50:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 03/14] iomap: Support THPs in BIO completion path
Message-ID: <20201015095029.GA23441@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
 <20201014030357.21898-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030357.21898-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:03:46AM +0100, Matthew Wilcox (Oracle) wrote:
> bio_for_each_segment_all() iterates once per regular sized page.
> Use bio_for_each_bvec_all() to iterate once per bvec and handle
> merged THPs ourselves, instead of teaching the block layer about THPs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This seems to conflict with your synchronous readpage series..
