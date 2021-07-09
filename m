Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908003C1D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 04:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGICbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 22:31:15 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36003 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhGICbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:31:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uf9kTmr_1625797708;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uf9kTmr_1625797708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Jul 2021 10:28:30 +0800
Date:   Fri, 9 Jul 2021 10:28:27 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseqh Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [RFC PATCH v1.1 2/2] erofs: dax support for non-tailpacking
 regular file
Message-ID: <YOe0S+NKUrBi5YZC@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseqh Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210704135056.42723-3-hsiangkao@linux.alibaba.com>
 <20210705132153.223839-1-hsiangkao@linux.alibaba.com>
 <20210709014719.GD11634@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210709014719.GD11634@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On Thu, Jul 08, 2021 at 06:47:19PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 05, 2021 at 09:21:53PM +0800, Gao Xiang wrote:

...

> >  	Opt_cache_strategy,
> > +	Opt_dax,
> >  	Opt_err
> >  };
> >  
> > @@ -370,6 +372,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> >  	fsparam_flag_no("acl",		Opt_acl),
> >  	fsparam_enum("cache_strategy",	Opt_cache_strategy,
> >  		     erofs_param_cache_strategy),
> > +	fsparam_flag("dax",             Opt_dax),
> >  	{}
> >  };
> >  
> > @@ -410,6 +413,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >  		ctx->cache_strategy = result.uint_32;
> >  #else
> >  		errorfc(fc, "compression not supported, cache_strategy ignored");
> > +#endif
> > +		break;
> > +	case Opt_dax:
> > +#ifdef CONFIG_FS_DAX
> > +		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > +		set_opt(ctx, DAX);
> 
> You might want to allow 'dax=always' and 'dax=never' to maintain parity
> with xfs/ext4's mount options...

Yeah, thanks for your suggestion. Will revise in the next version..

(Also, more use case details and development status about this scenario
 will be shown in the following months...)

Thanks,
Gao Xiang


> 
> --D
> 
> > +#else
> > +		errorfc(fc, "dax options not supported");
> >  #endif
> >  		break;
> >  	default:
> > @@ -496,10 +507,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> >  		return -ENOMEM;
> >  
> >  	sb->s_fs_info = sbi;
> > +	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> >  	err = erofs_read_superblock(sb);
> >  	if (err)
> >  		return err;
> >  
> > +	if (test_opt(ctx, DAX) &&
> > +	    !bdev_dax_supported(sb->s_bdev, EROFS_BLKSIZ)) {
> > +		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
> > +		clear_opt(ctx, DAX);
> > +	}
> > +
> >  	sb->s_flags |= SB_RDONLY | SB_NOATIME;
> >  	sb->s_maxbytes = MAX_LFS_FILESIZE;
> >  	sb->s_time_gran = 1;
> > @@ -609,6 +627,8 @@ static void erofs_kill_sb(struct super_block *sb)
> >  	sbi = EROFS_SB(sb);
> >  	if (!sbi)
> >  		return;
> > +	if (sbi->dax_dev)
> > +		fs_put_dax(sbi->dax_dev);
> >  	kfree(sbi);
> >  	sb->s_fs_info = NULL;
> >  }
> > @@ -711,8 +731,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  
> >  static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >  {
> > -	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
> > -	struct erofs_fs_context *ctx __maybe_unused = &sbi->ctx;
> > +	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
> > +	struct erofs_fs_context *ctx = &sbi->ctx;
> >  
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	if (test_opt(ctx, XATTR_USER))
> > @@ -734,6 +754,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >  	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
> >  		seq_puts(seq, ",cache_strategy=readaround");
> >  #endif
> > +	if (test_opt(ctx, DAX))
> > +		seq_puts(seq, ",dax");
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.24.4
> > 
