Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A88253EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH0HQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0HQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:16:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F853C061264;
        Thu, 27 Aug 2020 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=73TS0DS7ncNDVmyihFq6967c/Cyd4XuiTcflJQkc2as=; b=PgS6SNneAYaHlyPm5/ONnxRHE7
        P3nYQd6dTBdJvpIK72/GBsosN4b+E8Yh0T2mk5mZjsWxS5NHd9ofs9UmNeh+SxsAXWX4tpI9HSdxw
        2PiQ/Aloo11tnYtEk2gg+FvCuO+jh6AfKdwkYCFAAYW/OjYO+vO+HtywtK+wtX7EoErRzUzehXrDn
        5dXLIghPXo3pdEYXULoOaiFYHCLwlCxK0xUCZ+xfPi2JNGOyJPwEk6KUc/R+lurK5vPn+5f3LqWLA
        uL8ge0ldtd2EfNjdvRUQszON5419EruOyD+fw61457cxgfbeDdJsGbEtwbBkY8NpdlCpMMl8Nv6C2
        K0eDkegA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBC8h-0006kX-4L; Thu, 27 Aug 2020 07:16:03 +0000
Date:   Thu, 27 Aug 2020 08:16:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, yebin <yebin10@huawei.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200827071603.GA25305@infradead.org>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825145056.GC32298@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825145056.GC32298@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 04:50:56PM +0200, Jan Kara wrote:
> Do you mean that address_space filesystem uses to access its metadata on
> /dev/sda will be different from the address_space you will see when reading
> say /dev/sda?  Thus these will be completely separate (and incoherent)
> caches?

Yes.

> Although this would be simple it will break userspace I'm afraid.
> There are situations where tools read e.g. superblock of a mounted
> filesystem from the block device and rely on the data to be reasonably
> recent. Even worse e.g. tune2fs or e2fsck can *modify* superblock of a
> mounted filesystem through the block device (e.g. to set 'fsck after X
> mounts' fields and similar).

We've not had any problems when XFS stopped using the block device
address space 9.5 years ago.
