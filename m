Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043E17B6AB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjJCNiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjJCNiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:38:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659FAD;
        Tue,  3 Oct 2023 06:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DE4C433C8;
        Tue,  3 Oct 2023 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340291;
        bh=NlZyxNkQIumtF9Q9n/tAacWuxbXBIywHbpZoKHCSE+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpp9bM6C4l9kDVx1k4oyStFZWxRMSksjZl716JrVk9Sq+++BVo6NUtXVeR7NfW8V+
         UPobtpwYLj1jZBx4hfamN3KfK5SW4eYwnBZA+VIeKmptvM6mUnGkvje3wrCePSAG/O
         Lsf4wXDhLfqbO4GYvHSasBSPU782q28FIsY2mAvHcb8scEw2lrO/mN06gPJL0710Gi
         Xbc8l4rYEkbjAQoyJKtkIP+GvDiUslFaFI1H1+mVwr+e0SC3X4bEHg8wpxTWV75Q3J
         BrfzBwF24u+MXKQ/kIB69XZpgnG7fyFJ3udmNhf8ZOnIXyj6WrYhtFlWf1zaBzdRTw
         qo5W5OLpkHHfg==
Date:   Tue, 3 Oct 2023 15:38:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface
 function
Message-ID: <20231003-bespielbar-tarnt-c61162656db5@brauner>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
 <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiuQxTDqn4F62ueGf_9f4KC4p7xqRZdwPvL8rEYrCOWbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:22:25PM +0300, Amir Goldstein wrote:
> On Mon, Oct 2, 2023 at 3:57 PM Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >
> > From: Stefan Berger <stefanb@linux.ibm.com>
> >
> > When vfs_getattr_nosec() calls a filesystem's getattr interface function
> > then the 'nosec' should propagate into this function so that
> > vfs_getattr_nosec() can again be called from the filesystem's gettattr
> > rather than vfs_getattr(). The latter would add unnecessary security
> > checks that the initial vfs_getattr_nosec() call wanted to avoid.
> > Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> > with the new getattr_flags parameter to the getattr interface function.
> > In overlayfs and ecryptfs use this flag to determine which one of the
> > two functions to call.
> >
> > In a recent code change introduced to IMA vfs_getattr_nosec() ended up
> > calling vfs_getattr() in overlayfs, which in turn called
> > security_inode_getattr() on an exiting process that did not have
> > current->fs set anymore, which then caused a kernel NULL pointer
> > dereference. With this change the call to security_inode_getattr() can
> > be avoided, thus avoiding the NULL pointer dereference.
> >
> > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Tyler Hicks <code@tyhicks.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Co-developed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Now let's see what vfs maintainers think about this...

Seems fine overall. We kind of need to propagate the knowledge through
the layers. But I don't like that we need something like it...
