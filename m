Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E478DA94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjH3Sgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbjH3Jxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276D1B0;
        Wed, 30 Aug 2023 02:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801C260F0C;
        Wed, 30 Aug 2023 09:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B009C433C8;
        Wed, 30 Aug 2023 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693389219;
        bh=nknoL9w3Y4YI7sgEzXEgy31hHjSBtW5t6+EKdvixVT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGeSqtlADXPNsSRMnED5y2bc51bStrsRKgRLsG0vFmeuS7ZjsjtBx9snAHe0G8Vr2
         puIswmGZMwYKKpvbAUG4hgCkBPfAo5LnG+Zqi6zCKquDATicIUaBHr5eqdyzNoLlT+
         eDLqK7F5l64Ce6vhg3+b1Cyvv77qi6SuOOpM4UfSj8i00ym6zp0iNwdRQNPeW8AsCh
         s7jTGiZrttnG7dc7MMCLuv2nzzC2OWwW1dpk2JWvAsdtCdcLabRj31KBbnR0Ga2XvP
         vjAjcw2evRgbmv/HS/X8EAdywyIIJ9VzMleY3re1+0iiynu1XGC3tw9hN+y2/tEsbr
         Pj2cy6RWLJA5g==
Date:   Wed, 30 Aug 2023 11:53:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, jlayton@kernel.org,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 15/28] security: Introduce inode_post_removexattr hook
Message-ID: <20230830-kultfigur-verrohen-a689c59911d6@brauner>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-16-roberto.sassu@huaweicloud.com>
 <f5a61c0f09c1b8d8aaeb99ad7ba4aab15818c5ed.camel@linux.ibm.com>
 <9d482f25475a9d9bc0c93a8cbaf8bd4bb67d2cd6.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d482f25475a9d9bc0c93a8cbaf8bd4bb67d2cd6.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:31:35AM +0200, Roberto Sassu wrote:
> On Wed, 2023-03-08 at 10:43 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > > the inode_post_removexattr hook.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  fs/xattr.c                    |  1 +
> > >  include/linux/lsm_hook_defs.h |  2 ++
> > >  include/linux/security.h      |  5 +++++
> > >  security/security.c           | 14 ++++++++++++++
> > >  4 files changed, 22 insertions(+)
> > > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index 14a7eb3c8fa..10c959d9fc6 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -534,6 +534,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> > >  
> > >  	if (!error) {
> > >  		fsnotify_xattr(dentry);
> > > +		security_inode_post_removexattr(dentry, name);
> > >  		evm_inode_post_removexattr(dentry, name);
> > >  	}
> > 
> > Nothing wrong with this, but other places in this function test "if
> > (error) goto ...".   Perhaps it is time to clean this up.
> > 
> > >  
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index eedefbcdde3..2ae5224d967 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -147,6 +147,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> > >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> > >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> > >  	 struct dentry *dentry, const char *name)
> > > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> > > +	 const char *name)
> > 
> > @Christian should the security_inode_removexattr() and
> > security_inode_post_removexattr() arguments be the same?
> 
> Probably this got lost.
> 
> Christian, should security_inode_post_removexattr() have the idmap
> parameter as well?

Only if you call anything from any implementers of the hook that needs
access to the idmap.
