Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7DFDF86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfKON6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfKON6J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:58:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E61C20733;
        Fri, 15 Nov 2019 13:58:07 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:58:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191115085805.008870cb@gandalf.local.home>
In-Reply-To: <20191115134823.GQ26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
        <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
        <20191115032759.GA795729@kroah.com>
        <20191115041243.GN26530@ZenIV.linux.org.uk>
        <20191115072011.GA1203354@kroah.com>
        <20191115131625.GO26530@ZenIV.linux.org.uk>
        <20191115083813.65f5523c@gandalf.local.home>
        <20191115134823.GQ26530@ZenIV.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Nov 2019 13:48:23 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> > BTW, what do you mean by "can debugfs_remove_recursive() rely upon the
> > lack of attempts to create new entries inside the subtree it's trying
> > to kill?"  
> 
> Is it possible for something to call e.g. debugfs_create_dir() (or any
> similar primitive) with parent inside the subtree that has been
> passed to debugfs_remove_recursive() call that is still in progress?
> 
> If debugfs needs to cope with that, debugfs_remove_recursive() needs
> considerably heavier locking, to start with.

I don't know about debugfs, but at least tracefs (which cut and pasted
from debugfs) does not allow that. At least in theory it doesn't allow
that (and if it does, it's a bug in the locking at the higher levels).

And perhaps debugfs shouldn't allow that either. As it is only suppose
to be a light weight way to interact with the kernel, hence the name
"debugfs".

Yu, do you have a test case for the "infinite loop" case?

-- Steve
