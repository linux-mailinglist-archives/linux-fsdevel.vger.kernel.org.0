Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53650F1FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbiDZHR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiDZHRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D76E55F;
        Tue, 26 Apr 2022 00:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1552B615BA;
        Tue, 26 Apr 2022 07:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E71EC385A0;
        Tue, 26 Apr 2022 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650957258;
        bh=snQE+Fnly+u9s/Xdxc5lAF+utj8ofy98NL2Z/0H8mOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6pMGTxnv1t7ItIG6tspdoyHb6+LopALZNlFts78F+sx3GBoEcm2DnQvp3I0n38EQ
         LdvFUx6bUcxmfEYKxu2lMemTWFts28Ki1El0zu5+t3QWsHzWlshWgTvSAXxBs1lHvl
         6cyDc/H5YOVyU+E94zJ3alCSDwMprw7A5B2snWVpkMXLmr5+HBcq8m5nyKAZYF8UlD
         Ngnucfkf8aEAzc7BTzosyXeqW5uk2lq5NP8RW0x4gX8MhT7/Vy1HOEY1XP+a+iqZ9N
         ghCLaklBck0me+f/wtaETfIW/5hfbNPGNwCN/Tu3hWSEbB+mwFi4I6W3ucfSpwrxYL
         0eSU6BilKhz/w==
Date:   Tue, 26 Apr 2022 09:14:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v7 4/4] ceph: Remove S_ISGID stripping code in
 ceph_finish_async_create
Message-ID: <20220426071413.75mgcayybdb3cwgw@wittgenstein>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650946792-9545-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650946792-9545-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:19:52PM +0800, Yang Xu wrote:
> Previous patches moved sgid stripping exclusively into the vfs. So
> manual sgid stripping by the filesystem isn't needed anymore.
> 
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Since this is a very sensitive patch series I think we need to be
annoyingly pedantic about the commit messages. This is really only
necessary because of the nature of these changes so you'll forgive me
for being really annoying about this. Here's what I'd change the commit
messages to:

ceph: rely on vfs for setgid stripping

Now that we finished moving setgid stripping for regular files in setgid
directories into the vfs, individual filesystem don't need to manually
strip the setgid bit anymore. Drop the now unneeded code from ceph.


>  fs/ceph/file.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 6c9e837aa1d3..8e3b99853333 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -651,10 +651,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
>  		/* Directories always inherit the setgid bit. */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;

(Frankly, this ideally shouldn't be necessary as well, i.e. it'd be
great if that part would've been done by the vfs already too but it's
not as security sensitive as setgid stripping for regular files.)
