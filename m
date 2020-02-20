Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCE165DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBTM7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 07:59:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52867 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727553AbgBTM7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582203540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgoZ/r5nCvlwSEe4sHdp4x/cyogCcgRFAVbQihojpxY=;
        b=awxpTPwWKLB3Y37/DSIHdCjT36P9RtN3UsvMy5Ov587uD0Zstend/nH10T7Ls/xSEoHCST
        y0hPkhk6M0DvCVuliJkVmwit+rIDq/2Z+CR7Jw+T3J2FHGwDO6Rbkoe9qM6svNCylIscfp
        HC/bgQgfxeozLG14IswkjSLFSBbRK0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-FXF-0yCqM0yQB_kg1T-nig-1; Thu, 20 Feb 2020 07:58:56 -0500
X-MC-Unique: FXF-0yCqM0yQB_kg1T-nig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2FC107ACC4;
        Thu, 20 Feb 2020 12:58:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 932855C13C;
        Thu, 20 Feb 2020 12:58:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com>
References: <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/19] afs: Support fsinfo() [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <628198.1582203532.1@warthog.procyon.org.uk>
Date:   Thu, 20 Feb 2020 12:58:52 +0000
Message-ID: <628199.1582203532@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> Ewww. So basically, having one static set of .fsinfo_attributes is not
> sufficiently flexible for everyone, but instead of allowing the
> filesystem to dynamically provide a list of supported attributes, you
> just duplicate the super_operations? Seems to me like it'd be cleaner
> to add a function pointer to the super_operations that can dynamically
> fill out the supported fsinfo attributes.
>
> It seems to me like the current API is going to be a dead end if you
> ever want to have decent passthrough of these things for e.g. FUSE, or
> overlayfs, or VirtFS?

Ummm...

Would it be sufficient to have a function that returns a list of attributes?
Or does it need to be able to call to vfs_do_fsinfo() if it supports an
attribute?

There are two things I want to be able to do:

 (1) Do the buffer wrangling in the core - which means the core needs to see
     the type of the attribute.  That's fine if, say, afs_fsinfo() can call
     vfs_do_fsinfo() with the definition for any attribute it wants to handle
     and, say, return -ENOPKG otherways so that the core can then fall back to
     its private list.

 (2) Be able to retrieve the list of attributes and/or query an attribute.
     Now, I can probably manage this even through the same interface.  If,
     say, seeing FSINFO_ATTR_FSINFO_ATTRIBUTES causes the handler to simply
     append on the IDs of its own supported attributes (a helper can be
     provided for that).

     If it sees FSINFO_ATR_FSINFO_ATTRIBUTE_INFO, it can just look to see if
     it has the attribute with the ID matching Nth and return that, else
     ENOPKG - again a helper could be provided.

Chaining through overlayfs gets tricky.  You end up with multiple contributory
filesystems with different properties - and any one of those layers could
perhaps be another overlay.  Overlayfs would probably needs to integrate the
info and derive the lowest common set.

David

