Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1149036A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiAQIEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 03:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiAQIEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BCC061574;
        Mon, 17 Jan 2022 00:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ABEEB80DBE;
        Mon, 17 Jan 2022 08:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCCFC36AE7;
        Mon, 17 Jan 2022 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642406659;
        bh=OkVmzhLdmQ8xbnnzbn4B18pc9ZEWw8dpbXqplt56tEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGPD9gWQCvAjZhUPrVvrHRDc4Hyx1m6qYZZUJ+aPk1ury9o5D4cdagnAGGTQLsbTC
         gXfjZUDVn775zTC7phdM9CZfH4ax+XL6KuNIWww4b1Hzs7su/9E2H8Db9dzONosa5U
         k1Lo74DwI6wt4anrsabPY8iP8oQFE882+2F7grDU=
Date:   Mon, 17 Jan 2022 09:04:16 +0100
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
Message-ID: <YeUjAIWNCLX9OOj9@kroah.com>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
 <YbexPXpuI8RdOb8q@technoir>
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>
 <Ybik5dWF2w06JQM6@technoir>
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein>
 <164237084692.24166.3761469608708322913@noble.neil.brown.name>
 <YeUi7rqkC99CODU+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeUi7rqkC99CODU+@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 09:03:58AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 17, 2022 at 09:07:26AM +1100, NeilBrown wrote:
> > 
> > Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> > mount options as "remount" options, so it updates the configuration of the
> > single super_block on each mount.
> > Since that was changed, the mount options used for devtmpfs are ignored.
> > This is a regression which affect systemd - which mounts devtmpfs
> > with "-o mode=755,size=4m,nr_inodes=1m".
> > 
> > This patch restores the "remount" effect by calling reconfigure_single()
> > 
> > Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/base/devtmpfs.c    | 7 +++++++
> >  fs/super.c                 | 4 ++--
> >  include/linux/fs_context.h | 2 ++
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> Sorry, I thought Al was going to take this as the regression came from
> his tree, I should have picked it up earlier.  I'll queue it up after
> 5.17-rc1 is out.

Ah, nevermind, Linus just took it.

thanks,

greg k-h
