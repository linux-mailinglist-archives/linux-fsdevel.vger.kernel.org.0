Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B391BFD31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgD3OK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 10:10:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728853AbgD3OKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588255850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VowfTlmq1HtbuJqEEyd/fBmcNQLXQ23ibDnuiela/aU=;
        b=g+KCFU9kd5E+NS0Unci3QEzLfxOyHSRfZvwXpOQjTbKNSPMgY6e0kBE7RHgg4MpaUgtGCg
        HG8J3oyCO4qRc9Fg9Sm8zdE/7+62NO0gA4jUcqFwWl88v2hubCQk8/IXdsRhfmvZCfntIB
        RBCeoUI0+CXOqLeXtwB3BW+P451dYig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-r_tZDWmPPxqLuajNXMDqzg-1; Thu, 30 Apr 2020 10:10:48 -0400
X-MC-Unique: r_tZDWmPPxqLuajNXMDqzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5B7C801503;
        Thu, 30 Apr 2020 14:10:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D31EC605CF;
        Thu, 30 Apr 2020 14:10:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 50437223620; Thu, 30 Apr 2020 10:10:40 -0400 (EDT)
Date:   Thu, 30 Apr 2020 10:10:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] fuse, virtiofs: Do not alloc/install fuse device in
 fuse_fill_super_common()
Message-ID: <20200430141040.GB260081@redhat.com>
References: <20200427180354.GD146096@redhat.com>
 <CAJfpegunz80iFEvW=OhFHuHe4Zyb3isDBZKqCcLLGcRZp1PVmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegunz80iFEvW=OhFHuHe4Zyb3isDBZKqCcLLGcRZp1PVmg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:58:42AM +0200, Miklos Szeredi wrote:
> On Mon, Apr 27, 2020 at 8:04 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > As of now fuse_fill_super_common() allocates and installs one fuse device.
> > Filesystems like virtiofs can have more than one filesystem queues and
> > can have one fuse device per queue. Given, fuse_fill_super_common() only
> > handles one device, virtiofs allocates and installes fuse devices for
> > all queues except one.
> >
> > This makes logic little twisted and hard to understand. It probably
> > is better to not do any device allocation/installation in
> > fuse_fill_super_common() and let caller take care of it instead.
> 
> I don't have the details about the fuse super block setup in my head,
> but leaving the fuse_dev_alloc_install() call inside
> fuse_fill_super_common() and adding new
> fuse_dev_alloc()/fuse_dev_install() calls looks highly suspicious.

Good catch. My bad. I forgot to remove that fuse_dev_alloc_install() call
from fuse_fill_super_common(). I tested it and it worked. So I guess I just
ended up installing extra fud device in fc which was never used.

I will fix this and post V2 of the patch.

Thanks
Vivek

