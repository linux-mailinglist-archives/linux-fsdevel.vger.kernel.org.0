Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BB35F46A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351031AbhDNM7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351028AbhDNM7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618405141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghO25gdWYiPi8Hs5tMBOLgC7KmadptV5dHjDSHxwA/o=;
        b=fKOUo94N4oyf9c1Qx02GNpDvgqdB1W5+M2dAXqCSFg2l1mUWP/8bpeirj7NH8AwulPtC2g
        o57FefGuUt44n42zKCpDGFYCjzXCSnUrH1E09sKDpNk2EMrIyzozfO4uEohnmoyYKT9Xo0
        e0U0Gsqynx0rbNyZIw9FEs1H6LGMzJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-InOxrLTmPeK9PlxSFZ1f8g-1; Wed, 14 Apr 2021 08:59:00 -0400
X-MC-Unique: InOxrLTmPeK9PlxSFZ1f8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEAB68030BB;
        Wed, 14 Apr 2021 12:58:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-112.rdu2.redhat.com [10.10.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A2CD5C1B4;
        Wed, 14 Apr 2021 12:58:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DE024220BCF; Wed, 14 Apr 2021 08:58:54 -0400 (EDT)
Date:   Wed, 14 Apr 2021 08:58:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH v2 0/2] fuse: Fix clearing SGID when access ACL is set
Message-ID: <20210414125854.GL1235549@redhat.com>
References: <20210325151823.572089-1-vgoyal@redhat.com>
 <CAJfpegvU9zjT7qV=Rj4ok4kfYz-9BPhjp+xKz9odfSWaFxshyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvU9zjT7qV=Rj4ok4kfYz-9BPhjp+xKz9odfSWaFxshyA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:57:01PM +0200, Miklos Szeredi wrote:
> On Thu, Mar 25, 2021 at 4:19 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> >
> > Hi,
> >
> > This is V2 of the patchset. Posted V1 here.
> >
> > https://lore.kernel.org/linux-fsdevel/20210319195547.427371-1-vgoyal@redhat.com/
> >
> > Changes since V1:
> >
> > - Dropped the helper to determine if SGID should be cleared and open
> >   coded it instead. I will follow up on helper separately in a different
> >   patch series. There are few places already which open code this, so
> >   for now fuse can do the same. Atleast I can make progress on this
> >   and virtiofs can enable ACL support.
> >
> > Luis reported that xfstests generic/375 fails with virtiofs. Little
> > debugging showed that when posix access acl is set that in some
> > cases SGID needs to be cleared and that does not happen with virtiofs.
> >
> > Setting posix access acl can lead to mode change and it can also lead
> > to clear of SGID. fuse relies on file server taking care of all
> > the mode changes. But file server does not have enough information to
> > determine whether SGID should be cleared or not.
> >
> > Hence this patch series add support to send a flag in SETXATTR message
> > to tell server to clear SGID.
> 
> Changed it to have a single extended structure for the request, which
> is how this has always been handled in the fuse API.
> 
> The ABI is unchanged, but you'll need to update the userspace part
> according to the API change.  Otherwise looks good.

Hi Miklos,

Thanks. Patches look good. I will update userspace part and repost.

Vivek

> 
> Applied and pushed to fuse.git#for-next.
> 
> Thanks,
> Miklos
> 

