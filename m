Return-Path: <linux-fsdevel+bounces-54327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E1AFDEA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 05:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3963AE887
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 03:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817D23B63D;
	Wed,  9 Jul 2025 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+F+jf7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29661E47BA;
	Wed,  9 Jul 2025 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033553; cv=none; b=kFi7TIjA8Iwp76o+owiNIxuOxCv0h9OLJI0rXRZIK1vY0xcwD79j5pnHQxxyJe2XQ9AjD+qoZwlN0SIvDrjkBY2HHi7qu4EYYZXWMlgd7qMajsvsW+lGrMZWZXFqBdTIpNsl/UJ+heMPIsMuS3DbXUSQ8fIy48dMiS1PiEkD+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033553; c=relaxed/simple;
	bh=QytHeqnrZC2ddp9eJpzCiJaHZYXcVEL3Y7kDVMmL3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNynulNp1nVqZ7n6WgRN09PuQ0gAgvUc0faVYlAOdJ3XUu9DriFDIofuEIkRVDoBecM9PApTn3bvxmHyrGzMs7x9rbiV+l8hrZl1zwO5L5nYRsurFnUekMIgWeTUax9N2KkmHjXOjln3M9md5GlRJCqVheZMgD3cFAeGB5JUyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+F+jf7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF41C4CEF0;
	Wed,  9 Jul 2025 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752033552;
	bh=QytHeqnrZC2ddp9eJpzCiJaHZYXcVEL3Y7kDVMmL3JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+F+jf7eTJoZeBlRdUxYZgi+fL8+T8t834jF3yNHRTd+OhJ9Yhg1I7wAX/yFH/YAZ
	 uGEqYwpAHDcuvT+QqSM7ZjOLnKbKQv1VPVw/lENIbTX+RcNEmUeUpQtR/QqLpWIBkO
	 TCXgKk7DaR2RRSE0oL7eS1SwgASxr1S1j08W1YF80X/zYAUFmgn3UgXqZGeIX5q1YL
	 jYrTN3fmIhWhOQpxCRHTZnUNNz6Xx1i1GF7WgnqLk4XJF43bWhzKXS3hwm41CkT85S
	 xHCbc8zmhN76MMR7xG6O2puO8kSf+UDTdAFeeU8qtxqcyXxa1unEsk/ZLQSE2+vRGI
	 59myGqc7C424Q==
Date: Tue, 8 Jul 2025 20:59:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Message-ID: <20250709035911.GE2672029@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-12-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185032.46568-12-john@groves.net>

On Thu, Jul 03, 2025 at 01:50:25PM -0500, John Groves wrote:
> * -o shadow=<shadowpath>

What is a shadow?

> * -o daxdev=<daxdev>

And, uh, if there's a FUSE_GET_DAXDEV command, then what does this mount
option do?  Pre-populate the first element of that set?

--D

> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h |  8 +++++++-
>  fs/fuse/inode.c  | 28 +++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index a592c1002861..f4ee61046578 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -583,9 +583,11 @@ struct fuse_fs_context {
>  	unsigned int blksize;
>  	const char *subtype;
>  
> -	/* DAX device, may be NULL */
> +	/* DAX device for virtiofs, may be NULL */
>  	struct dax_device *dax_dev;
>  
> +	const char *shadow; /* famfs - null if not famfs */
> +
>  	/* fuse_dev pointer to fill in, should contain NULL on entry */
>  	void **fudptr;
>  };
> @@ -941,6 +943,10 @@ struct fuse_conn {
>  	/**  uring connection information*/
>  	struct fuse_ring *ring;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	char *shadow;
> +#endif
>  };
>  
>  /*
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e48e11c3f9f3..a7e1cf8257b0 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -766,6 +766,9 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	OPT_SHADOW,
> +#endif
>  	OPT_ERR
>  };
>  
> @@ -780,6 +783,9 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	fsparam_string("shadow",		OPT_SHADOW),
> +#endif
>  	{}
>  };
>  
> @@ -875,6 +881,15 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		ctx->blksize = result.uint_32;
>  		break;
>  
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	case OPT_SHADOW:
> +		if (ctx->shadow)
> +			return invalfc(fsc, "Multiple shadows specified");
> +		ctx->shadow = param->string;
> +		param->string = NULL;
> +		break;
> +#endif
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -888,6 +903,7 @@ static void fuse_free_fsc(struct fs_context *fsc)
>  
>  	if (ctx) {
>  		kfree(ctx->subtype);
> +		kfree(ctx->shadow);
>  		kfree(ctx);
>  	}
>  }
> @@ -919,7 +935,10 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  	else if (fc->dax_mode == FUSE_DAX_INODE_USER)
>  		seq_puts(m, ",dax=inode");
>  #endif
> -
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	if (fc->shadow)
> +		seq_printf(m, ",shadow=%s", fc->shadow);
> +#endif
>  	return 0;
>  }
>  
> @@ -1017,6 +1036,9 @@ void fuse_conn_put(struct fuse_conn *fc)
>  		}
>  		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>  			fuse_backing_files_free(fc);
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +		kfree(fc->shadow);
> +#endif
>  		call_rcu(&fc->rcu, delayed_release);
>  	}
>  }
> @@ -1834,6 +1856,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	sb->s_root = root_dentry;
>  	if (ctx->fudptr)
>  		*ctx->fudptr = fud;
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	fc->shadow = kstrdup(ctx->shadow, GFP_KERNEL);
> +#endif
>  	mutex_unlock(&fuse_mutex);
>  	return 0;
>  
> -- 
> 2.49.0
> 
> 

