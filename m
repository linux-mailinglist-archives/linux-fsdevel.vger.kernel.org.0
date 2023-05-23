Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB070E258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbjEWQf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjEWQfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:35:53 -0400
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E8DE5A;
        Tue, 23 May 2023 09:35:41 -0700 (PDT)
Date:   Tue, 23 May 2023 12:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684859739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+1sZNJGqmSSorNrp7Vi6hi24SWgmfSQeHF6o5ml3aM=;
        b=boM2zgX3bgqEBDShk9hs2N9+0YcX7kYB2z6gjcPWbAuGANGbQ8XRf/CROsOsiW2+eAm0it
        8iLCgk5Cl0XSAo8r3TGcHZehApiBzJwTlLXnbU2dyUrYPhtmmQwLMxvyZyvCM1Tib2GUac
        xWptY55CWX/cCg0qWcOG42+RgTJCy5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, cluster-devel@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZGzrV5j7OUU6rYij@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzoJLCRLk+pCKAk@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 09:21:56AM -0700, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 03:34:31PM +0200, Jan Kara wrote:
> > I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> > way (by prefaulting pages from the iter before grabbing the problematic
> > lock and then disabling page faults for the iomap_dio_rw() call). I guess
> > we should somehow unify these schemes so that we don't have two mechanisms
> > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> > 
> > Also good that you've written a fstest for this, that is definitely a useful
> > addition, although I suspect GFS2 guys added a test for this not so long
> > ago when testing their stuff. Maybe they have a pointer handy?
> 
> generic/708 is the btrfs version of this.
> 
> But I think all of the file systems that have this deadlock are actually
> fundamentally broken because they have a mess up locking hierarchy
> where page faults take the same lock that is held over the the direct I/
> operation.  And the right thing is to fix this.  I have work in progress
> for btrfs, and something similar should apply to gfs2, with the added
> complication that it probably means a revision to their network
> protocol.

No, this is fundamentally because userspace controls the ordering of
locking because the buffer passed to dio can point into any address
space. You can't solve this by changing the locking heirarchy.

If you want to be able to have locking around adding things to the
pagecache so that things that bypass the pagecache can prevent
inconsistencies (and we do, the big one is fcollapse), and if you want
dio to be able to use that same locking (because otherwise dio will also
cause page cache inconsistency), this is the way to do it.
