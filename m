Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCF5B8B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiINOwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINOwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:52:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C51A83D;
        Wed, 14 Sep 2022 07:52:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAC0A339CE;
        Wed, 14 Sep 2022 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663167153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCNnJsTvzDL0Ox0oJoto7Z0gWCmReDnFFpxhGEpv45M=;
        b=lK0OJflOFaTVBDNJGHIUSBQa3bUT+rqVNAOzb42o4ScXiVv1vJMQE0dPHLHRbiDHdkVX+G
        ilzuajvlwOM16QdSohRsh+XSCBQylRQrUx0g9xl98uhPJsdjw2Ldg1BHMs/m3TIcc1fk2J
        LV7soPZ1H7wl7Yj+sCJSmuokSlTfFg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663167153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCNnJsTvzDL0Ox0oJoto7Z0gWCmReDnFFpxhGEpv45M=;
        b=HDEaQIgQZQFxnGUVEGHKXrWl+9KmSpSPW44OQxNkxlot3B2fvH+wLLh/l5Cqrf2pJkcL8Y
        zx1SOSVooD/X0tAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8895134B3;
        Wed, 14 Sep 2022 14:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n84lKbHqIWMbQAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 14:52:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38F74A0680; Wed, 14 Sep 2022 16:52:33 +0200 (CEST)
Date:   Wed, 14 Sep 2022 16:52:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <20220914145233.cyeljaku4egeu4x2@quack3>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyFPtTtxYozCuXvu@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-09-22 04:51:17, Al Viro wrote:
> On Wed, Sep 07, 2022 at 01:45:26AM -0700, Christoph Hellwig wrote:
> > On Tue, Sep 06, 2022 at 12:21:06PM +0200, Jan Kara wrote:
> > > > For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> > > > not acquiring a reference is obviously safe, and the other callers will
> > > > need an audit, but I can't think of why it woul  ever be unsafe.
> > > 
> > > Are you sure about "For file systems not acquiring a reference is obviously
> > > safe"? I can see places e.g. in orangefs, afs, etc. which create bvec iters
> > > from pagecache pages. And then we have iter_file_splice_write() which
> > > creates bvec from pipe pages (which can also be pagecache pages if
> > > vmsplice() is used). So perhaps there are no lifetime issues even without
> > > acquiring a reference (but looking at the code I would not say it is
> > > obvious) but I definitely don't see how it would be safe to not get a pin
> > > to signal to filesystem backing the pagecache page that there is DMA
> > > happening to/from the page.
> > 
> > I mean in the context of iov_iter_get_pages callers, that is direct
> > I/O.  Direct callers of iov_iter_bvec which then pass that iov to
> > ->read_iter / ->write_iter will need to hold references (those are
> > the references that the callers of iov_iter_get_pages rely on!).
> 
> Unless I'm misreading Jan, the question is whether they should get or
> pin.  AFAICS, anyone who passes the sucker to ->read_iter() (or ->recvmsg(),
> or does direct copy_to_iter()/zero_iter(), etc.) is falling under
> =================================================================================
> CASE 5: Pinning in order to write to the data within the page
> -------------------------------------------------------------
> Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
> write to a page's data, unpin" can cause a problem. Case 5 may be considered a
> superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
> other words, if the code is neither Case 1 nor Case 2, it may still require
> FOLL_PIN, for patterns like this:
> 
> Correct (uses FOLL_PIN calls):
>     pin_user_pages()
>     write to the data within the pages
>     unpin_user_pages()
> 
> INCORRECT (uses FOLL_GET calls):
>     get_user_pages()
>     write to the data within the pages
>     put_page()
> =================================================================================

Yes, that was my point.

> Regarding iter_file_splice_write() case, do we need to pin pages
> when we are not going to modify the data in those?

Strictly speaking not. So far we are pinning pages even if they serve as
data source because it is simpler not to bother about data access direction
but I'm not really aware of anything that would mandate that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
