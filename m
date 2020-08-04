Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE123B987
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgHDL2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 07:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729789AbgHDL2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596540494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmybgDhXXpa2WIjCmVJUB2t6uD5jZGmRcSvZrNdVdFU=;
        b=YT4QXSoU2UiUpqkMQtKIWCnFrh3e2RXVLvpP8CQf6EdMObeJteoOppWmhujeOOK3XtnEAs
        bqHfbXi9VHQzLOTY9Ai9CHjaLdofIKmNeoYZ+h+L+wWDP730RpH+Lh4IlFdv8QphX5aY/J
        reJPG+2P0sDdSubdNx2a9gGj4K8N6mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-IOvjoFXsOuaBzlCt-KeoKw-1; Tue, 04 Aug 2020 07:28:09 -0400
X-MC-Unique: IOvjoFXsOuaBzlCt-KeoKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBD0193F561;
        Tue,  4 Aug 2020 11:28:08 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A92390E91;
        Tue,  4 Aug 2020 11:28:03 +0000 (UTC)
Date:   Tue, 4 Aug 2020 12:28:01 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200804112801.GA2659@work-vm>
References: <20200728105503.GE2699@work-vm>
 <20200728150859.0ad6ea79@bahia.lan>
 <2071310.X8v6e1yvPo@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2071310.X8v6e1yvPo@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> On Dienstag, 28. Juli 2020 15:08:59 CEST Greg Kurz wrote:
> > On Tue, 28 Jul 2020 11:55:03 +0100
> > 
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > Hi,
> > > 
> > >   Are there any standards for mapping xattr names/classes when
> > > 
> > > a restricted view of the filesystem needs to think it's root?
> > > 
> > > e.g. VMs that mount host filesystems, remote filesystems etc and the
> > > client kernel tries to set a trusted. or security. xattr and you want
> > > to store that on an underlying normal filesystem, but your
> > > VM system doesn't want to have CAP_SYS_ADMIN and/or doesn't want to
> > > interfere with the real hosts security.
> > > 
> > > I can see some existing examples:
> > >   9p in qemu
> > >   
> > >      maps system.posix_acl_* to user.virtfs.system.posix_acl_*
> > >      
> > >           stops the guest accessing any user.virtfs.*
> 
> Not that they were remapped, but the 'local' 9pfs fs driver also actively 
> interprets:
> 
> 	user.virtfs.uid
> 	user.virtfs.gid
> 	user.virtfs.mode
> 	user.virtfs.rdev
> 
> > >    overlayfs
> > >    
> > >       uses trusted.overlay.* on upper layer and blocks that from
> > >       
> > >            clients
> > >    
> > >    fuse-overlayfs
> > >    
> > >       uses trusted.overlay.* for compatibiltiy if it has perms,
> > >       otherwise falls back to user.fuseoverlayfs.*
> > >    
> > >    crosvm's virtiofs
> > >    
> > >       maps "security.sehash" to "user.virtiofs.security.sehash"
> > >       and blocks the guest from accessing user.virtiofs.*
> > > 
> > > Does anyone know of any others?
> 
> Well, depends on how large you draw the scope here. For instance Samba has a 
> bunch VFS modules which also uses and hence prohibits certain xattrs. For 
> instance for supporting (NTFS) alternate data streams (a.k.a. resource forks) 
> of Windows clients it uses user.DosStream.*:
> 
> https://www.samba.org/samba/docs/current/man-html/vfs_streams_xattr.8.html
> 
> as well as "user.DOSATTRIB".
> 
> And as macOS heavily relies on resource forks (i.e. macOS doesn't work without 
> them), there are a bunch of xattr remappings in the dedicated Apple VFS 
> module, like "aapl_*":
> 
> https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
> https://github.com/samba-team/samba/blob/master/source3/modules/vfs_fruit.c

Thanks;  what I've added to virtiofsd at the moment is a generic
remapping thing that lets me add any prefix and block/drop any xattr.

The other samba-ism I found was mvxattr(1) which lets you rename xattr's
ona  directory tree; which is quite useful.

Dave


> Best regards,
> Christian Schoenebeck
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

