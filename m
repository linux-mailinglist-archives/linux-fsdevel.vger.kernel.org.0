Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A231FBC8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMX0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 18:26:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57250 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfKMX0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:26:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iV21c-0008LC-5T; Wed, 13 Nov 2019 23:26:12 +0000
Date:   Wed, 13 Nov 2019 23:26:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: call fsnotify_sb_delete after evict_inodes
Message-ID: <20191113232612.GG26530@ZenIV.linux.org.uk>
References: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
 <1573159954-27846-3-git-send-email-sandeen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573159954-27846-3-git-send-email-sandeen@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:52:34PM -0600, Eric Sandeen wrote:
> When a filesystem is unmounted, we currently call fsnotify_sb_delete()
> before evict_inodes(), which means that fsnotify_unmount_inodes()
> must iterate over all inodes on the superblock, even though it will
> only act on inodes with a refcount.  This is inefficient and can lead
> to livelocks as it iterates over many unrefcounted inodes.
> 
> However, since fsnotify_sb_delete() and evict_inodes() are working
> on orthogonal sets of inodes (fsnotify_sb_delete() only cares about
> nonzero refcount, and evict_inodes() only cares about zero refcount),
> we can swap the order of the calls.  The fsnotify call will then have
> a much smaller list to walk (any refcounted inodes).
> 
> This should speed things up overall, and avoid livelocks in
> fsnotify_unmount_inodes().

Umm...  The critical part you've omitted here is that at this stage
any final iput() done by fsnotify_sb_delete() (or anybody else,
really) will forcibly evict the sucker there and then.  So it's not
as if any inodes were *added* to the evictable set by
fsnotify_sb_delete() to be picked by evict_inodes() - any candidate
is immediately disposed of.  The crucial point is that SB_ACTIVE
is already cleared by that stage - without that the patch would've
been badly broken.

That aside, both patches look sane.  Could you update the commit
message and resend the second one?
