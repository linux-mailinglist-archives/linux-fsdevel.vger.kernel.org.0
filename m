Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27C4C44EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiBYMwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiBYMwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:52:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C87462C;
        Fri, 25 Feb 2022 04:52:11 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 20C7C21155;
        Fri, 25 Feb 2022 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645793530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gvgCDrrNRjiQXWEFzylOMvqJ+2glDCwy3Eb66PaWnc=;
        b=D8yK2jblPQaKBxqfQY2GzHNeeG+aXD+J9UxugZZdx62VLwTAxCTtN1efOenuKsKby2x6Ru
        Gf2ZJ9y6eTPYdL+tGmLgABZxTwUQA4lek2CI++K6sHJjordbCvPy38ZLRvrtZRaRVpZECF
        iXhWrLpoJz5V7Ru66IQU6MjXt/0DY5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645793530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gvgCDrrNRjiQXWEFzylOMvqJ+2glDCwy3Eb66PaWnc=;
        b=WBw97hzHHPApTyqMTHwVeLODsAyyu5G/F87G8Zx4wEntHiSN8AICJ8UidR8Hds8lsA9+lv
        kRLA0qSFFiLr3tCA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 101D4A3B81;
        Fri, 25 Feb 2022 12:52:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC076A05D9; Fri, 25 Feb 2022 13:52:09 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:52:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Edward Shishkin <edward.shishkin@gmail.com>
Subject: Re: [PATCH] reiserfs: Deprecate reiserfs
Message-ID: <20220225125209.6dv6osndesrc346z@quack3.lan>
References: <20220223142653.22388-1-jack@suse.cz>
 <20220223213127.GI3061737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223213127.GI3061737@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-02-22 08:31:27, Dave Chinner wrote:
> On Wed, Feb 23, 2022 at 03:26:53PM +0100, Jan Kara wrote:
> > Reiserfs is relatively old filesystem and its development has ceased
> > quite some years ago. Linux distributions moved away from it towards
> > other filesystems such as btrfs, xfs, or ext4. To reduce maintenance
> > burden on cross filesystem changes (such as new mount API, iomap, folios
> > ...) let's add a deprecation notice when the filesystem is mounted and
> > schedule its removal to 2024.
> 
> Two years might be considered "short notice" for a filesystem, but I
> guess that people running it because it is stable will most likely
> also linger on stable kernels where it will live "maintained" for
> many years after it has been removed from the upstream code base.

Yeah, I guess that is the case usually. Anyway based on feedback from one
reiserfs user I've pushed the date to 2025.

> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/reiserfs/Kconfig | 10 +++++++---
> >  fs/reiserfs/super.c |  2 ++
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > Here's my suggestion for deprecating reiserfs. If nobody has reasons against
> > this, I'll send the patch to Linus during the next merge window.
> 
> Is there a deprecation/removal schedule somewhere that documents
> stuff like this? We documented in the XFS section of the kernel
> admin guide (where we also document mount option and
> sysctl deprecation and removal schedules), but I don't think
> anything like that exists for reiserfs or for filesystems in
> general.

The only document I'm aware of is Documentation/process/deprecated.rst
for which filesystem deprecation seems inappropriate. So no I don't think
we have such general document for filesystems.

> Other than that, the patch looks good.

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
