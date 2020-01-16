Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8D13D79E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgAPKNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 05:13:49 -0500
Received: from verein.lst.de ([213.95.11.211]:55181 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgAPKNs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:13:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BCCC468B20; Thu, 16 Jan 2020 11:13:44 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:13:44 +0100
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
Message-ID: <20200116101344.GA16435@lst.de>
References: <20200115144839.GA30301@lst.de> <20200115133101.GA28583@lst.de> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <26093.1579098922@warthog.procyon.org.uk> <28755.1579100378@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28755.1579100378@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:59:38PM +0000, David Howells wrote:
> Another thread could be writing to the file at the same time, but not in the
> same block.  That's managed by netfs, most likely based on the pages and page
> flags attached to the netfs inode being cached in this particular file[*].
> 
> What I was more thinking of is that SEEK_HOLE might run past the block of
> interest and into a block that's currently being written and see a partially
> written block.

But that's not a problem given that you know where to search.

> 
> [*] For AFS, this is only true of regular files; dirs and symlinks are cached
>     as monoliths and are there entirely or not at all.
> 
> > > However, SEEK_HOLE doesn't help with the issue of the filesystem 'altering'
> > > the content of the file by adding or removing blocks of zeros.
> > 
> > As does any other method.  If you need that fine grained control you
> > need to track the information yourself.
> 
> So, basically, I can't.  Okay.  I was hoping it might be possible to add an
> ioctl or something to tell filesystems not to do that with particular files.

File systems usually pad zeroes where they have to, typically for
sub-blocksize writes.   Disabling this would break data integrity.
