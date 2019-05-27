Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9E2B286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE0KyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 06:54:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfE0KyC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 06:54:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A64CAF58;
        Mon, 27 May 2019 10:54:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 401651E3C2F; Mon, 27 May 2019 12:53:57 +0200 (CEST)
Date:   Mon, 27 May 2019 12:53:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
Message-ID: <20190527105357.GD20440@quack2.suse.cz>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526143411.11244-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 26-05-19 17:34:04, Amir Goldstein wrote:
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  net/sunrpc/rpc_pipe.c | 4 ++++
>  1 file changed, 4 insertions(+)

Hum, I don't think all __rpc_depopulate() calls are guarded by i_rwsem
(e.g. those in rpc_gssd_dummy_populate()). Why aren't we using
rpc_depopulate() in those cases? Trond, Anna?

								Honza

> 
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 979d23646e33..917c85f15a0b 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -597,6 +597,8 @@ static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
>  
>  	dget(dentry);
>  	ret = simple_rmdir(dir, dentry);
> +	if (!ret)
> +		fsnotify_rmdir(dir, dentry);
>  	d_delete(dentry);
>  	dput(dentry);
>  	return ret;
> @@ -608,6 +610,8 @@ static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	dget(dentry);
>  	ret = simple_unlink(dir, dentry);
> +	if (!ret)
> +		fsnotify_unlink(dir, dentry);
>  	d_delete(dentry);
>  	dput(dentry);
>  	return ret;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
