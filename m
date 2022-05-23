Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C05531726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiEWUMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiEWULt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 16:11:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C72FE75;
        Mon, 23 May 2022 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbEcr7zqhWPFnXoF/KuL5Wkx22JBJ3c2clwbQUl5zn8=; b=YcCYg3bARqXOKkr9KCnYiIVA/O
        4kCGq1j7NQnK1rCwBYjYcBp79yCaa+veSl2Dx1quLuGeDujO4BSEVcsIJGp+a5QSK2RSosFhG3hjW
        xMKesUVI3DHJzHAD6RzkDdbXBW7hElXVml8xn3gObBiogi3m/SAMCruazsCZFCQi0CtlYy+m25fRB
        GdrhCmxTa54gy4NdhbEa5uiYAFKqPXLSZDUoPwg3i3ujBkmThEqmmRcFfV5FH8FYiLnW1rC06isEs
        gxhmy88B4LOk1iYVg8NmSU4PzSUEtrzQx8JtrCSV1UcEQ9kp/mviuzgA9wrsqNlGmevPCjJQzStwY
        X8M8EN4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntEOy-00GVbU-0B; Mon, 23 May 2022 20:11:40 +0000
Date:   Mon, 23 May 2022 21:11:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        vshankar@redhat.com, ceph-devel@vger.kernel.org, arnd@arndb.de,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/dcache: add d_compare() helper support
Message-ID: <YovqeybXUKEmhvsi@casper.infradead.org>
References: <20220519101847.87907-1-xiubli@redhat.com>
 <20220519101847.87907-2-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519101847.87907-2-xiubli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 06:18:45PM +0800, Xiubo Li wrote:
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

... empty commit message?

> ---
>  fs/dcache.c            | 15 +++++++++++++++
>  include/linux/dcache.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 93f4f5ee07bf..95a72f92a94b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dentry *dentry,
>  				       name) == 0;
>  }
>  
> +/**
> + * d_compare - compare dentry name with case-exact name
> + * @parent: parent dentry
> + * @dentry: the negative dentry that was passed to the parent's lookup func
> + * @name:   the case-exact name to be associated with the returned dentry
> + *
> + * Return: 0 if names are same, or 1
> + */
> +bool d_compare(const struct dentry *parent, const struct dentry *dentry,
> +	       const struct qstr *name)
> +{
> +	return !d_same_name(dentry, parent, name);
> +}
> +EXPORT_SYMBOL(d_compare);
> +
>  /**
>   * __d_lookup_rcu - search for a dentry (racy, store-free)
>   * @parent: parent dentry
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba51480b2..444b2230e5c3 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -233,6 +233,8 @@ extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
>  					wait_queue_head_t *);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
> +extern bool d_compare(const struct dentry *parent, const struct dentry *dentry,
> +		      const struct qstr *name);
>  extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
>  extern struct dentry *d_find_any_alias(struct inode *inode);
>  extern struct dentry * d_obtain_alias(struct inode *);
> -- 
> 2.36.0.rc1
> 
