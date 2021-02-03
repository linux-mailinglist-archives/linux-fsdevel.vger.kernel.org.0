Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8730D2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 06:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBCFSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 00:18:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45665 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229845AbhBCFSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:18:07 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1135GvnR020171
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Feb 2021 00:16:58 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 80C2F15C39E2; Wed,  3 Feb 2021 00:16:57 -0500 (EST)
Date:   Wed, 3 Feb 2021 00:16:57 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 11/12] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
Message-ID: <YBoxyQIdqRQT3jX5@mit.edu>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-12-ebiggers@kernel.org>
 <20210111105342.GE2502@lst.de>
 <X/yzzKhysdFUY/6o@sol.localdomain>
 <20210112132521.GB13780@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112132521.GB13780@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 02:25:21PM +0100, Christoph Hellwig wrote:
> > We could add:
> > 
> > 	static inline bool other_inode_has_dirtytime(struct inode *inode)
> > 	{
> > 		return (inode->state & (I_FREEING | I_WILL_FREE |
> > 					I_NEW | I_DIRTY_TIME)) == I_DIRTY_TIME;
> > 	}
> > 
> > But it seems a bit weird when it's specific to ext4 at the moment.
> > 
> > Are you thinking that other filesystems will implement the same sort of
> > opportunistic update, so we should add the helper now?
> 
> For my taste these checks for flags is way too much black magic and will
> trivially break when people add new flags.  So having a helper next to
> the definition of the I_* flags that is well documented would be very,
> very helpful.  My preferred naming would be something along the lines
> of 'inode_is_dirty_lazytime_only()'.

The name makes sense to me.  I'm not sure it's likely that there will
be new types of dirtiness --- as near I can tell the I_DIRTY_TIME was
the first time there has been any changes in a _really_ long time, but
I agree that how the flags interact (even before we added
I_DIRTY_TIME) involved no small amount of black magic, and it's the
kind of thing that requires deep meditation before trying to make any
changes, and then immediately slips out of one's L1 cache very shortly
afterwards.  :-)

					- Ted
