Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3E15F720
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgBNTur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 14:50:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387508AbgBNTuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3womVZzJfvJ/ZynJrzvKSuPFFEQ+5OZC1GleOd63lI=; b=mys1IIw2ciRDnnOg1+a/L/beW1
        7357IOcpU71f4WaOx5BF1LNC2w+18SN0vPkn0BAx47JJT1ekmHmdX8FSwWkmEYlpgtTfg19s9Abjz
        C63qA8m0b0CEy2AU9q7BlUDy99a16ZDwgMirXJrhg4DHrx0SPqZfihei8HMA11pjNBbVUpwLheoUP
        jvjy8FNDkU4VCt+tgQUnXJCoHFertNTu6iJOjBK/+hVJcmhn8+NpTpozWdqIMq0dPCfOJZW/tcUNw
        +8WmZZnCzebTqfb9kxxclwCAtZbdVOz7PFPt4fNiEzN9DwwuCPfQtrzfGXQYwl5+/DdizCTTOIeUg
        sfUqC+fA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2gz8-0001km-Ao; Fri, 14 Feb 2020 19:50:46 +0000
Date:   Fri, 14 Feb 2020 11:50:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Message-ID: <20200214195046.GC7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211010348.6872-2-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:03:36PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ra_submit() which is a wrapper around __do_page_cache_readahead() already
> returns an unsigned long, and the 'nr_to_read' parameter is an unsigned
> long, so fix __do_page_cache_readahead() to return an unsigned long,
> even though I'm pretty sure we're not going to readahead more than 2^32
> pages ever.

I was going through this and realised it's completely pointless -- the
returned value from ra_submit() and __do_page_cache_readahead() is
eventually ignored through all paths.  So I'm replacing this patch with
one that makes everything return void.
