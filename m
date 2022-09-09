Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3B5B3146
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIIDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIIIDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:03:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7FF22F5
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 01:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 213E9B82377
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 08:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E56C433D7;
        Fri,  9 Sep 2022 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662710623;
        bh=kmYjaCpFrKesiofBcfowMvQILvHZoc2JRE9d4xOlyLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0OIbErISq94uUP0govcdVqSLsICvYCvvFRYzoUMcenXXXG6m3HlD5inpVcrvgVvS
         d3gRTYkhDezmzl88LcbsICimbnpIMdedaBHwf+ZnbX0kRihnRCuC7noKJRV4R0Nrud
         /AvDDs9pXTt6yvlHZikpTNtynEnLCG2Z+x9vfmXBG+OJV/2NRaFbTu2x2CM18spH1B
         Vp9s0LfK7YWqeyeE3B9qCfeaLSCBcC0L+0n4oa1E9SWZRTq8j6TKirspYRobsWB5iF
         5kYfVagfPVfJur36YjlvhCg2aBpwKpg6KlGfJQKV+OCdG3kqERztDAPQ2uf/jkQGCg
         900JdllXRTf6A==
Date:   Fri, 9 Sep 2022 10:03:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220909080339.2rdbbk2g2p5evznd@wittgenstein>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-4-brauner@kernel.org>
 <20220906045746.GB32578@lst.de>
 <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
 <20220906075313.GA6672@lst.de>
 <20220906080744.3ielhtvqdpbqbqgq@wittgenstein>
 <20220906081510.GA8363@lst.de>
 <20220906082428.mfcjily4dyefunds@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906082428.mfcjily4dyefunds@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:24:32AM +0200, Christian Brauner wrote:
> On Tue, Sep 06, 2022 at 10:15:10AM +0200, Christoph Hellwig wrote:
> > On Tue, Sep 06, 2022 at 10:07:44AM +0200, Christian Brauner wrote:
> > > I've tried switching all filesystem to simply rely on
> > > i_op->{g,s}et_acl() but this doesn't work for at least 9p and cifs
> > > because they need access to the dentry. cifs hasn't even implemented
> > > i_op->get_acl() and I don't think they can because of the lack of a
> > > dentry argument.
> > > 
> > > The problem is not just that i_op->{g,s}et_acl() don't take a dentry
> > > argument it's in principle also super annoying to pass it to them
> > > because i_op->get_acl() is used to retrieve POSIX ACLs during permission
> > > checking and thus is called from generic_permission() and thus
> > > inode_permission() and I don't think we want or even can pass down a
> > > dentry everywhere for those. So I stopped short of finishing this
> > > implementation because of that.
> > > 
> > > So in order to make this work for cifs and 9p we would probably need a
> > > new i_op method that is separate from the i_op->get_acl() one used in
> > > the acl_permission_check() and friends...
> > 
> > Even if we can't use the existing methods, I think adding new
> > set_denstry_acl/get_dentry_acl (or whatever we name them) methods is
> > still better than doing this overload of the xattr methods
> > (just like the uapi overload instead of separate syscalls, but we
> > can't fix that).
> 
> Let me explore and see if I can finish the branch using dedicated i_op
> methods instead of updating i_op->get_acl().
> 
> I think any data that requires to be interpreteted by the VFS needs to
> have dedicated methods. Seth's branch for example, tries to add
> i_op->{g,s}et_vfs_caps() for vfs caps which also store ownership
> information instead of hacking it through the xattr api like we do now.

I finished a draft of the series. It severly lacks in meangingful commit
messages and I won't be able to finish it before Plumbers next week.
If people want to take a look the branch is available on gitlab and
kernel.org:

https://gitlab.com/brauner/linux/-/commits/fs.posix_acl.vfsuid/
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.posix_acl.vfsuid

This passes xfstests (ext4, xfs, btrfs, overlayfs with and without
idmapped layers, and LTP). I only needed to add i_op->get_dentry_acl()
as it was possible to adapt ->set_acl() to take a dentry argument and
not an inode argument.

So we have a dedicated POSIX ACL api:

struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
                              struct dentry *dentry, const char *acl_name)
int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
                const char *acl_name, struct posix_acl *kacl)
int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
                   const char *acl_name)

only relying on i_op->get_dentry_acl() and i_op->set_acl() removing the
void * and uapi POSIX ACL abuse completely.
