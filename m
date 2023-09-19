Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053217A66F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjISOmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjISOmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:42:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EFBF;
        Tue, 19 Sep 2023 07:42:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD51C433C7;
        Tue, 19 Sep 2023 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695134563;
        bh=fmKNdqxH/zIrstzQjIfs2t2FuaneBJfrzBO5jxEXwSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKYRaU+qfxDXg1U8c//7smnB0RNxrxJmpD9coY5m7xJHruNYe52KjBM2ZiJlqhweQ
         qQl3XPx+66dm1Tv2Y7wh87C6PMsMtHraJ4URg4uAdeYTiQ9VXqyoAN/gtXcYBtyzZq
         +LlGsQBmnwNOp4mXUvwKc7CRvxuSqzgMjeU1IE7hTxP7i75mrnUuy4yAI3ZtxAJL5i
         5NxnQZQKIjof25ECWx8Jcjd1Wob1ZRA9qRztcD9ueeNUEZnPw4qrnEeNBkCXzsg4HA
         xou5zs74RIYTsbtMCw50/FZK7Ex2fBfG7or0ytYg5mgXpx93CqsBRlzah8Gb8Q8Vd3
         92Enp+Km5AY9w==
Date:   Tue, 19 Sep 2023 16:42:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] linux/fs.h: fix umask on NFS with CONFIG_FS_POSIX_ACL=n
Message-ID: <20230919-tabuisieren-vernommen-81997dd7f6b6@brauner>
References: <20230919081837.1096695-1-max.kellermann@ionos.com>
 <20230919-altbekannt-musisch-35ac924166cf@brauner>
 <a955495733e55f4fecad42b252c0360a210988ff.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a955495733e55f4fecad42b252c0360a210988ff.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:26:38AM -0400, Jeff Layton wrote:
> On Tue, 2023-09-19 at 15:02 +0200, Christian Brauner wrote:
> > On Tue, Sep 19, 2023 at 10:18:36AM +0200, Max Kellermann wrote:
> > > Make IS_POSIXACL() return false if POSIX ACL support is disabled and
> > > ignore SB_POSIXACL/MS_POSIXACL.
> > > 
> > > Never skip applying the umask in namei.c and never bother to do any
> > > ACL specific checks if the filesystem falsely indicates it has ACLs
> > > enabled when the feature is completely disabled in the kernel.
> > > 
> > > This fixes a problem where the umask is always ignored in the NFS
> > > client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
> > > old regression caused by commit 013cdf1088d723 which itself was not
> > > completely wrong, but failed to consider all the side effects by
> > > misdesigned VFS code.
> > > 
> > > Prior to that commit, there were two places where the umask could be
> > > applied, for example when creating a directory:
> > > 
> > >  1. in the VFS layer in SYSCALL_DEFINE3(mkdirat), but only if
> > >     !IS_POSIXACL()
> > > 
> > >  2. again (unconditionally) in nfs3_proc_mkdir()
> > > 
> > > The first one does not apply, because even without
> > > CONFIG_FS_POSIX_ACL, the NFS client sets MS_POSIXACL in
> > > nfs_fill_super().
> > 
> > Jeff, in light of the recent SB_NOUMASK work for nfs4 to always skip
> > applying the umask how would this patch fit into the picture? Would be
> > good to have your review here.
> > 
> > > 
> > > After that commit, (2.) was replaced by:
> > > 
> > >  2b. in posix_acl_create(), called by nfs3_proc_mkdir()
> > > 
> > > There's one branch in posix_acl_create() which applies the umask;
> > > however, without CONFIG_FS_POSIX_ACL, posix_acl_create() is an empty
> > > dummy function which does not apply the umask.
> > > 
> > > The approach chosen by this patch is to make IS_POSIXACL() always
> > > return false when POSIX ACL support is disabled, so the umask always
> > > gets applied by the VFS layer.  This is consistent with the (regular)
> > > behavior of posix_acl_create(): that function returns early if
> > > IS_POSIXACL() is false, before applying the umask.
> > > 
> > > Therefore, posix_acl_create() is responsible for applying the umask if
> > > there is ACL support enabled in the file system (SB_POSIXACL), and the
> > > VFS layer is responsible for all other cases (no SB_POSIXACL or no
> > > CONFIG_FS_POSIX_ACL).
> > > 
> > > Reviewed-by: J. Bruce Fields <bfields@redhat.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > > ---
> > >  include/linux/fs.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 4aeb3fa11927..c1a4bc5c2e95 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2110,7 +2110,12 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
> > >  #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
> > >  #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
> > >  #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
> > > +
> > > +#ifdef CONFIG_FS_POSIX_ACL
> > >  #define IS_POSIXACL(inode)	__IS_FLG(inode, SB_POSIXACL)
> > > +#else
> > > +#define IS_POSIXACL(inode)	0
> > > +#endif
> > >  
> > >  #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
> > >  #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
> > > -- 
> > > 2.39.2
> > > 
> 
> (cc'ing Trond and Anna)
> 
> To be clear, Christian is talking about this patch that I sent last
> week:
> 
> https://lore.kernel.org/linux-fsdevel/20230911-acl-fix-v3-1-b25315333f6c@kernel.org/
> 
> At first glance, I don't see a problem with Max's patch.
> 
> If anything the patch in the lore link above should keep NFSv4 working
> as expected if we take Max's patch. You might also need to add

No, it wouldn't, I think.

If I understood your correctly last week then NFS always raised
SB_POSIXACL in nfs_fill_super() to prevent the VFS from applying umasks
in the VFS and in fact to not apply umask at all (at least for nfs4).

If that's the case then accepting this patch would mean that the VFS
wouldn't see this SB_POSIXACL flag anymore and would strip the umask in
the VFS causing a regression for you.
