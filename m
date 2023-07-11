Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3351174F109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjGKOEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjGKOEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4428D12A;
        Tue, 11 Jul 2023 07:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD98C61505;
        Tue, 11 Jul 2023 14:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC663C433C8;
        Tue, 11 Jul 2023 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689084246;
        bh=hkjM3kAIgQB2MsZK32Y0LnSzvU+OKdW0pajbNogIOCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9y6shDSvExiH8umQsf+SFCjEhlxKpJcK1FITT1X9fxWaBcy/PBj6GNyONmVduAK7
         VrN+5V1Cp/gDD5e/zaI0L7WDA3s767ezmniJorTsn3GXlqUFZeSrma97UopLdgpudB
         7GEQmf3i8/WAon5QrBgT3kivHV+TBb+xGvmBcNmI=
Date:   Tue, 11 Jul 2023 16:04:03 +0200
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
Message-ID: <2023071159-unsigned-salvation-405d@gregkh>
References: <20230710183338.58531-1-ivan@cloudflare.com>
 <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:21:10PM -0700, Ivan Babrou wrote:
> On Mon, Jul 10, 2023 at 12:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 10, 2023 at 11:33:38AM -0700, Ivan Babrou wrote:
> > > The following two commits added the same thing for tmpfs:
> > >
> > > * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> > > * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file handles on tmpfs")
> > >
> > > Having fsid allows using fanotify, which is especially handy for cgroups,
> > > where one might be interested in knowing when they are created or removed.
> > >
> > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > ---
> > >  fs/kernfs/mount.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > > index d49606accb07..930026842359 100644
> > > --- a/fs/kernfs/mount.c
> > > +++ b/fs/kernfs/mount.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/namei.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/exportfs.h>
> > > +#include <linux/uuid.h>
> > > +#include <linux/statfs.h>
> > >
> > >  #include "kernfs-internal.h"
> > >
> > > @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
> > >       return 0;
> > >  }
> > >
> > > +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > > +{
> > > +     simple_statfs(dentry, buf);
> > > +     buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > > +     return 0;
> > > +}
> > > +
> > >  const struct super_operations kernfs_sops = {
> > > -     .statfs         = simple_statfs,
> > > +     .statfs         = kernfs_statfs,
> > >       .drop_inode     = generic_delete_inode,
> > >       .evict_inode    = kernfs_evict_inode,
> > >
> > > @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
> > >               }
> > >               sb->s_flags |= SB_ACTIVE;
> > >
> > > +             uuid_gen(&sb->s_uuid);
> >
> > Since kernfs has as lot of nodes (like hundreds of thousands if not more
> > at times, being created at boot time), did you just slow down creating
> > them all, and increase the memory usage in a measurable way?
> 
> This is just for the superblock, not every inode. The memory increase
> is one UUID per kernfs instance (there are maybe 10 of them on a basic
> system), which is trivial. Same goes for CPU usage.

Ah, ok, my fault, thanks for clearing that up.

thanks,

greg k-h
