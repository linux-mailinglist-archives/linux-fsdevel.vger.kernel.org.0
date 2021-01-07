Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE532ED069
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbhAGNOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 08:14:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbhAGNOK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E56F3AD12;
        Thu,  7 Jan 2021 13:13:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 229D91E0872; Thu,  7 Jan 2021 14:13:28 +0100 (CET)
Date:   Thu, 7 Jan 2021 14:13:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/13] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <20210107131328.GC12990@quack2.suse.cz>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-5-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 04-01-21 16:54:43, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As was done for generic_update_time(), only pass I_DIRTY_TIME to
> __mark_inode_dirty() when the inode's timestamps were actually updated
> and lazytime is enabled.  This avoids a weird edge case where
> I_DIRTY_TIME could be set in i_state when lazytime isn't enabled.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

...
> +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> +		dirty_flags |= I_DIRTY_SYNC;
>  
> -	if (dirty)
> -		iflags |= I_DIRTY_SYNC;
>  	__mark_inode_dirty(inode, iflags);
				  ^^^ dirty_flags here?

Otherwise the change looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
