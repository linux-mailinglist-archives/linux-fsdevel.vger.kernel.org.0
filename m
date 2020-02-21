Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951C6166EAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 06:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgBUFCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 00:02:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46384 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBUFCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:02:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j50Rx-00GAaV-Pv; Fri, 21 Feb 2020 05:02:05 +0000
Date:   Fri, 21 Feb 2020 05:02:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200221050205.GW23230@ZenIV.linux.org.uk>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
 <87wo8rlgml.fsf@mid.deneb.enyo.de>
 <20200221040919.zmsayko3fnbdbmib@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221040919.zmsayko3fnbdbmib@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:09:19PM +1100, Aleksa Sarai wrote:

>  * open(/proc/self/fd/$n) failing with ELOOP might actually be a bug
>    (the error is coming from may_open as though the lookup was done with
>    O_NOFOLLOW) -- the nd_jump_link() jump takes the namei lookup to a
>    the symlink but it looks like the normal link_path_walk et al
>    handling doesn't actually try to continue resolving it. I'll look
>    into this a bit more.

Not a bug.  Neither mount nor symlink traversal applies to destinations
of pure jumps (be it a symlink to "/" or a procfs symlink).  Both are
deliberate and both for very good reasons.  We'd discussed that last
year (and I'm going to cover that on LSF); basically, there's no
good semantics for symlink traversal in such situation.

Again, this is absolutely deliberate.  And for sanity sake, don't bother
with link_path_walk() et.al. state in mainline - see #work.namei or
#work.do_last in vfs.git; I'm going to repost that series tonight or
tomorrow.  The logics is easier to follow there.
