Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82243D6BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhG0B0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhG0B0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:26:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4BC061757;
        Mon, 26 Jul 2021 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0ATl+eIh0HuiypTyuL38sNzso+AG9tCEbfF0CNjqqM=; b=unyefSVZ6q91OKI3QKjtdVxX7K
        bOZtKgxWnX4ShhE+mwfNAkHi+rfDnWczn5QB2a7UlkkiMzNHsxzuEGGFI9jDjScwVSg/dLxGhJNAH
        y6FDtCpt55JJlmHtjMd2pDKYOpOU5QdJC6Bta/hMqixP7gH6Paij1bsyOOIzNnzgytJ7aZi/iuH8h
        KlRpJCIAPYnsK464AaujXWchz+xg36bMNkv/Kd+YlM/+5IVwwN7+gDbR6dywCkhE3cHA8i6wi1WEU
        UEmr9aGtnqUUpqYf30O/yQNKEEz/bdQ1mCRG33fCpmw6XljCg4OSUIr7O+/J8xVyOahbR+m4mBHcL
        uz+Zfw0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8CTR-00EZdj-0O; Tue, 27 Jul 2021 02:06:00 +0000
Date:   Tue, 27 Jul 2021 03:05:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <YP9p8G6eu30+d2jH@casper.infradead.org>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
 <162733718119.4153.5949006309014161476@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162733718119.4153.5949006309014161476@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:06:21AM +1000, NeilBrown wrote:
> You seem to be assuming that inode->i_mapping->host is always 'inode'.
> That is not the case.

Weeeelllll ... technically, outside of the filesystems that are
changed here, the only assumption in common code that is made is that
inode_to_bdi(inode->i_mapping->host->i_mapping->host) ==
inode_to_bdi(inode)

Looking at inode_to_bdi, that just means that they have the same i_sb.
Which is ... not true for character raw devices?
        if (++raw_devices[minor].inuse == 1)
                file_inode(filp)->i_mapping =
                        bdev->bd_inode->i_mapping;
but then, who's using readahead on a character raw device?  They
force O_DIRECT.  But maybe this should pass inode->i_mapping->host
instead of inode.

> In particular, fs/coda/file.c contains
> 
> 	if (coda_inode->i_mapping == &coda_inode->i_data)
> 		coda_inode->i_mapping = host_inode->i_mapping;
> 
> So a "coda_inode" shares the mapping with a "host_inode".
> 
> This is why an inode has both i_data and i_mapping.
> 
> So I'm not really sure this patch is safe.  It might break codafs.
> 
> But it is more likely that codafs isn't used, doesn't work, should be
> removed, and i_data should be renamed to i_mapping.

I think there's also something unusual going on with either ocfs2
or gfs2.  But yes, I don't understand the rules for when I need to
go from inode->i_mapping->host.
