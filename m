Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05522FEC34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfKPMEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 07:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfKPMEV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:04:21 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4AA5206D3;
        Sat, 16 Nov 2019 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573905859;
        bh=dAjtnLMfO/Nd1pkNrNhg1n5rbr3vsUl0dpG+t3ex+hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1e2AcsJWhmZgIQlWh8lEEiF/jtnkKt0qZVWCnNobpMPoZxXDw1QznepQ9aXWnYkh
         6I9BBfy8/gVVSA7jJ84v5kMx4nSHhdszjlfLYnVt88ApdUNG6DjAy77r3bp5Ollalc
         +Lp7rKGU+khZy4co3bC/fLO8YIhUhSl2hnzj1EEM=
Date:   Sat, 16 Nov 2019 13:04:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191116120416.GA446630@kroah.com>
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
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:10:37PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2019 at 04:26:09PM -0500, Steven Rostedt wrote:
> > On Fri, 15 Nov 2019 21:18:20 +0000
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > OK... debugfs and tracefs definitely convert to that; so do, AFAICS,
> > > spufs and selinuxfs, and I wouldn't be surprised if it could be
> > > used in a few more places...  securityfs, almost certainly qibfs,
> > > gadgetfs looks like it could make use of that.  Maybe subrpc
> > > as well, but I'll need to look in details.  configfs won't,
> > > unfortunately...
> > 
> > Thanks Al for looking into this.
> > 
> > I'll try to test it in tracefs, and see if anything breaks. But
> > probably wont get to it till next week.
> 
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

Thanks for doing this.  Sorry for the delay in getting back to this, was
on a long-haul flight...

Anyway, this looks sane to me.  debugfs "should" not be having a file
added while a directory is being removed at the same time, but I really
can't guarantee that someone is trying to do something crazy like that.
So "heavy" locking is fine with me, this never has to be a "fast"
operation, it's much more important to get it "correct".

thanks,

greg k-h
