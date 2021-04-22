Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD0367676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhDVAoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhDVAox (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:44:53 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC1C06174A;
        Wed, 21 Apr 2021 17:44:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZNRw-007B5f-KZ; Thu, 22 Apr 2021 00:44:08 +0000
Date:   Thu, 22 Apr 2021 00:44:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: Avoid potential use after free
Message-ID: <YIDG2MOSITJxJBqd@zeniv-ca.linux.org.uk>
References: <20210406235332.2206460-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406235332.2206460-1-pakki001@umn.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> In virtio_fs_get_tree, after fm is freed, it is again freed in case
> s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> a double free, set fm to NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4ee6f734ba83..a7484c1539bf 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	if (fsc->s_fs_info) {
>  		fuse_conn_put(fc);
>  		kfree(fm);
> +		fm = NULL;
>  	}
>  	if (IS_ERR(sb))
>  		return PTR_ERR(sb);

NAK.  The only cases when sget_fc() returns without having ->s_fs_info
zeroed are when it has successfull grabbed a reference to existing live
superblock or when it has failed.  In the former case we proceed straight
to
        fsc->root = dget(sb->s_root);
	return 0;
and in the latter we bugger off on IS_ERR(sb).  No double-free in either
case.  Said that, the logics in there (especially around the cleanups
on virtio_fs_fill_super() failures) is bloody convoluted, but sorting
that out would take a lot more RTFS than I'm willing to start right now.

In any case, this patch does not fix any bugs and does not make the
thing easier to follow, so...

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
