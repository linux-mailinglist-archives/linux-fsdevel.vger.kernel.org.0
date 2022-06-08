Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB36542F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 13:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiFHL1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiFHL1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C541673D1;
        Wed,  8 Jun 2022 04:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35337615B3;
        Wed,  8 Jun 2022 11:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0B3C34116;
        Wed,  8 Jun 2022 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654687653;
        bh=mw/8TTzcVjw2Heammx4s/Kl/78h76VgQk6zFg4QLP4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlFAibnCvGU1+f/+rCYQSyeyXOW0jQAf3vYCJG3DfXUYZInQ2s6gx5FLhQCF/Y/K2
         XqQPblVMpU4oDHt6uMyraFdx8J77OTimMxURh0L93rSDmYWaayZbHkgNbl+FZZQ5np
         V10Un2CYmhO52QU3XYCdDD30hf25xyC8HQca5jqlIEh++sUqua1biWtWQnSbzA9F8c
         3D9BP2yb6WSxk5Qvpsos2Zy/oVoOESAQ4xhogmLsi43jDtEZwP8G/9evFnl4qtf8gD
         1KMcIQqvj/LCWtDip4MIkSxumkP3WCj2sP7RQxZ2BmcaJSs+YEGerBBIqkx3YPl2F1
         J0yiCCDxbJdpA==
Date:   Wed, 8 Jun 2022 13:27:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
Message-ID: <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
References: <20220607153139.35588-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607153139.35588-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian Göttsche wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Support file descriptors obtained via O_PATH for extended attribute
> operations.
> 
> Extended attributes are for example used by SELinux for the security
> context of file objects. To avoid time-of-check-time-of-use issues while
> setting those contexts it is advisable to pin the file in question and
> operate on a file descriptor instead of the path name. This can be
> emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> which might not be mounted e.g. inside of chroots, see[2].
> 
> [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f647376a7233d2ac2d12ca50
> [2]: https://github.com/SELinuxProject/selinux/commit/de285252a1801397306032e070793889c9466845
> 
> Original patch by Miklos Szeredi <mszeredi@redhat.com>
> https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915.11275-6-mszeredi@redhat.com/
> 
> > While this carries a minute risk of someone relying on the property of
> > xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
> > introducing another set of syscalls.
> >
> > Only file->f_path and file->f_inode are accessed in these functions.
> >
> > Current versions return EBADF, hence easy to detect the presense of
> > this feature and fall back in case it's missing.
> 
> CC: linux-api@vger.kernel.org
> CC: linux-man@vger.kernel.org
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

I'd be somewhat fine with getxattr and listxattr but I'm worried that
setxattr/removexattr waters down O_PATH semantics even more. I don't
want O_PATH fds to be useable for operations which are semantically
equivalent to a write.

In sensitive environments such as service management/container runtimes
we often send O_PATH fds around precisely because it is restricted what
they can be used for. I'd prefer to not to plug at this string.
