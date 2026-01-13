Return-Path: <linux-fsdevel+bounces-73355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97276D1618B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AFE33008E06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6152248176;
	Tue, 13 Jan 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="WfoIGKbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9E163;
	Tue, 13 Jan 2026 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265777; cv=none; b=N728ILEF08uX9vPZaplhtA1V7KqrqknBKWSXS4Wf4U68f0xPstwSu1OvLSaEwc+4GqGReWCNLOWNxYh5NsTcnBN7hA3Mh63SEqNOy/fAKVY9WFpPLH/77u9QjSEl4aMBRB0guUqOxD8X4tyL9+H9BCfaCMud6qxchLU0JuGi2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265777; c=relaxed/simple;
	bh=Kggmb77ytihcHf5+lXA+EufCWEeNLjUfEizYBi03TlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q/g4sRqfo7x5bVYpW1Tb86ajAtdbWdB2rqUKS08LdpxtvFgUYO68uJHm2CxRn6zoKFwe32wEeTH07m0FZEtGwTfFvG80/BnrPEnALYbjgVCo8LMqKkzodKa7Lg98jxohztpA3/cK4Nf7mRZU1CK9wGkp+V2Wa6IOinL0F0Tom2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=WfoIGKbX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B7D51FD10;
	Tue, 13 Jan 2026 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1768265772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXN6T25nFixjXVaPmXBjazSh+YbeQOL9dYmGzZAoTWo=;
	b=WfoIGKbX65JVPViitXXL2+5q6iAu39k2qW6Mq5vtQuD4+LK0FUvGJj96NcR/8GbJC2XBLj
	VfQNTP2JMhWNPFip4eYU4FChsb+ofQgup4SSL1s28khxIyYJ9qXlZ+cWyECQlb2TquTNn3
	ji3jaqHgsQE5OAq91bPqyU69ZFeME+pU9NaZ4P+v+CcfV40O1+RK/Mz48wdBEfV5QwjpX8
	XXPFJPbYmbQSv+NFSxWlgnhoPE4vZ7tCCdIJUVxwKngNF/2VU+qgaVO/ZLYq9qcJwwqHD8
	9Hyf2ViqNtwqQN1Ty0e/mI3oGECmI/VlIuLgY5nyZGAPjdbajvvQVv8fCL4gwg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org,  hch@lst.de,  jack@suse.cz,
  linux-xfs@vger.kernel.org,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  amir73il@gmail.com
Subject: Re: [PATCH 6/6] ext4: convert to new fserror helpers
In-Reply-To: <176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>
	(Darrick J. Wong's message of "Mon, 12 Jan 2026 16:32:27 -0800")
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
	<176826402693.3490369.5875002879192895558.stgit@frogsfrogsfrogs>
Date: Mon, 12 Jan 2026 19:56:09 -0500
Message-ID: <87zf6i2uvq.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefirggsrhhivghlucfmrhhishhmrghnuceuvghrthgriihiuceoghgrsghrihgvlheskhhrihhsmhgrnhdrsggvqeenucggtffrrghtthgvrhhnpeffgfevieeuvdfgudeviedvjeevfedvkedvgffhhffhfeethedvveefhfeuudfgteenucfkphepuddtjedrudejuddrudeftddrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutdejrddujedurddufedtrddvfedvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehgrggsrhhivghlsehkrhhishhmrghnrdgsvgdpqhhiugepudeujeffheduhfffuddtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehlihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrgh

"Darrick J. Wong" <djwong@kernel.org> writes:

> From: Darrick J. Wong <djwong@kernel.org>
>
> Use the new fserror functions to report metadata errors to fsnotify.
> Note that ext4 inconsistently passes around negative and positive error
> numbers all over the codebase, so we force them all to negative for
> consistency in what we report to fserror, and fserror ensures that only
> positive error numbers are passed to fanotify, per the fanotify(7)
> manpage.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ioctl.c |    2 ++
>  fs/ext4/super.c |   13 +++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
>
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7ce0fc40aec2fb..ea26cd03d3ce28 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -26,6 +26,7 @@
>  #include <linux/fsmap.h>
>  #include "fsmap.h"
>  #include <trace/events/ext4.h>
> +#include <linux/fserror.h>
>  
>  typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
>  				     struct ext4_super_block *es,
> @@ -844,6 +845,7 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
>  		return -EINVAL;
>  	}
>  	clear_opt(sb, DISCARD);
> +	fserror_report_shutdown(sb, GFP_KERNEL);
>  	return 0;
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d026..a6241ffb8639c3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -48,6 +48,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/fserror.h>
>  
>  #include "ext4.h"
>  #include "ext4_extents.h"	/* Needed for trace points definition */
> @@ -824,7 +825,8 @@ void __ext4_error(struct super_block *sb, const char *function,
>  		       sb->s_id, function, line, current->comm, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(sb, NULL, error ? error : EFSCORRUPTED);
> +	fserror_report_metadata(sb, error ? -abs(error) : -EFSCORRUPTED,
> +				GFP_ATOMIC);
>  
>  	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
> @@ -856,7 +858,9 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>  			       current->comm, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(inode->i_sb, inode, error ? error : EFSCORRUPTED);
> +	fserror_report_file_metadata(inode,
> +				     error ? -abs(error) : -EFSCORRUPTED,
> +				     GFP_ATOMIC);
>  
>  	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
>  			  function, line);
> @@ -896,7 +900,7 @@ void __ext4_error_file(struct file *file, const char *function,
>  			       current->comm, path, &vaf);
>  		va_end(args);
>  	}
> -	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
> +	fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_ATOMIC);
>  
>  	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
>  			  function, line);
> @@ -965,7 +969,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>  		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>  		       sb->s_id, function, line, errstr);
>  	}
> -	fsnotify_sb_error(sb, NULL, errno ? errno : EFSCORRUPTED);
> +	fserror_report_metadata(sb, errno ? -abs(errno) : -EFSCORRUPTED,
> +				GFP_ATOMIC);
>  
>  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
>

Perhaps also delete fsnotify_sb_error after this patch since it is now
implemented by fserror_worker and, if I follow correctly, we don't want
it to be called without the shutdown protection mechanism.

-- 
Gabriel Krisman Bertazi

