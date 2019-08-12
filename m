Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F48A425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHLRSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:18:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLRSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2hDI1ZzVIacAqTMuHLmt8TLr06BIGisIfD/1FImKGgc=; b=q+nc2GKq1xRiRsCrjqQxkIEEE
        lmMbVUI3DOl6jvyDMKiXV8pEAZIIjR3EJ1GftbzjTOhdEbCvEM6FdRkAoXj118SrvsWgkCWZDosyH
        iVOFuaMOcBfiaV9z9KgfVJy5f18/3oiuAWDY9EgT+n3ZKMtRcUZrGfAVhYbxJ+K4Ti0rH2NjY+j9x
        MPUqdY0ceYy00oUtGSlLkRasi7RI44PrDDE57+qaYOrWkDGr7FSlheBdjuslWdR+0N9Znn/fqJ8CI
        5tPnf6LOCSHmsmUxB54rmnTcdJIJN+yDx5i9IIyi2UbUz8JCFtOuQL6UFM/f/wEZp6/cx3tan0XHV
        E/Nevnu2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxDxv-0001NR-Qr; Mon, 12 Aug 2019 17:18:39 +0000
Date:   Mon, 12 Aug 2019 10:18:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 2/5] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190812171839.GC24564@infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:52:53PM +1000, Matthew Bobrowski wrote:
> In preparation for implementing the direct IO write code path modifications
> that make us of iomap infrastructure we need to move out the inode
> extension/truncate code from ext4_iomap_end() callback. For direct IO, if the
> current code remained it would behave incorrectly. If we update the inode size
> prior to converting unwritten extents we run the risk of allowing a racing
> direct IO read operation to find unwritten extents before they are converted.
> 
> The inode extension/truncate has been moved out into a new function
> ext4_handle_inode_extension(). This will be used by both direct IO and DAX
> code paths if the write results with the inode being extended.

ext4_iomap_end is empty now, so you could as well remove it entirely.
