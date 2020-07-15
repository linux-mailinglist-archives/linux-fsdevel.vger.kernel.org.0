Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5294D221133
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgGOPe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:34:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgGOPe4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:34:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2ED93AD18;
        Wed, 15 Jul 2020 15:34:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9FD231E12C9; Wed, 15 Jul 2020 17:34:54 +0200 (CEST)
Date:   Wed, 15 Jul 2020 17:34:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] fanotify: no external fh buffer in
 fanotify_name_event
Message-ID: <20200715153454.GO23073@quack2.suse.cz>
References: <20200708111156.24659-1-amir73il@gmail.com>
 <20200708111156.24659-20-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708111156.24659-20-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-07-20 14:11:55, Amir Goldstein wrote:
> The fanotify_fh struct has an inline buffer of size 12 which is enough
> to store the most common local filesystem file handles (e.g. ext4, xfs).
> For file handles that do not fit in the inline buffer (e.g. btrfs), an
> external buffer is allocated to store the file handle.
> 
> When allocating a variable size fanotify_name_event, there is no point
> in allocating also an external fh buffer when file handle does not fit
> in the inline buffer.
> 
> Check required size for encoding fh, preallocate an event buffer
> sufficient to contain both file handle and name and store the name after
> the file handle.
> 
> At this time, when not reporting name in event, we still allocate
> the fixed size fanotify_fid_event and an external buffer for large
> file handles, but fanotify_alloc_name_event() has already been prepared
> to accept a NULL file_name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one tiny nit below:

> @@ -305,27 +323,34 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>   * Return 0 on failure to encode.
>   */
>  static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> -			      gfp_t gfp)
> +			      unsigned int fh_len, gfp_t gfp)
>  {
> -	int dwords, type, bytes = 0;
> +	int dwords, bytes, type = 0;
>  	char *ext_buf = NULL;
>  	void *buf = fh->buf;
>  	int err;
>  
>  	fh->type = FILEID_ROOT;
>  	fh->len = 0;
> +	fh->flags = 0;
>  	if (!inode)
>  		return 0;
>  
> -	dwords = 0;
> +	/*
> +	 * !gpf means preallocated variable size fh, but fh_len could
> +	 * be zero in that case if encoding fh len failed.
> +	 */
>  	err = -ENOENT;
> -	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> -	if (!dwords)
> +	if (!gfp)
> +		bytes = fh_len;
> +	else
> +		bytes = fanotify_encode_fh_len(inode);

Any reason why proper fh len is not passed in by both callers? We could
then get rid of this 'if' and 'bytes' variable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
