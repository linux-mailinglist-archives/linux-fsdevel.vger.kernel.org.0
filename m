Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C01D8CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfJPJmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 05:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfJPJmj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:42:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55EE6B284;
        Wed, 16 Oct 2019 09:42:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 879D61E3BDE; Wed, 16 Oct 2019 11:42:37 +0200 (CEST)
Date:   Wed, 16 Oct 2019 11:42:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191016094237.GE30337@quack2.suse.cz>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
 <20191015073740.GA21550@quack2.suse.cz>
 <c3c6a9df-c4f5-7692-d8c0-3f6605a74ef4@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c6a9df-c4f5-7692-d8c0-3f6605a74ef4@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-10-19 21:36:08, Eric Sandeen wrote:
> On 10/15/19 2:37 AM, Jan Kara wrote:
> > On Mon 14-10-19 16:30:24, Eric Sandeen wrote:
> >> Anything that walks all inodes on sb->s_inodes list without rescheduling
> >> risks softlockups.
> >>
> >> Previous efforts were made in 2 functions, see:
> >>
> >> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> >> ac05fbb inode: don't softlockup when evicting inodes
> >>
> >> but there hasn't been an audit of all walkers, so do that now.  This
> >> also consistently moves the cond_resched() calls to the bottom of each
> >> loop in cases where it already exists.
> >>
> >> One loop remains: remove_dquot_ref(), because I'm not quite sure how
> >> to deal with that one w/o taking the i_lock.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > Thanks Eric. The patch looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> thanks
> 
> > BTW, I suppose you need to add Al to pickup the patch?
> 
> Yeah (cc'd now)
> 
> But it was just pointed out to me that if/when the majority of inodes
> at umount time have i_count == 0, we'll never hit the resched in 
> fsnotify_unmount_inodes() and may still have an issue ...

Yeah, that's a good point. So that loop will need some further tweaking
(like doing iget-iput dance in need_resched() case like in some other
places).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
