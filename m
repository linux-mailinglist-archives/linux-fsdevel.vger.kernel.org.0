Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40382242B67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLOdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgHLOdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597242815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ptz149Dzz4Oa9+r9hICCY5f9CezxQ0mTEhoFjgcr4M=;
        b=OWrsbejdsyiSlNHxUdlBhvU/MZQjr++S/4IQHzjal0rgJOT9t0CaTBJ8zpOyZgZP2AX9sn
        MU2HG/uCWp34mC//PKGLYdopfmJnKwdRmc9HNYVLeSqRd2jmrVjeTYuRLbohDfFlCwzvj4
        p2kLOlGtwgPpzMAETKPEFFqrm9DD+vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-3WZOfEj5Miu7lNt4ix_emQ-1; Wed, 12 Aug 2020 10:33:32 -0400
X-MC-Unique: 3WZOfEj5Miu7lNt4ix_emQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1342C18B9F77;
        Wed, 12 Aug 2020 14:33:31 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE9F5D6BD;
        Wed, 12 Aug 2020 14:33:26 +0000 (UTC)
Date:   Wed, 12 Aug 2020 15:33:23 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200812143323.GF2810@work-vm>
References: <20200728105503.GE2699@work-vm>
 <2627251.EZXEZLLarb@silver>
 <20200812111819.GE2810@work-vm>
 <12480108.dgM6XvcGr8@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12480108.dgM6XvcGr8@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> On Mittwoch, 12. August 2020 13:18:19 CEST Dr. David Alan Gilbert wrote:
> > * Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> > > On Dienstag, 4. August 2020 13:28:01 CEST Dr. David Alan Gilbert wrote:
> > > > > Well, depends on how large you draw the scope here. For instance Samba
> > > > > has
> > > > > a bunch VFS modules which also uses and hence prohibits certain
> > > > > xattrs.
> > > > > For instance for supporting (NTFS) alternate data streams (a.k.a.
> > > > > resource forks) of Windows clients it uses user.DosStream.*:
> > > > > 
> > > > > https://www.samba.org/samba/docs/current/man-html/vfs_streams_xattr.8.
> > > > > html
> > > > > 
> > > > > as well as "user.DOSATTRIB".
> > > > > 
> > > > > And as macOS heavily relies on resource forks (i.e. macOS doesn't work
> > > > > without them), there are a bunch of xattr remappings in the dedicated
> > > > > Apple VFS module, like "aapl_*":
> > > > > 
> > > > > https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
> > > > > https://github.com/samba-team/samba/blob/master/source3/modules/vfs_fr
> > > > > uit.
> > > > > c
> > > > 
> > > > Thanks;  what I've added to virtiofsd at the moment is a generic
> > > > remapping thing that lets me add any prefix and block/drop any xattr.
> > > 
> > > Right, makes absolutely sense to make it configurable. There are too many
> > > use cases for xattrs, and the precise xattr names are often configurable
> > > as well, like with the mentioned Samba VFS modules.
> > > 
> > > > The other samba-ism I found was mvxattr(1) which lets you rename xattr's
> > > > ona  directory tree; which is quite useful.
> > > 
> > > Haven't seen that before, interesting.
> > > 
> > > BTW, I have plans for adding support for file forks [1] (a.k.a. alternate
> > > streams, a.k.a. resource forks) on Linux kernel side, so I will probably
> > > come up with an RFC in couple weeks to see whether there would be
> > > acceptance for that at all and if yes in which form.
> > > 
> > > That would open a similar problematic to virtiofsd on the long term, as
> > > file forks have a namespace on their own.
> > 
> > Yeh I'm sure that'll need wiring into lots of things in weird ways!
> > I guess the main difference between an extended attribute and a
> > file-fork is that you can access the fork using an fd and it feels more
> > like a file?
> 
> Well, that's a very short reduction of its purpose, but it is a common core 
> feature, yes.
> 
> xattrs are only suitable for very small data (currently <= 64 kiB on Linux), 
> whereas file forks can be as large as any regular file. And yes, forks 
> commonly work with fd, so they allow you to do all kinds of I/O operations on 
> them. Theoretically though you could even allow to use forks with any other 
> function that accepts an fd.
> 
> The main issue is that file forks are not in POSIX. So every OS currently has 
> its own concept and API, which probably makes a consensus more difficult for 
> Linux.
> 
> For instance Solaris allows you to set different ownership and permissions on 
> forks as well. It does not allow you to create sub-forks though, nor directory 
> structures for forks.

Yeh that's quite a change in semantics.

> On macOS there was (or actually still is) even a quite complex API which 
> separated forks into "resource forks" and "data forks", where resource forks 
> were typically used as components of an application binary (e.g. menu 
> structure, icons, executable binary modules, text and translations). So 
> resource forks not only had names, they also had predefined 16-bit type 
> identifiers:
> https://en.wikipedia.org/wiki/Resource_fork

Yeh, lots of different ways.

In a way, if you had a way to drop the 64kiB limit on xattr, then you
could have one type of object, but then add new ways of accessing them
as forks.

Dave

> Best regards,
> Christian Schoenebeck
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

