Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF17390B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 23:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhEYV2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEYV2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 17:28:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD9C061574;
        Tue, 25 May 2021 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYNzR6K3PIie0xGXngP89tD+HJUpDWKHnFmlSQ/Txdk=; b=Zdjlab78a1pNCAT69XlYHdae+P
        1og8tvKEDGIShobkaTEJQ6UnAuc+SWNYft47PGNjMC7oF56+sWx8Zxo2gcqeo8qMZ5OyVPU8Ej6em
        Hy3iBLURPqblP1D1iu5wAB4i6vQEhbWfXg8PYIJNYTnUU4fQJ024cZT6lKLUoL5eRYsNoYqbs4M6U
        dhqPkczBY65bXJrReQDOJp6wFwFwsz8fa5NJparemNjKVH9pcxiS16tVrDsVVliID6k7S4I05SEvC
        EITaphGXQuqgSM+ssPPgmfCyNZXH88xzaEHv+/rcitpgGJBSfHbOHZNhwTqc6OYUtn0kAxd8sg9Z0
        NciHE5KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lleZ8-003udz-0Z; Tue, 25 May 2021 21:26:27 +0000
Date:   Tue, 25 May 2021 22:26:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <YK1rebI5vZKCeLlp@casper.infradead.org>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
 <YKntRtEUoxTEFBOM@localhost>
 <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:13:52PM -0600, Andreas Dilger wrote:
> Definitely "-o discard" is known to have a measurable performance impact,
> simply because it ends up sending a lot more requests to the block device,
> and those requests can be slow/block the queue, depending on underlying
> storage behavior.
> 
> There was a patch pushed recently that targets "-o discard" performance:
> https://patchwork.ozlabs.org/project/linux-ext4/list/?series=244091
> that needs a bit more work, but may be worthwhile to test if it improves
> your workload, and help put some weight behind landing it?

This all seems very complicated.  I have chosen with my current laptop
to "short stroke" the drive.  That is, I discarded the entire bdev,
then partitioned it roughly in half.  The second half has never seen
any writes.  This effectively achieves the purpose of TRIM/discard;
there are a lot of unused LBAs, so the underlying flash translation layer
always has plenty of spare space when it needs to empty an erase block.

Since the steady state of hard drives is full, I have to type 'make clean'
in my build trees more often than otherwise and remember to delete iso
images after i've had them lying around for a year, but I'd rather clean
up a little more often than get these weird performance glitches.

And if I really do need half a terabyte of space temporarily, I can
always choose to use the fallow range for a while, then discard it again.

