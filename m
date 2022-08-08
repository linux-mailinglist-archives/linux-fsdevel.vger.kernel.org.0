Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161F258CA80
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiHHO0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiHHO0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB9111C1C
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659968781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6qFvGy4HT+baIVkoLM8gIUhFv7ZzYgakTyFaHG2mz4=;
        b=bOBC2X3brRX/PJH4Da5qS9EzRWEimEXNJIpJWCmdsK2HbhttG+319Yi2j52Ii6+RJPIcLI
        7ttQxsFA6PBfZZTeTHrfg18UA25MZeeydZxHYlnA9+PrguufxXueboIGkydQ6pgY1bT+bO
        kBpL3DDhlNwGB4zxG5WvaeZRrK8hppg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-kHp-W3CyNoWdE_-XTSVRpA-1; Mon, 08 Aug 2022 10:26:15 -0400
X-MC-Unique: kHp-W3CyNoWdE_-XTSVRpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D84821907;
        Mon,  8 Aug 2022 14:26:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A6A61121315;
        Mon,  8 Aug 2022 14:26:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 278EQCjL012350;
        Mon, 8 Aug 2022 10:26:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 278EQAPT012346;
        Mon, 8 Aug 2022 10:26:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 8 Aug 2022 10:26:10 -0400 (EDT)
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
In-Reply-To: <Yu/RJtoJPhkWXIdP@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com> <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com> <YuflGG60pHiXp2z/@casper.infradead.org>
 <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com> <YuyNE5c06WStxQ2z@casper.infradead.org> <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com> <Yu/RJtoJPhkWXIdP@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 7 Aug 2022, Matthew Wilcox wrote:

> On Sun, Aug 07, 2022 at 07:37:22AM -0400, Mikulas Patocka wrote:
> > @@ -135,6 +133,49 @@ BUFFER_FNS(Meta, meta)
> >  BUFFER_FNS(Prio, prio)
> >  BUFFER_FNS(Defer_Completion, defer_completion)
> >  
> > +static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
> > +{
> > +	/*
> > +	 * make it consistent with folio_mark_uptodate
> > +	 * pairs with smp_acquire__after_ctrl_dep in buffer_uptodate
> > +	 */
> > +	smp_wmb();
> > +	set_bit(BH_Uptodate, &bh->b_state);
> > +}
> > +
> > +static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
> > +{
> > +	clear_bit(BH_Uptodate, &bh->b_state);
> > +}
> > +
> > +static __always_inline int buffer_uptodate(const struct buffer_head *bh)
> > +{
> > +	bool ret = test_bit(BH_Uptodate, &bh->b_state);
> > +	/*
> > +	 * make it consistent with folio_test_uptodate
> > +	 * pairs with smp_wmb in set_buffer_uptodate
> > +	 */
> > +	if (ret)
> > +		smp_acquire__after_ctrl_dep();
> > +	return ret;
> > +}
> 
> This all works for me.  While we have the experts paying attention,
> would it be better to do
> 
> 	return smp_load_acquire(&bh->b_state) & (1L << BH_Uptodate) > 0;

Yes, it may be nicer.

> > +static __always_inline void set_buffer_locked(struct buffer_head *bh)
> > +{
> > +	set_bit(BH_Lock, &bh->b_state);
> > +}
> > +
> > +static __always_inline int buffer_locked(const struct buffer_head *bh)
> > +{
> > +	bool ret = test_bit(BH_Lock, &bh->b_state);
> > +	/*
> > +	 * pairs with smp_mb__after_atomic in unlock_buffer
> > +	 */
> > +	if (!ret)
> > +		smp_acquire__after_ctrl_dep();
> > +	return ret;
> > +}
> 
> Are there places that think that lock/unlock buffer implies a memory
> barrier?

There's this in fs/reiserfs:

if (!buffer_dirty(bh) && !buffer_locked(bh)) {
	reiserfs_free_jh(bh); <--- this could be moved before buffer_locked


if (buffer_locked((journal->j_header_bh))) {
	...
}
journal->j_last_flush_trans_id = trans_id;
journal->j_first_unflushed_offset = offset;
jh = (struct reiserfs_journal_header *)(journal->j_header_bh->b_data); <--- this could be moved before buffer_locked

Mikulas

