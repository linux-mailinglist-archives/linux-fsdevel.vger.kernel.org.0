Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983A8355E77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhDFWHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhDFWHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:07:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C928C06174A;
        Tue,  6 Apr 2021 15:06:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u8so12325907qtq.12;
        Tue, 06 Apr 2021 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JcELlbuxWwPI8dfTFSYAOzu9FA0v9IiB9zKDgpWQPYA=;
        b=gaReUITBmTMOI4qcZIgcKs652nOhD6+Hv2CfiWWBBTmMDncXO03q4NS3QsXcszIgV+
         5SjtB+VXk+8/6dczGDc56/Isgh7qkvdTKQyFPvCsyIK/l6UVz/1BmYPytyl9gWI2+hTW
         v01BFJelID55zXOVvVUg9nVh9wYdtKE8OXSJ/p/16YibcOwwXXsnd3jurowgJhF0j4ih
         9gszRi1cV6BOJ6NPO9dDZHoIb0P1QomVGRW+mu57sIrJ75t6zRAkdbQRjYWQTua9ODzu
         eaO6a6M3iZ5qN7l/LDRwPGPP95/0Xk1YPu1OspJ/D1/o5tM0u7Hi12UegCMWzllRpW8o
         yReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcELlbuxWwPI8dfTFSYAOzu9FA0v9IiB9zKDgpWQPYA=;
        b=JfQUoLYSJmel8xVX8d+bjBJWPN2kE56F+AzlTlbjF3iPBRoUGu1JeuYflK9Lxh+a+T
         Dka2+ib6IQsJ3oLSPDF0AsRT6xS+fyi5vMfwAC/waVDTEmiCBWqpz6jHYIaK/LUWF/Nc
         eGRSNZIHBDFFA2hDEJfco3zTauFm3Z2rUpivLwLncrqppk1mPVZXHD0w4Njj5B8vwBpM
         c58UhZnoBgwo1kmRdPy7MCqHEIDwcPWAzWTL/Eskq6pS1+Be6OaNcu7OMKk07Q88hQO3
         /eCBhivelg1XqXtlzaxgjp375nldowi0xp/axX9/hy8j3EgsY9pxF9CtV7NB6VMhUyS3
         CX6w==
X-Gm-Message-State: AOAM531mb/4inPVqkryCQJNsr/ej5FMt6pwXu2zP4Lc7AqZS8vgg7zYe
        iXI25jpbb167PogMMzv70+vp8Wx0QvwY
X-Google-Smtp-Source: ABdhPJzqr0fo6WFGk41c/cnYR19cQzLjOtwQzqpIzdWivWA9eyJI2/NeyBC5BglWrt1cP79MVisZwQ==
X-Received: by 2002:a05:622a:d3:: with SMTP id p19mr129254qtw.53.1617746811782;
        Tue, 06 Apr 2021 15:06:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n24sm15388135qtr.21.2021.04.06.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:06:51 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:06:49 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] vfs: factor out inode hash head calculation
Message-ID: <YGzbeWxf1r+AivSJ@moria.home.lan>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123343.1739669-2-david@fromorbit.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:33:41PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> In preparation for changing the inode hash table implementation.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

> ---
>  fs/inode.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a047ab306f9a..b8d9eb3454dc 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -60,6 +60,22 @@ static unsigned int i_hash_shift __read_mostly;
>  static struct hlist_head *inode_hashtable __read_mostly;
>  static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
>  
> +static unsigned long hash(struct super_block *sb, unsigned long hashval)
> +{
> +	unsigned long tmp;
> +
> +	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
> +			L1_CACHE_BYTES;
> +	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> i_hash_shift);
> +	return tmp & i_hash_mask;
> +}
> +
> +static inline struct hlist_head *i_hash_head(struct super_block *sb,
> +		unsigned int hashval)
> +{
> +	return inode_hashtable + hash(sb, hashval);
> +}
> +
>  /*
>   * Empty aops. Can be used for the cases where the user does not
>   * define any of the address_space operations.
> @@ -475,16 +491,6 @@ static inline void inode_sb_list_del(struct inode *inode)
>  	}
>  }
>  
> -static unsigned long hash(struct super_block *sb, unsigned long hashval)
> -{
> -	unsigned long tmp;
> -
> -	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
> -			L1_CACHE_BYTES;
> -	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> i_hash_shift);
> -	return tmp & i_hash_mask;
> -}
> -
>  /**
>   *	__insert_inode_hash - hash an inode
>   *	@inode: unhashed inode
> @@ -1073,7 +1079,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  			    int (*test)(struct inode *, void *),
>  			    int (*set)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
> +	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
>  	struct inode *old;
>  	bool creating = inode->i_state & I_CREATING;
>  
> @@ -1173,7 +1179,7 @@ EXPORT_SYMBOL(iget5_locked);
>   */
>  struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	struct hlist_head *head = i_hash_head(sb, ino);
>  	struct inode *inode;
>  again:
>  	spin_lock(&inode_hash_lock);
> @@ -1241,7 +1247,7 @@ EXPORT_SYMBOL(iget_locked);
>   */
>  static int test_inode_iunique(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *b = inode_hashtable + hash(sb, ino);
> +	struct hlist_head *b = i_hash_head(sb, ino);
>  	struct inode *inode;
>  
>  	hlist_for_each_entry_rcu(inode, b, i_hash) {
> @@ -1328,7 +1334,7 @@ EXPORT_SYMBOL(igrab);
>  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct hlist_head *head = i_hash_head(sb, hashval);
>  	struct inode *inode;
>  
>  	spin_lock(&inode_hash_lock);
> @@ -1383,7 +1389,7 @@ EXPORT_SYMBOL(ilookup5);
>   */
>  struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	struct hlist_head *head = i_hash_head(sb, ino);
>  	struct inode *inode;
>  again:
>  	spin_lock(&inode_hash_lock);
> @@ -1432,7 +1438,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
>  					     void *),
>  				void *data)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct hlist_head *head = i_hash_head(sb, hashval);
>  	struct inode *inode, *ret_inode = NULL;
>  	int mval;
>  
> @@ -1477,7 +1483,7 @@ EXPORT_SYMBOL(find_inode_nowait);
>  struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
>  			     int (*test)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
> +	struct hlist_head *head = i_hash_head(sb, hashval);
>  	struct inode *inode;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> @@ -1515,7 +1521,7 @@ EXPORT_SYMBOL(find_inode_rcu);
>  struct inode *find_inode_by_ino_rcu(struct super_block *sb,
>  				    unsigned long ino)
>  {
> -	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	struct hlist_head *head = i_hash_head(sb, ino);
>  	struct inode *inode;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> @@ -1535,7 +1541,7 @@ int insert_inode_locked(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	ino_t ino = inode->i_ino;
> -	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	struct hlist_head *head = i_hash_head(sb, ino);
>  
>  	while (1) {
>  		struct inode *old = NULL;
> -- 
> 2.31.0
> 
