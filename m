Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE24E2550B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0VjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 17:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0VjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:39:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECCC061264;
        Thu, 27 Aug 2020 14:39:06 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBPbo-005mLI-VH; Thu, 27 Aug 2020 21:39:01 +0000
Date:   Thu, 27 Aug 2020 22:39:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        yebin <yebin10@huawei.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Message-ID: <20200827213900.GG1236603@ZenIV.linux.org.uk>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz>
 <20200825121616.GA10294@infradead.org>
 <20200825145056.GC32298@quack2.suse.cz>
 <20200827071603.GA25305@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827071603.GA25305@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:16:03AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 25, 2020 at 04:50:56PM +0200, Jan Kara wrote:
> > Do you mean that address_space filesystem uses to access its metadata on
> > /dev/sda will be different from the address_space you will see when reading
> > say /dev/sda?  Thus these will be completely separate (and incoherent)
> > caches?
> 
> Yes.
> 
> > Although this would be simple it will break userspace I'm afraid.
> > There are situations where tools read e.g. superblock of a mounted
> > filesystem from the block device and rely on the data to be reasonably
> > recent. Even worse e.g. tune2fs or e2fsck can *modify* superblock of a
> > mounted filesystem through the block device (e.g. to set 'fsck after X
> > mounts' fields and similar).
> 
> We've not had any problems when XFS stopped using the block device
> address space 9.5 years ago.

How much writes from fsck use does xfs see, again?
