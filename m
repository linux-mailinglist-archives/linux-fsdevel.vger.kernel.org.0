Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CE5AE266
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiIFIYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiIFIYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:24:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F874DEAF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 01:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCF90B81649
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 08:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6925EC433D7;
        Tue,  6 Sep 2022 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662452672;
        bh=EWV+zBS3ucLkqhYfY6C+/if7Ri+GlPww+jwJrntjL4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN0mJ1NH4aM0W1c8QImjfOhJbuvNzGu/jjnsCgDHVWmjTDArxZhK/VxKoumvpfs4c
         rReR38oews37nY0oG6JLiKwr4ixV24snlr79sQWuMrsh50B2N+nwbz/QUcZPN44yQd
         sOzgwpDFYJmZ6j4AHXBLdppAFhF+EdRUely/VzH8/sWiaQRH2EHG1tsja82/e8o3AL
         GYcFjRGmFn0mvBcnxWcnZ/TTHVY405BAtKmhyQNpJYT8tp9RMuZ/R/yACrnTZoRpHp
         VJncMfKz4Tty8x4fLmivSQQSNPSZiCECd19s/eocIxXDc/CnMILUmNaXJ1lOeTg6oJ
         /tibuY+DsVxjg==
Date:   Tue, 6 Sep 2022 10:24:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906082428.mfcjily4dyefunds@wittgenstein>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-4-brauner@kernel.org>
 <20220906045746.GB32578@lst.de>
 <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
 <20220906075313.GA6672@lst.de>
 <20220906080744.3ielhtvqdpbqbqgq@wittgenstein>
 <20220906081510.GA8363@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906081510.GA8363@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:15:10AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 10:07:44AM +0200, Christian Brauner wrote:
> > I've tried switching all filesystem to simply rely on
> > i_op->{g,s}et_acl() but this doesn't work for at least 9p and cifs
> > because they need access to the dentry. cifs hasn't even implemented
> > i_op->get_acl() and I don't think they can because of the lack of a
> > dentry argument.
> > 
> > The problem is not just that i_op->{g,s}et_acl() don't take a dentry
> > argument it's in principle also super annoying to pass it to them
> > because i_op->get_acl() is used to retrieve POSIX ACLs during permission
> > checking and thus is called from generic_permission() and thus
> > inode_permission() and I don't think we want or even can pass down a
> > dentry everywhere for those. So I stopped short of finishing this
> > implementation because of that.
> > 
> > So in order to make this work for cifs and 9p we would probably need a
> > new i_op method that is separate from the i_op->get_acl() one used in
> > the acl_permission_check() and friends...
> 
> Even if we can't use the existing methods, I think adding new
> set_denstry_acl/get_dentry_acl (or whatever we name them) methods is
> still better than doing this overload of the xattr methods
> (just like the uapi overload instead of separate syscalls, but we
> can't fix that).

Let me explore and see if I can finish the branch using dedicated i_op
methods instead of updating i_op->get_acl().

I think any data that requires to be interpreteted by the VFS needs to
have dedicated methods. Seth's branch for example, tries to add
i_op->{g,s}et_vfs_caps() for vfs caps which also store ownership
information instead of hacking it through the xattr api like we do now.
