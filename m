Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD96A670A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 05:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCAEkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 23:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCAEki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:40:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E63866D;
        Tue, 28 Feb 2023 20:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o7MbehWGYND6XLDZlBnJaQydm1QSl+nXiW5U9gE5KhQ=; b=V7hSI29cVR99yN9mPyKRJ67eVM
        uBZXj407uSloZ7fQIZYAi+PosKZUFj5sgPoS7ERv2P6zLPe4qrKvEQulcqkNUosbnI0D/Ig+NzCMg
        ZIVvqIP4zkuyDm8r6n3bIFvH63+a7H4IEhrpJqvtvaEkq1C2GdES4KTNvmfZ3aeGtrVOeYU/dddgN
        XdKY00A5bn1YYOudmDCOCdgrutpC7SQdCPLtLtD2K22RdGjAhzohV7AHII+YFXj1EZyNBtuc+1ICe
        vA9eWaTJn4eg5Q6jCs4J54v/FR/8Aq7febgPU2hqUfKiWooBleQvlHOgDRZUsXtOQ7MN3ps3XGoUw
        Msi8jexw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXEGP-001NX9-Kz; Wed, 01 Mar 2023 04:40:25 +0000
Date:   Wed, 1 Mar 2023 04:40:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <Y/7XOSj5LUu/MYCU@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <7c111304-b56b-167f-bced-9e06e44241cd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c111304-b56b-167f-bced-9e06e44241cd@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:18:30PM +0800, Gao Xiang wrote:
> > For example, most cloud storage devices are doing read-ahead to try to
> > anticipate read requests from the VM.  This can interfere with the
> > read-ahead being done by the guest kernel.  So being able to tell
> > cloud storage device whether a particular read request is stemming
> > from a read-ahead or not.  At the moment, as Matthew Wilcox has
> > pointed out, we currently use the read-ahead code path for synchronous
> > buffered reads.  So plumbing this information so it can passed through
> > multiple levels of the mm, fs, and block layers will probably be
> > needed.
> 
> It seems that is also useful as well, yet if my understanding is correct,
> it's somewhat unclear for me if we could do more and have a better form
> compared with the current REQ_RAHEAD (currently REQ_RAHEAD use cases and
> impacts are quite limited.)

I'm pretty sure the Linux readahead algorithms could do with some serious
tuning (as opposed to the hacks the Android device vendors are doing).
Outside my current level of enthusiasm / knowledge, alas.  And it's
hard because while we no longer care about performance on floppies,
we do care about performance from CompactFlash to 8GB/s NVMe drives.
I had one person recently complain that 200Gbps ethernet was too slow
for their storage, so there's a faster usecase to care about.
