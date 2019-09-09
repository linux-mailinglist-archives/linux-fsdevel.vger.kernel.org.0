Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27C3AD26E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 05:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbfIID5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 23:57:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50934 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbfIID5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:57:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i7AnN-0002nw-PW; Mon, 09 Sep 2019 03:56:53 +0000
Date:   Mon, 9 Sep 2019 04:56:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@01.org
Subject: Re: [vfs]  8bb3c61baf:  vm-scalability.median -23.7% regression
Message-ID: <20190909035653.GF1131@ZenIV.linux.org.uk>
References: <20190903084122.GH15734@shao2-debian>
 <20190908214601.GC1131@ZenIV.linux.org.uk>
 <20190908234722.GE1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1909081953360.1134@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1909081953360.1134@eggly.anvils>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:10:17PM -0700, Hugh Dickins wrote:

Hmm...  FWIW, I'd ended up redoing most of the thing, with
hopefully sane carve-up.  Differences:
	* we really care only about three things having
been set - ->max_blocks, ->max_inodes and ->huge.  This
__set_bit() hack is cute, but asking for trouble (and getting
it).  Explicit ctx->seen & SHMEM_SEEN_BLOCKS, etc. is
cleaner.
	*
>  const struct fs_parameter_description shmem_fs_parameters = {
> -	.name		= "shmem",
> +	.name		= "tmpfs",
>  	.specs		= shmem_param_specs,
>  	.enums		= shmem_param_enums,
>  };

	Missed that one, will fold.

	*
> @@ -3448,9 +3446,9 @@ static void shmem_apply_options(struct s

	The whole "apply" thing is useless - in remount we
need to copy max_inode/max_blocks/huge/mpol under the lock after
checks, and we can do that manually just fine.  Other options
(uid/gid/mode) get ignored.  There very little overlap
with fill_super case, really.

> -		old = sbinfo->mpol;
> -		sbinfo->mpol = ctx->mpol;
> +		/*
> +		 * Update sbinfo->mpol now while stat_lock is held.
> +		 * Leave shmem_free_fc() to free the old mpol if any.
> +		 */
> +		swap(sbinfo->mpol, ctx->mpol);

Umm...  Missed that use-after-free due to destructor, TBH (in
remount, that is).  Fixed (in a slightly different way).

>  		}
>  		if (*rest)
> -			return invalf(fc, "shmem: Invalid size");
> +			goto bad_value;
>  		ctx->max_blocks = DIV_ROUND_UP(size, PAGE_SIZE);
>  		break;

FWIW, I had those with s/shmem/tmpfs/, no problem with merging like
that.  Will fold.

[snip]
>  	case Opt_huge:
> -#ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
> -		if (!has_transparent_hugepage() &&
> -		    result.uint_32 != SHMEM_HUGE_NEVER)
> -			return invalf(fc, "shmem: Huge pages disabled");
> -
>  		ctx->huge = result.uint_32;
> +		if (ctx->huge != SHMEM_HUGE_NEVER &&
> +		    !(IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
> +		      has_transparent_hugepage()))
> +			goto unsupported_parameter;
>  		break;
> -#else
> -		return invalf(fc, "shmem: huge= option disabled");
> -#endif
> -
> -	case Opt_mpol: {
> -#ifdef CONFIG_NUMA
> -		struct mempolicy *mpol;
> -		if (mpol_parse_str(param->string, &mpol))
> -			return invalf(fc, "shmem: Invalid mpol=");
> -		mpol_put(ctx->mpol);
> -		ctx->mpol = mpol;
> -#endif
> -		break;
> -	}

OK...

> +	case Opt_mpol:
> +		if (IS_ENABLED(CONFIG_NUMA)) {
> +			struct mempolicy *mpol;
> +			if (mpol_parse_str(param->string, &mpol))
> +				goto bad_value;
> +			mpol_put(ctx->mpol);
> +			ctx->mpol = mpol;
> +			break;
> +		}
> +		goto unsupported_parameter;

Slightly different here - I'd done that bit as
                mpol_put(ctx->mpol);
                ctx->mpol = NULL;
                if (mpol_parse_str(param->string, &ctx->mpol))
                        return invalf (goto bad_value now)
		


> +unsupported_parameter:
> +	return invalf(fc, "tmpfs: Unsupported parameter '%s'", param->key);
> +bad_value:
> +	return invalf(fc, "tmpfs: Bad value for '%s'", param->key);


> -			return invalf(fc, "shmem: Can't retroactively limit nr_blocks");
> +			return invalf(fc, "tmpfs: Cannot retroactively limit size");
>  		}
>  		if (percpu_counter_compare(&sbinfo->used_blocks, ctx->max_blocks) > 0) {
>  			spin_unlock(&sbinfo->stat_lock);
> -			return invalf(fc, "shmem: Too few blocks for current use");
> +			return invalf(fc, "tmpfs: Too small a size for current use");
>  		}
>  	}
>  
> @@ -3587,11 +3591,11 @@ static int shmem_reconfigure(struct fs_c
>  	if (test_bit(Opt_nr_inodes, &ctx->changes)) {
>  		if (ctx->max_inodes && !sbinfo->max_inodes) {
>  			spin_unlock(&sbinfo->stat_lock);
> -			return invalf(fc, "shmem: Can't retroactively limit nr_inodes");
> +			return invalf(fc, "tmpfs: Cannot retroactively limit inodes");
>  		}
>  		if (ctx->max_inodes < inodes_in_use) {
>  			spin_unlock(&sbinfo->stat_lock);
> -			return invalf(fc, "shmem: Too few inodes for current use");
> +			return invalf(fc, "tmpfs: Too few inodes for current use");
>  		}
>  	}

s/Can't/Cannot/ and s/few blocks/small a size/?  No problem, except that I'd done
			err = "Too few inodes for current use";
			goto out;
...
out:
        return invalf(fc, "tmpfs: %s", err);


Anyway, see vfs.git#uncertain.shmem for what I've got with those folded in.
Do you see any problems with that one?  That's the last 5 commits in there...
