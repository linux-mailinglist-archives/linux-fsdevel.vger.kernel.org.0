Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D18490367
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 09:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiAQIEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 03:04:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40036 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiAQIED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:04:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7582B80E0D;
        Mon, 17 Jan 2022 08:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77F9C36AE3;
        Mon, 17 Jan 2022 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642406641;
        bh=2JCOslLMhe3KWhnV/JB85orDa5Y/1s3SfbLP8qvgU8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKK7QiWToJ3FUFgSeozzMB8De9peOLcm+Z0LBxLm0yXi3KittG4jbOjtoD/8Zqrqg
         mxDMW1UqXAk88r3rjLHZoFDVbavd8F7FNtFrKWdUZfIyXF3mMCrzPFag5yeUY8xAPC
         sYOZd9iOj4u6QjBOakH/11pCMoF6yL2FJit6H+kA=
Date:   Mon, 17 Jan 2022 09:03:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH - resend] devtmpfs regression fix: reconfigure on each
 mount
Message-ID: <YeUi7rqkC99CODU+@kroah.com>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
 <YbexPXpuI8RdOb8q@technoir>
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>
 <Ybik5dWF2w06JQM6@technoir>
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein>
 <164237084692.24166.3761469608708322913@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164237084692.24166.3761469608708322913@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 09:07:26AM +1100, NeilBrown wrote:
> 
> Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> mount options as "remount" options, so it updates the configuration of the
> single super_block on each mount.
> Since that was changed, the mount options used for devtmpfs are ignored.
> This is a regression which affect systemd - which mounts devtmpfs
> with "-o mode=755,size=4m,nr_inodes=1m".
> 
> This patch restores the "remount" effect by calling reconfigure_single()
> 
> Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/base/devtmpfs.c    | 7 +++++++
>  fs/super.c                 | 4 ++--
>  include/linux/fs_context.h | 2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)

Sorry, I thought Al was going to take this as the regression came from
his tree, I should have picked it up earlier.  I'll queue it up after
5.17-rc1 is out.

thanks,

greg k-h
