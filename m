Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67B3D6C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhG0CGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 22:06:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40474 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhG0CGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:06:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 380CD220F7;
        Tue, 27 Jul 2021 02:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627353993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APvpEj/C5O4j/vdhFvTtJp7pnacMiKi2HxGUdwadN9A=;
        b=HTPIbu+kTIomAhzPQLYze7fN3sW6GE90+OasyJtLyvaSGiu0IAdGFEr7V4HspoLodUOBP/
        UvPy/OMuKM1RkOZvSCDTlV86zdkLGq6MBl3SnCXoBUgN1H6A8/1zcAKYRxh/C9Zv6gKvzy
        qrWJKbyfZ3WkSN5CslF1AI4/2ICNCh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627353993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APvpEj/C5O4j/vdhFvTtJp7pnacMiKi2HxGUdwadN9A=;
        b=PmhyBKHBUB/VZueUX4Yf4VwUCJ35+fUSE0BTDLR7TKF9+dBAU5skZHv2Rzr/PAfOhEsvVc
        VsBvQhdi/HRVEaCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BDC22133DE;
        Tue, 27 Jul 2021 02:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xRWIHYhz/2CqUgAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 02:46:32 +0000
Date:   Mon, 26 Jul 2021 21:46:30 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <20210727024630.ia4sne4gbruvssgy@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
 <162733718119.4153.5949006309014161476@noble.neil.brown.name>
 <YP9p8G6eu30+d2jH@casper.infradead.org>
 <162735275468.4153.4700285307587386171@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162735275468.4153.4700285307587386171@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12:25 27/07, NeilBrown wrote:
> On Tue, 27 Jul 2021, Matthew Wilcox wrote:
> > On Tue, Jul 27, 2021 at 08:06:21AM +1000, NeilBrown wrote:
> > > You seem to be assuming that inode->i_mapping->host is always 'inode'.
> > > That is not the case.
> > 
> > Weeeelllll ... technically, outside of the filesystems that are
> > changed here, the only assumption in common code that is made is that
> > inode_to_bdi(inode->i_mapping->host->i_mapping->host) ==
> > inode_to_bdi(inode)
> 
> Individual filesystems doing their own thing is fine.  Passing just an
> inode to inode_to_bdi is fine.
> 
> But the patch changes do_dentry_open()

But do_dentry_open() is setting up the file pointer (f) based on
inode (and it's i_mapping). Can f->f_mapping change within
do_dentry_open()?

> 
> > 
> > Looking at inode_to_bdi, that just means that they have the same i_sb.
> > Which is ... not true for character raw devices?
> >         if (++raw_devices[minor].inuse == 1)
> >                 file_inode(filp)->i_mapping =
> >                         bdev->bd_inode->i_mapping;
> > but then, who's using readahead on a character raw device?  They
> > force O_DIRECT.  But maybe this should pass inode->i_mapping->host
> > instead of inode.
> 
> Also not true in coda.
> 
> coda (for those who don't know) is a network filesystem which fetches
> whole files (and often multiple files) at a time (like the Andrew
> filesystem).  The files are stored in a local filesystem which acts as a
> cache.
> 
> So an inode in a 'coda' filesystem access page-cache pages from a file
> in e.g. an 'ext4' filesystem.  This is done via the ->i_mapping link.
> For (nearly?) all other filesystems, ->i_mapping is a link to ->i_data
> in the same inode.
> 
> > 
> > > In particular, fs/coda/file.c contains
> > > 
> > > 	if (coda_inode->i_mapping == &coda_inode->i_data)
> > > 		coda_inode->i_mapping = host_inode->i_mapping;
> > > 
> > > So a "coda_inode" shares the mapping with a "host_inode".
> > > 
> > > This is why an inode has both i_data and i_mapping.
> > > 
> > > So I'm not really sure this patch is safe.  It might break codafs.
> > > 
> > > But it is more likely that codafs isn't used, doesn't work, should be
> > > removed, and i_data should be renamed to i_mapping.
> > 
> > I think there's also something unusual going on with either ocfs2
> > or gfs2.  But yes, I don't understand the rules for when I need to
> > go from inode->i_mapping->host.
> > 
> 
> Simple.  Whenever you want to work with the page-cache pages, you cannot
> assume anything in the original inode is relevant except i_mapping (and
> maybe i_size I guess).
> 
> NeilBrown

-- 
Goldwyn
