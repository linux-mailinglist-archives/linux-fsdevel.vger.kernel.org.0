Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8509321F07E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGNMNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:13:11 -0400
Received: from nautica.notk.org ([91.121.71.147]:55181 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgGNMNK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:13:10 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C9AB1C01B; Tue, 14 Jul 2020 14:13:04 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:12:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Victor Hsieh <victorhsieh@google.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Fix TCREATE's fid in protocol
Message-ID: <20200714121249.GA21928@nautica>
References: <20200713215759.3701482-1-victorhsieh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713215759.3701482-1-victorhsieh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Victor Hsieh wrote on Mon, Jul 13, 2020:
> The fid parameter of TCREATE represents the directory that the file

This is not TCREATE, this is TLCREATE.
The fid represents the directory before the call, but on success
represents the file that has been created.

> should be created at. The current implementation mistakenly passes a
> locally created fid for the file. The correct file fid is usually
> retrieved by another WALK call, which does happen right after.
> 
> The problem happens when a new created fd is read from (i.e. where
> private_data->fid is used), but not write to.

I'm not sure why the code currently does a 2nd walk from the directory
with the name which is prone to a race instead of cloning ofid without a
path, but I fail to see the problem you ran into - file->private_data is
a fid pointing to the file as it should be.

Could you describe what kind of errors you get and if possible how to
reproduce?

> Fixes: 5643135a2846 ("fs/9p: This patch implements TLCREATE for 9p2000.L protocol.")
> Signed-off-by: Victor Hsieh <victorhsieh@google.com>
> Cc: stable@vger.kernel.org

(afaiu it is normally frowned upon for developers to add this cc (I can
understand stable@ not wanting spam discussing issues left and right
before maintainers agreed on them!) ; I can add it to the commit itself
if requested but they normally pick most such fixes pretty nicely for
backport anyway; I see most 9p patches backported as long as the patch
applies cleanly which is pretty much all the time.
Please let me know if I understood that incorrectly)

> ---
>  fs/9p/vfs_inode_dotl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 60328b21c5fb..90a7aaea918d 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -285,7 +285,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  			 err);
>  		goto error;
>  	}
> -	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
> +	err = p9_client_create_dotl(dfid, name, v9fs_open_to_dotl_flags(flags),
>  				    mode, gid, &qid);
>  	if (err < 0) {
>  		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
