Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF8479571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhLQU1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 15:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhLQU1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:27:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759DC061574;
        Fri, 17 Dec 2021 12:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114D0B8276D;
        Fri, 17 Dec 2021 20:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A76C36AE2;
        Fri, 17 Dec 2021 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639772871;
        bh=hlsF7cdtuWbthcDpSEdmMJMAm2CO1nuQzGJM4/xks8o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FJLyo6zFdqHpAuqDbzft4mCyDOrY1Q7Axqy+sKe2zFFZYE31sNKZYVTv3zjJ7QNQ0
         UB0ESxyBHN73brkOE5C3/LSwNbmF6qcT8gPSSp4kogD32HqeHhDPYGuqexxcTH75kl
         i6rLm22m1He9QJQ19rkm2ktfxD5cZ1HZI0ePY/KhKx+YjNk3+E146eFffaivIVI3nj
         6vxHgXix0AzxurfxnEew1GOXq6FHeX5npb8vtknXNwkcFFSMD6B8Dfc9bsorXrhonA
         wi7jNxIPwwuj8rZDv8og6/51djaxmnUdTYlZTZ87vvuhCeeCMPb5QF11ZRBSqvHSb6
         AcZtDf/dVGLFQ==
Message-ID: <4a45cbd11952dc953c2e8066e675345d499b8158.camel@kernel.org>
Subject: Re: [PATCH] ceph: Make ceph_netfs_issue_op() handle inlined data
 (untested)
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Dec 2021 15:27:50 -0500
In-Reply-To: <163977198611.2082978.4748242515627648240.stgit@warthog.procyon.org.uk>
References: <163977198611.2082978.4748242515627648240.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-12-17 at 20:13 +0000, David Howells wrote:
> Here's a first stab at making ceph_netfs_issue_op() handle inlined data on
> page 0.  The code that's upstream *ought* to be doing this in
> ceph_readpage() as the page isn't pinned and could get discarded under
> memory pressure from what I can see.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: ceph-devel@vger.kernel.org
> ---
> 
>  fs/ceph/addr.c |   79 ++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 553e2b5653f3..b72f77fe32f2 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -244,6 +244,61 @@ static void finish_netfs_read(struct ceph_osd_request *req)
>  	iput(req->r_inode);
>  }
>  
> +static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
> +{
> +	struct netfs_read_request *rreq = subreq->rreq;
> +	struct inode *inode = rreq->inode;
> +	struct ceph_mds_reply_info_parsed *rinfo;
> +	struct ceph_mds_reply_info_in *iinfo;
> +	struct ceph_mds_request *req;
> +	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct iov_iter iter;
> +	ssize_t err = 0;
> +	size_t len;
> +
> +	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> +	__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
> +
> +	if (subreq->start >= inode->i_size || subreq->start >= 4096)
> +		goto out;
> +
> +	/* We need to fetch the inline data. */
> +	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
> +	if (IS_ERR(req)) {
> +		err = PTR_ERR(req);
> +		goto out;
> +	}
> +	req->r_ino1 = ci->i_vino;
> +	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
> +	req->r_num_caps = 2;
> +
> +	err = ceph_mdsc_do_request(mdsc, NULL, req);
> +	if (err < 0)
> +		goto out;
> +
> +	rinfo = &req->r_reply_info;
> +	iinfo = &rinfo->targeti;
> +	if (iinfo->inline_version == CEPH_INLINE_NONE) {
> +		/* The data got uninlined */
> +		ceph_mdsc_put_request(req);
> +		return false;
> +	}
> +
> +	len = min_t(size_t, 4096 - subreq->start, iinfo->inline_len);
> +	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
> +
> +	err = copy_to_iter(iinfo->inline_data, len, &iter);
> +	if (err == 0)
> +		err = -EFAULT;
> +
> +	ceph_mdsc_put_request(req);
> +
> +out:
> +	netfs_subreq_terminated(subreq, err, false);
> +	return true;
> +}
> +
>  static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
>  {
>  	struct netfs_read_request *rreq = subreq->rreq;
> @@ -258,6 +313,10 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
>  	int err = 0;
>  	u64 len = subreq->len;
>  
> +	if (ci->i_inline_version != CEPH_INLINE_NONE &&
> +	    ceph_netfs_issue_op_inline(subreq))
> +		return;
> +
>  	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino, subreq->start, &len,
>  			0, 1, CEPH_OSD_OP_READ,
>  			CEPH_OSD_FLAG_READ | fsc->client->osdc.client->options->read_from_replica,
> @@ -331,23 +390,9 @@ static int ceph_readpage(struct file *file, struct page *subpage)
>  	size_t len = folio_size(folio);
>  	u64 off = folio_file_pos(folio);
>  
> -	if (ci->i_inline_version != CEPH_INLINE_NONE) {
> -		/*
> -		 * Uptodate inline data should have been added
> -		 * into page cache while getting Fcr caps.
> -		 */
> -		if (off == 0) {
> -			folio_unlock(folio);
> -			return -EINVAL;
> -		}
> -		zero_user_segment(&folio->page, 0, folio_size(folio));
> -		folio_mark_uptodate(folio);
> -		folio_unlock(folio);
> -		return 0;
> -	}
> -
> -	dout("readpage ino %llx.%llx file %p off %llu len %zu folio %p index %lu\n",
> -	     vino.ino, vino.snap, file, off, len, folio, folio_index(folio));
> +	if (ci->i_inline_version == CEPH_INLINE_NONE)
> +		dout("readpage ino %llx.%llx file %p off %llu len %zu folio %p index %lu\n",
> +		     vino.ino, vino.snap, file, off, len, folio, folio_index(folio));
>  
>  	return netfs_readpage(file, folio, &ceph_netfs_read_ops, NULL);
>  }
> 
> 

This also looks good to me. I'll plan to do some testing with it on top
of the other patches you sent and see how it goes.

It may be best to just toss these into a branch based on top of your
fscache-rewrite branch, and I can pull that into an integration branch
for testing locally.

I'll have to work out a test environment with inline support too, and
make sure we can exercise this codepath.
-- 
Jeff Layton <jlayton@kernel.org>
