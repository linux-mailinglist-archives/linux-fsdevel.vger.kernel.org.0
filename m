Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D62D4BFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 21:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgLIUfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 15:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgLIUfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:35:53 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97DCC0613CF;
        Wed,  9 Dec 2020 12:35:12 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn6Au-0009Lu-Nb; Wed, 09 Dec 2020 20:35:00 +0000
Date:   Wed, 9 Dec 2020 20:35:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: fs/namei.c: Make status likely to be ECHILD in lookup_fast()
Message-ID: <20201209203500.GQ3579531@ZenIV.linux.org.uk>
References: <20201209152403.6d6cf9ba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209152403.6d6cf9ba@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:24:03PM -0500, Steven Rostedt wrote:
> From:  Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Running my yearly branch profiling code, it detected a 100% wrong branch
> condition in name.c for lookup_fast(). The code in question has:
> 
> 		status = d_revalidate(dentry, nd->flags);
> 		if (likely(status > 0))
> 			return dentry;
> 		if (unlazy_child(nd, dentry, seq))
> 			return ERR_PTR(-ECHILD);
> 		if (unlikely(status == -ECHILD))
> 			/* we'd been told to redo it in non-rcu mode */
> 			status = d_revalidate(dentry, nd->flags);
> 
> If the status of the d_revalidate() is greater than zero, then the function
> finishes. Otherwise, if it is an "unlazy_child" it returns with -ECHILD.
> After the above two checks, the status is compared to -ECHILD, as that is
> what is returned if the original d_revalidate() needed to be done in a
> non-rcu mode.
> 
> Especially this path is called in a condition of:
> 
> 	if (nd->flags & LOOKUP_RCU) {
> 
> And most of the d_revalidate() functions have:
> 
> 	if (flags & LOOKUP_RCU)
> 		return -ECHILD;

Umm...  That depends upon the filesystem mix involved; said that, I'd rather
drop that "unlikely"...
