Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0489664C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfHTQ0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 12:26:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54369 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726345AbfHTQ0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:26:41 -0400
Received: from callcc.thunk.org (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7KGPBGs030830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 12:25:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B3927420843; Tue, 20 Aug 2019 12:25:10 -0400 (EDT)
Date:   Tue, 20 Aug 2019 12:25:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, chandanrmail@gmail.com,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Message-ID: <20190820162510.GC10232@mit.edu>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
 <20190820051236.GE159846@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820051236.GE159846@architecture4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:12:36PM +0800, Gao Xiang wrote:
> Add a word, I have some little concern about post read procession order
> a bit as I mentioned before, because I'd like to move common EROFS
> decompression code out in the future as well for other fses to use
> after we think it's mature enough.
> 
> It seems the current code mainly addresses eliminating duplicated code,
> therefore I have no idea about that...

Actually, we should chat.  I was actually thinking about "borrowing"
code from erofs to provide ext4-specific compression.  I was really
impressed with the efficiency goals in the erofs design[1] when I
reviewed the Usenix ATC paper, and as the saying goes, the best
artists know how to steal from the best.  :-)

[1] https://www.usenix.org/conference/atc19/presentation/gao

My original specific thinking was to do code reuse by copy and paste,
simply because it was simpler, and I have limited time to work on it.
But if you are interested in making the erofs pipeline reusable by
other file systems, and have the time to do the necessary code
refactoring, I'd love to work with you on that.

It should be noted that the f2fs developers have been working on their
own compression scheme that was going to be f2fs-specific, unlike the
file system generic approach used with fsverity and fscrypt.

My expectation is that we will need to modify the read pipeling code
to support compression.  That's true whether we are looking at the
existing file system-specific code used by ext4 and f2fs or in some
combined work such as what Chandan has proposed.

Cheers,

					- Ted
