Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1016DFFBF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 23:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQWYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 17:24:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46212 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfKQWYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:24:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWSxy-0007bC-8I; Sun, 17 Nov 2019 22:24:22 +0000
Date:   Sun, 17 Nov 2019 22:24:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191117222422.GA26872@ZenIV.linux.org.uk>
References: <20191115083813.65f5523c@gandalf.local.home>
 <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
 <20191115175423.GS26530@ZenIV.linux.org.uk>
 <20191115184209.GT26530@ZenIV.linux.org.uk>
 <20191115194138.GU26530@ZenIV.linux.org.uk>
 <20191115211820.GV26530@ZenIV.linux.org.uk>
 <20191115162609.2d26d498@gandalf.local.home>
 <20191115221037.GW26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115221037.GW26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:10:37PM +0000, Al Viro wrote:

> I'll probably throw that into #next.dcache - if nothing else,
> that cuts down on the size of patch converting d_subdirs/d_child
> from list to hlist...
> 
> Need to get some sleep first, though - only 5 hours today, so
> I want to take another look at that thing tomorrow morning -
> I don't trust my ability to spot obvious bugs right now... ;-/
> 
> Oh, well - that at least might finally push the old "kernel-side
> rm -rf done right" pile of half-baked patches into more useful
> state, probably superseding most of them.

	Curious...  Is there any point keeping debugfs_remove() and
debugfs_remove_recursive() separate?   The thing is, the only case
when their behaviours differ is when the victim is non-empty.  In that
case the former quietly does nothing; the latter (also quietly) removes
the entire subtree.  And the caller has no way to tell if that case has
happened - they can't even look at the dentry they'd passed, since
in the normal case it's already pointing to freed (and possibly reused)
memory by that point.

	The same goes for tracefs, except that there we have only
one caller of tracefs_remove(), and it's guaranteed to be a non-directory.
So there we definitely can fold them together.

	Greg, could we declare debufs_remove() to be an alias for
debugfs_remove_recursive()?
