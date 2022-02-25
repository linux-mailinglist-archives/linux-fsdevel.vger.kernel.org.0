Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233074C4B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 17:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbiBYQk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiBYQkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:40:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F41218CCD;
        Fri, 25 Feb 2022 08:40:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 239732114D;
        Fri, 25 Feb 2022 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645807222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWMIUHa0fBAb1sjWcQulU95T21ZKZnSq9Doda166V14=;
        b=JuAs0dtW2wKpx+bssg4WCSeHc5mfMUwNAAGWi8XDNYurKR3sLARj4hsjyn2H0iFs+IYOr6
        RFR2U763fOXe3DBAGG27SkFLlNUyTw0ZQJN4ojIxuCk7xv0Cl25kk01aNJG63nm+W/Rft1
        v+t0yk988AO+naiNi2oLsRFYna6Eo4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645807222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWMIUHa0fBAb1sjWcQulU95T21ZKZnSq9Doda166V14=;
        b=fpmsJkUoh+jPBaKF+/CqprBoDi2xs0cypb+JYPL6ZNxz8ceCCtHITK0r9Kk6gHWNGae0/z
        1mCd7CFTzPJSPHBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1463A3B83;
        Fri, 25 Feb 2022 16:40:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0352FA05D9; Fri, 25 Feb 2022 17:40:15 +0100 (CET)
Date:   Fri, 25 Feb 2022 17:40:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Message-ID: <20220225164015.sriu6rz4hnqz25s5@quack3.lan>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225120522.6qctxigvowpnehxl@quack3.lan>
 <1d31ce1f-d307-fef0-8fce-84d6d96c6968@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d31ce1f-d307-fef0-8fce-84d6d96c6968@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-02-22 16:14:14, Chaitanya Kulkarni wrote:
> On 2/25/22 04:05, Jan Kara wrote:
> > On Fri 25-02-22 00:50:18, John Hubbard wrote:
> >> Hi,
> >>
> >> Summary:
> >>
> >> This puts some prerequisites in place, including a CONFIG parameter,
> >> making it possible to start converting and testing the Direct IO part of
> >> each filesystem, from get_user_pages_fast(), to pin_user_pages_fast().
> >>
> >> It will take "a few" kernel releases to get the whole thing done.
> >>
> >> Details:
> >>
> >> As part of fixing the "get_user_pages() + file-backed memory" problem
> >> [1], and to support various COW-related fixes as well [2], we need to
> >> convert the Direct IO code from get_user_pages_fast(), to
> >> pin_user_pages_fast(). Because pin_user_pages*() calls require a
> >> corresponding call to unpin_user_page(), the conversion is more
> >> elaborate than just substitution.
> >>
> >> Further complicating the conversion, the block/bio layers get their
> >> Direct IO pages via iov_iter_get_pages() and iov_iter_get_pages_alloc(),
> >> each of which has a large number of callers. All of those callers need
> >> to be audited and changed so that they call unpin_user_page(), rather
> >> than put_page().
> >>
> >> After quite some time exploring and consulting with people as well, it
> >> is clear that this cannot be done in just one patchset. That's because,
> >> not only is this large and time-consuming (for example, Chaitanya
> >> Kulkarni's first reaction, after looking into the details, was, "convert
> >> the remaining filesystems to use iomap, *then* convert to FOLL_PIN..."),
> >> but it is also spread across many filesystems.
> > 
> > With having modified fs/direct-io.c and fs/iomap/direct-io.c which
> > filesystems do you know are missing conversion? Or is it that you just want
> > to make sure with audit everything is fine? The only fs I could find
> > unconverted by your changes is ceph. Am I missing something?
> 
> if I understand your comment correctly file systems which are listed in
> the list see [1] (all the credit goes to John to have a complete list)
> that are not using iomap but use XXX_XXX_direct_IO() should be fine,
> since in the callchain going from :-
> 
> XXX_XXX_direct_io()
>   __blkdev_direct_io()
>    do_direct_io()
> 
>    ...
> 
>      submit_page_selection()
>       get/put_page() <---
> 
> will take care of itself ?

Yes, John's changes to fs/direct-io.c should take care of these
filesystems using __blkdev_direct_io().

								Honza

> [1]
> 
> jfs_direct_IO()
> nilfs_direct_IO()
> ntfs_dirct_IO()
> reiserfs_direct_IO()
> udf_direct_IO()
> ocfs2_dirct_IO()
> affs_direct_IO()
> exfat_direct_IO()
> ext2_direct_IO()
> fat_direct_IO()
> hfs_direct_IO()
> hfs_plus_direct_IO()
> 
> -ck
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
