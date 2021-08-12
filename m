Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD873EA802
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhHLPwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238337AbhHLPwC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:52:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C483160E93;
        Thu, 12 Aug 2021 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628783497;
        bh=uXlwixVhz3r12PQwZ371Hh89I7lhiqCjmhBVz7o2Ak4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cic9I+DISQwO/7rbHdOuiwhmdY0BtVKNXk4NBm2OtzaBHSzR4+x5sKzH7VkDpBbEQ
         jObXE6oeSrJYmxR+Mn6HwvOD3dXHD7v2PFU+FQpw0w0FtlfZxm3O9qeEuYKSa5OeM+
         mKzLVDIs3Lxx5JU2Alodr8Eg86SsQoRNQdryiH5OJzwmQPqkxMNWE7SBa+g0+pQyBg
         BDpfvr/1lL1Rfccd+hk+7wBAoP06aokxoGmsIxfYoqs05btBmbrkbwGv41oidLMCuw
         YkPC1ZsxTxjZ0pTqO+1S2V3prENsgAi0OqPoIG2PU2oVYAvkegeZo2aLOYU2u3vzwP
         AJpTaH+M94ccg==
Received: by pali.im (Postfix)
        id 6086572F; Thu, 12 Aug 2021 17:51:34 +0200 (CEST)
Date:   Thu, 12 Aug 2021 17:51:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 03/20] udf: Fix iocharset=utf8 mount option
Message-ID: <20210812155134.g67ncugjvruos3cy@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-4-pali@kernel.org>
 <20210812141736.GE14675@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812141736.GE14675@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 12 August 2021 16:17:36 Jan Kara wrote:
> On Sun 08-08-21 18:24:36, Pali Rohár wrote:
> > Currently iocharset=utf8 mount option is broken. To use UTF-8 as iocharset,
> > it is required to use utf8 mount option.
> > 
> > Fix iocharset=utf8 mount option to use be equivalent to the utf8 mount
> > option.
> > 
> > If UTF-8 as iocharset is used then s_nls_map is set to NULL. So simplify
> > code around, remove UDF_FLAG_NLS_MAP and UDF_FLAG_UTF8 flags as to
> > distinguish between UTF-8 and non-UTF-8 it is needed just to check if
> > s_nls_map set to NULL or not.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Thanks for the cleanup. It looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Or should I take this patch through my tree?

Hello! Patches are just RFC, mostly untested and not ready for merging.
I will wait for feedback and then I do more testing nad prepare new
patch series.

> 
> 								Honza
> 
> 
> > ---
> >  fs/udf/super.c   | 50 ++++++++++++++++++------------------------------
> >  fs/udf/udf_sb.h  |  2 --
> >  fs/udf/unicode.c |  4 ++--
> >  3 files changed, 21 insertions(+), 35 deletions(-)
> > 
> > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > index 2f83c1204e20..6e8c29107b04 100644
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -349,10 +349,10 @@ static int udf_show_options(struct seq_file *seq, struct dentry *root)
> >  		seq_printf(seq, ",lastblock=%u", sbi->s_last_block);
> >  	if (sbi->s_anchor != 0)
> >  		seq_printf(seq, ",anchor=%u", sbi->s_anchor);
> > -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_UTF8))
> > -		seq_puts(seq, ",utf8");
> > -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP) && sbi->s_nls_map)
> > +	if (sbi->s_nls_map)
> >  		seq_printf(seq, ",iocharset=%s", sbi->s_nls_map->charset);
> > +	else
> > +		seq_puts(seq, ",iocharset=utf8");
> >  
> >  	return 0;
> >  }
> > @@ -558,19 +558,24 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
> >  			/* Ignored (never implemented properly) */
> >  			break;
> >  		case Opt_utf8:
> > -			uopt->flags |= (1 << UDF_FLAG_UTF8);
> > +			if (!remount) {
> > +				unload_nls(uopt->nls_map);
> > +				uopt->nls_map = NULL;
> > +			}
> >  			break;
> >  		case Opt_iocharset:
> >  			if (!remount) {
> > -				if (uopt->nls_map)
> > -					unload_nls(uopt->nls_map);
> > -				/*
> > -				 * load_nls() failure is handled later in
> > -				 * udf_fill_super() after all options are
> > -				 * parsed.
> > -				 */
> > +				unload_nls(uopt->nls_map);
> > +				uopt->nls_map = NULL;
> > +			}
> > +			/* When nls_map is not loaded then UTF-8 is used */
> > +			if (!remount && strcmp(args[0].from, "utf8") != 0) {
> >  				uopt->nls_map = load_nls(args[0].from);
> > -				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
> > +				if (!uopt->nls_map) {
> > +					pr_err("iocharset %s not found\n",
> > +						args[0].from);
> > +					return 0;
> > +				}
> >  			}
> >  			break;
> >  		case Opt_uforget:
> > @@ -2139,21 +2144,6 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
> >  	if (!udf_parse_options((char *)options, &uopt, false))
> >  		goto parse_options_failure;
> >  
> > -	if (uopt.flags & (1 << UDF_FLAG_UTF8) &&
> > -	    uopt.flags & (1 << UDF_FLAG_NLS_MAP)) {
> > -		udf_err(sb, "utf8 cannot be combined with iocharset\n");
> > -		goto parse_options_failure;
> > -	}
> > -	if ((uopt.flags & (1 << UDF_FLAG_NLS_MAP)) && !uopt.nls_map) {
> > -		uopt.nls_map = load_nls_default();
> > -		if (!uopt.nls_map)
> > -			uopt.flags &= ~(1 << UDF_FLAG_NLS_MAP);
> > -		else
> > -			udf_debug("Using default NLS map\n");
> > -	}
> > -	if (!(uopt.flags & (1 << UDF_FLAG_NLS_MAP)))
> > -		uopt.flags |= (1 << UDF_FLAG_UTF8);
> > -
> >  	fileset.logicalBlockNum = 0xFFFFFFFF;
> >  	fileset.partitionReferenceNum = 0xFFFF;
> >  
> > @@ -2308,8 +2298,7 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
> >  error_out:
> >  	iput(sbi->s_vat_inode);
> >  parse_options_failure:
> > -	if (uopt.nls_map)
> > -		unload_nls(uopt.nls_map);
> > +	unload_nls(uopt.nls_map);
> >  	if (lvid_open)
> >  		udf_close_lvid(sb);
> >  	brelse(sbi->s_lvid_bh);
> > @@ -2359,8 +2348,7 @@ static void udf_put_super(struct super_block *sb)
> >  	sbi = UDF_SB(sb);
> >  
> >  	iput(sbi->s_vat_inode);
> > -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
> > -		unload_nls(sbi->s_nls_map);
> > +	unload_nls(sbi->s_nls_map);
> >  	if (!sb_rdonly(sb))
> >  		udf_close_lvid(sb);
> >  	brelse(sbi->s_lvid_bh);
> > diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> > index 758efe557a19..4fa620543d30 100644
> > --- a/fs/udf/udf_sb.h
> > +++ b/fs/udf/udf_sb.h
> > @@ -20,8 +20,6 @@
> >  #define UDF_FLAG_UNDELETE		6
> >  #define UDF_FLAG_UNHIDE			7
> >  #define UDF_FLAG_VARCONV		8
> > -#define UDF_FLAG_NLS_MAP		9
> > -#define UDF_FLAG_UTF8			10
> >  #define UDF_FLAG_UID_FORGET     11    /* save -1 for uid to disk */
> >  #define UDF_FLAG_GID_FORGET     12
> >  #define UDF_FLAG_UID_SET	13
> > diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
> > index 5fcfa96463eb..622569007b53 100644
> > --- a/fs/udf/unicode.c
> > +++ b/fs/udf/unicode.c
> > @@ -177,7 +177,7 @@ static int udf_name_from_CS0(struct super_block *sb,
> >  		return 0;
> >  	}
> >  
> > -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
> > +	if (UDF_SB(sb)->s_nls_map)
> >  		conv_f = UDF_SB(sb)->s_nls_map->uni2char;
> >  	else
> >  		conv_f = NULL;
> > @@ -285,7 +285,7 @@ static int udf_name_to_CS0(struct super_block *sb,
> >  	if (ocu_max_len <= 0)
> >  		return 0;
> >  
> > -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
> > +	if (UDF_SB(sb)->s_nls_map)
> >  		conv_f = UDF_SB(sb)->s_nls_map->char2uni;
> >  	else
> >  		conv_f = NULL;
> > -- 
> > 2.20.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
