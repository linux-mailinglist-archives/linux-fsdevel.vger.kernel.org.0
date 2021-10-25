Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0337B439E38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhJYSPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 14:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhJYSPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635185565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8ah838eO3168zIaxLRE0mRw++ffFI0IyCYbQEDnzmQ=;
        b=LC1pxk7c4MjKaabnYaHEhF4msnJs+0KCdxTEVJW4zfRD5105+nC+y/b7GPOOBPdvokbCrm
        yfvsa9GUqMPKL6N26j0Y1nuWoerDy1xLV2TlJ0Gkoqu39YCUyebAKQMdnlBXlENLX1flfY
        lVO56DkAgXBNp9p5U2coVYJKpRL3dbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-mS2K43CTNAO9TG5ZMJi3mQ-1; Mon, 25 Oct 2021 14:12:42 -0400
X-MC-Unique: mS2K43CTNAO9TG5ZMJi3mQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED17180DDED;
        Mon, 25 Oct 2021 18:12:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35FC76FEED;
        Mon, 25 Oct 2021 18:12:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AF3AB22045E; Mon, 25 Oct 2021 14:12:10 -0400 (EDT)
Date:   Mon, 25 Oct 2021 14:12:10 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <YXbzeomdC5cD1xfF@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAzB5sOrFRUzTC5@redhat.com>
 <96956132-fced-5739-d69a-7b424dc65f7c@linux.alibaba.com>
 <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:52:51AM -0700, Ira Weiny wrote:
> On Fri, Oct 22, 2021 at 02:54:03PM +0800, JeffleXu wrote:
> > cc [Ira Weiny], author of per inode DAX on xfs/ext4
> > 
> > On 10/20/21 11:17 PM, Vivek Goyal wrote:
> > > On Wed, Oct 20, 2021 at 10:52:38AM +0800, JeffleXu wrote:
> > >>
> > >>
> > >> On 10/18/21 10:10 PM, Vivek Goyal wrote:
> > >>> On Mon, Oct 11, 2021 at 11:00:47AM +0800, Jeffle Xu wrote:
> > >>>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> > >>>> operate the same which is equivalent to 'always'. To be consistemt with
> > >>>> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> > >>>> option is specified, the default behaviour is equal to 'inode'.
> > >>>
> > >>> Hi Jeffle,
> > >>>
> > >>> I am not sure when  -o "dax=inode"  is used as a default? If user
> > >>> specifies, "-o dax" then it is equal to "-o dax=always", otherwise
> > >>> user will explicitly specify "-o dax=always/never/inode". So when
> > >>> is dax=inode is used as default?
> > >>
> > >> That means when neither '-o dax' nor '-o dax=always/never/inode' is
> > >> specified, it is actually equal to '-o dax=inode', which is also how
> > >> per-file DAX on ext4/xfs works.
> > > 
> 
> It's been a while so I'm fuzzy on the details of the discussions but yes that
> is the way things are now in the code.
> 
> > > [ CC dave chinner] 
> > > 
> > > Is it not change of default behavior for ext4/xfs as well. My
> > > understanding is that prior to this new dax options, "-o dax" enabled
> > > dax on filesystem and if user did not specify it, DAX is disbaled
> > > by default.
> 
> Technically it does change default behavior...  However, NOT in a way which
> breaks anything.  See below.
> 
> > > 
> > > Now after introduction of "-o dax=always/never/inode", if suddenly
> > > "-o dax=inode" became the default if user did not specify anything,
> > > that's change of behavior.
> 
> Technically yes but not in a broken way.
> 
> > >
> > > Is that intentional. If given a choice,
> > > I would rather not change default and ask user to opt-in for
> > > appropriate dax functionality.
> 
> There is no need for this.
> 
> > > 
> > > Dave, you might have thoughts on this. It makes me uncomfortable to
> > > change virtiofs dax default now just because other filesytems did it.
> > > 
> > 
> > I can only find the following discussions about the earliest record on
> > this tri-state mount option:
> > 
> > https://lore.kernel.org/lkml/20200316095509.GA13788@lst.de/
> > https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
> > 
> > 
> > Hi, Ira Weiny,
> > 
> > Do you have any thought on this, i.e. why the default behavior has
> > changed after introduction of per inode dax?
> 
> While this is 'technically' different behavior the end user does not see any
> difference in behavior if they continue without software changes.  Specifically
> specifying nothing continues to operate with all the files on the FS to be
> '_not_ DAX'.  While specifying '-o dax' forces DAX on all files.
> 
> This expands the default behavior in a backwards compatible manner.

This is backward compatible in a sense that if somebody upgrades to new
kernel, things will still be same. 

I think little problematic change is that say I bring in persistent
memory from another system (which has FS_XFLAGS_DAX set on some inodes)
and then mount it without andy of the dax mount options, then per
inode dax will be enabled unexpectedly if I boot with newer kernels
but it will be disable if I mount with older kernels. Do I understand it
right.

> The user
> can now enable DAX on some files.  But this is an opt-in on the part of the
> user of the FS and again does not change with existing software/scripts/etc.

Don't understand this "opt-in" bit. If user mounts an fs without
specifying any of the dax options, then per inode dax will still be
enabled if inode has the correct flag set. So is setting of flag being
considered as opt-in (insted of mount option).

If setting of flag is being considered as opt-in, that probably will not
work very well with virtiofs. Because server can enforce a different
policy for enabling per file dax (instead of FS_XFLAG_DAX).

And given there are two entities here (client and server), I think it
will be good if if we give client a chance as well to decide whether
it wants to enable per file dax or not. I know it can alwasy do 
"dax=never" but it can still be broken if client software remains
same but host/server software is upgraded or commnad line changed.

So for virtiofs, I think better behavior is to continue to not enable
any dax until and unless user opts-in using "-o dax=foo" options.

Thanks
Vivek



> 
> Does that make sense?
> 
> Ira
> 

