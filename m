Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1E5F3D04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJDHFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJDHFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:05:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CDEE02E;
        Tue,  4 Oct 2022 00:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4359B8160C;
        Tue,  4 Oct 2022 07:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599AEC433C1;
        Tue,  4 Oct 2022 07:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664867103;
        bh=AUPUQA+Gqkffiz159XDkGeRx4va6HgRuw8sStcNwhEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlojbK6B3227XIgjAD7w0qAWB6BIhJlNKW50LY9NosQDlJ7pRFqvuumHmFbSunLuL
         0WX9pzzmyZ8Rs75OMZ2a9/qM4tLcAivN7kCSYTwnLzXS1wdxVH9c0lZ81ec8iW0iED
         fQqUehuJJCCVkHLxaXwNZroySFCWZyzG1nY1XJOGLGQbsUhZDaMA2WYoEXRAsoFg0D
         WTbSzcrg7QqPfi849ca0BshyYUIRzPV29sDAHD0HFHQH5cUA/8/mlNwejDwKiYLO52
         hs5v+F6ZLKcir6514oUH8SoD7kh2mtnqbNVQtB/4V0LnyJ4UZzKjoexgvEttAk2wpJ
         Cf54DSXXNCFvg==
Date:   Tue, 4 Oct 2022 09:04:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 13/30] evm: add post set acl hook
Message-ID: <20221004070453.vb34nsenxf2ocwff@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-14-brauner@kernel.org>
 <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
 <20220930084438.4wuyeyogdthiwmmn@wittgenstein>
 <e55cf916e5d5a50e293c7dc5b4f00802578eb6d6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e55cf916e5d5a50e293c7dc5b4f00802578eb6d6.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 07:48:31AM -0400, Mimi Zohar wrote:
> Hi Christian,
> 
> On Fri, 2022-09-30 at 10:44 +0200, Christian Brauner wrote:
> > On Thu, Sep 29, 2022 at 09:44:45PM -0400, Mimi Zohar wrote: 
> > > On Thu, 2022-09-29 at 17:30 +0200, Christian Brauner wrote:
> > > > The security_inode_post_setxattr() hook is used by security modules to
> > > > update their own security.* xattrs. Consequently none of the security
> > > > modules operate on posix acls. So we don't need an additional security
> > > > hook when post setting posix acls.
> > > > 
> > > > However, the integrity subsystem wants to be informed about posix acl
> > > > changes and specifically evm to update their hashes when the xattrs
> > > > change. 
> > > 
> > > ^... to be informed about posix acl changes in order to reset the EVM
> > > status flag.
> > 
> > Substituted.
> >  
> > 
> > > 
> > > > The callchain for evm_inode_post_setxattr() is:
> > > > 
> > > > -> evm_inode_post_setxattr()
> > > 
> > > Resets the EVM status flag for both EVM signatures and HMAC.
> > > 
> > > >    -> evm_update_evmxattr()
> > > 
> > > evm_update_evmxattr() is only called for "security.evm", not acls.
> 
> After re-reading the code with fresh eyes, I made a mistake here. 
> Please revert these suggestions.

Ok.

> 
> > 
> > I've added both comments but note that I'm explaining this in the
> > paragraph below as well.
> 
> Agreed.
> 
> > 
> > > 
> > > >       -> evm_calc_hmac()
> > > >          -> evm_calc_hmac_or_hash()
> > > > 
> > > > and evm_cacl_hmac_or_hash() walks the global list of protected xattr
> > > > names evm_config_xattrnames. This global list can be modified via
> > > > /sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
> > > > restricted to security.* xattrs and the default xattrs in
> > > > evm_config_xattrnames only contains security.* xattrs as well.
> > > > 
> > > > So the actual value for posix acls is currently completely irrelevant
> > > > for evm during evm_inode_post_setxattr() and frankly it should stay that
> > > > way in the future to not cause the vfs any more headaches. But if the
> > > > actual posix acl values matter then evm shouldn't operate on the binary
> > > > void blob and try to hack around in the uapi struct anyway. Instead it
> > > > should then in the future add a dedicated hook which takes a struct
> > > > posix_acl argument passing the posix acls in the proper vfs format.
> > > > 
> > > > For now it is sufficient to make evm_inode_post_set_acl() a wrapper
> > > > around evm_inode_post_setxattr() not passing any actual values down.
> > > > This will still cause the hashes to be updated as before.
> > > 
> > > ^This will cause the EVM status flag to be reset.
> > 
> > Substituted.
> 
> My mistake.  Can you replace it with:
> 
> This will still cause the EVM status flag to be reset and EVM HMAC's to
> be updated as before.

Sure.
