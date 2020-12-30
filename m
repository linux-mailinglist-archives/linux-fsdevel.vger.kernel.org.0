Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8A82E7C34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3UFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 15:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 15:05:35 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22AC061573;
        Wed, 30 Dec 2020 12:04:55 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuhiD-005WfQ-Tp; Wed, 30 Dec 2020 20:04:50 +0000
Date:   Wed, 30 Dec 2020 20:04:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix: second lock in function d_prune_aliases().
Message-ID: <20201230200449.GF3579531@ZenIV.linux.org.uk>
References: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 30, 2020 at 03:01:25PM +0800, YANG LI wrote:
> Goto statement jumping will cause lock to be executed again without
> executing unlock, placing the lock statement in front of goto
> label to fix this problem.
> 
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci <abaci@linux.alibaba.com>

I am sorry, but have you even attempted to trigger that codepath?
Just to test your patch...

FWIW, the patch is completely broken.  Obviously so, since you
have dput() done just before goto restart and dput() in very
much capable of blocking.  It should never be called with spinlocks
held.  And if you look at __dentry_kill() (well, dentry_unlink_inode()
called by __dentry_kill()), you will see that it bloody well *DOES*
drop inode->i_lock.

NAK.
