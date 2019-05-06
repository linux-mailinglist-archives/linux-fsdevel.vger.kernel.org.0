Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B614BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEFO0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 10:26:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58790 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFO0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 10:26:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNeZl-00053N-AN; Mon, 06 May 2019 14:26:41 +0000
Date:   Mon, 6 May 2019 15:26:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
Message-ID: <20190506142641.GD23075@ZenIV.linux.org.uk>
References: <20190505091549.1934-1-amir73il@gmail.com>
 <20190505130528.GA23075@ZenIV.linux.org.uk>
 <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com>
 <20190505134706.GB23075@ZenIV.linux.org.uk>
 <CAOQ4uxhY0WmA7bTHhBXJLery2NmLKb_kGxoQY-hae3CrBA2sXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhY0WmA7bTHhBXJLery2NmLKb_kGxoQY-hae3CrBA2sXQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 03:43:24PM +0300, Amir Goldstein wrote:
> OK. What do you have to say about this statement?
> 
>     Because fsnotify_nameremove() is called from d_delete() with negative
>     or unhashed dentry, d_move() is not expected on this dentry, so it is
>     safe to use d_parent/d_name without take_dentry_name_snapshot().
> 
> I assume it is not correct, but cannot figure out why.
> Under what circumstances is d_move() expected to move an unhashed
> dentry and hash it?

For starters, d_splice_alias() picking an exising alias for given directory
inode.

> My other thought is why is fsnotify_nameremove() in d_delete() and
> not in vfs_unlink()/vfs_rmdir() under parent inode lock like the rest
> of the fsnotify_create/fsnotify_move hooks?
> 
> In what case would we need the fsnotify event that is not coming
> from vfs_unlink()/vfs_rmdir()?

*snort*

You can thank those who whine about notifications on sysfs/devpts/whatnot.
Go talk to them if you wish, but don't ask me to translate what you'll get
into something coherent - I'd never been able to.
