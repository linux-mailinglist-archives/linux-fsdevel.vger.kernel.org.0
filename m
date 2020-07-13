Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067DF21D559
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgGMLzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgGMLzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:55:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FFC061755;
        Mon, 13 Jul 2020 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLFAndwWzTjXcjnnkj0cK4pUDHXUjgGWKnCg3eg4tXM=; b=Wvox2aLkDPEvhLsNc8WLk8VuxN
        xPWa5UDz8aYe9P5zJ+iqipvSHOKSGNpfGWKJ90n3oAkFae9hwImLp2oyMFY26LUS8p7oRFmm1EOrk
        GsdQ2rohZpQTT2JQYj7UFW2FHZWWlacHmPTPyaA7ruva9c4AdVnNm7AgjYAKYA+hYGcsZMDxjvCCT
        XbsY4Y8m+4bbsHFX/xb/NGFM+AbEkO6+zKWaXka6j42QDYcnM07egqolsUOgew2hIhPdPuoBYH15P
        aA07FbQRV1HzgQlT0aLwJqJjPQe0dZ+pfMhgEVlHGn08RDdlCExt4NJMVagrLr07ES52oDA9pCznS
        GxrMiqpg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jux38-0004gc-1T; Mon, 13 Jul 2020 11:55:10 +0000
Date:   Mon, 13 Jul 2020 12:55:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: fall back to buffered writes for invalidation
 failures
Message-ID: <20200713115509.GW12769@casper.infradead.org>
References: <20200713074633.875946-1-hch@lst.de>
 <20200713074633.875946-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713074633.875946-3-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:46:33AM +0200, Christoph Hellwig wrote:
> Failing to invalid the page cache means data in incoherent, which is
> a very bad state for the system.  Always fall back to buffered I/O
> through the page cache if we can't invalidate mappings.

Is that the right approach though?  I don't have a full picture in my head,
but wouldn't we be better off marking these pages as !Uptodate and doing
the direct I/O?
