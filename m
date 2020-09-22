Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F62274B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIVVbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgIVVbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600810278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aFvNuPkiP/NuYhPUrI+asp00ueCeU+680DYxuLmpyz4=;
        b=BH5TVKzNEPofB4XI0OJcOwgVHbS/T0HZH/CcMsCGlfsSxr97YCr7tM3pxjXufBSqnUe+sq
        nu99G2MDNERD6dqTuMOYsAxq92fb4QSH9qnbJN56AxXzm6PcJrde6PhfG0gyxd6VBCstAx
        L3VeskVjdb+KaZPXR7+ypB9Da3+bH0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-dirza1uuOr6HBDP6y6rVWQ-1; Tue, 22 Sep 2020 17:31:16 -0400
X-MC-Unique: dirza1uuOr6HBDP6y6rVWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0026A186DD27;
        Tue, 22 Sep 2020 21:31:14 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1DA078822;
        Tue, 22 Sep 2020 21:31:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7D0A1223B13; Tue, 22 Sep 2020 17:31:10 -0400 (EDT)
Date:   Tue, 22 Sep 2020 17:31:10 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v2 4/6] fuse: Kill suid/sgid using ATTR_MODE if it is not
 truncate
Message-ID: <20200922213110.GI57620@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
 <20200916161737.38028-5-vgoyal@redhat.com>
 <CAJfpegsncAteUfTAHAttwyVQmhGoK7FCeO_z+xcB_4QkYZEzsQ@mail.gmail.com>
 <20200922200840.GF57620@redhat.com>
 <CAJfpegs3PO=OH_VDMByibCnQ3d8kZYC2BWvu05DxpdRjMuNjyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs3PO=OH_VDMByibCnQ3d8kZYC2BWvu05DxpdRjMuNjyg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:25:30PM +0200, Miklos Szeredi wrote:
> On Tue, Sep 22, 2020 at 10:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Sep 22, 2020 at 03:56:47PM +0200, Miklos Szeredi wrote:
> > > On Wed, Sep 16, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > > But if this is non-truncate setattr then server will not kill suid/sgid.
> > > > So continue to send ATTR_MODE to kill suid/sgid for non-truncate setattr,
> > > > even if ->handle_killpriv_v2 is enabled.
> > >
> > > Sending ATTR_MODE doesn't make sense, since that is racy.   The
> > > refresh-recalculate makes the race window narrower, but it doesn't
> > > eliminate it.
> >
> > Hi Miklos,
> >
> > Agreed that it does not eliminate that race.
> >
> > >
> > > I think I suggested sending write synchronously if suid/sgid/caps are
> > > set.  Do you see a problem with this?
> >
> > Sorry, I might have missed it. So you are saying that for the case of
> > ->writeback_cache, force a synchronous WRITE if suid/sgid is set. But
> > this will only work if client sees the suid/sgid bits. If client B
> > set the suid/sgid which client A does not see then all the WRITEs
> > will be cached in client A and not clear suid/sgid bits.
> 
> Unless the attributes are invalidated (either by timeout or
> explicitly) there's no way that in that situation the suid/sgid bits
> can be cleared.  That's true of your patch as well.

Right. And that's why I mentioned that handle_killpriv_v2 is not fully
compatible with ->writeback_cache.

> 
> >
> > Also another problem is that if client sees suid/sgid and we make
> > WRITE synchronous, client's suid/sgid attrs are still cached till
> > next refresh (both for ->writeback_cache and non writeback_cache
> > case). So server is clearing suid/sgid bits but client still
> > keeps them cached. I hope none of the code paths end up using
> > this stale value and refresh attrs before using suid/sgid.
> >
> > Shall we refresh attrs after WRITE if suid/sgid is set and client
> > expects it to clear after WRITE finishes to solve this problem. Or
> > this is something which is actually not a real problem and I am
> > overdesigning.
> 
> The fuse_perform_write() path already has the attribute invalidation,
> which will trigger GETATTR from fuse_update_attributes() in the next
> write.

Ok. So if there is any path which potentially can make use of cached
suid/sgid, we just need to make sure fuse_update_attributes() has been
called in that path.

> 
> So I think all that should work fine.

Sounds good. I will give it a try and see if I notice any other issues.

Thanks
Vivek

