Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624C412893A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 14:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLUNlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 08:41:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfLUNlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 08:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3CDE2Cs800spsJ1UVineI/b70h1m84idjOmg8MxfYYU=; b=KMEXF0JPS9sEvJ3jC5crz79W0
        uYEukdP70LlKz373RFukZBtCnVfkCia1CXvabHlUCwf5dB5P4JCNmPtBF63GiytrfH7nahrZRFHQ3
        2/6GYixGCXIdjaZPv5b2GkL8zFaXkn9afYsHZP60HFJDatN/3S/aCAma+lBNt7ZAgUlbSc2L2yPok
        +2D2nipEJycvRv6H7EemiEJU9xSm+yaemtZzaek7Qij7O5V4V/NBzkK2LA8KQVxCvUsLYL8vb/0hP
        bQwdoBh1eLeHPCkv6mlcWaW2CsknyIJ6ExiTyxMVaoVsLAfMXteoyQOXvp1EaOlAy/RFzBvRIKRUu
        Pziv7qV5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iif0Q-00060k-Un; Sat, 21 Dec 2019 13:41:18 +0000
Date:   Sat, 21 Dec 2019 05:41:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191221134118.GA17355@infradead.org>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213195750.32184-4-rgoldwyn@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:57:45PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as btrfs can perform direct I/O without holding the
> inode->i_rwsem in some of the cases like writing within i_size.
> So, remove the check for lockdep_assert_held() in iomap_dio_rw()

As said last time: in the callers the assert is completely pointless,
as it is always very close to taking the lock.  This was just intended
to deal with callers not adhering to the iomap_dio_rw calling
conventins, and moving the assert to the calllers doesn't help with
that at all.

So if you think you need to remove it do just that and write a changelog
explaining the why much better.
