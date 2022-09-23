Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229F15E7549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIWH6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIWH6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DFA12E409;
        Fri, 23 Sep 2022 00:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A1561277;
        Fri, 23 Sep 2022 07:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A60C433C1;
        Fri, 23 Sep 2022 07:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663919877;
        bh=YJX1tQz1yzxglwezk9I3dhNZMQxZpf3Oqah4VC30Bx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwGVPbP4SF6otAa3yEb3WPh0sozWk5sFA5ZdQsx3yRTVkv9O9Nnna1IGORQZEIj5s
         YD26qaFJfq3xqfAFOXrKwRx1FypioE2cqxKlZ9Rs5SFren4uoyOnf/JfGixnv+28ym
         a/zaA6Rbz2HX/5OULy7jmtdjUi9D5UaQmwR83XrC9vnYAMuCv5WAWpVosGy5IZ0Cpn
         SjF6GbAB7BrEhp1BXSpnm5rfonTQRBvtDqmydGfRfMx7pm3g8ysPHuL+IfE9fwsOYh
         0//HRRr61+sq5p7KUYaKBGRuNvGvl8IhDDNvu1xpnLAgT+5Vth0kDB3eCfTXDdppyx
         7RxZmc++CQKvQ==
Date:   Fri, 23 Sep 2022 09:57:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
Message-ID: <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923064707.GD16489@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > properly review the changes, but one thing immediately jumped out at
> > me when looking at this: why is the LSM hook
> > "security_inode_set_acl()" when we are passing a dentry instead of an
> > inode?  We don't have a lot of them, but there are
> > `security_dentry_*()` LSM hooks in the existing kernel code.
> 
> I'm no LSM expert, but isn't the inode vs dentry for if it is
> related to an inode operation or dentry operation, not about that
> the first argument is?

Indeed. For example,

void security_inode_post_setxattr(struct dentry *dentry, const char *name,
				  const void *value, size_t size, int flags)
{
	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
		return;
	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
	evm_inode_post_setxattr(dentry, name, value, size);
}

int security_inode_getxattr(struct dentry *dentry, const char *name)
{
	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
		return 0;
	return call_int_hook(inode_getxattr, 0, dentry, name);
}

int security_inode_listxattr(struct dentry *dentry)
{
	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
		return 0;
	return call_int_hook(inode_listxattr, 0, dentry);
}
