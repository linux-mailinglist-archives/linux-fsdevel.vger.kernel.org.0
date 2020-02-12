Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3D15B1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBLUS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:18:27 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:50546 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgBLUS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:18:27 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1j1ySb-0004um-00; Wed, 12 Feb 2020 20:18:13 +0000
Date:   Wed, 12 Feb 2020 15:18:13 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212201813.GB1663@brightrain.aerifal.cx>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
 <87wo8rlgml.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo8rlgml.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:01:22PM +0100, Florian Weimer wrote:
> * Al Viro:
> 
> > On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:
> >
> >> | Further, I've found some inconsistent behavior with ext4: chmod on the
> >> | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
> >> | on the O_PATH fd succeeds and changes the symlink mode. This is with
> >> | 5.4. Cany anyone else confirm this? Is it a problem?
> >> 
> >> It looks broken to me because fchmod (as an inode-changing operation)
> >> is not supposed to work on O_PATH descriptors.
> >
> > Why?  O_PATH does have an associated inode just fine; where does
> > that "not supposed to" come from?
> 
> It fails on most file systems right now.  I thought that was expected.
> Other system calls (fsetxattr IIRC) do not work on O_PATH descriptors,
> either.  I assumed that an O_PATH descriptor was not intending to
> confer that capability.  Even openat fails.
> 
> Although fchmod does succeed on read-only descriptors, which is a bit
> strange.

That's intentional and as-specified (and matches all historical
practice):

  "The fchmod() function shall be equivalent to chmod() except that
  the file whose permissions are changed is specified by the file
  descriptor fildes."

And chmod is specified as:

  "The application shall ensure that the effective user ID of the
  process matches the owner of the file or the process has appropriate
  privileges in order to do this."

No alternate behavior regarding permissions is specified; ability to
operate on the file does not depend on the open file mode.

Rich
