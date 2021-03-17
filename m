Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484B833F632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhCQRBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232650AbhCQRB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616000488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wpyt/V/SL83d7rfSEN24xJ3PtTzDk8RCGWnV2AMlmvs=;
        b=chKp+rP96Dzgcl/zzkMSDFcgzFJIwU0x7CRfN4Wg2lF90bYZnGOsGkXCSn6Ne8U/WzU54v
        2SalmVkl3s77+pE41hV1nxnL8r/Vj2nNELmTYYP6fxikt2M/4rhm2XkJsrelJBVhIE0QQb
        F5GAn+z/DSGmgxPAVXZlWRNZ0gVC0xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-Q52ep2ThPh-TZnGpvxGPfA-1; Wed, 17 Mar 2021 13:01:25 -0400
X-MC-Unique: Q52ep2ThPh-TZnGpvxGPfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8326B88128E;
        Wed, 17 Mar 2021 17:01:23 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-32.rdu2.redhat.com [10.10.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF5B25D6AC;
        Wed, 17 Mar 2021 17:01:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 62B8A220BCF; Wed, 17 Mar 2021 13:01:19 -0400 (EDT)
Date:   Wed, 17 Mar 2021 13:01:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Luis Henriques <lhenriques@suse.de>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 1/1] fuse: send file mode updates using SETATTR
Message-ID: <20210317170119.GE324911@redhat.com>
References: <20210316160147.289193-1-vgoyal@redhat.com>
 <20210316160147.289193-2-vgoyal@redhat.com>
 <CAJfpegtD-6Xt3JDtoOtqJLXeDzVgjfaVJhHU8OQ8Lpw9tu2FzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtD-6Xt3JDtoOtqJLXeDzVgjfaVJhHU8OQ8Lpw9tu2FzA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:43:35PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 16, 2021 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > If ACL changes, it is possible that file mode permission bits change. As of
> > now fuse client relies on file server to make those changes. But it does
> > not send enough information to server so that it can decide where SGID
> > bit should be cleared or not. Server does not know if caller has CAP_FSETID
> > or not. It also does not know what are caller's group memberships and if any
> > of the groups match file owner group.
> 
> Right.  So what about performing the capability and group membership
> check in the client and sending the result of this check to the
> server?

Hi Miklos,

But that will still be non-atomic, right? I mean server probably will
do setxattr first, then check if SGID was cleared or not, and if it
has not been cleared, then it needs to set the mode.

IOW, we still have two operations (setxattr followed by mode setting).

I had thought about that option. But could not understand what does
it buy us as opposed to guest sending a SETATTR.

> 
> Yes, need to extend fuse_setxattr_in.

Ok.
> 
> There's still a race with uid and gid changing on the underlying
> filesystem, so the attributes need to be refreshed, but I don't think
> that's a big worry.

Yes, attributes will need to be refreshed.

Thanks
Vivek

