Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD2966A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHTQl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 12:41:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33012 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727077AbfHTQl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:41:59 -0400
Received: from callcc.thunk.org (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7KGcboC007051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 12:38:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4B96E420843; Tue, 20 Aug 2019 12:38:37 -0400 (EDT)
Date:   Tue, 20 Aug 2019 12:38:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, chandanrmail@gmail.com,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Message-ID: <20190820163837.GD10232@mit.edu>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652707.8YmLLlegLt@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:35:29AM +0530, Chandan Rajendra wrote:
> Looks like F2FS requires a lot more flexiblity than what can be offered by
> read callbacks i.e.
> 
> 1. F2FS wants to make use of its own workqueue for decryption, verity and
>    decompression.
> 2. F2FS' decompression code is not an FS independent entity like fscrypt and
>    fsverity. Hence they would need Filesystem specific callback functions to
>    be invoked from "read callbacks". 
> 
> Hence I would suggest that we should drop F2FS changes made in this
> patchset. Please let me know your thoughts on this.

That's probably the best way to go for now.  My one concern is that it
means that only ext4 will be using your framework.  I could imagine
that some people might argue that should just move the callback scheme
into ext4 code as opposed to leaving it in fscrypt --- at least until
we can find other file systems where we can show that it will be
useful for those other file systems.

(Perhaps a useful experiment would be to have someone implement patches
to support fscrypt and fsverity in ext2 --- the patch might or might
not be accepted for upstream inclusion, but it would be useful to
demonstrate how easy it is to add fscrypt and fsverity.)

The other thing to consider is that there has been some discussion
about adding generalized support for I/O submission to the iomap
library.  It might be that if that work is accepted, support for
fscrypt and fsverity would be a requirement for ext4 to use that
portion of iomap's functionality.  So in that eventuality, it might be
that we'll want to move your read callbacks code into iomap, or we'll
need to rework the read callbacks code so it can work with iomap.

But this is all work for the future.  I'm a firm believe that the
perfect should not be the enemy of the good, and that none of this
should be a fundamental obstacle in having your code upstream.

Cheers,

					- Ted


