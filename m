Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89834A3CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiAaEzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:55:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiAaEza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:55:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53109210F8;
        Mon, 31 Jan 2022 04:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643604929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdB1XHgAD5AGIVVsRx2EQeO3d7TEVq5YDPKnGsmvoSo=;
        b=ftP6guEKgOcD+qcuWJB4Xv35Y3zrOaBJa7dEeRwiPxi7j0RdkmePW0y4SVOUF1tfiQx3Am
        M2ehez+KMUHgYKFc9mWEZyGEQxHrMSe3AHK/zkmITG8sjFg11LH/NEKTuy40HetAAAONEF
        eXNds0UoJYZ71pbvTaaTrdKyjuFva8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643604929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdB1XHgAD5AGIVVsRx2EQeO3d7TEVq5YDPKnGsmvoSo=;
        b=8N8jRXLY8+y2eslTTS+XbYtUzAQY0tbcbK/gwomrzZVkGqleGjjbAcNdu1NK2vBOJTdXB7
        h3qF/JOYSUqsinBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7AA113638;
        Mon, 31 Jan 2022 04:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kCDWIL1r92H1FgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 04:55:25 +0000
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
In-reply-to: <YfdkCsxyu0jpo+98@casper.infradead.org>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>,
 <164360183350.4233.691070075155620959.stgit@noble.brown>,
 <YfdkCsxyu0jpo+98@casper.infradead.org>
Date:   Mon, 31 Jan 2022 15:55:22 +1100
Message-id: <164360492268.18996.14760090171177015570@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jan 2022, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 03:03:53PM +1100, NeilBrown wrote:
> >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> >     and the flag is set.
> 
> Is this actually useful?  I ask because Dave Chinner believes
> the call to ->writepage in vmscan to be essentially unused.

He would be wrong ...  unless "essentially" means "mostly" rather than
"totally".
swap-out to NFS results in that ->writepage call.

Of course swap_writepage ignores sync_mode, so this might not be
entirely relevant.

But the main point of the patch is not to return AOP_WRITEPAGE_ACTIVATE
to vmscan.  It is to avoid writing at all when WB_SYNC_NONE and
congested.  e.g. for POSIX_FADV_DONTNEED
It is also to allow the removal of congestion tracking with minimal
changes to behaviour.

If I end up changing some dead code into different dead code, I really
don't care.  I'm not here to clean up all dead code - only the dead code
specifically related to congestion.

NeilBrown


> See commit 21b4ee7029c9, and I had a followup discussion with him
> on IRC:
> 
> <willy> dchinner: did you gather any stats on how often ->writepage was
> 	being called by pageout() before "xfs: drop ->writepage completely"
> 	was added?
> <dchinner> willy: Never saw it on XFS in 3 years in my test environment...
> <dchinner> I don't ever recall seeing the memory reclaim guards we put on
> 	->writepage in XFS ever firing - IIRC they'd been there for the best
> 	part of a decade.
> <willy> not so much the WARN_ON firing but the case where it actually calls
> 	iomap_writepage
> <dchinner> willy: I mean both - I was running with a local patch that warned
> 	on writepage for a long time, regardless of where it was called from.
> 
> I can believe things are different for a network filesystem, or maybe
> XFS does background writeback better than other filesystems, but it
> would be intriguing to be able to get rid of ->writepage altogether
> (or at least from pageout(); migrate.c may be a thornier proposition).
> 
> 
