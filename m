Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B8585F25
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiGaNlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiGaNlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E947ECE07
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659274871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWo/FoD4QM1KXB5H5atBkQnHX7hzvCdJbAxzr/wiEMY=;
        b=Zbnycxqy82V111fO2VR3wSE8jsfZ7R3EisKkzG6KP0+dnjjWP7us4fwZS+qYemS/rN3Ju3
        /CAQuLb+I3O/rGhovVCuXgwyg+GECDwRcvWZ/+U2kha1Qizr4f7UHsvQCY5wCPVd38eBsx
        DLYhatTR7VRDsrhAklQMUGjscYYGI9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-oXmXFGOKNDy0l_ivd3DbPQ-1; Sun, 31 Jul 2022 09:41:04 -0400
X-MC-Unique: oXmXFGOKNDy0l_ivd3DbPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF8D801585;
        Sun, 31 Jul 2022 13:41:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92C6D1121314;
        Sun, 31 Jul 2022 13:41:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 26VDf3iN009354;
        Sun, 31 Jul 2022 09:41:03 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 26VDf2oa009349;
        Sun, 31 Jul 2022 09:41:02 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 31 Jul 2022 09:41:02 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Add a read memory barrier to wait_on_buffer
In-Reply-To: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com> <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 31 Jul 2022, Ard Biesheuvel wrote:

> This has little to do with speculation, so better to drop this S bomb
> from your commit message. This is about concurrency and weak memory
> ordering.

Yes.

> This doesn't seem like a very robust fix to me, tbh - I suppose this
> makes the symptom you encountered go away, but the underlying issue
> remains afaict.
> 
> Given that the lock and uptodate fields etc are just bits in a
> bitfield, wouldn't it be better to use cmpxchg() with acquire/release
> semantics (as appropriate) to manage these bits?

The kernel already uses clear_bit_unlock, test_and_set_bit_lock and 
wait_on_bit_lock_io to manage the BH_Lock bit - and they have 
acquire/release semantics.

The only problem is that test_bit doesn't provide any memory barriers. 
Should we add the barrier to buffer_locked() instead of wait_on_buffer()? 
Perhaps it would fix more bugs - in reiserfs, there's this piece of code:

                if (buffer_locked(bh)) {
                        spin_unlock(lock);
                        wait_on_buffer(bh);
                        spin_lock(lock);
                }
                if (!buffer_uptodate(bh)) {
                        ret = -EIO;
                }

or this:
                if (buffer_locked(bh)) {
                        int depth;
                        PROC_INFO_INC(sb, scan_bitmap.wait);
                        depth = reiserfs_write_unlock_nested(sb);
                        __wait_on_buffer(bh);
                        reiserfs_write_lock_nested(sb, depth);
                }
                BUG_ON(!buffer_uptodate(bh));
                BUG_ON(atomic_read(&bh->b_count) == 0);

That assumes that buffer_locked provides a barrier.

Mikulas

