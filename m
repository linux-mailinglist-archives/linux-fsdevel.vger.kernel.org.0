Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C455FC7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiF2JqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiF2Jp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:45:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CCF3CFE2;
        Wed, 29 Jun 2022 02:45:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 399A51F8B2;
        Wed, 29 Jun 2022 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656495948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJoGQTsPE+Dxaf6jvW0uc7P3npJ++wfiOu4E3cT9rBQ=;
        b=SVl3S5CxwLaEZCJ3dbGDXESeEuFbr2T3EY1ZOOca71E5obHmemd7VPpmaOpxaQOfZv5LV6
        yVMI7K+2EH/3Z6zy7VmOKzeWnmrD4UF96AvUzA0R27Qa9KkXXiBtZaN8h5Hken4YaqI/om
        D2Ig0+uUOWSXqmbumK65/pH6lRM9eI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656495948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJoGQTsPE+Dxaf6jvW0uc7P3npJ++wfiOu4E3cT9rBQ=;
        b=7MjcfhQ95VyrzC6rxwh5V6aBGEQ3JlWc3W+GmzkA9Zh2ltGjMCZAxK7xxjRk8dReKSs5UK
        KvZltUG3E1BEKqDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0DAAA2C141;
        Wed, 29 Jun 2022 09:45:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA394A062F; Wed, 29 Jun 2022 11:45:47 +0200 (CEST)
Date:   Wed, 29 Jun 2022 11:45:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220629094547.xa27x7oiuhasglzl@quack3>
References: <20220624122334.80603-1-hch@lst.de>
 <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
 <20220624125118.GA789@lst.de>
 <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
 <20220625091143.GA23118@lst.de>
 <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4af4c49-c537-bd6d-c27e-fe9ed71b9a8e@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 10:29:00, Chris Mason wrote:
> I'd love a proper fix for this on the *_user_pages() side where
> page_mkwrite() style notifications are used all the time.  It's just a huge
> change, and my answer so far has always been that using btrfs mmap'd memory
> for this kind of thing isn't a great choice either way.

As Christoph wrote, it isn't a problem that you would not get a
page_mkwrite() notification. That happens just fine. But the problem is
that after that, the page can still get modified after you've removed all
writeable mappings of the page (e.g. by calling page_mkclean() in
clear_page_dirty_for_io()). And there's no way a kernel can provide further
notification for such writes because we've simply handed of the page
physical address to the HW to DMA into.

So the only viable solution is really for the filesystem to detect such
unprotectable pages if it cares and somehow deal with them (skip writeback,
use bounce pages, ...). The good news is that we already have
page_maybe_dma_pinned() call that at least allows detection of such
unprotectable pages.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
