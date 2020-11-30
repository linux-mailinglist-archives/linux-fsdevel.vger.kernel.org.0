Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602612C8943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 17:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgK3QU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgK3QU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:20:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E9C0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wuvr8ktVu69oBt5AzogUblhmO6R3zydGLW0PXV6ptfA=; b=rarYP6MJNSuwkUW/BXQfgudtCq
        WT43w7FbTs4v7ArWprg+1ZbMqLTnN0/8RTgpY6FATWjDSHMSpiEFq4kjAHXLZoyPVuQcbV366xIER
        LXrgbhDjjRq9WKi0v5Y9vrvEq2kR2aVKzBOhI7F8ZA/9xOEzTD1Btsev5rNKmkDoIMuNecDBRe0Ee
        vYI+BjNe+Gpx2yK8M5wsP95nMQSZsxcgoTfEGPU6T8iy0Ac5xdyNmto3LLsfwZ3fd3WwMa8R2UxCL
        ImBvY6K7Ds+0PAl/74kc0PKnpVHirSOB2tdqLUEGeBFYw+XWVQqzpewQ8sQkOrEDeoNpnD1RrVb2z
        Ony+mYKg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjlty-0008E8-PZ; Mon, 30 Nov 2020 16:19:46 +0000
Date:   Mon, 30 Nov 2020 16:19:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Gong, Sishuai" <sishuai@purdue.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Race] data race between do_mpage_readpage() and set_blocksize()
Message-ID: <20201130161946.GA30124@infradead.org>
References: <A57702D8-5E3E-401B-8010-C86901DD5D61@purdue.edu>
 <20201130161042.GD4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130161042.GD4327@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:10:42PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 30, 2020 at 03:41:53PM +0000, Gong, Sishuai wrote:
> > We found a data race in linux kernel 5.3.11 that we are able to reproduce in x86 under specific interleavings. Currently, we are not sure about the consequence of this race so we would like to confirm with the community if this can be a harmful bug.
> 
> How are you able to reproduce it?  Normally mpage_readpage() is only called
> from a filesystem, and you shouldn't be able to change the size of the
> blocks in a block device while there's a mounted filesystem.

mpage_readpages was also called by blkdev_readpages.  For current
mainline s/readpages/readahead/ but the effect should be the same.
