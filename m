Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574745F61CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJFHlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJFHlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60408F940;
        Thu,  6 Oct 2022 00:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABE26186B;
        Thu,  6 Oct 2022 07:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2864AC43470;
        Thu,  6 Oct 2022 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665042059;
        bh=kGenI/jk5ijf8spPWifalIgcDvhyFZb7xm1JyKIXBxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDv83JM/0cQwQvJArwcT1dwOvhvgfxXwx5CpX4p+4AtoU3tqpUzvG0pSO0SMiOujR
         8ZXwUyC6CJE8VN5cxgmU9tgJjqbdJR2DiK8op4CyvflxI7XAnjuaBVSKmV4raC53Xe
         xP+qyAPlTwILOXXydJpZQVzawvztXWV5m10d1+iPnuDkUzsa49zGnBKMY/BfY8FVC4
         0W2w9cXjD9e+woiMu4GPgiHbAY+VCN/76AFTIwRzizKd35hx22pUNB3Q0EBDvDttmg
         eOxMri/dcLiTjFIoQ8qX45J4Qm5BGkUSo2DqeGLbmzjCW5uY8SbMz0qn9pXNunu7Et
         FQp63ijmsZm+w==
Date:   Thu, 6 Oct 2022 09:40:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steve French <smfrench@gmail.com>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
Message-ID: <20221006074054.sif5cjou4edas2mz@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
 <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein>
 <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com>
 <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
 <CAJfpegviBdPx25oLTNHCg661GfMa92NKOadSr=QnaFAhzkkN2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegviBdPx25oLTNHCg661GfMa92NKOadSr=QnaFAhzkkN2Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:31:47AM +0200, Miklos Szeredi wrote:
> On Wed, 5 Oct 2022 at 09:15, Christian Brauner <brauner@kernel.org> wrote:
> 
> > We're just talking about thet fact that
> > {g,s}etxattr(system.posix_acl_{access,default}) work on cifs but
> > getting acls based on inode operations isn't supported. Consequently you
> > can't use the acls for permission checking in the vfs for cifs. If as
> > you say below that's intentional because the client doesn't perform
> > access checks then that's probably fine.
> 
> Now I just need to wrap my head around how this interacts with all the
> uid/gid transformations.

Currently it doesn't because cifs doesn't support idmapped mounts.

> 
> Do these (userns, mnt_userns) even make sense for the case of remotely
> checked permissions?

Namespaces are local concepts. They are relevant for permission checking
and are e.g., used to generate a {g,u}id that may be sent to a server. A
concrete example would be a network filesystems that would change the
ownership of a file and the client calls it's ->setattr() inode
operation. The fs_userns and/or mnt_userns is used to generate a raw
{g,u}id value to be sent to the server (So all netns call from_kuid()
ultimately to send a raw {g,u}id over the wire. The server can then do
whatever additional permission checking it wants based on that {g,u}id.

For acls it's the same. We use the namespaces to generate the raw values
and send them to the server that stores them. Either in the acl uapi
format or if the netfs has a custom format for acls or translate them
into it's own acl format. The server can then use them for permission
checking however it wants. But if the server allows the client to
retrieve them during permission checking in the vfs then we need to
translate that raw format from the server into the proper local format
again at which point the namespaces are relevant again.
I hope that helped.
