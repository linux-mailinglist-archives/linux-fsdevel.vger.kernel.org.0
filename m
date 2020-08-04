Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C809723BB66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHDNv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:51:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52345 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=xA2o7XnhMx6nwHORAB1Loqysa36DaEqLZuL5oD6C+UE=; b=GeY30jXCinuUAsSzG18bzMc0S+
        gROgD09Y+awSPq8K49w8Ch2Cn1mf/CPiuC3DUCTgldN0dQYYQEHJgbcOuKxemz4NjYuRlZ+t43RoM
        mzCSNJbqWf5gXLUQljos0cxO+6OSWVEZef/JHNAy8dzp4o415I1yPYGW8FpN487N4bJQws9PozRUc
        4AcanUdx35s4NxDBHu+PFUYq8nsssUSxpG6lTJQ1xxpGMIoPlwq0b6tzwtdffTaRnd06jFq0uwecY
        +CMMq/9XW92lmPIFb+jp/VWIryhiSNNLv+xtV/pmZDqGtRjZGCFi5n86D+RmjVC6zr+/0e6rGOzuN
        Mk58muQg==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Date:   Tue, 04 Aug 2020 15:51:22 +0200
Message-ID: <2627251.EZXEZLLarb@silver>
In-Reply-To: <20200804112801.GA2659@work-vm>
References: <20200728105503.GE2699@work-vm> <2071310.X8v6e1yvPo@silver> <20200804112801.GA2659@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Dienstag, 4. August 2020 13:28:01 CEST Dr. David Alan Gilbert wrote:
> > Well, depends on how large you draw the scope here. For instance Samba has
> > a bunch VFS modules which also uses and hence prohibits certain xattrs.
> > For instance for supporting (NTFS) alternate data streams (a.k.a.
> > resource forks) of Windows clients it uses user.DosStream.*:
> > 
> > https://www.samba.org/samba/docs/current/man-html/vfs_streams_xattr.8.html
> > 
> > as well as "user.DOSATTRIB".
> > 
> > And as macOS heavily relies on resource forks (i.e. macOS doesn't work
> > without them), there are a bunch of xattr remappings in the dedicated
> > Apple VFS module, like "aapl_*":
> > 
> > https://www.samba.org/samba/docs/current/man-html/vfs_fruit.8.html
> > https://github.com/samba-team/samba/blob/master/source3/modules/vfs_fruit.
> > c
> 
> Thanks;  what I've added to virtiofsd at the moment is a generic
> remapping thing that lets me add any prefix and block/drop any xattr.

Right, makes absolutely sense to make it configurable. There are too many use 
cases for xattrs, and the precise xattr names are often configurable as well, 
like with the mentioned Samba VFS modules.

> The other samba-ism I found was mvxattr(1) which lets you rename xattr's
> ona  directory tree; which is quite useful.

Haven't seen that before, interesting.

BTW, I have plans for adding support for file forks [1] (a.k.a. alternate 
streams, a.k.a. resource forks) on Linux kernel side, so I will probably come 
up with an RFC in couple weeks to see whether there would be acceptance for 
that at all and if yes in which form.

That would open a similar problematic to virtiofsd on the long term, as file 
forks have a namespace on their own.

[1] https://en.wikipedia.org/wiki/Fork_(file_system)

Best regards,
Christian Schoenebeck


