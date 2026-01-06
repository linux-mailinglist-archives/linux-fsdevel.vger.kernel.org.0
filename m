Return-Path: <linux-fsdevel+bounces-72531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD7CF9C3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 18:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6EA315A935
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9AA26CE3F;
	Tue,  6 Jan 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUfRjIz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150320F079;
	Tue,  6 Jan 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720637; cv=none; b=IJFxu1gYAvUWcbxCPVnQCofbEXih+blcBQw7Uxxu7UBjzCj041gWH+irnAs5t50RDDJ/hNzUgTF95FK9bIRIpRmANnQ9uNqwhz1tyQyRVzArK+S8at/NR5HuWFtxVXJLs4rRxZLK7KoUsZWFdViKnNfBRLH21Ws6JwOnzsS1gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720637; c=relaxed/simple;
	bh=pBcwUDZ+JYFYHCFjigi2ujyDsZScOpgIHsZ7TNAIlGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNdb/dAE2oQpSyFGb1uZJf2j/R8dC8nwu8nO9KWo6aZSH6pmRvrvIIYk3UfQSx1ALmsc1hzdBO9x5qDQnBPqMmTBEIJ8NhTEnf+6tTvKEWJfIlNCSNbWwi4XLSnoEkLEFPNeodfPXI338YrK0iNZ8muwLThrSdaZSG6rB4fhi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUfRjIz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFC4C116C6;
	Tue,  6 Jan 2026 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767720636;
	bh=pBcwUDZ+JYFYHCFjigi2ujyDsZScOpgIHsZ7TNAIlGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUfRjIz3pAFGZXpwpteH0LQQ73z2KHMfmgV8mN/hcByfFQyDrbCymvIAY0tePsq/9
	 eYGaiKYdgntVA/OY7zssFSkUQ6IYAs5TYMN89+/PtbSLSOXtqoMpO/TmiOs17TkS+L
	 Rz+CA6mRRi8Uf0lPM3uqQxREesaihOBCK2LlBswxloswS5UUjJuYBonkxXSJOpcLQ1
	 /qYtYVk+GUnBbmTiM3m++sP0vHp7tqnWrgcKiqknCR3Od+gxPoIn8BaxI9D+iG//4z
	 8SASwXRmfUUTr7VSyO0mUf+Wm/WqBTkz2BQNpuz3y9liyqkwuTu1EPSlz7ZpKGM7y0
	 X+ZyhcIWbIvPw==
Date: Tue, 6 Jan 2026 09:30:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
Message-ID: <20260106173036.GC191481@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332256.686273.6918131598618211052.stgit@frogsfrogsfrogs>
 <lhvwanmjakwkrpugrhg6qjjv5nvsywr2nlbqmwrt76jqijmkgv@fqpzmao4zknr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhvwanmjakwkrpugrhg6qjjv5nvsywr2nlbqmwrt76jqijmkgv@fqpzmao4zknr>

On Mon, Dec 22, 2025 at 04:34:48PM +0100, Jan Kara wrote:
> On Wed 17-12-25 18:04:14, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Use the new fserror functions to report metadata errors to fsnotify.
> > Note that ext4 inconsistently passes around negative and positive error
> > numbers all over the codebase, so we force them all to negative for
> > consistency in what we report to fserror, and fserror ensures that only
> > positive error numbers are passed to fanotify, per the fanotify(7)
> > manpage.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> We need to cleanup those error numbers passing - we should have mostly
> negative ones AFAIK - where do we end up passing positive ones? But it's
> unrelated to this patch so feel free to add:

Here and there:

$ git grep 'ext4_error.*[[:space:]]E[A-Z]' fs/ext4/
fs/ext4/balloc.c:582:           ext4_error_err(sb, EIO, "Cannot read block bitmap - "
fs/ext4/ialloc.c:201:           ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
fs/ext4/inode.c:4952:           ext4_error_inode_block(inode, err_blk, EIO,
fs/ext4/inode.c:4967:           ext4_error_inode_block(inode, err_blk, EIO,
fs/ext4/inode.c:5188:           __ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
fs/ext4/inode.c:5728:                   ext4_error_inode_block(inode, iloc.bh->b_blocknr, EIO,
fs/ext4/mmp.c:218:                              ext4_error_err(sb, EBUSY, "abort");

> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

--D

> 
> 								Honza
> 
> > ---
> >  fs/ext4/ioctl.c |    2 ++
> >  fs/ext4/super.c |   13 +++++++++----
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > 
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 7ce0fc40aec2fb..ea26cd03d3ce28 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/fsmap.h>
> >  #include "fsmap.h"
> >  #include <trace/events/ext4.h>
> > +#include <linux/fserror.h>
> >  
> >  typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
> >  				     struct ext4_super_block *es,
> > @@ -844,6 +845,7 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
> >  		return -EINVAL;
> >  	}
> >  	clear_opt(sb, DISCARD);
> > +	fserror_report_shutdown(sb, GFP_KERNEL);
> >  	return 0;
> >  }
> >  
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 87205660c5d026..a6241ffb8639c3 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/fsnotify.h>
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> > +#include <linux/fserror.h>
> >  
> >  #include "ext4.h"
> >  #include "ext4_extents.h"	/* Needed for trace points definition */
> > @@ -824,7 +825,8 @@ void __ext4_error(struct super_block *sb, const char *function,
> >  		       sb->s_id, function, line, current->comm, &vaf);
> >  		va_end(args);
> >  	}
> > -	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
> > +	fserror_report_metadata(sb, error ? -abs(error) : -EFSCORRUPTED,
> > +				GFP_ATOMIC);
> >  
> >  	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
> >  }
> > @@ -856,7 +858,9 @@ void __ext4_error_inode(struct inode *inode, const char *function,
> >  			       current->comm, &vaf);
> >  		va_end(args);
> >  	}
> > -	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
> > +	fserror_report_file_metadata(inode,
> > +				     error ? -abs(error) : -EFSCORRUPTED,
> > +				     GFP_ATOMIC);
> >  
> >  	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
> >  			  function, line);
> > @@ -896,7 +900,7 @@ void __ext4_error_file(struct file *file, const char *function,
> >  			       current->comm, path, &vaf);
> >  		va_end(args);
> >  	}
> > -	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
> > +	fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_ATOMIC);
> >  
> >  	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
> >  			  function, line);
> > @@ -965,7 +969,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
> >  		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
> >  		       sb->s_id, function, line, errstr);
> >  	}
> > -	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
> > +	fserror_report_metadata(sb, errno ? -abs(errno) : -EFSCORRUPTED,
> > +				GFP_ATOMIC);
> >  
> >  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
> >  }
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

