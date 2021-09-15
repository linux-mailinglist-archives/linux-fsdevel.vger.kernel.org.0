Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7140BCA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 02:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhIOAaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 20:30:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41785 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229991AbhIOAaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 20:30:11 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18F0SW4D005150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 20:28:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EEB2F15C3424; Tue, 14 Sep 2021 20:28:31 -0400 (EDT)
Date:   Tue, 14 Sep 2021 20:28:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <YUE+L19JyjqWh+Md@mit.edu>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163157838437.13293.14244628630141187199.stgit@noble.brown>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> 
> Of particular interest is the ext4_journal_start family of calls which
> can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> a high bit, so it is safe in practice.

I'm really not fond of this type blurring.  What I'd suggeset doing
instead is adding a "gfp_t gfp_mask" parameter to the
__ext4_journal_start_sb().  With the exception of one call site in
fs/ext4/ialloc.c, most of the callers of __ext4_journal_start_sb() are
via #define helper macros or inline funcions.  So it would just
require adding a GFP_NOFS as an extra parameter to the various macros
and inline functions which call __ext4_journal_start_sb() in
ext4_jbd2.h.

The function ext4_journal_start_with_revoke() is called exactly once
so we could just bury the __GFP_NOFAIL in the definition of that
macros, e.g.:

#define ext4_journal_start_with_revoke(inode, type, blocks, revoke_creds) \
	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
			     GFP_NOFS | __GFP_NOFAIL, (revoke_creds))

but it's probably better to do something like this:

#define ext4_journal_start_with_revoke(gfp_mask, inode, type, blocks, revoke_creds) \
	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
			     gfp_mask, (revoke_creds))

So it's explicit in the C function ext4_ext_remove_space() in
fs/ext4/extents.c that we are explicitly requesting the __GFP_NOFAIL
behavior.

Does that make sense?

					- Ted
