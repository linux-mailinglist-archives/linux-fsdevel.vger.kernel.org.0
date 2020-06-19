Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AE2009CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgFSNSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFSNST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:18:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8BC06174E;
        Fri, 19 Jun 2020 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b0goR5/zxlpemil3+FImPZfqp9ezrFkx/bKeIQ1Vi3Y=; b=beQs5fo4caTmQK19KVmCCUe+WH
        mp5fNCExITVOO4vQ6QZnRM6VBvLLvprtOikEmZmWk7LsaRUPriohXmuAeFYVKAup/UbQOfN/UHXL+
        G/fO2P+D7SPRSkQDsCvIhvMAUS8KSQybkK8rL8njwvjPT0EpnwcJbbrhdiUtkt6B7F15a0xmrvj8L
        LytefAzzF9mptH0PRRM26FcWMckIdgpK2g+oobumbcDgZkkL5B08fddlDtH9mqxhOZ+Ryhc+4A2VI
        XjTbad789qG1x/14jfZz06dqX4z8TyR0ldzOatg1+vePs7+2D7FXaE74SzLbj6hUfLkbdXYmdYln4
        n41Af6/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmGuO-0007Ah-Sc; Fri, 19 Jun 2020 13:18:16 +0000
Date:   Fri, 19 Jun 2020 06:18:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200619131816.GB15982@infradead.org>
References: <20200615160244.741244-1-agruenba@redhat.com>
 <20200618013901.GR11245@magnolia>
 <20200618123227.GO8681@bombadil.infradead.org>
 <CAHc6FU5x8+54zX5NWEDdsf5HV5qXLnjS1SM+oYmX1yMrh_mDfA@mail.gmail.com>
 <20200618135639.GA15658@infradead.org>
 <20200618151523.GQ8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618151523.GQ8681@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:15:23AM -0700, Matthew Wilcox wrote:
> Thinking about it, wouldn't the second test be better replaced with:
> 
> 	if (WARN_ON(iomap.offset + iomap.length <= pos))
> 
> in case the filesystem returns an extent which finishes before pos?
> This would be a superset of the test for length being 0.

The idea was to tell what is wrong.  Both with the initial iomap work
and later the COW support I had all kinds of weird scenarious during
bringup where an obvious error has been very helpful.
