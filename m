Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9532B4E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450163AbhCCFax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235382AbhCCBbX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:31:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B1E64E21;
        Wed,  3 Mar 2021 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614735040;
        bh=OF8WUPKSv4QXc/+YPWIqmJarQdHRZfG1pwud0AaXB9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Px3O4abFVJu9eUSMf9VaWKMuxsy66RLx0Lx7pWv0Sl7yoYE0IZMJtGTGjGpvYtShx
         kPXTmRk05YMHg9YPfXNuQufBngiDT2dYPdPRZZi4m9ACvuAzniw16o7b6XzfcK8tnC
         bfBBq6PNazSz7XQPt5GY6rrVQmMCE/eAIF790xUA=
Date:   Tue, 2 Mar 2021 17:30:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-Id: <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
In-Reply-To: <20210226140011.2883498-1-willy@infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 26 Feb 2021 14:00:11 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> After splitting generic_file_buffered_read() into smaller parts, it
> turns out we can reuse one of the parts in filemap_fault().  This fixes
> an oversight -- waiting for the I/O to complete is now interruptible
> by a fatal signal.  And it saves us a few bytes of text in an unlikely
> path.

We also handle AOP_TRUNCATED_PAGE which the present code fails to do. 
Should this be in the changelog?

Did we handle AOP_TRUNCATED_PAGE in the pre-splitup code, or is this new?


