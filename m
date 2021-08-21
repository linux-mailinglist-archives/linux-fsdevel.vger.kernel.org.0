Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8316A3F3AE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhHUOL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhHUOL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:11:26 -0400
X-Greylist: delayed 66309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Aug 2021 07:10:47 PDT
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E84C061575;
        Sat, 21 Aug 2021 07:10:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHRhQ-00Egv2-Fg; Sat, 21 Aug 2021 14:10:16 +0000
Date:   Sat, 21 Aug 2021 14:10:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     cgel.zte@gmail.com
Cc:     christian.brauner@ubuntu.com, jamorris@linux.microsoft.com,
        gladkov.alexey@gmail.com, yang.yang29@zte.com.cn, tj@kernel.org,
        paul.gortmaker@windriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: prevent mount proc on same mountpoint in one pid
 namespace
Message-ID: <YSEJSKgwNKqGupt/@zeniv-ca.linux.org.uk>
References: <20210821083105.30336-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821083105.30336-1-yang.yang29@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 21, 2021 at 01:31:05AM -0700, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Patch "proc: allow to mount many instances of proc in one pid namespace"
> aims to mount many instances of proc on different mountpoint, see
> tools/testing/selftests/proc/proc-multiple-procfs.c.
> 
> But there is a side-effects, user can mount many instances of proc on
> the same mountpoint in one pid namespace, which is not allowed before.
> This duplicate mount makes no sense but wastes memory and CPU, and user
> may be confused why kernel allows it.
> 
> The logic of this patch is: when try to mount proc on /mnt, check if
> there is a proc instance mount on /mnt in the same pid namespace. If
> answer is yes, return -EBUSY.
> 
> Since this check can't be done in proc_get_tree(), which call
> get_tree_nodev() and will create new super_block unconditionally.
> And other nodev fs may faces the same case, so add a new hook in
> fs_context_operations.

NAK.  As attack prevention it's worthless (you can just bind-mount
a tmpfs directory between them).  Besides, filesystem does *not*
get to decide where it would be mounted.  Especially since it couldn't
rely upon that, anyway, what with mount --bind possible *after* it had
been initially mounted.
