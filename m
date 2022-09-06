Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733D5AE538
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiIFKVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiIFKVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:21:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5B41D28;
        Tue,  6 Sep 2022 03:21:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1691F9B8;
        Tue,  6 Sep 2022 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662459667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRzzxJnv5MaykTq7esKm/SId3jWkWiPAdjMo5oqrhRE=;
        b=KxJvAYQmECJdKHflrlphoK6jMea5m356jipctQWsyyBn2mXvuIKqE/JpJczXYmkvoH9nO8
        NoOB88iSwiI2Ub8MVRt1ql+V2Du8naLMoby+IJylMg9zSLiTlT9sPsRaZXQbR44F6irWgs
        wfZCT1dxVKV4e5PjvHq5w10DQUscpmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662459667;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRzzxJnv5MaykTq7esKm/SId3jWkWiPAdjMo5oqrhRE=;
        b=plZXEtxGbS1qVODpVEpx1mvVcKzPPQXJbGzq02JAcGOhoP0DN1kZuv58cv4wa0hVHaZblC
        6/YkhJlMFnkIsNAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F33D13A7A;
        Tue,  6 Sep 2022 10:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M/EfGxMfF2POBgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Sep 2022 10:21:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 053EBA067E; Tue,  6 Sep 2022 12:21:06 +0200 (CEST)
Date:   Tue, 6 Sep 2022 12:21:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <20220906102106.q23ovgyjyrsnbhkp@quack3>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxb7YQWgjHkZet4u@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-09-22 00:48:49, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:44:28AM -0700, John Hubbard wrote:
> > OK, that part is clear.
> > 
> > >  - for the pin case don't use the existing bvec helper at all, but
> > >    copy the logic for the block layer for not pinning.
> > 
> > I'm almost, but not quite sure I get the idea above. Overall, what
> > happens to bvec pages? Leave the get_page() pin in place for FOLL_GET
> > (or USE_FOLL_GET), I suppose, but do...what, for FOLL_PIN callers?
> 
> Do not change anyhing for FOLL_GET callers, as they are on the way out
> anyway.
> 
> For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> not acquiring a reference is obviously safe, and the other callers will
> need an audit, but I can't think of why it woul  ever be unsafe.

Are you sure about "For file systems not acquiring a reference is obviously
safe"? I can see places e.g. in orangefs, afs, etc. which create bvec iters
from pagecache pages. And then we have iter_file_splice_write() which
creates bvec from pipe pages (which can also be pagecache pages if
vmsplice() is used). So perhaps there are no lifetime issues even without
acquiring a reference (but looking at the code I would not say it is
obvious) but I definitely don't see how it would be safe to not get a pin
to signal to filesystem backing the pagecache page that there is DMA
happening to/from the page.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
