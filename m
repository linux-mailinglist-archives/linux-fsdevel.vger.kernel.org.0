Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA7FE715
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 22:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKOVSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 16:18:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40574 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfKOVSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:18:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iViyy-0006vh-CA; Fri, 15 Nov 2019 21:18:20 +0000
Date:   Fri, 15 Nov 2019 21:18:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [RFC] simple_recursive_removal()
Message-ID: <20191115211820.GV26530@ZenIV.linux.org.uk>
References: <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
 <20191115131625.GO26530@ZenIV.linux.org.uk>
 <20191115083813.65f5523c@gandalf.local.home>
 <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
 <20191115175423.GS26530@ZenIV.linux.org.uk>
 <20191115184209.GT26530@ZenIV.linux.org.uk>
 <20191115194138.GU26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115194138.GU26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 07:41:38PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2019 at 06:42:09PM +0000, Al Viro wrote:
> > Come to think of that, if we use IS_DEADDIR as "no more additions" marking,
> > that looks like a good candidate for all in-kernel rm -rf on ramfs-style
> > filesystems without cross-directory renames.  This bit in kill_it() above
> >  		if victim is regular
> >  			__debugfs_file_removed(victim)
> > would be an fs-specific callback passed by the caller, turning the whole
> > thing into this:
> 
> Umm...  A bit more than that, actually - the callback would be
> void remove_one(struct dentry *victim)
> {
> 	if (d_is_reg(victim))
> 		__debugfs_file_removed(victim);
> 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> }
> and the caller would do
> 	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
> 	simple_recursive_removal(dentry, remove_one);
> 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);

OK... debugfs and tracefs definitely convert to that; so do, AFAICS,
spufs and selinuxfs, and I wouldn't be surprised if it could be
used in a few more places...  securityfs, almost certainly qibfs,
gadgetfs looks like it could make use of that.  Maybe subrpc
as well, but I'll need to look in details.  configfs won't,
unfortunately...
