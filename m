Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475F76B34AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCJDUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJDUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:20:02 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503E3FFBEC;
        Thu,  9 Mar 2023 19:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9GsbB5b7BGtJnl9LtZ+ApF1Ae/mKzKhIP/UQI7rA/0I=; b=QxRSy9LlNWuDonXYa23yzhuHgy
        fCeVd5y8zr6e2px1BVDmNZ7RL0MVOj2WYo4ZriMLDOfoQ3eZR6enevaGtBQ+Ir4yBmpmXAX+9aL/j
        ni2GPsrAyhspoV8+YnhHKAoL7jYum3OgPXbydPXtzTvExVVrMO2OfUocxfBVnSX5eyUaBkwPkrCc/
        VE0M31dReAslqzUVi1nlmsHl0MbEIsFjQxu3dd29ddYr1m/sgOJlKeCEh+Ts4lrH7rnJYmJjPRTxJ
        4IxBaEIwaMXYrF8lhn5WVD4/oC9zxg9ep7OMmQz6A+Jst/zsjIbHd/4BSig2belxygPu+j8zO//Ur
        rrpmXtWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTIC-00FCTd-0l;
        Fri, 10 Mar 2023 03:19:40 +0000
Date:   Fri, 10 Mar 2023 03:19:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] ext4: convert to use i_blockmask()
Message-ID: <20230310031940.GE3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309152127.41427-4-frank.li@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:21:25PM +0800, Yangtao Li wrote:
> Use i_blockmask() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -none
> v2:
> -convert to i_blockmask()
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d251d705c276..eec36520e5e9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
>  {
>  	struct inode *inode = mpd->inode;
>  	int err;
> -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> +	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
>  							>> inode->i_blkbits;

Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode)) -
compiler should bloody well be able to figure out that division by (1 << n) is
shift down by n and it's easier to follow that way...
