Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60534F822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 06:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhCaEyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 00:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCaEyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 00:54:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEAAC061574;
        Tue, 30 Mar 2021 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wIuJCiHGrink7N+zzFOEwUOD7eV2TDviRurljTUqLgQ=; b=XXtGSFRBa/aIKQwnwcdl6QW4FB
        mukV70lxPNlQctc7MaXB1B6802SYl8YwB/gK9wRAxOA2MfPOpVn6mrxda7ZuYI4oyt6oFqqnhIkb4
        udoSn9Hwo2L5GhPO4ThoK5c7B0PRqF9OiQQrT6Mv5Po01SGJmEypYWMwoaC4/yHyogBou/Co97jxS
        zq5xlw1MgMDxpIItsrpUukR2HYneXhmM9BZieJTDrN3+s7TaZAAr7EdKETctkN79yy9LtMNOlQWDp
        fdSoyMNSPrmEgfzy9W7FEMXganFuZ9OVGgdQq52x2Pg9qQd609O3UOAMrWKXCYVxkR/bffuXTuEIw
        Q1dcMB2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRSre-0042Yc-03; Wed, 31 Mar 2021 04:54:00 +0000
Date:   Wed, 31 Mar 2021 05:53:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hfsplus: Fix out-of-bounds warnings in
 __hfsplus_setxattr
Message-ID: <20210331045357.GV351017@casper.infradead.org>
References: <20210330145226.GA207011@embeddedor>
 <20210330214320.93600506530f1ab18338b467@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330214320.93600506530f1ab18338b467@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:43:20PM -0700, Andrew Morton wrote:
> On Tue, 30 Mar 2021 09:52:26 -0500 "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > Fix the following out-of-bounds warnings by enclosing
> > structure members file and finder into new struct info:
> > 
> > fs/hfsplus/xattr.c:300:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct DInfo' at offset 48 [-Warray-bounds]
> > fs/hfsplus/xattr.c:313:5: warning: 'memcpy' offset [65, 80] from the object at 'entry' is out of the bounds of referenced subobject 'user_info' with type 'struct FInfo' at offset 48 [-Warray-bounds]
> > 
> > Refactor the code by making it more "structured."
> > 
> > Also, this helps with the ongoing efforts to enable -Warray-bounds and
> > makes the code clearer and avoid confusing the compiler.
> 
> Confused.  What was wrong with the old code?  Was this warning
> legitimate and if so, why?  Or is this patch a workaround for a
> compiler shortcoming?

The offending line is this:

-                               memcpy(&entry.file.user_info, value,
+                               memcpy(&entry.file.info, value,
                                                file_finderinfo_len);

what it's trying to do is copy two structs which are adjacent to each
other in a single call to memcpy().  gcc legitimately complains that the
memcpy to this struct overruns the bounds of the struct.  What Gustavo
has done here is introduce a new struct that contains the two structs,
and now gcc is happy that the memcpy doesn't overrun the length of this
containing struct.
