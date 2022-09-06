Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491015AE240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiIFIPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiIFIPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:15:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A64A120
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 01:15:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15FB668AFE; Tue,  6 Sep 2022 10:15:11 +0200 (CEST)
Date:   Tue, 6 Sep 2022 10:15:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906081510.GA8363@lst.de>
References: <20220829123843.1146874-1-brauner@kernel.org> <20220829123843.1146874-4-brauner@kernel.org> <20220906045746.GB32578@lst.de> <20220906074532.ysyitr5yxy5adfsx@wittgenstein> <20220906075313.GA6672@lst.de> <20220906080744.3ielhtvqdpbqbqgq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906080744.3ielhtvqdpbqbqgq@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:07:44AM +0200, Christian Brauner wrote:
> I've tried switching all filesystem to simply rely on
> i_op->{g,s}et_acl() but this doesn't work for at least 9p and cifs
> because they need access to the dentry. cifs hasn't even implemented
> i_op->get_acl() and I don't think they can because of the lack of a
> dentry argument.
> 
> The problem is not just that i_op->{g,s}et_acl() don't take a dentry
> argument it's in principle also super annoying to pass it to them
> because i_op->get_acl() is used to retrieve POSIX ACLs during permission
> checking and thus is called from generic_permission() and thus
> inode_permission() and I don't think we want or even can pass down a
> dentry everywhere for those. So I stopped short of finishing this
> implementation because of that.
> 
> So in order to make this work for cifs and 9p we would probably need a
> new i_op method that is separate from the i_op->get_acl() one used in
> the acl_permission_check() and friends...

Even if we can't use the existing methods, I think adding new
set_denstry_acl/get_dentry_acl (or whatever we name them) methods is
still better than doing this overload of the xattr methods
(just like the uapi overload instead of separate syscalls, but we
can't fix that).
