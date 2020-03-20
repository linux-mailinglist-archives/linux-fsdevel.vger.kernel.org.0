Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2618CFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCTOFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:05:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTOFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n/bVoNnai1Z8EXWktYzvjCdfjvG9IjTbEvaQWdguc00=; b=KGA9sdjQ6eq6QDNOVK8h4ctiJ1
        /gV7+CS9MAOMaFFmpVVrRlxA2A1cNVTAH9Sq5UJPx/qrYuBmi1Cn0SvgaJ9d4i3ro7AOicxt8v2t4
        RFWU+EulSXyA+okLM07zYfw4iM+Y5zW5srrU+S2L6xBeL5TXTsDCeAVmB2Ka1HEqzbb8NhjYostj4
        +iautOBEwNfRV1kHmqzd5AeLbM0CYkK5fanTBby5q9JQHfRWJVf2vAPyXSQbayIfL6e5U+wLDCp8h
        XuAiN304YJULVS0U4+uWWstaw97IsQcQ/+N9AJcUOANkwXJYfhC/KB2FU1ES0mz6wp6FFLAe+e6c2
        Ic9Q557A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIHK-0002Cq-37; Fri, 20 Mar 2020 14:05:38 +0000
Date:   Fri, 20 Mar 2020 07:05:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, willy@infradead.org,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200320140538.GA27895@infradead.org>
References: <20200319150805.uaggnfue5xgaougx@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319150805.uaggnfue5xgaougx@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I spent a fair amount of time looking over this change, and I am
starting to feel very bad about it.  iomap_apply() has pretty clear
semantics of either return an error, or return the bytes processed,
and in general these semantics work just fine.

The thing that breaks this concept is the btrfs submit_bio hook,
which allows the file system to keep state for each bio actually
submitted.  But I think you can simply keep the length internally
in btrfs - use the space in iomap->private as a counter of how
much was allocated, pass the iomap to the submit_io hook, and
update it there, and then deal with the rest in ->iomap_end.

That assumes ->iomap_end actually is the right place - can someone
explain what the expected call site for __endio_write_update_ordered
is?  It kinda sorta looks to me like something that would want to
be called after I/O completion, not after I/O submission, but maybe
I misunderstand the code.
