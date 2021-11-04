Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794A7444DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 04:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhKDD2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhKDD2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:28:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B752DC061714;
        Wed,  3 Nov 2021 20:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9i73/6SdJ1N1Ck8Ld5HrqcvwEwZRwzBBD8DWT4Y6rxE=; b=Dazl8Z3ANUaz5rfl60/hjAKu18
        w+jsFb/x6+dTJk5XjF407tuILdWfuMn49x5KrkGWbhUpSIjBObeF1ioJ100baLXKVHWbnzZLdHP8x
        FfRboGC/hLir+sSejNvq+OYwCSWx1myCYFHQEU4fEmp21/iOvFLTUS7hdo3z/oZDsry+s4ojtXQzu
        6qKYWFM9SMwDYZGmSGAB0pNHEKBiunFaaHrdbjAG2M567HB+zTT9KQPzqzHvUfajB+h7HrVMwDQSY
        wsPeSX25njmiBUgfVCqZRlXvLH/wnOraUy9OJVd21ARoyv/QpTqP2Z9ayt+cizM1+OuCQBxrH97Xt
        LvSgeJPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miTKE-005dMm-G7; Thu, 04 Nov 2021 03:22:46 +0000
Date:   Thu, 4 Nov 2021 03:22:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, Jeffrey E Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] afs: Fix ENOSPC, EDQUOT and other errors to fail a write
 rather than retrying
Message-ID: <YYNR2t+RmtFd+bT/@casper.infradead.org>
References: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:43:20PM +0000, David Howells wrote:
> Currently, at the completion of a storage RPC from writepages, the errors
> ENOSPC, EDQUOT, ENOKEY, EACCES, EPERM, EKEYREJECTED and EKEYREVOKED cause
> the pages involved to be redirtied and the write to be retried by the VM at
> a future time.
> 
> However, this is probably not the right thing to do, and, instead, the
> writes should be discarded so that the system doesn't get blocked (though
> unmounting will discard the uncommitted writes anyway).

umm.  I'm not sure that throwing away the write is the best answer
for some of these errors.  Our whole story around error handling in
filesystems, the page cache and the VFS is pretty sad, but I don't think
that this is the right approach.

Ideally, we'd hold onto the writes in the page cache until (eg for ENOSPC
/ EDQUOT), the user has deleted some files, then retry the writes.

We should definitely stop the user dirtying more pages on this mount,
or at least throttle processes which are dirtying new pages (eg in
folio_mark_dirty()), which implies a check of the superblock.  Until the
ENOSPC is cleared up, at which time writeback can resume ... of course,
the server won't necessarily notify us when it is cleared up (because
it might be due to a different client filling the storage), so we might
need to peridically re-attempt writeback so that we know whether ENOSPC
has been resolved.
