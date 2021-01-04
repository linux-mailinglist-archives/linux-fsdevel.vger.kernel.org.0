Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A82E9904
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 16:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbhADPlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 10:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbhADPlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609774822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyojpWNSzgtWyJREo2LjY5m6YVWxrpfHvlQARKlxkEw=;
        b=gD4kq5qzAc/dPSdKlX5HxYf/aeOyDC9KEogz4bZ9PF8Tx0asuyLVXzXCvjIDeUzyfW8puL
        4QXf6Pktx4gM/8MP2zaMctBEkW/fc4Xo4+O1Xb8w4aMlhgMcG8Gy36i/DtJq3RPUwdWB8P
        yU5301+SX8IOrLQOm3Jkyq8qWz9mj9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-ZkUzEKOJPZ-_fMl2pDh-tw-1; Mon, 04 Jan 2021 10:40:19 -0500
X-MC-Unique: ZkUzEKOJPZ-_fMl2pDh-tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13B81800D41;
        Mon,  4 Jan 2021 15:40:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336E8271AB;
        Mon,  4 Jan 2021 15:40:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A3AF1220BCF; Mon,  4 Jan 2021 10:40:15 -0500 (EST)
Date:   Mon, 4 Jan 2021 10:40:15 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20210104154015.GA73873@redhat.com>
References: <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com>
 <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:22:07PM +0200, Amir Goldstein wrote:
> > > Since Jeff's patch is minimal, I think that it should be the fix applied
> > > first and proposed for stable (with adaptations for non-volatile overlay).
> >
> > Does stable fix has to be same as mainline fix. IOW, I think atleast in
> > mainline we should first fix it the right way and then think how to fix
> > it for stable. If fixes taken in mainline are not realistic for stable,
> > can we push a different small fix just for stable?
> 
> We can do a lot of things.
> But if we are able to create a series with minimal (and most critical) fixes
> followed by other fixes, it would be easier for everyone involved.

I am not sure this is really critical. writeback error reporting for
overlayfs are broken since the beginning for regular mounts. There is no
notion of these errors being reported to user space. If that did not
create a major issue, then why suddenly volatile mounts make it
a critical issue.

To me we should fix the issue properly which is easy to maintain
down the line and then worry about doing a stable fix if need be.

> 
> >
> > IOW, because we have to push a fix in stable, should not determine
> > what should be problem solution for mainline, IMHO.
> >
> 
> I find in this case there is a correlation between the simplest fix and the
> most relevant fix for stable.
> 
> > The porblem I have with Jeff's fix is that its only works for volatile
> > mounts. While I prefer a solution where syncfs() is fixed both for
> > volatile as well as non-volatile mount and then there is less confusion.
> >
> 
> I proposed a variation on Jeff's patch that covers both cases.
> Sargun is going to work on it.

What's the problem with my patches which fixes syncfs() error reporting
for overlayfs both for volatile and non-volatile mount?

Thanks
Vivek

