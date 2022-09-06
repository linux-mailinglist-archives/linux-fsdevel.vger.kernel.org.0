Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01A25AE1E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiIFIH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiIFIHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:07:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392405072C
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 01:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9580DB8163F
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 08:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D131C433D7;
        Tue,  6 Sep 2022 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662451669;
        bh=EnNtP9xZOXnA8nuKS7CFuQz+N7DqMRYHSHd5JG0uNFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ67M3+7oXfie0P43eFn4W42ZrUaIW+kkqYfPvV8IhZWmRyiV1gfqlxphU7sxNUL9
         dLW1AOyCtzjLFR6Qi/JEXFUXxA0eooekiJOlQMdOBOxdmQa1jiia92F+bkiOypvHp9
         rYWZ/i+2t+ANJPIpb3O0x/Ew49J4OdIKxPMjNa4L5ij/Z10a7MGkNUXsYf+P5XX9sH
         ltSO3IZdXWpaSQ12NVwEjrMKfv/gz5600mGqdgrorHfvgU/Is1nfQgw37tGshVe4XS
         OB4E3UHjDG2rWS4StIfvIbRDwlbLS5O+4v8OrUwQBPbTvmE/KOGKK0uDDh8oWfg/3T
         VqOEED3xDCKMQ==
Date:   Tue, 6 Sep 2022 10:07:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906080744.3ielhtvqdpbqbqgq@wittgenstein>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-4-brauner@kernel.org>
 <20220906045746.GB32578@lst.de>
 <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
 <20220906075313.GA6672@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906075313.GA6672@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:53:13AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 09:45:32AM +0200, Christian Brauner wrote:
> > > structure type for the on-disk vs uapi ACL formats?  They will be the
> > 
> > We do already have separate format for uapi and VFS ACLs. I'm not sure
> > if you're suggesting another intermediate format.
> 
> Right now struct posix_acl_xattr_header and
> struct posix_acl_xattr_entry is used both for the UAPI, and the
> on-disk format of various file systems, despite the different cases
> using different kinds of uids/gids.
> 
> > I'm currently working on a larger series to get rid of the uapi struct
> > abuse for POSIX ACLs. Building on that work Seth will get rid of similar
> > abuses for VFS caps. I'm fairly close but the rough idea is:
> 
> Can we just stop accessing ACLs through the xattrs ops at all, and
> just have dedicated methods instead?  This whole multiplexing of
> ACLs through xattrs APIs has been an unmitigated disaster.

IIuc then this is exactly what I tried to do (I have a still very hacky
version of this approach in
https://gitlab.com/brauner/linux/-/commits/fs.posix_acl.vfsuid/).

I've tried switching all filesystem to simply rely on
i_op->{g,s}et_acl() but this doesn't work for at least 9p and cifs
because they need access to the dentry. cifs hasn't even implemented
i_op->get_acl() and I don't think they can because of the lack of a
dentry argument.

The problem is not just that i_op->{g,s}et_acl() don't take a dentry
argument it's in principle also super annoying to pass it to them
because i_op->get_acl() is used to retrieve POSIX ACLs during permission
checking and thus is called from generic_permission() and thus
inode_permission() and I don't think we want or even can pass down a
dentry everywhere for those. So I stopped short of finishing this
implementation because of that.

So in order to make this work for cifs and 9p we would probably need a
new i_op method that is separate from the i_op->get_acl() one used in
the acl_permission_check() and friends...

> 
> Similar for all other "xattrs" that are not just user data and
> interpreted by the kernel, but ACLs are by far the worst.

I absolutely agree.
