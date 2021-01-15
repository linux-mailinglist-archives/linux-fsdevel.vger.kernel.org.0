Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1A2F884F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAOWTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:19:10 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:48936 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbhAOWTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:19:10 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id CF493110C30;
        Sat, 16 Jan 2021 09:18:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l0XQH-000Lu8-Pc; Sat, 16 Jan 2021 09:18:25 +1100
Date:   Sat, 16 Jan 2021 09:18:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, tj <tj@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: locking (or LOCKDEP) problem with mark_buffer_dirty()
Message-ID: <20210115221825.GA78965@dread.disaster.area>
References: <330231792.44586135.1610635888053.JavaMail.zimbra@redhat.com>
 <1403463545.44592876.1610637956402.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403463545.44592876.1610637956402.JavaMail.zimbra@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=LUTreo_bbnMX7zBHYQ8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:25:56AM -0500, Bob Peterson wrote:
> Hi Tejun and linux-fsdevel,
> 
> I have a question about function mark_buffer_dirty and LOCKDEP.
> 
> Background: Func mark_buffer_dirty() has a calling sequence that looks kind
> of like this (simplified):
> 
> mark_buffer_dirty()
>    __set_page_dirty()
>       account_page_dirtied()
>          inode_to_wb() which contains:
> #ifdef CONFIG_LOCKDEP
> 	WARN_ON_ONCE(debug_locks &&
> 		     (!lockdep_is_held(&inode->i_lock) &&
> 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
> 		      !lockdep_is_held(&inode->i_wb->list_lock)));
> #endif

inode_to_wb() gets called:

- under the xa_lock from page accounting (such as the above path), 
- under the inode->i_lock from wbc_attach_and_unlock_inode() and
  other places,
- and wb->list_lock is what protects the writeback list that the
  inode is on, so it held whenever the inode is added/removed from a
  writeback list.

Essentially, one of those locks has to be held to keep inode_to_wb()
stable and valid.  The function inode_switch_wbs_work_fn() explains
this in a roundabout way:

.....
         * Grabbing old_wb->list_lock, inode->i_lock and the i_pages lock
         * gives us exclusion against all wb related operations on @inode
         * including IO list manipulations and stat updates.
         */

So, essentially, inode_to_wb() is checking at least one of these
locks is held when it is called.

In the above case, __set_page_dirty() takes the xa_lock before
calling account_page_dirtied(), so the lockdep warning should not
ever fire in this path. It also means that you can't hold the
xa_lock when calling mark_buffer_dirty()....

>    ...
>    __mark_inode_dirty()
>       spin_lock(&inode->i_lock);
>       ...
>       spin_unlock(&inode->i_lock);
>    ...      

__mark_inode_dirty() also takes the wb->list_lock (via
locked_inode_to_wb_and_lock_list() because the inode->i_lock is held
so the lockdep check won't fire). Hence you can't hold the
wb->list_lock when calling mark_buffer_dirty() either.

> The LOCKDEP checks were added with Tejun Heo's 2015 patch, aaa2cacf8184e2a92accb8e443b1608d65f9a13f.
> 
> Since mark_buffer_dirty()'s call to __mark_inode_dirty() locks the inode->i_lock,
> functions must not call mark_buffer_dirty() with inode->i_lock locked: or deadlock.

You can't hold any of those three locks inode_to_wb() checks when calling
mark_buffer_dirty(), nor should you. And, AFAICT,
mark_buffer_dirty() is doing all the right locking, so maybe there's
something else going on here that isn't actually a bug in
mark_buffer_dirty().

> If they're not doing anything with the xarrays or the i_wb list (i.e. holding the
> other two locks), they get these LOCKDEP warnings.
>
> So either:
> (a) the LOCKDEP warnings are not valid in all cases -or-
> (b) mark_buffer_dirty() should be grabbing inode->i_lock at some point like __mark_inode_dirty() does.

> My question is: which is it, a or b? TIA.

c) something else?

Perhaps you've got some other inode->i_lock locking bug, and this is
the first place that happens to notice it? Or perhap lockdep itself
has been broken again?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
