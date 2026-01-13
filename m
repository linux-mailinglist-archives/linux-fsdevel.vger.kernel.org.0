Return-Path: <linux-fsdevel+bounces-73359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC0ED1628F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F69302D91C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74292727E2;
	Tue, 13 Jan 2026 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKsZg0+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9F21E0AD;
	Tue, 13 Jan 2026 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267594; cv=none; b=Qa+Le30D1i7h5i8mvgRptwx/1HNuPx3LWvzsL8J7Rn5jTjisfRPJSZm7HJFX7MYarUu8KJtnFJY5oxjUpB13GWdw70mMHK8tPbPoO0gfluHxDTXZl1yOLue+HpC8vexBLH+URKvNoHyLfqG3Qqq7Qizqwia5JbQeOGZ67xJaQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267594; c=relaxed/simple;
	bh=Nr4KtDhNg+4h7ThlqYwwAuYEUz+4/IpDCPVtQ0J2rsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzC3RaqGtQH3QF6eRvC47BsTDd0vHuAXBimWzbEmo1zfQUS/kxXXuCV3/8ou7rGS1jRtX5KCMIObUUjBtQwBLMxNWPUXGTEHx8YGQ1t5aVmScgAIuQLJRgAtdRrxvTBJLl1pIf4gUHIsgy7OKdMLJFxjZ9BeF3YI48ugGzFGWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKsZg0+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9DCC116D0;
	Tue, 13 Jan 2026 01:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768267593;
	bh=Nr4KtDhNg+4h7ThlqYwwAuYEUz+4/IpDCPVtQ0J2rsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKsZg0+uHK5ChrSoz4JoG7ahcII2uaGofEK8IKQw/ELANP7OV45BibFym926ujuGX
	 FZ9KwuV/Oaotl6u16CAgZDDDU6SF00IrcdY35Noa/4xhiTD3ItGHmRc3VcxzkVkT1d
	 kxezTs7x4ZIloeLYJyKugWV8qNvz/exxND6hJS1E19ESIhWTNOx10yy79bxmw9rNyW
	 9pjMfJYVsyjY/uTmE2zX1JZqOBF7/orWaDK6mWBbxNPhUDU4WGdNNCWrBZSeUw5kDX
	 VhqDbm+re4KpXOhtz+P8eM+UvkpDpV7NLrwyKIzmlH4g+5P5U6djD91J70ee4wgrSz
	 Jp6FnzNwR9QYg==
Date: Mon, 12 Jan 2026 17:26:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
Message-ID: <20260113012633.GT15551@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
 <176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>
 <87zf6i2uvq.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf6i2uvq.fsf@mailhost.krisman.be>

On Mon, Jan 12, 2026 at 07:56:09PM -0500, Gabriel Krisman Bertazi wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
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
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Jan Kara <jack@suse.cz>
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
> 
> Perhaps also delete fsnotify_sb_error after this patch since it is now
> implemented by fserror_worker and, if I follow correctly, we don't want
> it to be called without the shutdown protection mechanism.

<nod> I was planning to ask Linus if I could do that as a treewide
cleanup at the end of the whichever merge window integrates this, just
in case someone else adds a fsnotify_sb_error call to their filesystem
during that same merge window.

--D

> -- 
> Gabriel Krisman Bertazi
> 

