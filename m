Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E96D74DE5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 21:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGJTlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGJTlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436A115;
        Mon, 10 Jul 2023 12:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A1C611BD;
        Mon, 10 Jul 2023 19:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2DEC433C8;
        Mon, 10 Jul 2023 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689018065;
        bh=4JghVo9ntVNo5eow2Va+8PEDtvw9T3mWBVw4q3zNsuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjxjdxwy8939dFbsEfTW/y4r4/FPIAMEe5+YtOiWABsy3aE9uptN/GNiWKzmHAoPq
         DJvfGpgFffG/ZEvc60Rx3ATbNnciqmW36W4CrJOMvHCKGSwfF1eUaHUQD/9fJEnOos
         CsPWfrUnXzLouSyf4k+sRmvtRunIgOXxZIAO2zOQ=
Date:   Mon, 10 Jul 2023 21:41:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in
 fsid
Message-ID: <2023071046-paramount-climatic-31cb@gregkh>
References: <20230710183338.58531-1-ivan@cloudflare.com>
 <2023071039-negate-stalemate-6987@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071039-negate-stalemate-6987@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:40:23PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 10, 2023 at 11:33:38AM -0700, Ivan Babrou wrote:
> > The following two commits added the same thing for tmpfs:
> > 
> > * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> > * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file handles on tmpfs")
> > 
> > Having fsid allows using fanotify, which is especially handy for cgroups,
> > where one might be interested in knowing when they are created or removed.
> > 
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > ---
> >  fs/kernfs/mount.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index d49606accb07..930026842359 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/namei.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/exportfs.h>
> > +#include <linux/uuid.h>
> > +#include <linux/statfs.h>
> >  
> >  #include "kernfs-internal.h"
> >  
> > @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
> >  	return 0;
> >  }
> >  
> > +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > +{
> > +	simple_statfs(dentry, buf);
> > +	buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > +	return 0;
> > +}
> > +
> >  const struct super_operations kernfs_sops = {
> > -	.statfs		= simple_statfs,
> > +	.statfs		= kernfs_statfs,
> >  	.drop_inode	= generic_delete_inode,
> >  	.evict_inode	= kernfs_evict_inode,
> >  
> > @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
> >  		}
> >  		sb->s_flags |= SB_ACTIVE;
> >  
> > +		uuid_gen(&sb->s_uuid);
> 
> Since kernfs has as lot of nodes (like hundreds of thousands if not more
> at times, being created at boot time), did you just slow down creating
> them all, and increase the memory usage in a measurable way?
> 
> We were trying to slim things down, what userspace tools need this
> change?  Who is going to use it, and what for?
> 
> There were some benchmarks people were doing with booting large memory
> systems that you might want to reproduce here to verify that nothing is
> going to be harmed.

Oh wait, is this just a per-superblock thing?

confused,

greg k-h
