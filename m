Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33D242A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHLNe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 09:34:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55419 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHLNeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=+XDbLf/mNp/3qY81Ajxy0LYyiR5ahihDvGXF7OzXih8=; b=gKuMRv7gTg2PROTxJ8h5yTNYtY
        ISDEx+alfS3Kh7gOL9gvA3Dep6sulN+daFh8ptRnHGDcswURcrqemcs7SpogO8qBDsXsqzbr11Z0g
        OepmwX8RcBPn1/CP8ww+btVBhVgtlvmxHoeytPxf/w5nvA3b0JzBUfoac6TprL43oxoLRiy0mrFwb
        l1wuE/o6BoUCUwa9BIuOKtYp1nTVvDJgSSJuJCknuKWOUzdSUgoxbq3L7ZtVlu0PRThnaFgI1AtD9
        mEkcWgHwPOS2jNqMGcCNeNsUjeIxVvKzfzTXB1XBu2eXexStGO5A+zMSqQAOCK8u8YB0ap4sS4C+F
        uSC7BOXg==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Date:   Wed, 12 Aug 2020 15:34:19 +0200
Message-ID: <12480108.dgM6XvcGr8@silver>
In-Reply-To: <20200812111819.GE2810@work-vm>
References: <20200728105503.GE2699@work-vm> <2627251.EZXEZLLarb@silver> <20200812111819.GE2810@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mittwoch, 12. August 2020 13:18:19 CEST Dr. David Alan Gilbert wrote:
> * Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
> > On Dienstag, 4. August 2020 13:28:01 CEST Dr. David Alan Gilbert wrote:
> > > > Well, depends on how large you draw the scope here. For instance Samba
> > > > has
> > > > a bunch VFS modules which also uses and hence prohibits certain
> > > > xattrs.
> > > > For instance for supporting (NTFS) alternate data streams (a.k.a.
> > > > resource forks) of Windows clients it uses user.DosStream.*:
> > > > 
> > > > https://www.samba.org/samba/docs/current/man-html/vfs_streams_xattr.8.
> > > > html
> > > > 
> > > > as well as "user.DOSATTRIB".
> > > > 
> > > > And as macOS heavily relies on resource forks (i.e. macOS doesn't work
> > > > without them), there are a bunch of xattr remappings in the dedicated
> > > > Apple VFS module, like "aapl_*":
> > > > 
> > > > https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
> > > > https://github.com/samba-team/samba/blob/master/source3/modules/vfs_fr
> > > > uit.
> > > > c
> > > 
> > > Thanks;  what I've added to virtiofsd at the moment is a generic
> > > remapping thing that lets me add any prefix and block/drop any xattr.
> > 
> > Right, makes absolutely sense to make it configurable. There are too many
> > use cases for xattrs, and the precise xattr names are often configurable
> > as well, like with the mentioned Samba VFS modules.
> > 
> > > The other samba-ism I found was mvxattr(1) which lets you rename xattr's
> > > ona  directory tree; which is quite useful.
> > 
> > Haven't seen that before, interesting.
> > 
> > BTW, I have plans for adding support for file forks [1] (a.k.a. alternate
> > streams, a.k.a. resource forks) on Linux kernel side, so I will probably
> > come up with an RFC in couple weeks to see whether there would be
> > acceptance for that at all and if yes in which form.
> > 
> > That would open a similar problematic to virtiofsd on the long term, as
> > file forks have a namespace on their own.
> 
> Yeh I'm sure that'll need wiring into lots of things in weird ways!
> I guess the main difference between an extended attribute and a
> file-fork is that you can access the fork using an fd and it feels more
> like a file?

Well, that's a very short reduction of its purpose, but it is a common core 
feature, yes.

xattrs are only suitable for very small data (currently <= 64 kiB on Linux), 
whereas file forks can be as large as any regular file. And yes, forks 
commonly work with fd, so they allow you to do all kinds of I/O operations on 
them. Theoretically though you could even allow to use forks with any other 
function that accepts an fd.

The main issue is that file forks are not in POSIX. So every OS currently has 
its own concept and API, which probably makes a consensus more difficult for 
Linux.

For instance Solaris allows you to set different ownership and permissions on 
forks as well. It does not allow you to create sub-forks though, nor directory 
structures for forks.

On macOS there was (or actually still is) even a quite complex API which 
separated forks into "resource forks" and "data forks", where resource forks 
were typically used as components of an application binary (e.g. menu 
structure, icons, executable binary modules, text and translations). So 
resource forks not only had names, they also had predefined 16-bit type 
identifiers:
https://en.wikipedia.org/wiki/Resource_fork

Best regards,
Christian Schoenebeck


