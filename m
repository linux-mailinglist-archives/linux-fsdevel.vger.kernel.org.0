Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE8230C4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgG1OWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:22:02 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42147 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgG1OWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:22:02 -0400
X-Greylist: delayed 1566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 10:22:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=bLi8O3eJbsokZo71I1/Qz7Qu0cmHpk0FaJ4k5AQd2To=; b=KrEOW34ZbBeJgyc26b6+NlPBoz
        sVdvKlXGefQxYPrMdVsoNkPUWL4Gsx8ZBTDtJK3AdMbp95mmY/QsGVA0VPqb3t6jiopOo9AUNPGqb
        vmqhF+hrI+DEzNGazAghGPdEQ/t1Df5xQ69tEGyqX46T7xbpoK/uQXqltKviZFI7qydoxpUhkIpcZ
        d1ItezA48Hn9hQVbO3/UH74iGCGTx/qBWQ9QSm+ERJj9XKydPvHiMdKBT4wFa/71tFqECSSCEEg19
        tc8aN2JGpRo5RLTB7Edf5jvBktqoRXVD+dAGyISE6wrN2/89xVBXLR+1IDG6iIB0kOaYtI2E+6gZR
        /F8lfNhA==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        linux-fsdevel@vger.kernel.org, stefanha@redhat.com,
        mszeredi@redhat.com, vgoyal@redhat.com, gscrivan@redhat.com,
        dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Date:   Tue, 28 Jul 2020 15:55:51 +0200
Message-ID: <2071310.X8v6e1yvPo@silver>
In-Reply-To: <20200728150859.0ad6ea79@bahia.lan>
References: <20200728105503.GE2699@work-vm> <20200728150859.0ad6ea79@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Dienstag, 28. Juli 2020 15:08:59 CEST Greg Kurz wrote:
> On Tue, 28 Jul 2020 11:55:03 +0100
> 
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > Hi,
> > 
> >   Are there any standards for mapping xattr names/classes when
> > 
> > a restricted view of the filesystem needs to think it's root?
> > 
> > e.g. VMs that mount host filesystems, remote filesystems etc and the
> > client kernel tries to set a trusted. or security. xattr and you want
> > to store that on an underlying normal filesystem, but your
> > VM system doesn't want to have CAP_SYS_ADMIN and/or doesn't want to
> > interfere with the real hosts security.
> > 
> > I can see some existing examples:
> >   9p in qemu
> >   
> >      maps system.posix_acl_* to user.virtfs.system.posix_acl_*
> >      
> >           stops the guest accessing any user.virtfs.*

Not that they were remapped, but the 'local' 9pfs fs driver also actively 
interprets:

	user.virtfs.uid
	user.virtfs.gid
	user.virtfs.mode
	user.virtfs.rdev

> >    overlayfs
> >    
> >       uses trusted.overlay.* on upper layer and blocks that from
> >       
> >            clients
> >    
> >    fuse-overlayfs
> >    
> >       uses trusted.overlay.* for compatibiltiy if it has perms,
> >       otherwise falls back to user.fuseoverlayfs.*
> >    
> >    crosvm's virtiofs
> >    
> >       maps "security.sehash" to "user.virtiofs.security.sehash"
> >       and blocks the guest from accessing user.virtiofs.*
> > 
> > Does anyone know of any others?

Well, depends on how large you draw the scope here. For instance Samba has a 
bunch VFS modules which also uses and hence prohibits certain xattrs. For 
instance for supporting (NTFS) alternate data streams (a.k.a. resource forks) 
of Windows clients it uses user.DosStream.*:

https://www.samba.org/samba/docs/current/man-html/vfs_streams_xattr.8.html

as well as "user.DOSATTRIB".

And as macOS heavily relies on resource forks (i.e. macOS doesn't work without 
them), there are a bunch of xattr remappings in the dedicated Apple VFS 
module, like "aapl_*":

https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
https://github.com/samba-team/samba/blob/master/source3/modules/vfs_fruit.c

Best regards,
Christian Schoenebeck


