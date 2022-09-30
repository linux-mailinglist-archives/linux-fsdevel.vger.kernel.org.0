Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE75F073F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiI3JKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiI3JJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C632DAB;
        Fri, 30 Sep 2022 02:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966CA62294;
        Fri, 30 Sep 2022 09:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA1CC433C1;
        Fri, 30 Sep 2022 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664528994;
        bh=79bgR9VG7tCW3CuM4iqbfedY5No+zeDX0by/MDi4pPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2hTYZc+up7nrCLm0IzfCA32Np9Qyj2kkkXkiDQrxxZ2VhCgtLA6uhWO74Pkrdkb+
         SyFDhNeGVPZebQojm9r0O3/W8fPTQ+qHJpe7tGRlnvUlBamFXdrQ0BiJjr9K3PeTl8
         urvEKcYg4FFH5nvC3tMCtKGMGpSz16APTMA3xYqBZr/oBlfpHDA0ujIKmsAUBEjwuu
         v4w6zmdsCgwnZSFCSO/nSU634gB52ccII4QWbpr2H/Xtm5TtqHOc7kq3WWHrY9xOBO
         EErdpEcFa2jNdsRHq9r9JLUFGJiK/wIHiHh7pevzlmEQqokYTaiS11pm+0piU+FMDO
         4R2/NWJ3AEcOg==
Date:   Fri, 30 Sep 2022 11:09:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:53:05AM +0200, Miklos Szeredi wrote:
> On Thu, 29 Sept 2022 at 17:31, Christian Brauner <brauner@kernel.org> wrote:
> 
> > This adds a new ->get_acl() inode operations which takes a dentry
> > argument which filesystems such as 9p, cifs, and overlayfs can implement
> > to get posix acls.
> 
> This is confusing.   For example overlayfs ends up with two functions
> that are similar, but not quite the same:
> 
>  ovl_get_acl -> ovl_get_acl_path -> vfs_get_acl -> __get_acl(mnt_userns, ...)
> 
>  ovl_get_inode_acl -> get_inode_acl -> __get_acl(&init_user_ns, ...)
> 
> So what's the difference and why do we need both?  If one can retrive
> the acl without dentry, then why do we need the one with the dentry?

The ->get_inode_acl() method is called during generic_permission() and
inode_permission() both of which are called from various filesystems in
their ->permission inode operations. There's no dentry available during
the permission inode operation and there are filesystems like 9p and
cifs that need a dentry.

> If a filesystem cannot implement a get_acl() without a dentry, then
> what will happen to caller's that don't have a dentry?

This happens today for cifs where posix acls can be created and read but
they cannot be used for permission checking where no inode is available.
New filesystems shouldn't have this issue.
