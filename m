Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6DFFE9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 07:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfKRGh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 01:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfKRGh6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:37:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E556A20726;
        Mon, 18 Nov 2019 06:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574059076;
        bh=xgIaUo5Wf2fkFFbeeaxEj0+738UZbioePrKM1Q6oZrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3KDVVd+L4ft9oNa2N0w5ZAo+2PDgAImeol8j9fgnhOCq+RIPpY9Vs/FgEH9EtEfe
         E3JYwYvvfrKJ9EZYBDjabY+IG5Pgw281cLm47/HKqYHoMXV+a+6w1aFfincW5aSlEx
         ztqgQHlVp/keu5h9FTvakcP9QXZwpT8qazklwJpQ=
Date:   Mon, 18 Nov 2019 07:37:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191118063753.GA63802@kroah.com>
References: <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
 <20191115175423.GS26530@ZenIV.linux.org.uk>
 <20191115184209.GT26530@ZenIV.linux.org.uk>
 <20191115194138.GU26530@ZenIV.linux.org.uk>
 <20191115211820.GV26530@ZenIV.linux.org.uk>
 <20191115162609.2d26d498@gandalf.local.home>
 <20191115221037.GW26530@ZenIV.linux.org.uk>
 <20191117222422.GA26872@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117222422.GA26872@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 17, 2019 at 10:24:22PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2019 at 10:10:37PM +0000, Al Viro wrote:
> 
> > I'll probably throw that into #next.dcache - if nothing else,
> > that cuts down on the size of patch converting d_subdirs/d_child
> > from list to hlist...
> > 
> > Need to get some sleep first, though - only 5 hours today, so
> > I want to take another look at that thing tomorrow morning -
> > I don't trust my ability to spot obvious bugs right now... ;-/
> > 
> > Oh, well - that at least might finally push the old "kernel-side
> > rm -rf done right" pile of half-baked patches into more useful
> > state, probably superseding most of them.
> 
> 	Curious...  Is there any point keeping debugfs_remove() and
> debugfs_remove_recursive() separate?   The thing is, the only case
> when their behaviours differ is when the victim is non-empty.  In that
> case the former quietly does nothing; the latter (also quietly) removes
> the entire subtree.  And the caller has no way to tell if that case has
> happened - they can't even look at the dentry they'd passed, since
> in the normal case it's already pointing to freed (and possibly reused)
> memory by that point.
> 
> 	The same goes for tracefs, except that there we have only
> one caller of tracefs_remove(), and it's guaranteed to be a non-directory.
> So there we definitely can fold them together.
> 
> 	Greg, could we declare debufs_remove() to be an alias for
> debugfs_remove_recursive()?

Yes, we can do that there's no reason to keep those separate at all.
Especially if it makes things easier overall.

thanks,

greg k-h
