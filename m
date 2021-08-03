Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09E3DE36D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 02:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhHCAP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 20:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHCAP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:15:58 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C609C06175F;
        Mon,  2 Aug 2021 17:15:48 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BE3DC6C0C; Mon,  2 Aug 2021 20:15:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BE3DC6C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1627949746;
        bh=OCGZP64OD91fAUXxmT0Uz7TLHSVGqZUGpiy+xnWtjj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJ0zRQTIUDvRLFx+sJlBSxUhve7zCbgjnCUEEULjslGdiKIzQQlRZGu4Xwp1wBE0j
         rm1/1Ly2Art3ofeGQcfvJhTcDCOl0WzlYcUQPXvKBBjnq345sPO6TTD6y7qhGS2E9d
         pBG6DslqL80STAF0A7v4/udDaPNzsDYPKHpj9OgQ=
Date:   Mon, 2 Aug 2021 20:15:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
Message-ID: <20210803001546.GI6890@fieldses.org>
References: <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <20210802123930.GA6890@fieldses.org>
 <162793864421.32159.6348977485257143426@noble.neil.brown.name>
 <20210802215059.GF6890@fieldses.org>
 <162794157037.32159.9608382458264702109@noble.neil.brown.name>
 <20210802221434.GG6890@fieldses.org>
 <162794380480.32159.709590144894407738@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162794380480.32159.709590144894407738@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:36:44AM +1000, NeilBrown wrote:
> On Tue, 03 Aug 2021, J. Bruce Fields wrote:
> > On Tue, Aug 03, 2021 at 07:59:30AM +1000, NeilBrown wrote:
> > > On Tue, 03 Aug 2021, J. Bruce Fields wrote:
> > > > On Tue, Aug 03, 2021 at 07:10:44AM +1000, NeilBrown wrote:
> > > > > On Mon, 02 Aug 2021, J. Bruce Fields wrote:
> > > > > > On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> > > > > > > For btrfs, the "location" is root.objectid ++ file.objectid.  I think
> > > > > > > the inode should become (file.objectid ^ swab64(root.objectid)).  This
> > > > > > > will provide numbers that are unique until you get very large subvols,
> > > > > > > and very many subvols.
> > > > > > 
> > > > > > If you snapshot a filesystem, I'd expect, at least by default, that
> > > > > > inodes in the snapshot to stay the same as in the snapshotted
> > > > > > filesystem.
> > > > > 
> > > > > As I said: we need to challenge and revise user-space (and meat-space)
> > > > > expectations. 
> > > > 
> > > > The example that came to mind is people that export a snapshot, then
> > > > replace it with an updated snapshot, and expect that to be transparent
> > > > to clients.
> > > > 
> > > > Our client will error out with ESTALE if it notices an inode number
> > > > changed out from under it.
> > > 
> > > Will it?
> > 
> > See fs/nfs/inode.c:nfs_check_inode_attributes():
> > 
> > 	if (nfsi->fileid != fattr->fileid) {
> >                 /* Is this perhaps the mounted-on fileid? */
> >                 if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
> >                     nfsi->fileid == fattr->mounted_on_fileid)
> >                         return 0;
> >                 return -ESTALE;
> >         }
> 
> That code fires if the fileid (inode number) reported for a particular
> filehandle changes.  I'm saying that won't happen.
> 
> If you reflink (aka snaphot) a btrfs subtree (aka "subvol"), then the
> new sub-tree will ALREADY have different filehandles than the original
> subvol.

Whoops, you're right, sorry for the noise....

--b.

> Whether it has the same inode numbers or different ones is
> irrelevant to NFS.

