Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D954D62A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbiCKN4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 08:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiCKN4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:56:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9501C4B1B;
        Fri, 11 Mar 2022 05:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EE6FB82C08;
        Fri, 11 Mar 2022 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EAFC340E9;
        Fri, 11 Mar 2022 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006901;
        bh=OBsbrwAjRxifwn84roMcXQuqX/kpZdztcjpFo/JKQko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QbFLEHJ9gNUiww7Aa2daPJT8G3gJjnCZZn+DTKJZtqNdpc4ugsphe6nOXX+6UKaRS
         h66FdJ667Cy/wbe5Y2U599bOkoPkgvXruaWbwbzmgfyHn4aIFNojJHEDVXxK6O7XMG
         488ynVbT08O5uuswo2XlyJVKqwRQjb79aN/8r54ax3vYquyh+Wwj9Z6OrnUoSaXfu2
         RIG/PEIuCootjEC/Vop1yPyUUnw6FJnimm2bv16vzWcssG/wmgFknygna88SBp+kB7
         szWj5K3pR9Ah1SBNwxCQjisCD6tJTfIpVZC2Dpx4FeKLJQnfnvSeDQFZttNGkcrDoy
         Uk1sRD7k66Clw==
Message-ID: <1e96f2c36f7c49a7d2d57dc1eb4135bd27a06122.camel@kernel.org>
Subject: Re: [PATCH v3 12/20] ceph: Make ceph_init_request() check caps on
 readahead
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Mar 2022 08:54:59 -0500
In-Reply-To: <2533821.1647006574@warthog.procyon.org.uk>
References: <dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com>
         <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
         <164692907694.2099075.10081819855690054094.stgit@warthog.procyon.org.uk>
         <2533821.1647006574@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-03-11 at 13:49 +0000, David Howells wrote:
> Jeff Layton <jlayton@redhat.com> wrote:
> 
> > > +static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
> > > +{
> > > +	struct inode *inode = rreq->inode;
> > > +	int got = 0, want = CEPH_CAP_FILE_CACHE;
> > > +	int ret = 0;
> > > +
> > > +	if (file) {
> > > +		struct ceph_rw_context *rw_ctx;
> > > +		struct ceph_file_info *fi = file->private_data;
> > > +
> > > +		rw_ctx = ceph_find_rw_context(fi);
> > > +		if (rw_ctx)
> > > +			return 0;
> > > +	}
> > > +
> > > +	if (rreq->origin != NETFS_READAHEAD)
> > > +		return 0;
> > > +
> > 
> > ^^^
> > I think you should move this check above the if (file) block above it.
> > We don't need to anything at all if we're not in readahead.
> 
> How about the attached, then?
> 
> David
> ---
> commit 7082946186fc26016b15bc9039bd6d92ae732ef3
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Mar 9 21:45:22 2022 +0000
> 
>     ceph: Make ceph_init_request() check caps on readahead
>     
>     Move the caps check from ceph_readahead() to ceph_init_request(),
>     conditional on the origin being NETFS_READAHEAD so that in a future patch,
>     ceph can point its ->readahead() vector directly at netfs_readahead().
>     
>     Changes
>     =======
>     ver #4)
>      - Move the check for NETFS_READAHEAD up in ceph_init_request()[2].
>     
>     ver #3)
>      - Split from the patch to add a netfs inode context[1].
>      - Need to store the caps got in rreq->netfs_priv for later freeing.
>     
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: ceph-devel@vger.kernel.org
>     cc: linux-cachefs@redhat.com
>     Link: https://lore.kernel.org/r/8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org/ [1]
>     Link: https://lore.kernel.org/r/dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com/ [2]
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 9189257476f8..4aeccafa5dda 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -354,6 +354,45 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	dout("%s: result %d\n", __func__, err);
>  }
>  
> +static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
> +{
> +	struct inode *inode = rreq->inode;
> +	int got = 0, want = CEPH_CAP_FILE_CACHE;
> +	int ret = 0;
> +
> +	if (rreq->origin != NETFS_READAHEAD)
> +		return 0;
> +
> +	if (file) {
> +		struct ceph_rw_context *rw_ctx;
> +		struct ceph_file_info *fi = file->private_data;
> +
> +		rw_ctx = ceph_find_rw_context(fi);
> +		if (rw_ctx)
> +			return 0;
> +	}
> +
> +	/*
> +	 * readahead callers do not necessarily hold Fcb caps
> +	 * (e.g. fadvise, madvise).
> +	 */
> +	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
> +	if (ret < 0) {
> +		dout("start_read %p, error getting cap\n", inode);
> +		return ret;
> +	}
> +
> +	if (!(got & want)) {
> +		dout("start_read %p, no cache cap\n", inode);
> +		return -EACCES;
> +	}
> +	if (ret == 0)
> +		return -EACCES;
> +
> +	rreq->netfs_priv = (void *)(uintptr_t)got;
> +	return 0;
> +}
> +
>  static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  {
>  	struct inode *inode = mapping->host;
> @@ -365,7 +404,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  }
>  
>  static const struct netfs_request_ops ceph_netfs_read_ops = {
> -	.is_cache_enabled	= ceph_is_cache_enabled,
> +	.init_request		= ceph_init_request,
>  	.begin_cache_operation	= ceph_begin_cache_operation,
>  	.issue_read		= ceph_netfs_issue_read,
>  	.expand_readahead	= ceph_netfs_expand_readahead,
> @@ -393,33 +432,7 @@ static int ceph_readpage(struct file *file, struct page *subpage)
>  
>  static void ceph_readahead(struct readahead_control *ractl)
>  {
> -	struct inode *inode = file_inode(ractl->file);
> -	struct ceph_file_info *fi = ractl->file->private_data;
> -	struct ceph_rw_context *rw_ctx;
> -	int got = 0;
> -	int ret = 0;
> -
> -	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
> -		return;
> -
> -	rw_ctx = ceph_find_rw_context(fi);
> -	if (!rw_ctx) {
> -		/*
> -		 * readahead callers do not necessarily hold Fcb caps
> -		 * (e.g. fadvise, madvise).
> -		 */
> -		int want = CEPH_CAP_FILE_CACHE;
> -
> -		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
> -		if (ret < 0)
> -			dout("start_read %p, error getting cap\n", inode);
> -		else if (!(got & want))
> -			dout("start_read %p, no cache cap\n", inode);
> -
> -		if (ret <= 0)
> -			return;
> -	}
> -	netfs_readahead(ractl, &ceph_netfs_read_ops, (void *)(uintptr_t)got);
> +	netfs_readahead(ractl, &ceph_netfs_read_ops, NULL);
>  }
>  
>  #ifdef CONFIG_CEPH_FSCACHE
> 

LGTM,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
