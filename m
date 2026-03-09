Return-Path: <linux-fsdevel+bounces-79773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GE4IDrGrmn2IgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:08:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B5F2396A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC354306145C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131C3A962B;
	Mon,  9 Mar 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wUbFTL8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC531B4F09;
	Mon,  9 Mar 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061423; cv=none; b=FEi36olAsWjzlZ6vPJiFQJCmNlPziKfLvmPEKu/uqWy+x0OCgBhdqGQQmjibmmLcF6BJnp9U3b2J6NzZsdttro4azLVRpB99UgNm//1haN+A2qDtCu4x+0G4kY8J0H5WJNFirsHtP8dp3JsXflBbCv66ok8tjNaGyo/AX2RU5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061423; c=relaxed/simple;
	bh=lGT5ww1NhXs2hSez1bAO9HTrJA20ocH020oS2znqhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDtzms1gi3+IE+pJt/wnVBwERU53IEXOlZpY9f0QcfkaqsMIjgnOT8oSzQF0MWpc8lNGZgckV7z3vFO2IPv7aJuOkRpMIOyN1eTVa0KSkfgv5GA4d86OrjxsagFM6ZdzVrUaeTQyxkXjAR3uDgF7jyYFHMmhSXIBGFlswv8XmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wUbFTL8q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=31L+FqXjA9EQYwvqJDRlkc1ufhApxWyjZUFXmPO4kyo=; b=wUbFTL8qq30tSQVJq3ehcYQJoe
	uOZaGIefAhIY4RzRkPNn5HRPSP3a3alribkOgWKM+6MXdt7p2OfIx6M50Qc2mYfK3vcDJVlgoIzEP
	Wu8li/RWq6cFOJUt5fjGOQM+3xLQ36GtSBG7mRaC8sjN1i1VctXLOtZK2RVsvTpuAG2/Oexwdo7Dn
	sR1T7RYrKUvPdnUwpivZwJ9i03LE8qMaU3DdsdektN9ZUd0MzlrN5a9jJaHGjQ3YS9aMCTV94LCDr
	7c+kC0Cdql1pQvpQEEB8H18cUk+nVJItpT/BveaT4IjvEV4JSriGKXwOELHVd98sj6sqKSrjah82P
	xT74puWw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzaGk-00000005YcO-06Ql;
	Mon, 09 Mar 2026 13:03:34 +0000
Date: Mon, 9 Mar 2026 13:03:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Hongbo Li <lihongbo22@huawei.com>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
Message-ID: <aa7FJfgwkdXlifJX@casper.infradead.org>
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
X-Rspamd-Queue-Id: D8B5F2396A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,huawei.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79773-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,casper.infradead.org:mid,googlesource.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:03:43AM +0800, Gao Xiang wrote:
> Hi Chao,
> 
> (+cc -fsdevel, willy, Jan kara)
> 
> On 2026/3/9 10:30, Chao Yu wrote:
> > This patch introduces a new mount option 'nolargefolio' for EROFS.
> > When this option is specified, large folio will be disabled by
> > default for all inodes, this option can be used for environments
> > where large folio resources are limited, it's necessary to only
> > let specified user to allocate large folios on demand.
> 
> For this kind of options, I think more real backgrounds
> about avoiding high-order allocations are needed in the
> commit message (at least for later reference) also like
> what I observed in:
> https://android-review.googlesource.com/c/kernel/common/+/3877981
> 
> because the entire community tends to enable large folios
> unconditionally if possible.  Without enough clarification,
> even I merge this, there will be endless questions again
> and again about this.

This was a decision made early on.  If the heuristics are wrong, they
need to be fixed.  It's very disappointing to see people try to sneak
these changes into individual filesystems.  Thanks for catching it and
preventing it from sneaking in.  Chao is not a new contributor; he
should know better than this by now.

> And Jan once raised up if it should be a user interface
> or auto-tuning one:
> https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5
> 
> My question is that if the needs are real, I wonder if
> it should be a vfs generic decision instead (because
> it's not due to the filesystem restriction but due to
> real system memory pressure or heavy workload for
> example).  However, if the answer is that others don't
> really care about this, I'm fine to leave it as an
> erofs-specific option as long as the actual case is
> clear in the commit message.
> 
> Thanks,
> Gao Xiang
> 
> 
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   Documentation/filesystems/erofs.rst | 1 +
> >   fs/erofs/inode.c                    | 3 ++-
> >   fs/erofs/internal.h                 | 1 +
> >   fs/erofs/super.c                    | 8 +++++++-
> >   4 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > index fe06308e546c..d692a1d9f32c 100644
> > --- a/Documentation/filesystems/erofs.rst
> > +++ b/Documentation/filesystems/erofs.rst
> > @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
> >   inode_share            Enable inode page sharing for this filesystem.  Inodes with
> >                          identical content within the same domain ID can share the
> >                          page cache.
> > +nolargefolio           Disable large folio support for all files.
> >   ===================    =========================================================
> >   Sysfs Entries
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index 4b3d21402e10..26361e86a354 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
> >   		return 0;
> >   	}
> > -	mapping_set_large_folios(inode->i_mapping);
> > +	if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
> > +		mapping_set_large_folios(inode->i_mapping);
> >   	aops = erofs_get_aops(inode, false);
> >   	if (IS_ERR(aops))
> >   		return PTR_ERR(aops);
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index a4f0a42cf8c3..b5d98410c699 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -177,6 +177,7 @@ struct erofs_sb_info {
> >   #define EROFS_MOUNT_DAX_NEVER		0x00000080
> >   #define EROFS_MOUNT_DIRECT_IO		0x00000100
> >   #define EROFS_MOUNT_INODE_SHARE		0x00000200
> > +#define EROFS_MOUNT_NO_LARGE_FOLIO	0x00000400
> >   #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
> >   #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 972a0c82198d..a353369d4db8 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
> >   enum {
> >   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> >   	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> > -	Opt_inode_share,
> > +	Opt_inode_share, Opt_nolargefolio,
> >   };
> >   static const struct constant_table erofs_param_cache_strategy[] = {
> > @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> >   	fsparam_flag_no("directio",	Opt_directio),
> >   	fsparam_u64("fsoffset",		Opt_fsoffset),
> >   	fsparam_flag("inode_share",	Opt_inode_share),
> > +	fsparam_flag("nolargefolio",	Opt_nolargefolio),
> >   	{}
> >   };
> > @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >   		else
> >   			set_opt(&sbi->opt, INODE_SHARE);
> >   		break;
> > +	case Opt_nolargefolio:
> > +		set_opt(&sbi->opt, NO_LARGE_FOLIO);
> > +		break;
> >   	}
> >   	return 0;
> >   }
> > @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
> >   	if (test_opt(opt, INODE_SHARE))
> >   		seq_puts(seq, ",inode_share");
> > +	if (test_opt(opt, NO_LARGE_FOLIO))
> > +		seq_puts(seq, ",nolargefolio");
> >   	return 0;
> >   }
> 

