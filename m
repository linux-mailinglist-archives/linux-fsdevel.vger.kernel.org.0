Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9E9679C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfHTRbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 13:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTRbS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:31:18 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7F9206DF;
        Tue, 20 Aug 2019 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566322276;
        bh=xchQBhCrLDaryEtWVa7H/buI3AaIEZHu2PtVlis3tCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EALnhDjg14LpO0z6cXs41pGJl7VFZngK162MACYic3kP6I//VLW2CmWhxhuzm0c6H
         wcvyfirgB/snkOQx4T15wm1bmb9l4uIsgtgzjBZ+9/uEO0LGb8H/igXp4ZS938r7Xf
         hjpdWBYQLCRV1iQNAm+ZeItii52405uPaddS2Xug=
Date:   Tue, 20 Aug 2019 10:31:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, chandanrmail@gmail.com,
        adilger.kernel@dilger.ca, yuchao0@huawei.com, hch@infradead.org
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Message-ID: <20190820173116.GA58214@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
 <20190820163837.GD10232@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820163837.GD10232@mit.edu>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

On 08/20, Theodore Y. Ts'o wrote:
> On Tue, Aug 20, 2019 at 10:35:29AM +0530, Chandan Rajendra wrote:
> > Looks like F2FS requires a lot more flexiblity than what can be offered by
> > read callbacks i.e.
> > 
> > 1. F2FS wants to make use of its own workqueue for decryption, verity and
> >    decompression.
> > 2. F2FS' decompression code is not an FS independent entity like fscrypt and
> >    fsverity. Hence they would need Filesystem specific callback functions to
> >    be invoked from "read callbacks". 
> > 
> > Hence I would suggest that we should drop F2FS changes made in this
> > patchset. Please let me know your thoughts on this.
> 
> That's probably the best way to go for now.  My one concern is that it
> means that only ext4 will be using your framework.  I could imagine
> that some people might argue that should just move the callback scheme
> into ext4 code as opposed to leaving it in fscrypt --- at least until
> we can find other file systems where we can show that it will be
> useful for those other file systems.

I also have to raise a flag on this. Doesn't this patch series try to get rid
of redundant work? What'd be the rationale, if it only supports ext4?

How about generalizing the framework to support generic_post_read and per-fs
post_read for fscrypt/fsverity/... selectively?

Thanks,

> 
> (Perhaps a useful experiment would be to have someone implement patches
> to support fscrypt and fsverity in ext2 --- the patch might or might
> not be accepted for upstream inclusion, but it would be useful to
> demonstrate how easy it is to add fscrypt and fsverity.)
> 
> The other thing to consider is that there has been some discussion
> about adding generalized support for I/O submission to the iomap
> library.  It might be that if that work is accepted, support for
> fscrypt and fsverity would be a requirement for ext4 to use that
> portion of iomap's functionality.  So in that eventuality, it might be
> that we'll want to move your read callbacks code into iomap, or we'll
> need to rework the read callbacks code so it can work with iomap.
> 
> But this is all work for the future.  I'm a firm believe that the
> perfect should not be the enemy of the good, and that none of this
> should be a fundamental obstacle in having your code upstream.
> 
> Cheers,
> 
> 					- Ted
> 
