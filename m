Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05144C443D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 13:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbiBYMF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 07:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBYMF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:05:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280575219;
        Fri, 25 Feb 2022 04:05:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEFE81F383;
        Fri, 25 Feb 2022 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645790725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAnCOUNlpv0ysOvixU+XiM/OYFni8Zhhf05M8qRwWEU=;
        b=aaFFZkaYWOBT51HIQxzbdnm8VuoA/WoCDd8Qu/upqGIefFJk9jhikk4N9zV8xGTaJs8kHY
        +yjgEy/Dc0JWAceihZu1YNm+fmIjDGZHVoQY70rqxK1PfJLGC+UNKNObRBKJ/dHH7+pWB4
        Z00YB9cQ7DbBbLg9/Jd+V8DNN3em3rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645790725;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAnCOUNlpv0ysOvixU+XiM/OYFni8Zhhf05M8qRwWEU=;
        b=fxvXNPiwyYmsV4yQ5iUWGJLOT+ZZNJBUXgh+gmwP7vMYMk++4m4Zvw5Y/FtcfTHXeQU9zG
        DNhuYgTV6kAhiHDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 78DDAA3B84;
        Fri, 25 Feb 2022 12:05:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 175A6A05D9; Fri, 25 Feb 2022 13:05:22 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:05:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Message-ID: <20220225120522.6qctxigvowpnehxl@quack3.lan>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225085025.3052894-1-jhubbard@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-02-22 00:50:18, John Hubbard wrote:
> Hi,
> 
> Summary:
> 
> This puts some prerequisites in place, including a CONFIG parameter,
> making it possible to start converting and testing the Direct IO part of
> each filesystem, from get_user_pages_fast(), to pin_user_pages_fast().
> 
> It will take "a few" kernel releases to get the whole thing done.
> 
> Details:
> 
> As part of fixing the "get_user_pages() + file-backed memory" problem
> [1], and to support various COW-related fixes as well [2], we need to
> convert the Direct IO code from get_user_pages_fast(), to
> pin_user_pages_fast(). Because pin_user_pages*() calls require a
> corresponding call to unpin_user_page(), the conversion is more
> elaborate than just substitution.
> 
> Further complicating the conversion, the block/bio layers get their
> Direct IO pages via iov_iter_get_pages() and iov_iter_get_pages_alloc(),
> each of which has a large number of callers. All of those callers need
> to be audited and changed so that they call unpin_user_page(), rather
> than put_page().
> 
> After quite some time exploring and consulting with people as well, it
> is clear that this cannot be done in just one patchset. That's because,
> not only is this large and time-consuming (for example, Chaitanya
> Kulkarni's first reaction, after looking into the details, was, "convert
> the remaining filesystems to use iomap, *then* convert to FOLL_PIN..."),
> but it is also spread across many filesystems.

With having modified fs/direct-io.c and fs/iomap/direct-io.c which
filesystems do you know are missing conversion? Or is it that you just want
to make sure with audit everything is fine? The only fs I could find
unconverted by your changes is ceph. Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
