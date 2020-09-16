Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51B226BBEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 07:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIPFmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 01:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgIPFl7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:41:59 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F1D206F7;
        Wed, 16 Sep 2020 05:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600234918;
        bh=hSP4gRwVEWhysa34HuwuUeUWtwGLR+7qBuvWJ/US/xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6DxVqWLpWKYFixD+gwLxBRh1iUCN5ANUHZOZ773rz+A3XDsFwA3/qz5POT3/X5pv
         MEO3ATs0i1zhe9mEIRHRP3dHjUStgDnGX5eRK4iG4LawIRdKytaRh1Wlvx2gNGSION
         MwoogpUb3sI4lAbZ2Mi8BbgtPd4HPKJXYKsFyazc=
Date:   Tue, 15 Sep 2020 22:41:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix KMSAN uninit-value bug by initializing nd in
 do_file_open_root
Message-ID: <20200916054157.GC825@sol.localdomain>
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:56:56AM +0530, Anant Thazhemadam wrote:
> The KMSAN bug report for the bug indicates that there exists;
> Local variable ----nd@do_file_open_root created at:
>  do_file_open_root+0xa4/0xb40 fs/namei.c:3385
>  do_file_open_root+0xa4/0xb40 fs/namei.c:3385
> 
> Initializing nd fixes this issue, and doesn't break anything else either
> 
> Fixes: https://syzkaller.appspot.com/bug?extid=4191a44ad556eacc1a7a
> Reported-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
> Tested-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index e99e2a9da0f7..b27382586209 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3404,7 +3404,7 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
>  struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
>  		const char *name, const struct open_flags *op)
>  {
> -	struct nameidata nd;
> +	struct nameidata nd = {};
>  	struct file *file;
>  	struct filename *filename;
>  	int flags = op->lookup_flags | LOOKUP_ROOT;

Looking at the actual KMSAN report, it looks like it's nameidata::dir_mode or
nameidata::dir_uid that is uninitialized.  You need to figure out the correct
solution, not just blindly initialize with zeroes -- that could hide a bug.
Is there a bug that is preventing these fields from being initialized to the
correct values, are these fields being used when they shouldn't be, etc...

- Eric
