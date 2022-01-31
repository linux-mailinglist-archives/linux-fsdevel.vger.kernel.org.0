Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0B4A51A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 22:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381278AbiAaVjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 16:39:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381161AbiAaViZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:38:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4909321117;
        Mon, 31 Jan 2022 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643665101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKd6R/0YNRyfzQ8ZZPjRR1HT9tn7/jzGyteVTy+hgUM=;
        b=w9OpH9VTawfzJ/u8BXxgoWfymo+nzi1jLr7eZl7pa7S3H/zTZKoiY74UIkzV5oczRiR35F
        eLqBmYg3tZ8JK2/HDaZcngWqnQ+25s7odv9jecLpLT9NEc3dJUozM5hdxJii1lZgOzXMMQ
        FFGA76YJ9SMMXO+XgXy/NeWcIiKT5is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643665101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKd6R/0YNRyfzQ8ZZPjRR1HT9tn7/jzGyteVTy+hgUM=;
        b=aObXzQQUXcR2oE8tQR5V9RJQ891z3ud0AVoKa2jrFRJM1SxbfNEWDptJM65WaSHMXX4Vyx
        716tCFUO9nP6+iAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A75313CCA;
        Mon, 31 Jan 2022 21:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id caHTFcZW+GGqAQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 21:38:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nfs: remove reliance on bdi congestion
In-reply-to: <YffhBYZ+6pgWeF71@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183350.4233.691070075155620959.stgit@noble.brown>,
 <YfdkCsxyu0jpo+98@casper.infradead.org>,
 <164360492268.18996.14760090171177015570@noble.neil.brown.name>,
 <YffhBYZ+6pgWeF71@casper.infradead.org>
Date:   Tue, 01 Feb 2022 08:38:11 +1100
Message-id: <164366509142.18996.11029008051103064089@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 01 Feb 2022, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 03:55:22PM +1100, NeilBrown wrote:
> > On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> > > On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
> > > >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> > > >     and the flag is set.
> > > 
> > > Is this actually useful?  I ask because Dave Chinner believes
> > > the call to ->writepage in vmscan to be essentially unused.
> > 
> > He would be wrong ...  unless "essentially" means "mostly" rather than
> > "totally".
> > swap-out to NFS results in that ->writepage call.
> 
> For writes, SWP_FS_OPS uses ->direct_IO, not ->writepage.  Confused.
> 

I shouldn't have mentioned NFS - that is an irrelevant distraction.

The "call to ->writepage in vmscan" is used, at least for swap.
For swapout it is the ->writepage from swap_aops, not the ->writepage of
any filesystem.  This is swap_writepage(), and for SWP_FS_OPS that maps
to a ->direct_IO call.

Dave may well be right that the ->writepage in vmscan never calls
xfs_writepage or many others.

To get to the ->writepage of a filesystem it would need to be called
from kswapd.  You would need to have no swap configured, and 90% of
memory consumed with anon pages so that the dirty_background_ratio
of 10% didn't kick off writeback.  Then I would expect to kswapd to
write out to a filesystem before writeback would do it.

Nonetheless, without clear evidence to the contrary, I think it is
safest to add this test to the ->writepage function for any filesystem
which currently sets the bdi async congested flag.

Thanks,
NeilBrown
