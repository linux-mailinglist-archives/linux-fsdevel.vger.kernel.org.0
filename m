Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6013DE0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhHBUlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhHBUlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:41:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45561C06175F;
        Mon,  2 Aug 2021 13:41:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 304A86C0C; Mon,  2 Aug 2021 16:41:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 304A86C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627936885;
        bh=q/UuuHCbZV3tHIdfne8YVZJEixvdkw4Um1I/o0Jqicg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcfNcaGlpP6lHk2GKC5A2fO2xG/cg+HjALtkJo/TVtEcP0ElO4H+6JV/IP17JHEp6
         ZWEJYj2SrqQQ/yFASOtKqCxEdkHzL11TWT70253S8kAuoXf+guvYScad2rCziLALFF
         rKZ/deGSqCkmXEwi65n7rYZcnM7/l7PPN+qCWZ9o=
Date:   Mon, 2 Aug 2021 16:41:25 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     NeilBrown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
Message-ID: <20210802204125.GE6890@fieldses.org>
References: <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <20210802123930.GA6890@fieldses.org>
 <47101630-9d59-5818-34dd-3755e101fc18@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47101630-9d59-5818-34dd-3755e101fc18@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:32:45PM -0500, Patrick Goetz wrote:
> On 8/2/21 7:39 AM, J. Bruce Fields wrote:
> >On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> >>For btrfs, the "location" is root.objectid ++ file.objectid.  I think
> >>the inode should become (file.objectid ^ swab64(root.objectid)).  This
> >>will provide numbers that are unique until you get very large subvols,
> >>and very many subvols.
> >
> >If you snapshot a filesystem, I'd expect, at least by default, that
> >inodes in the snapshot to stay the same as in the snapshotted
> >filesystem.
> 
> For copy on right systems like ZFS, how could it be otherwise?

I'm reacting to Neil's suggesting above, which (as I understand it)
would result in different inode numbers.

--b.
