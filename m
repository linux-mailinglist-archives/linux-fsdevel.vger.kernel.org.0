Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D13A8019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhFONfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbhFONfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623763981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VSN2OS40QTnJllmAJbSh1cIS6wfPXK84jgrGK1B8F+k=;
        b=Jc3k9cWuur+P/qFul2TI7+X9y09I5IryoIrLyFz/FItLIe/YbvNqULm0UVp7A75tAwOUMF
        VrBRMVeNV/8lYnGKhYdK9YRPBDEBBfsM5eFrIwpmOcgr4SsD40w/5FCZZbkK36GGFp953o
        BcaLE33mpexQOzwCilJT89X0LogU//Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-b8iEaStUPEyDpiXD11cNQQ-1; Tue, 15 Jun 2021 09:32:58 -0400
X-MC-Unique: b8iEaStUPEyDpiXD11cNQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5095A101F00F;
        Tue, 15 Jun 2021 13:32:56 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-170.rdu2.redhat.com [10.10.115.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 971195272D;
        Tue, 15 Jun 2021 13:32:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 23AA2220BCF; Tue, 15 Jun 2021 09:32:41 -0400 (EDT)
Date:   Tue, 15 Jun 2021 09:32:41 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
Message-ID: <20210615133241.GA965196@redhat.com>
References: <20200722090758.3221812-1-chirantan@chromium.org>
 <20210614212808.GD869400@redhat.com>
 <CAJFHJrpu9vewcD2er6oB_xwtF4Pc-njkRaA7rfJwsTvw5Fi2og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFHJrpu9vewcD2er6oB_xwtF4Pc-njkRaA7rfJwsTvw5Fi2og@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 06:35:21PM +0900, Chirantan Ekbote wrote:
> Hi Vivek,
> 
> On Tue, Jun 15, 2021 at 6:28 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jul 22, 2020 at 06:07:57PM +0900, Chirantan Ekbote wrote:
> > > Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> > > fuse_init_out struct.  When this flag is set the kernel will append the
> > > security context for a newly created inode to the request (create,
> > > mkdir, mknod, and symlink).  The server is responsible for ensuring that
> > > the inode appears atomically with the requested security context.
> > >
> > > For example, if the server is backed by a "real" linux file system then
> > > it can write the security context value to
> > > /proc/thread-self/attr/fscreate before making the syscall to create the
> > > inode.
> > >
> > > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> >
> > Hi Chirantan,
> >
> > I am wondering what's the status of this work now. Looks like it
> > was not merged.
> >
> > We also need the capability to set selinux security xattrs on newly
> > created files in virtiofs.
> >
> > Will you be interested in reviving this work and send patches again
> > and copy the selinux as well as linux security module list
> > (linux-security-module@vger.kernel.org) as suggested by casey.
> >
> 
> Not really.  We have our own local solution for this (see below) so if
> you or someone else wants to pick it up, please go ahead.
> 

Ok.

> > How are you managing in the meantime. Carrying patches in your own
> > kernel?
> >
> 
> Kind of. This patch series changes the protocol and the feature bit we
> were using was claimed by FUSE_SUBMOUNTS instead so carrying it
> locally is not really viable long term.  Instead we're carrying a
> patch similar to the original RFC patch that doesn't change the
> protocol [1].

Ok, got it. So you went ahead for simpler solution of setting security
xattr after creating file hence making it non-atomic. But changelog
suggests that it works for your use case as you always do a restorecon
on reboot. 

But I guess upstream will need a solution where file creation and
security xattr setting can be atomic.

Thanks. If time permits, I might look into the patches you had posted.

Thanks
Vivek

