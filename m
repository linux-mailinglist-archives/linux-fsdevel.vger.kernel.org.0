Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5747F13B034
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgANRCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 12:02:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42680 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:02:54 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irPac-0087wB-8a; Tue, 14 Jan 2020 17:02:50 +0000
Date:   Tue, 14 Jan 2020 17:02:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
Message-ID: <20200114170250.GA8904@ZenIV.linux.org.uk>
References: <3326.1579019665@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3326.1579019665@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:34:25PM +0000, David Howells wrote:
> With my rewrite of fscache and cachefiles:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> 
> when a file gets invalidated by the server - and, under some circumstances,
> modified locally - I have the cache create a temporary file with vfs_tmpfile()
> that I'd like to just link into place over the old one - but I can't because
> vfs_link() doesn't allow you to do that.  Instead I have to either unlink the
> old one and then link the new one in or create it elsewhere and rename across.
> 
> Would it be possible to make linkat() take a flag, say AT_LINK_REPLACE, that
> causes the target to be replaced and not give EEXIST?  Or make it so that
> rename() can take a tmpfile as the source and replace the target with that.  I
> presume that, either way, this would require journal changes on ext4, xfs and
> btrfs.

Umm...  I don't like the idea of linkat() doing that - you suddenly get new
fun cases to think about (what should happen when the target is a mountpoint,
for starters?) _and_ you would have to add a magical flag to vfs_link() so
that it would know which tests to do.  As for rename...  How would that
work?  AT_EMPTY_PATH for source?  What happens if two threads do that
at the same time?  Should that case be always "create a new link, even
if you've got it by plain lookup somewhere"?  Worse, suppose you do that
to given tmpfile; what should happen to /proc/self/fd/* link to it?  Should
it point to new location, or...?
