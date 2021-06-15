Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED233A8162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFONxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbhFONxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623765069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gSdThyIdMrNQRAlMW4E56JGtME2sOvlbaIEd5yJBHs=;
        b=JZ6RX7bu8D77sPUWuIgUhoINzdyRR+xiElaNmGCqxxN1XqUVJd7bSVCLLznIAUUwmpFt3a
        MEIyj3hwurEuV213IWNmMgP0nRN/GHhkflMzL/oIzrXNhWSsXu7ghtH9U5OdwFvJpvkIGp
        MAmC+I3X7pp7ge8PK29KpfrkMBBQ+SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-6hEdmEA3MCexY0mvFNRFDg-1; Tue, 15 Jun 2021 09:51:07 -0400
X-MC-Unique: 6hEdmEA3MCexY0mvFNRFDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BAE801106;
        Tue, 15 Jun 2021 13:51:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-170.rdu2.redhat.com [10.10.115.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA20760861;
        Tue, 15 Jun 2021 13:50:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 297C4220BCF; Tue, 15 Jun 2021 09:50:57 -0400 (EDT)
Date:   Tue, 15 Jun 2021 09:50:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        dgilbert@redhat.com, v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] init/do_mounts.c: Add root="fstag:<tag>" syntax for root
 device
Message-ID: <20210615135057.GB965196@redhat.com>
References: <20210608153524.GB504497@redhat.com>
 <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
 <20210609154543.GA579806@redhat.com>
 <YMHKZhfT0CUgeLno@stefanha-x1.localdomain>
 <YMHOXn2cpGh1T9vz@codewreck.org>
 <YMXyW0KXc3HqdUAj@codewreck.org>
 <20210614142804.GA869400@redhat.com>
 <YMfi3Q50b1wV+lDW@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMfi3Q50b1wV+lDW@codewreck.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:14:37AM +0900, Dominique Martinet wrote:
> Vivek Goyal wrote on Mon, Jun 14, 2021 at 10:28:04AM -0400:
> > I am not a big fan of nobdev_filesystems array but I really don't feel
> > comfortable opening up this code by default to all filesystems having
> > flag FS_REQUIRES_DEV. Use cases of this code path are not well documented
> > and something somewhere will be broken and called regression.
> > 
> > I think nobdev_filesystems is sort of a misfit. Even mtd, ubi, cifs
> > and nfs are nobdev filesystems but they are not covered by this.
> 
> I think it's fine being able to have these root mounted both ways, then
> eventually removing the old fs-specific options after a period of
> deprecation to have a unique and simple interface.

Sure. And I think v2 of patches where I propose a whitelist of filesystems
should be able to achieve that. Right now I call that tag based
filesystems where tag is directly passed to filesystem. I think
mtd/ubi/cifs/nfs should be able to use that as well and be added to
that whitelist down the line.

> 
> Maybe it's just a bit of a dream big attitude :-)

> 
> > > I'd bite the bullet and use FS_REQUIRES_DEV (and move this part of the
> > > code just a bit below after the root_wait check just in case it matters,
> > 
> > Problem with moving this below root_wait check is that if user boots
> > with root_wait option for virtiofs/9p, it will loop infitely. Reason
> > being that ROOT_DEV=0 and device will never show up.
> 
> Hm, well, then don't use root_wait?! would be my first reaction.
> 
> The reason I suggested to move below would be that there might be
> filesystems which handle both a block device and no block device, and
> for these we wouldn't want to break root_wait which would become kind of
> a switch saying "this really is a block device usecase even if the fs
> doesn't require dev" -- that's also the reason I was mostly optimistic
> even if we make it generic for all filesystems, there'd be this way out
> even if the thing is compiled in.
> 
> 
> Ultimately if we go through the explicit whitelist that's not required
> anyway, and in that case it's probably better to check before as you've
> said.

Yes, current whitelist based approach will not allow to have both
block devices as well as tag/non-block based root devices. Are there
any examples where we current filesystems support such things. And
can filesystem deal with it instead?

If this becomes a requirement, then we will have to go back to my
previous proposal of "root=fstag=<tag>" instead. That way "root=<foo>"
will be interpreted as block device while "root=fstag=<foo>" explicitly
says its some kind of tag (and not a block device).

> 
> 
> > I am assuming that for out use cases, device will need to be present
> > at the time of boot. We can't have a notion of waiting for device to
> > show up.
> > 
> > > but at that point if something would mount with /dev/root but not with
> > > the raw root=argument then they probably do require a device!)
> > > 
> > > It could also be gated by a config option like e.g. CONFIG_ROOT_NFS and
> > > others all are to make sure it doesn't impact anyone who doesn't want to
> > > be impacted - I'm sure some people want to make sure their device
> > > doesn't boot off a weird root if someone manages to change kernel params
> > > so would want a way of disabling the option...
> > 
> > I guess I could do that. Given more than one filesystem will use this
> > option (virtiofs and 9p to begin with), so we will have to have a 
> > config option name which is little more generic and not filesystem
> > specific like CONFIG_ROOT_NFS or CONFIG_ROOT_CIFS.
> 
> Well there's the builtin check you added, and there's the ability to
> root boot from it that's historically always been separated.
> 
> The builtin checks you added actually doesn't matter all that much to
> me. I mean, it'll pass this step, but fail as it cannot mount later
> anyway, and it was an explicit request to have this filesystem in the
> command line: you've changed an error that says "I cannot mount 9p!" to
> "I cannot find root-device!" so it's not really a big deal.
> 
> 
> What I was advocating for is the whole feature being gated by some
> option - my example with an embdedded device having 9p builtin (because
> for some reason they have everything builtin) but not wanting to boot on
> a tcp 9p rootfs still stands even if we're limiting this to a few
> filesystems.
> 
> If you're keeping the idea of tags CONFIG_ROOT_TAGS ?

I thought about it and CONFIG_ROOT_TAGS made less sense because it will
disable all filesystem roots. So say you don't want to boot from 9p
rootfs but are ok booting from virtiofs rootfs, then disablig whole
feature does not allow that.

We probably need to have per filesystem option. Something like CONFIG_ROOT_NFS
and CONFIG_CIFS_ROOT. So may be we need to add CONFIG_ROOT_VIRTIOFS
and COFIG_ROOT_9P_FS to decide wither to include filesystem in whitelist
or not and that will enable/disable boot from root functionality.

I feel that these kind of patches can go in later. Because a user
can boot from 9p or virtiofs rootfs anyway using mtd prefix hack
or using /dev/root as tag hack and adding these options does not
close those paths. So I thought that adding these config
options should not be a strict requirement for this patch series and
these options can be added separately in respective filesystems. WDYT?

Thanks
Vivek

> 
> 
> > > Also, matter-of-factedly, how is this going to be picked up?
> > > Is the plan to send it directly to Linus as part of the next virtiofs
> > > PR? Going through Al Viro?
> > 
> > I was hoping that this patch can be routed through Al Viro.
> 
> Sounds good to me as well - I've upgraded him to To: to get his
> attention.
> (v2 has been sent as "[PATCH v2 0/2] Add support to boot virtiofs and
> 9pfs as rootfs"; I'll review/retest in the next few days)
> 
> -- 
> Dominique
> 

