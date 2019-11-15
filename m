Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD70FDF42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKONs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:48:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60950 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKONs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:48:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbxX-0001U0-6B; Fri, 15 Nov 2019 13:48:23 +0000
Date:   Fri, 15 Nov 2019 13:48:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115134823.GQ26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
 <20191115131625.GO26530@ZenIV.linux.org.uk>
 <20191115083813.65f5523c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115083813.65f5523c@gandalf.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:38:13AM -0500, Steven Rostedt wrote:
> On Fri, 15 Nov 2019 13:16:25 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > I want to understand the overall situation.  No argument, list_empty()
> > in there is BS, for many reasons.  But I wonder if trying to keep the
> > current structure of the iterator _and_ the use of simple_rmdir()/simple_unlink()
> > is the right approach.
> 
> My guess is that debugfs was written to be as simple as possible.
> Nothing too complex. And in doing so, may have issues as you are
> pointing out. Just a way to allow communications between user space and
> kernel space (as tracefs started out).
> 
> BTW, what do you mean by "can debugfs_remove_recursive() rely upon the
> lack of attempts to create new entries inside the subtree it's trying
> to kill?"

Is it possible for something to call e.g. debugfs_create_dir() (or any
similar primitive) with parent inside the subtree that has been
passed to debugfs_remove_recursive() call that is still in progress?

If debugfs needs to cope with that, debugfs_remove_recursive() needs
considerably heavier locking, to start with.
