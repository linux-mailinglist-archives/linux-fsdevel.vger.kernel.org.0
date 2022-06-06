Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61B53EB67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiFFNIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiFFNIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:08:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702986B00F;
        Mon,  6 Jun 2022 06:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B6D2C21A90;
        Mon,  6 Jun 2022 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654520889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MN/pjZfKcAO7FTQBAh4+y52Sr75CPrTtBghqpmx7gg=;
        b=1/iSwJ/4PLELCpyrs8S1HtZHBKST/UvsE1r21I4uGOi/04gs9oJCxUZaUxLSXuAWyL6ssC
        ZAFXYaFW4OK2b7hGhTLY9z5f1SyM6EE4GHrwHha/yC19zc8BWgCgLKe4zT6QCshBbO9eYO
        I5qyPNzjC+gHxb/IT40kxTcDC8NyiPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654520889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MN/pjZfKcAO7FTQBAh4+y52Sr75CPrTtBghqpmx7gg=;
        b=ngi9ih8Qj6gB5/Ajz1UcVipkjFEVNImKpHTZ14aqByhXvwXneNWiGbARS1pEmy139upIAm
        8dXNdibURT9rPRAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4C2C2C141;
        Mon,  6 Jun 2022 13:08:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5CE76A0633; Mon,  6 Jun 2022 15:08:09 +0200 (CEST)
Date:   Mon, 6 Jun 2022 15:08:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] quota: Prevent memory allocation recursion while
 holding dq_lock
Message-ID: <20220606130809.6mton73yzxekjwtv@quack3.lan>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-2-willy@infradead.org>
 <20220606080334.tv5r7kljang55fat@quack3.lan>
 <Yp32IsyQFJXRAOtt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp32IsyQFJXRAOtt@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 06-06-22 13:42:10, Matthew Wilcox wrote:
> On Mon, Jun 06, 2022 at 10:03:34AM +0200, Jan Kara wrote:
> > On Sun 05-06-22 15:38:13, Matthew Wilcox (Oracle) wrote:
> > > As described in commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in
> > > read_cache_page_gfp while doing f2fs_quota_read"), we must not enter
> > > filesystem reclaim while holding the dq_lock.  Prevent this more generally
> > > by using memalloc_nofs_save() while holding the lock.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > This is definitely a good cleanup to have and seems mostly unrelated to the
> > rest. I'll take it rightaway into my tree. Thanks for the patch!
> 
> Thanks!  It's really a pre-requisite for the second patch; I haven't
> seen anywhere in the current codebase that will have a problem.  All
> the buffer_heads are allocated with GFP_NOFS | __GFP_NOFAIL (in
> grow_dev_page()).

Yes, I understand. But as f2fs case shows, there can be fs-local
allocations that may be impacted. And it is good to have it documented in
the code that dq_lock is not reclaim safe to avoid bugs like f2fs had in
the future.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
