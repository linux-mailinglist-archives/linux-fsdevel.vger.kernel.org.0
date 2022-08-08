Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC49658CAEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiHHO63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiHHO6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A572012AD5
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659970672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QV1haXmrif3A28i1cY1lp+uj/T99BiZiUpEQe1keJWk=;
        b=Hdmhgb4Jdpw37mDfXuga8nfvxrKxHmNC3zUcdaOIavSnNtinTD1a+qk5Wu1maSkNW5Rpwh
        w3E+pnZ5Dknjk86j0d77EShuSTD/3nLQurbiEIdBtUnDC4QpFNxCLcrB9Rd6BBNcOrwgCD
        1Y2xCKpVUW3novrFFHRc9H3XesaC2cc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-7qqwk5nNPyObKHLoqMHhMw-1; Mon, 08 Aug 2022 10:57:48 -0400
X-MC-Unique: 7qqwk5nNPyObKHLoqMHhMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0F6C823F0D;
        Mon,  8 Aug 2022 14:57:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CF36112131B;
        Mon,  8 Aug 2022 14:57:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 278EvkLc013506;
        Mon, 8 Aug 2022 10:57:46 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 278Evjcp013502;
        Mon, 8 Aug 2022 10:57:45 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 8 Aug 2022 10:57:45 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] add barriers to buffer functions
In-Reply-To: <YvEgZuSdv8XHtkJg@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com> <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com> <YuflGG60pHiXp2z/@casper.infradead.org> <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com> <YuyNE5c06WStxQ2z@casper.infradead.org>
 <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com> <Yu/RJtoJPhkWXIdP@casper.infradead.org> <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com> <YvEgZuSdv8XHtkJg@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 8 Aug 2022, Matthew Wilcox wrote:

> On Mon, Aug 08, 2022 at 10:26:10AM -0400, Mikulas Patocka wrote:
> > On Sun, 7 Aug 2022, Matthew Wilcox wrote:
> > > > +static __always_inline void set_buffer_locked(struct buffer_head *bh)
> > > > +{
> > > > +	set_bit(BH_Lock, &bh->b_state);
> > > > +}
> > > > +
> > > > +static __always_inline int buffer_locked(const struct buffer_head *bh)
> > > > +{
> > > > +	bool ret = test_bit(BH_Lock, &bh->b_state);
> > > > +	/*
> > > > +	 * pairs with smp_mb__after_atomic in unlock_buffer
> > > > +	 */
> > > > +	if (!ret)
> > > > +		smp_acquire__after_ctrl_dep();
> > > > +	return ret;
> > > > +}
> > > 
> > > Are there places that think that lock/unlock buffer implies a memory
> > > barrier?
> > 
> > There's this in fs/reiserfs:
> > 
> > if (!buffer_dirty(bh) && !buffer_locked(bh)) {
> > 	reiserfs_free_jh(bh); <--- this could be moved before buffer_locked
> 
> It might be better to think of buffer_locked() as
> buffer_someone_has_exclusive_access().  I can't see the problem with
> moving the reads in reiserfs_free_jh() before the read of buffer_locked.
> 
> > if (buffer_locked((journal->j_header_bh))) {
> > 	...
> > }
> > journal->j_last_flush_trans_id = trans_id;
> > journal->j_first_unflushed_offset = offset;
> > jh = (struct reiserfs_journal_header *)(journal->j_header_bh->b_data); <--- this could be moved before buffer_locked
> 
> I don't think b_data is going to be changed while someone else holds
> the buffer locked.  That's initialised by set_bh_page(), which is an
> initialisation-time thing, before the BH is visible to any other thread.

So, do you think that we don't need a barrier in buffer_locked()?


There is also this (where the BUG_ON(!buffer_uptodate(bh)) saves it).
                if (buffer_locked(bh)) {
                        int depth;
                        PROC_INFO_INC(sb, scan_bitmap.wait);
                        depth = reiserfs_write_unlock_nested(sb);
                        __wait_on_buffer(bh);
                        reiserfs_write_lock_nested(sb, depth);
                }
                BUG_ON(!buffer_uptodate(bh));
                BUG_ON(atomic_read(&bh->b_count) == 0);

                if (info->free_count == UINT_MAX)
                        reiserfs_cache_bitmap_metadata(sb, bh, info); <--- this could be moved before buffer_locked if there were no BUG_ONs

Mikulas

