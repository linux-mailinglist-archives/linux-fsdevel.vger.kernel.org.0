Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036043FD02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhJ2NHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 09:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232020AbhJ2NHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635512671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbTjEKH7xzceII7P5NIQZwmHGt0n/7o6W1cNFj9np/4=;
        b=Ij3/KDzC9a6tYKaZOjynt/oadXtv6U6InGULav+jYU5/v7syWg9DgI3ZXbhLDeGwbiT2sx
        cB1hesibjUwDo7luL5brc2zIBya3DzUEjfZZng7FnyJNwJGXkUe00WYHICy+Gasw3wqXGy
        TdfIPq9rk+cokMHEF4wcFWa01fK/jJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-p7cba5BQPte293W5sT11xw-1; Fri, 29 Oct 2021 09:04:28 -0400
X-MC-Unique: p7cba5BQPte293W5sT11xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A228066F3;
        Fri, 29 Oct 2021 13:04:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16FEE5DA60;
        Fri, 29 Oct 2021 13:03:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3BDA9220562; Fri, 29 Oct 2021 09:03:52 -0400 (EDT)
Date:   Fri, 29 Oct 2021 09:03:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <YXvxOEbGxqhoG7Ti@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAsV3xp3aeOjaeh@redhat.com>
 <eb0c9711-66cb-bf79-0cf6-c6d6eec5ceea@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0c9711-66cb-bf79-0cf6-c6d6eec5ceea@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 04:33:06PM +0800, JeffleXu wrote:
> 
> 
> On 10/20/21 10:48 PM, Vivek Goyal wrote:
> > On Wed, Oct 20, 2021 at 10:52:38AM +0800, JeffleXu wrote:
> >>
> >>
> >> On 10/18/21 10:10 PM, Vivek Goyal wrote:
> >>> On Mon, Oct 11, 2021 at 11:00:47AM +0800, Jeffle Xu wrote:
> >>>> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> >>>> operate the same which is equivalent to 'always'. To be consistemt with
> >>>> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> >>>> option is specified, the default behaviour is equal to 'inode'.
> >>>
> >>> Hi Jeffle,
> >>>
> >>> I am not sure when  -o "dax=inode"  is used as a default? If user
> >>> specifies, "-o dax" then it is equal to "-o dax=always", otherwise
> >>> user will explicitly specify "-o dax=always/never/inode". So when
> >>> is dax=inode is used as default?
> >>
> >> That means when neither '-o dax' nor '-o dax=always/never/inode' is
> >> specified, it is actually equal to '-o dax=inode', which is also how
> >> per-file DAX on ext4/xfs works.
> >>
> >> This default behaviour for local filesystem, e.g. ext4/xfs, may be
> >> straightforward, since the disk inode will be read into memory during
> >> the inode instantiation, and checking for persistent inode attribute
> >> shall be realatively cheap, except that the default behaviour has
> >> changed from 'dax=never' to 'dax=inode'.
> > 
> > Interesting that ext4/xfs allowed for this behavior change.
> > 
> >>
> >> Come back to virtiofs, when neither '-o dax' nor '-o
> >> dax=always/never/inode' is specified, and it actually behaves as '-o
> >> dax=inode', as long as '-o dax=server/attr' option is not specified for
> >> virtiofsd, virtiofsd will always clear FUSE_ATTR_DAX and thus guest will
> >> always disable DAX. IOWs, the guest virtiofs atually behaves as '-o
> >> dax=never' when neither '-o dax' nor '-o dax=always/never/inode' is
> >> specified, and '-o dax=server/attr' option is not specified for virtiofsd.
> >>
> >> But I'm okay if we need to change the default behaviour for virtiofs.
> > 
> > This is change of behavior from client's perspective. Even if client
> > did not opt-in for DAX, DAX can be enabled based on server's setting.
> > Not that there is anything wrong with it, but change of behavior part
> > concerns me.
> > 
> > In case of virtiofs, lot of features we are controlling from server.
> > Client typically just calls "mount" and there are not many options
> > users can specify for mount.  
> > 
> > Given we already allowed to make client a choice about DAX behavior,
> > I will feel more comfortable that we don't change it and let client
> > request a specific DAX mode and if client does not specify anything,
> > then DAX is not enabled.
> > 
> 
> Hi Vivek,
> 
> How about the following design about the default behavior to move this
> patchset forward, considering the discussion on another thread [1]?
> 
> - guest side: '-o dax=inode' acts as the default, keeping consistent
> with xfs/ext4

This sounds good.

> - virtiofsd: the default behavior is like, neither file size based
> policy ('dax=server') nor persistent inode flags based policy
> ('dax=attr') is used, though virtiofsd indeed advertises that
> it supports per inode DAX feature (so that it won't fail FUSE_INIT
> negotiation phase when guest advertises dax=inode by default)... In
> fact, it acts like 'dax=never' in this case.

Not sure why virtiofsd needs to advertise that it supports per inode
DAX even if no per inode dax policy is in affect. Guest will know that
server is not supporting per inode DAX. But it will not return an
error to user space (because dax=inode seems to be advisory).

IOW, this is very similar to the case of using dax=inode on a block
device which does not support DAX. No errors and no warnings.

> 
> Then when guest opts-in and specifies '-o dax=inode' manually, then it
> shall realize that proper configuration for virtiofsd is also needed (-o
> dax=server|attr).

I gave some comments w.r.t dax=server naming in your posting. Not sure if
you got a chance to look at it.

Thanks
Vivek

> 
> [1] https://www.spinics.net/lists/linux-xfs/msg56642.html
> 
> -- 
> Thanks,
> Jeffle
> 

