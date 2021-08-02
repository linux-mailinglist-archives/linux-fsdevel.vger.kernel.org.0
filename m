Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9893DD009
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 07:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhHBFdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 01:33:13 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:60134 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBFdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:33:12 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAQSS-005v4j-Vb; Mon, 02 Aug 2021 05:25:49 +0000
Date:   Mon, 2 Aug 2021 05:25:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
Message-ID: <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162787790940.32159.14588617595952736785@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:

> It think we need to bite-the-bullet and decide that 64bits is not
> enough, and in fact no number of bits will ever be enough.  overlayfs
> makes this clear.

Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
early...

> So I think we need to strongly encourage user-space to start using
> name_to_handle_at() whenever there is a need to test if two things are
> the same.

... and forgetting the inconvenient facts, such as that two different
fhandles may correspond to the same object.

> I accept that I'm proposing some BIG changes here, and they might break
> things.  But btrfs is already broken in various ways.  I think we need a
> goal to work towards which will eventually remove all breakage and still
> have room for expansion.  I think that must include:
> 
> - providing as-unique-as-practical inode numbers across the whole
>   filesystem, and deprecating the internal use of different device
>   numbers.  Make it possible to mount without them ASAP, and aim to
>   make that the default eventually.
> - working with user-space tool/library developers to use
>   name_to_handle_at() to identify inodes, only using st_ino
>   as a fall-back
> - adding filehandles to various /proc etc files as needed, either
>   duplicating lines or duplicating files.  And helping application which
>   use these files to migrate (I would *NOT* change the dev numbers in
>   the current file to report the internal btrfs dev numbers the way that
>   SUSE does.  I would prefer that current breakage could be used to
>   motivate developers towards depending instead on fhandles).
> - exporting subtree (aka subvol) id to user-space, possibly paralleling
>   proj_id in some way, and extending various tools to understand
>   subtrees
> 
> Who's with me??

Cf. "Poe Law"...
