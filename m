Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6753713C680
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAOOso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:48:44 -0500
Received: from verein.lst.de ([213.95.11.211]:51328 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOOso (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:48:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C5BC68B20; Wed, 15 Jan 2020 15:48:40 +0100 (CET)
Date:   Wed, 15 Jan 2020 15:48:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200115144839.GA30301@lst.de>
References: <20200115133101.GA28583@lst.de> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <26093.1579098922@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26093.1579098922@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:35:22PM +0000, David Howells wrote:
> > If we can't get that easily it can be emulated using lseek SEEK_DATA /
> > SEEK_HOLE assuming no other thread could be writing to the file, or the
> > raciness doesn't matter.
> 
> Another thread could be writing to the file, and the raciness matters if I
> want to cache the result of calling SEEK_HOLE - though it might be possible
> just to mask it off.

Well, if you have other threads changing the file (writing, punching holes,
truncating, etc) you have lost with any interface that isn't an atomic
give me that data or tell me its a hole.  And even if that if you allow
threads that aren't part of your fscache implementation to do the
modifications you have lost.  If on the other hand they are part of
fscache you should be able to synchronize your threads somehow.

> One problem I have with SEEK_HOLE is that there's no upper bound on it.  Say
> I have a 1GiB cachefile that's completely populated and I want to find out if
> the first byte is present or not.  I call:
> 
> 	end = vfs_llseek(file, SEEK_HOLE, 0);
> 
> It will have to scan the metadata of the entire 1GiB file and will then
> presumably return the EOF position.  Now this might only be a mild irritation
> as I can cache this information for later use, but it does put potentially put
> a performance hiccough in the case of someone only reading the first page or
> so of the file (say the file program).  On the other hand, probably most of
> the files in the cache are likely to be complete - in which case, it's
> probably quite cheap.

At least for XFS all the metadata is read from disk at once anyway,
so you only spend a few more cycles walking through a pretty efficient
in-memory data structure.

> However, SEEK_HOLE doesn't help with the issue of the filesystem 'altering'
> the content of the file by adding or removing blocks of zeros.

As does any other method.  If you need that fine grained control you
need to track the information yourself.
