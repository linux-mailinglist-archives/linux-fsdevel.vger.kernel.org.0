Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5215B16F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgBLT6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:58:08 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:50532 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLT6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:58:08 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1j1y6p-0004qS-00; Wed, 12 Feb 2020 19:55:43 +0000
Date:   Wed, 12 Feb 2020 14:55:43 -0500
From:   Rich Felker <dalias@libc.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212195543.GA1663@brightrain.aerifal.cx>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212195118.GN23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:51:18PM +0000, Al Viro wrote:
> On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:
> 
> > | Further, I've found some inconsistent behavior with ext4: chmod on the
> > | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
> > | on the O_PATH fd succeeds and changes the symlink mode. This is with
> > | 5.4. Cany anyone else confirm this? Is it a problem?
> > 
> > It looks broken to me because fchmod (as an inode-changing operation)
> > is not supposed to work on O_PATH descriptors.
> 
> Why?  O_PATH does have an associated inode just fine; where does
> that "not supposed to" come from?

Indeed, my expectation was that both fchmod and chmod via the magic
symlink succeed, given a new enough kernel for operations on O_PATH
fds to be supported. I'd like to switch to using fstat+fchmod to do
this, and only fallback to /proc on older kernels where O_PATH fds
cause EBADF. But I'm somewhat concerned by the inconsistency between
behavior of the two approaches.

Rich
