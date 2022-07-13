Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D99573FAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 00:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiGMWn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGMWn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:43:56 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C041A810
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 15:43:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BA8D010E8040;
        Thu, 14 Jul 2022 08:43:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oBl5C-000Z1y-Vy; Thu, 14 Jul 2022 08:43:51 +1000
Date:   Thu, 14 Jul 2022 08:43:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ansgar.loesser@kom.tu-darmstadt.de
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Message-ID: <20220713224350.GE3600936@dread.disaster.area>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <93f0f713-ac87-a82c-2b47-d73144739e3a@tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93f0f713-ac87-a82c-2b47-d73144739e3a@tu-darmstadt.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62cf4aaa
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=8nJEP1OIZ-IA:10 a=RgO8CyIxsXoA:10 a=NEAV23lmAAAA:8 a=7-415B0cAAAA:8
        a=ZNJ5VpLRhxOUgDbXMNEA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:16:14PM +0200, Ansgar Lößer wrote:
> > > And the inode_permission() check is wrong, but at least it does have
> > > the important check there (ie that FMODE_WRITE one). So doing the
> > > inode_permissions() check at worst just makes it fail too often, but
> > > since it's all a "optimistically dedupe" anyway, that kind of "fail in
> > > odd situations" doesn't really matter.
> > > 
> > > So for allow_file_dedupe(), I'd suggest:
> > > 
> > >   (a) remove the inode_permission() check in allow_file_dedupe()
> > > 
> > >   (b) remove the uid_eq() check for the same reason (if you didn't open
> > > the destination for write, you have no business deduping anything,
> > > even if you're the owner)
> > So we're going to break userspace?
> > https://github.com/markfasheh/duperemove/issues/129
> > 
> 
> I am actually not sure why writability is needed for 'dest' at all. Of
> course, the deduplication might cause a write on the block device or
> underlying storage, but from the abstract fs perspective, neither the data
> nor any metadata can change, regardless of the success of the deduplication.

Metadata is most definitely changed by a dedupe operation. Run
filefrag or FIEMAP before/after and you'll see that the block
mapping for at least the destination file (and maybe the source,
too!) as a result of the dedupe operation.

> The only attribute that might change is the position of the block on the
> blockdevice. Does changing this information require write permissions?

Yes.

The block map is needed to access the user data, hence POSIX
requires modifications to the block map be covered by fdatasync()
persistence guarantees. i.e.  modifying the block map of a
file/inode is most definitely considered a write operation that
needs a post-completion fdatasync/fsync operation to provide
the modification with persistence guarantees.

Indeed, we require write permissions for fallocate() operations that
directly modify the block list but don't change data, too. e.g.
preallocation over a hole, sparsifying a file by punching out data
ranges containing only zeros, etc. These are not changing the user
visible data; they only modify the underlying block map of the
inode. This is exactly the same as dedupe - these operations are not
modifying user visible data, they just modify the index needed to
find the physical location of the user data in the filesystem.

In fact, there's an fallocate() operation called
FALLOC_FL_UNSHARE_RANGE, which is the exact opposite of dedupe - it
takes a shared extent and explicitly breaks the sharing, copying
data and changing the underlying block map of the file to do that.
It doesn't change user visible data, but it most definitely changes
the metadata and the data layout of the file.

So, yeah, operations that directly manipulate the extent layout of
the file (reflink/clone, dedupe, fallocate, etc) are most definitely
modification operations. Always have been, always will be, and
should always require write permissions to have been granted to the
caller...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
