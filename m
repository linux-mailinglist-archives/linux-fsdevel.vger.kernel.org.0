Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E3425058
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhJGJwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 05:52:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhJGJwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:52:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 804E32008B;
        Thu,  7 Oct 2021 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633600235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW40KaM1lKgxJUUU8ncvlQiPDre5IRRCh+8ZWAaODsg=;
        b=R8PcWSL65q+iFRelGz3/+YfvxYSk4urANMubdcWqQYcmFhqgeAtTSl3MnXwg1BaGp0kcEG
        nhBRm1xA/i8N2Wcsdy5VVBBX1aYeqlvX9/GO7kSUnxGQCO6CmZOFFlKf6pDg/bj8Iwicfm
        FWkP/qfzGNSrHS4EtOytAaz2sBEwqp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633600235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW40KaM1lKgxJUUU8ncvlQiPDre5IRRCh+8ZWAaODsg=;
        b=kvRNzUKVHRH32JSIfWRvq5y0CQWlGTDUo2s8M7utsXMvFd9OJSzpfIlaANjoukFZVD6VaP
        /leGP6ZP43nQCdBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 463B5A3B8C;
        Thu,  7 Oct 2021 09:50:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 422251F2C99; Thu,  7 Oct 2021 11:01:57 +0200 (CEST)
Date:   Thu, 7 Oct 2021 11:01:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20211007090157.GB12712@quack2.suse.cz>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-7-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923130814.140814-7-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-09-21 21:08:10, Chengguang Xu wrote:
> Implement overlayfs' ->write_inode to sync dirty data
> and redirty overlayfs' inode if necessary.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

...

> +static int ovl_write_inode(struct inode *inode,
> +			   struct writeback_control *wbc)
> +{
> +	struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> +	struct inode *upper = ovl_inode_upper(inode);
> +	unsigned long iflag = 0;
> +	int ret = 0;
> +
> +	if (!upper)
> +		return 0;
> +
> +	if (!ovl_should_sync(ofs))
> +		return 0;
> +
> +	if (upper->i_sb->s_op->write_inode)
> +		ret = upper->i_sb->s_op->write_inode(inode, wbc);
> +

I'm somewhat confused here. 'inode' is overlayfs inode AFAIU, so how is it
correct to pass it to ->write_inode function of upper filesystem? Shouldn't
you pass 'upper' there instead?

> +	if (mapping_writably_mapped(upper->i_mapping) ||
> +	    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
> +		iflag |= I_DIRTY_PAGES;
> +
> +	iflag |= upper->i_state & I_DIRTY_ALL;

Also since you call ->write_inode directly upper->i_state won't be updated
to reflect that inode has been written out (I_DIRTY flags get cleared in
__writeback_single_inode()). So it seems to me overlayfs will keep writing
out upper inode until flush worker on upper filesystem also writes the
inode and clears the dirty flags? So you rather need to call something like
write_inode_now() that will handle the flag clearing and do writeback list
handling for you?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
