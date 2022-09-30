Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B45F06C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 10:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiI3Iov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI3Ioq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985F1408F;
        Fri, 30 Sep 2022 01:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A9462272;
        Fri, 30 Sep 2022 08:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20573C433D6;
        Fri, 30 Sep 2022 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664527484;
        bh=d1ZEgyLvbAWwEvt+KDAgrmBxhZSgx4ZgAWldRS0Ue3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwJz6cn2OyQ2cLyL/dqHFljtF6OGMIoTUu220yVVdrM7DJyH9X6YBEe/a8miaZpk5
         8MyCvQ6KRB3oIDvjNmoSh6K/wnO+yX2v/b5FKyEH917liXShZObmk5ik8IcDzHB1ex
         aTjM4y18yhtAJ75Dxxfzp0ThCMnc68glyl9+KsdY0PqUrMRy3xFaIRLruEYraySr6s
         7z2U55caDoCFJucpSJIq3fc8EB5vvNcGBDnuZ5FHmryYWIJjuIB9H2tGylttw+J5JO
         MGOnfRWjJrcOGG7XYU5Hxwq6fMtaXy4mTRXSAW5OviPk+jW/H6OIxVPXq7SpP/y3qn
         xiOYiEyzEUeVQ==
Date:   Fri, 30 Sep 2022 10:44:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v4 13/30] evm: add post set acl hook
Message-ID: <20220930084438.4wuyeyogdthiwmmn@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-14-brauner@kernel.org>
 <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:44:45PM -0400, Mimi Zohar wrote:
> Hi Christian,
> 
> On Thu, 2022-09-29 at 17:30 +0200, Christian Brauner wrote:
> > The security_inode_post_setxattr() hook is used by security modules to
> > update their own security.* xattrs. Consequently none of the security
> > modules operate on posix acls. So we don't need an additional security
> > hook when post setting posix acls.
> > 
> > However, the integrity subsystem wants to be informed about posix acl
> > changes and specifically evm to update their hashes when the xattrs
> > change. 
> 
> ^... to be informed about posix acl changes in order to reset the EVM
> status flag.

Substituted. 

> 
> > The callchain for evm_inode_post_setxattr() is:
> > 
> > -> evm_inode_post_setxattr()
> 
> Resets the EVM status flag for both EVM signatures and HMAC.
> 
> >    -> evm_update_evmxattr()
> 
> evm_update_evmxattr() is only called for "security.evm", not acls.  

I've added both comments but note that I'm explaining this in the
paragraph below as well.

> 
> >       -> evm_calc_hmac()
> >          -> evm_calc_hmac_or_hash()
> > 
> > and evm_cacl_hmac_or_hash() walks the global list of protected xattr
> > names evm_config_xattrnames. This global list can be modified via
> > /sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
> > restricted to security.* xattrs and the default xattrs in
> > evm_config_xattrnames only contains security.* xattrs as well.
> > 
> > So the actual value for posix acls is currently completely irrelevant
> > for evm during evm_inode_post_setxattr() and frankly it should stay that
> > way in the future to not cause the vfs any more headaches. But if the
> > actual posix acl values matter then evm shouldn't operate on the binary
> > void blob and try to hack around in the uapi struct anyway. Instead it
> > should then in the future add a dedicated hook which takes a struct
> > posix_acl argument passing the posix acls in the proper vfs format.
> > 
> > For now it is sufficient to make evm_inode_post_set_acl() a wrapper
> > around evm_inode_post_setxattr() not passing any actual values down.
> > This will still cause the hashes to be updated as before.
> 
> ^This will cause the EVM status flag to be reset.

Substituted.
