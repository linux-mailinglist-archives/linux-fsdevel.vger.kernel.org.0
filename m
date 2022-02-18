Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0FD4BC04B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiBRTbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 14:31:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiBRTbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:31:33 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AA735DD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 11:31:15 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL8yH-002oBd-Er; Fri, 18 Feb 2022 19:31:13 +0000
Date:   Fri, 18 Feb 2022 19:31:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix link vs. rename race
Message-ID: <Yg/0ARYO0d3pa6a4@zeniv-ca.linux.org.uk>
References: <20220218153249.406028-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218153249.406028-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:32:49PM +0100, Miklos Szeredi wrote:
> There has been a longstanding race condition between rename(2) and link(2),
> when those operations are done in parallel:
> 
> 1. Moving a file to an existing target file (eg. mv file target)
> 2. Creating a link from the target file to a third file (eg. ln target
>    link)
> 
> By the time vfs_link() locks the target inode, it might already be unlinked
> by rename.  This results in vfs_link() returning -ENOENT in order to
> prevent linking to already unlinked files.  This check was introduced in
> v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
> deleted file").
> 
> This breaks apparent atomicity of rename(2), which is described in
> standards and the man page:
> 
>     "If newpath already exists, it will be atomically replaced, so that
>      there is no point at which another process attempting to access
>      newpath will find it missing."
> 
> The simplest fix is to exclude renames for the complete link operation.
> 
> This patch introduces a global rw_semaphore that is locked for read in
> rename and for write in link.  To prevent excessive contention, do not take
> the lock in link on the first try.  If the source of the link was found to
> be unlinked, then retry with the lock held.

AFAICS, that deadlocks if lock_rename() is taken in ecryptfs_rename() (with
lock_rename() already taken by its caller) after another thread blocks trying
to take your link_rwsem exclusive.
