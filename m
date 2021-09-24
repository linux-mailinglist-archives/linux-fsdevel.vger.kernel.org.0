Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01C416B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 06:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbhIXEgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbhIXEgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 00:36:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD4C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 21:35:16 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTcvS-006r8Z-Mj; Fri, 24 Sep 2021 04:35:06 +0000
Date:   Fri, 24 Sep 2021 04:35:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yangerkun <yangerkun@huawei.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com
Subject: Re: [PATCH] ramfs: fix mount source show for ramfs
Message-ID: <YU1VegG/+AHwHaom@zeniv-ca.linux.org.uk>
References: <20210811122811.2288041-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811122811.2288041-1-yangerkun@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 08:28:11PM +0800, yangerkun wrote:
> ramfs_parse_param does not parse key "source", and will convert
> -ENOPARAM to 0. This will skip vfs_parse_fs_param_source in
> vfs_parse_fs_param, which lead always "none" mount source for ramfs. Fix
> it by parse "source" in ramfs_parse_param.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/ramfs/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 65e7e56005b8..0d7f5f655fd8 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -202,6 +202,10 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	struct ramfs_fs_info *fsi = fc->s_fs_info;
>  	int opt;
>  
> +	opt = vfs_parse_fs_param_source(fc, param);
> +	if (opt != -ENOPARAM)
> +		return opt;
> +
>  	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
>  	if (opt < 0) {
>  		/*

	Umm...  If anything, I would rather call that thing *after*
fs_parse() gives negative, similar to what kernel/cgroup/cgroup-v1.c
does.
