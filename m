Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD06AF2DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 00:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfIJWRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 18:17:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53222 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfIJWRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 18:17:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i7oSI-0006Op-4O; Tue, 10 Sep 2019 22:17:46 +0000
Date:   Tue, 10 Sep 2019 23:17:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        renxudong1@huawei.com, Hou Tao <houtao1@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190910221746.GJ1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910215357.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:53:57PM +0100, Al Viro wrote:

> * we might need to grab dentry reference around dir_emit() in dcache_readdir().
> As it is, devpts makes it very easy to fuck that one up.

FWIW, that goes back to commit 8ead9dd54716 (devpts: more pty driver interface
cleanups) three years ago.  Rule of the thumb: whenever you write "no actual
semantic changes" in commit message, you are summoning Murphy...

> * it might make sense to turn next_positive() into "try to walk that much,
> return a pinned dentry, drop the original one, report how much we'd walked".
> That would allow to bring ->d_lock back and short-term it might be the best
> solution.  IOW,
> int next_positive(parent, from, count, dentry)
> 	grab ->d_lock
> 	walk the list, decrementing count on hashed positive ones
> 		 if we see need_resched
> 			 break
> 	if we hadn't reached the end, grab whatever we'd reached
> 	drop ->d_lock
> 	dput(*dentry)
> 	if need_resched
> 		schedule
> 	*dentry = whatever we'd grabbed or NULL
> 	return count;
> 
> The callers would use that sucker in a loop - readdir would just need to
> initialize next to NULL and do
>         while (next_positive(dentry, p, 1, &next), next != NULL) {
> in the loop, with dput(next) in the very end.  And lseek would do
> 				to = NULL;
> 				p = &dentry->d_subdirs;
> 				do {
> 					n = next_positive(dentry, p, n, &to);
> 					if (!to)
> 						break;
> 					p = &to->d_child;
> 				} while (n);
> 				move_cursor(cursor, to ? p : NULL);
> 				dput(to);
> instead of
> 				to = next_positive(dentry, &dentry->d_subdirs, n);
> 				move_cursor(cursor, to ? &to->d_child : NULL);
> 
> Longer term I would really like to get rid of ->d_lock in that thing,
> but it's much too late in this cycle for that.
