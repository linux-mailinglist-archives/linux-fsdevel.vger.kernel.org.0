Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224AA29E416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 08:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgJ2HeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 03:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgJ2HY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478DC0613D5;
        Wed, 28 Oct 2020 19:47:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXcY1-00AMVG-SL; Wed, 28 Oct 2020 03:54:53 +0000
Date:   Wed, 28 Oct 2020 03:54:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cai@redhat.com
Subject: Re: [PATCH] pipe: fix potential inode leak in create_pipe_files()
Message-ID: <20201028035453.GI3576660@ZenIV.linux.org.uk>
References: <779f767d-c08b-0c03-198e-06270100d529@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779f767d-c08b-0c03-198e-06270100d529@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:03:52AM +0800, Zhiqiang Liu wrote:
> 
> In create_pipe_files(), if alloc_file_clone() fails, we will call
> put_pipe_info to release pipe, and call fput() to release f.
> However, we donot call iput() to free inode.

Huh?  Have you actually tried to trigger that failure exit?

> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> ---
>  fs/pipe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 0ac197658a2d..8856607fde65 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -924,6 +924,7 @@ int create_pipe_files(struct file **res, int flags)
>  	if (IS_ERR(res[0])) {
>  		put_pipe_info(inode, inode->i_pipe);
>  		fput(f);
> +		iput(inode);
>  		return PTR_ERR(res[0]);

No.  That inode is created with refcount 1.  If alloc_file_pseudo()
succeeds, the reference we'd been holding has been transferred into
dentry allocated by alloc_file_pseudo() (and attached to f).
From that point on we do *NOT* own a reference to inode and no
subsequent failure exits have any business releasing it.

In particular, alloc_file_clone() DOES NOT create extra references
to inode, whether it succeeds or fails.  Dropping the reference
to f will take care of everything.

If you tried to trigger that failure exit with your patch applied,
you would've seen double iput(), as soon as you return from sys_pipe()
to userland and task_work is processed (which is where the real
destructor of struct file will happen).

NAK.
