Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38923544D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHAUlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHAUlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:41:31 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82524C061756
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 13:41:31 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so32072909qka.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aingp8oS2G2PVwN1rnp+d4+phne8/5iWi2v05A7a2sU=;
        b=QVO3Ew/KL3nDfX1d9igJ1oJgkGhANqhcS5wSsH2XKFOwPIH8mMivvp9K/ce60UuTwB
         rNN7fVX39TWj4ZPjABBISZn/TJiunDQc94y88zddoP15JgxWDrW49OWQMeoyxg6TvV94
         Xzg0MZ/HO9AJxc5yLAHVTlCKUfP/55h1hFYFVdpIeLD/Sa2jjeLztGbPxQLLniDJEtpD
         MxxCjsrcHnAkDTdHBHyI13GHnfEOE8/MDuIKjXE+6jhcS0av0pYzI/vjoA7JoMszX/g2
         dNOlgMp+0oafStMrmEItHlX+Ym0G78l8Xr3qm8yU5AcA3dg8cz/NTfpP/2UjzpLoW/NB
         FLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aingp8oS2G2PVwN1rnp+d4+phne8/5iWi2v05A7a2sU=;
        b=PsPKraSJfSXKXb84TW9fTvHYOlWQOwxShR3MApcR2dgTdv+DSfUeU6zCQa1i3BUOxx
         vlroKBF9zriUpCErQTzUc1JPmL41LbmJu8IxTaqQilr+zgem3tVPNJ8n6oHmvXP+aodY
         5rigtf+ik3CyGl9vl8LqkQUeiS1pVDmgx2lDWtf3kWhMTuE1BUGapVOqugkQFaoIjbqR
         H9NBfWiRJ7l12rIfncRtynNxQ0vvF7/bRDSj+OMMzMyORbxFOkWRwQyy8L4Gyj0WwHMc
         1Wyd8vUKM+jrGCtdPIWxN/rqs+ZXVwBAYuXsZHuZ3AXHBq/W3LixqiFf4SJ2fVWOrV2r
         I3Kg==
X-Gm-Message-State: AOAM531lPmGTLug86d89yp7k2jX07ILYb4x0o4HRaqsJ7rkJ5UolEkpV
        sCFiBxJVXEsl04j8fcwxSyXB/w==
X-Google-Smtp-Source: ABdhPJzk4kI6PwXrX/99a757H17j1SC7Vtj7elOGGcPJVutQERmAdKSYa33T6Vu50z3kXF3+QL8zIw==
X-Received: by 2002:a05:620a:7e7:: with SMTP id k7mr9488726qkk.420.1596314490116;
        Sat, 01 Aug 2020 13:41:30 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l13sm14050302qth.77.2020.08.01.13.41.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 01 Aug 2020 13:41:28 -0700 (PDT)
Date:   Sat, 1 Aug 2020 13:41:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Down <chris@chrisdown.name>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v7 2/2] tmpfs: Support 64-bit inums per-sb
In-Reply-To: <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name>
Message-ID: <alpine.LSU.2.11.2008011223120.10700@eggly.anvils>
References: <cover.1594661218.git.chris@chrisdown.name> <8b23758d0c66b5e2263e08baf9c4b6a7565cbd8f.1594661218.git.chris@chrisdown.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Jul 2020, Chris Down wrote:

> The default is still set to inode32 for backwards compatibility, but
> system administrators can opt in to the new 64-bit inode numbers by
> either:
> 
> 1. Passing inode64 on the command line when mounting, or
> 2. Configuring the kernel with CONFIG_TMPFS_INODE64=y
> 
> The inode64 and inode32 names are used based on existing precedent from
> XFS.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Again, thanks, and comments below, but nothing to override tha Ack.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> ---
>  Documentation/filesystems/tmpfs.rst | 11 +++++
>  fs/Kconfig                          | 15 +++++++
>  include/linux/shmem_fs.h            |  1 +
>  mm/shmem.c                          | 65 ++++++++++++++++++++++++++++-
>  4 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 4e95929301a5..47b84ddaa8bb 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -150,6 +150,15 @@ These options do not have any effect on remount. You can change these
>  parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
>  
>  
> +tmpfs has a mount option to select whether it will wrap at 32- or 64-bit inode
> +numbers:
> +
> +inode64   Use 64-bit inode numbers
> +inode32   Use 32-bit inode numbers
> +
> +On 64-bit, the default is set by CONFIG_TMPFS_INODE64. On 32-bit, inode64 is
> +not legal and will produce an error at mount time.
> +

I did originally want to move this up higher, between the discussion
of nr_inodes and mpol; but its placing here follows where you placed
it in /proc/mounts, and I end up agreeing with that, so let's leave
where you've placed it.

But this is a description of a new pair of mount options, nothing to
do with the paragraph below, so one more blank line is needed.

Except that tmpfs.txt has now been replaced by tmpfs.rst, with some
====ing too.  We'd better add that.  I'm unfamiliar with, and not
prepared for .rst - getting Doc right has become a job for specialists.
I'll send a -fix.patch of how how I think it should look to Andrew and
Randy Dunlap, hoping Randy can confirm whether it ends up right.

>  So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
> @@ -161,3 +170,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
>     Hugh Dickins, 4 June 2007
>  :Updated:
>     KOSAKI Motohiro, 16 Mar 2010
> +Updated:

I bet that should say ":Updated:" now.

> +   Chris Down, 13 July 2020
> diff --git a/fs/Kconfig b/fs/Kconfig
> index ff257b81fde5..64d530ba42f6 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -229,6 +229,21 @@ config TMPFS_XATTR
>  
>  	  If unsure, say N.
>  
> +config TMPFS_INODE64
> +	bool "Use 64-bit ino_t by default in tmpfs"
> +	depends on TMPFS && 64BIT
> +	default n

Okay: I haven't looked up what our last position was on which way the
default should be, but I do recall that we were reluctantly realizing
that we couldn't safely be as radical as we had hoped.

As to "default n" being the default and unnecessary: I don't mind
seeing it there explicitly, let's give the work to whoever wants to
delete that line.

> +	help
> +	  tmpfs has historically used only inode numbers as wide as an unsigned
> +	  int. In some cases this can cause wraparound, potentially resulting in
> +	  multiple files with the same inode number on a single device. This option
> +	  makes tmpfs use the full width of ino_t by default, similarly to the
> +	  inode64 mount option.

I've just realized that this, and the inode64 Documentation, make no
mention of why you might not want to enable it: it sounds like such a
good thing, with the documentation on why not in include/linux/fs.h.
I'd better add some text to these in the -fix.patch.

> +
> +	  To override this default, use the inode32 or inode64 mount options.
> +
> +	  If unsure, say N.
> +
>  config HUGETLBFS
>  	bool "HugeTLB file system support"
>  	depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index eb628696ec66..a5a5d1d4d7b1 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -36,6 +36,7 @@ struct shmem_sb_info {
>  	unsigned char huge;	    /* Whether to try for hugepages */
>  	kuid_t uid;		    /* Mount uid for root directory */
>  	kgid_t gid;		    /* Mount gid for root directory */
> +	bool full_inums;	    /* If i_ino should be uint or ino_t */

Fine, but don't be surprised if I change that eventually,
maybe I'll make it a bit in a bitmask: I've nothing against bools
generally, but like to know the size of my structure fields,
and never sure what size a bool ends up with.

>  	ino_t next_ino;		    /* The next per-sb inode number to use */
>  	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
>  	struct mempolicy *mpol;     /* default memory policy for mappings */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0ae250b4da28..f3126ad7ba3d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -114,11 +114,13 @@ struct shmem_options {
>  	kuid_t uid;
>  	kgid_t gid;
>  	umode_t mode;
> +	bool full_inums;
>  	int huge;
>  	int seen;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> +#define SHMEM_SEEN_INUMS 8
>  };
>  
>  #ifdef CONFIG_TMPFS
> @@ -286,12 +288,17 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
>  			ino = sbinfo->next_ino++;
>  			if (unlikely(is_zero_ino(ino)))
>  				ino = sbinfo->next_ino++;
> -			if (unlikely(ino > UINT_MAX)) {
> +			if (unlikely(!sbinfo->full_inums &&
> +				     ino > UINT_MAX)) {

And don't be surprised if I put that on one line one day :)

>  				/*
>  				 * Emulate get_next_ino uint wraparound for
>  				 * compatibility
>  				 */
> -				ino = 1;
> +				if (IS_ENABLED(CONFIG_64BIT))
> +					pr_warn("%s: inode number overflow on device %d, consider using inode64 mount option\n",
> +						__func__, MINOR(sb->s_dev));

I like that you've added a warning; but it comes too late for a remount,
doesn't it?  We could do a countdown - "Only 1 billion more inode numbers
until overflow!" - that would be fun :) But a multiplicity of warnings
would be irritating to some and unnoticed by others.  I don't know.

> +				sbinfo->next_ino = 1;
> +				ino = sbinfo->next_ino++;
>  			}
>  			*inop = ino;
>  		}
> @@ -304,6 +311,10 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
>  		 * unknown contexts. As such, use a per-cpu batched allocator
>  		 * which doesn't require the per-sb stat_lock unless we are at
>  		 * the batch boundary.
> +		 *
> +		 * We don't need to worry about inode{32,64} since SB_KERNMOUNT
> +		 * shmem mounts are not exposed to userspace, so we don't need
> +		 * to worry about things like glibc compatibility.
>  		 */
>  		ino_t *next_ino;
>  		next_ino = per_cpu_ptr(sbinfo->ino_batch, get_cpu());
> @@ -3397,6 +3408,8 @@ enum shmem_param {
>  	Opt_nr_inodes,
>  	Opt_size,
>  	Opt_uid,
> +	Opt_inode32,
> +	Opt_inode64,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3416,6 +3429,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_string("nr_inodes",	Opt_nr_inodes),
>  	fsparam_string("size",		Opt_size),
>  	fsparam_u32   ("uid",		Opt_uid),
> +	fsparam_flag  ("inode32",	Opt_inode32),
> +	fsparam_flag  ("inode64",	Opt_inode64),
>  	{}
>  };
>  
> @@ -3487,6 +3502,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  			break;
>  		}
>  		goto unsupported_parameter;
> +	case Opt_inode32:
> +		ctx->full_inums = false;
> +		ctx->seen |= SHMEM_SEEN_INUMS;
> +		break;
> +	case Opt_inode64:
> +		if (sizeof(ino_t) < 8) {
> +			return invalfc(fc,
> +				       "Cannot use inode64 with <64bit inums in kernel\n");
> +		}
> +		ctx->full_inums = true;
> +		ctx->seen |= SHMEM_SEEN_INUMS;
> +		break;
>  	}
>  	return 0;
>  
> @@ -3578,8 +3605,16 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		}
>  	}
>  
> +	if ((ctx->seen & SHMEM_SEEN_INUMS) && !ctx->full_inums &&
> +	    sbinfo->next_ino > UINT_MAX) {
> +		err = "Current inum too high to switch to 32-bit inums";
> +		goto out;
> +	}
> +
>  	if (ctx->seen & SHMEM_SEEN_HUGE)
>  		sbinfo->huge = ctx->huge;
> +	if (ctx->seen & SHMEM_SEEN_INUMS)
> +		sbinfo->full_inums = ctx->full_inums;
>  	if (ctx->seen & SHMEM_SEEN_BLOCKS)
>  		sbinfo->max_blocks  = ctx->blocks;
>  	if (ctx->seen & SHMEM_SEEN_INODES) {
> @@ -3619,6 +3654,29 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>  	if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
>  		seq_printf(seq, ",gid=%u",
>  				from_kgid_munged(&init_user_ns, sbinfo->gid));
> +
> +	/*
> +	 * Showing inode{64,32} might be useful even if it's the system default,
> +	 * since then people don't have to resort to checking both here and
> +	 * /proc/config.gz to confirm 64-bit inums were successfully applied
> +	 * (which may not even exist if IKCONFIG_PROC isn't enabled).
> +	 *
> +	 * We hide it when inode64 isn't the default and we are using 32-bit
> +	 * inodes, since that probably just means the feature isn't even under
> +	 * consideration.
> +	 *
> +	 * As such:
> +	 *
> +	 *                     +-----------------+-----------------+
> +	 *                     | TMPFS_INODE64=y | TMPFS_INODE64=n |
> +	 *  +------------------+-----------------+-----------------+
> +	 *  | full_inums=true  | show            | show            |
> +	 *  | full_inums=false | show            | hide            |
> +	 *  +------------------+-----------------+-----------------+
> +	 *
> +	 */

Thanks for spelling this out: it may be the most contentious part
of the patch.  I don't disagree with your decision, but I can imagine
it causing annoyance.  Let's start off with it as you decided, but be
ready to be persuaded differently.  I have a growing inclination
towards the 64-bit kernel showing ",inode32" but never ",inode64".

> +	if (IS_ENABLED(CONFIG_TMPFS_INODE64) || sbinfo->full_inums)
> +		seq_printf(seq, ",inode%d", (sbinfo->full_inums ? 64 : 32));
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
>  	if (sbinfo->huge)
> @@ -3667,6 +3725,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  			ctx->blocks = shmem_default_max_blocks();
>  		if (!(ctx->seen & SHMEM_SEEN_INODES))
>  			ctx->inodes = shmem_default_max_inodes();
> +		if (!(ctx->seen & SHMEM_SEEN_INUMS))
> +			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
>  	} else {
>  		sb->s_flags |= SB_NOUSER;
>  	}
> @@ -3684,6 +3744,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	sbinfo->uid = ctx->uid;
>  	sbinfo->gid = ctx->gid;
> +	sbinfo->full_inums = ctx->full_inums;
>  	sbinfo->mode = ctx->mode;
>  	sbinfo->huge = ctx->huge;
>  	sbinfo->mpol = ctx->mpol;
> -- 
> 2.27.0
