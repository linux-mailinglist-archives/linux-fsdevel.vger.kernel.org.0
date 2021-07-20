Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2313D023D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhGTTCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 15:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhGTTCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626810160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZX6jEwOeEdHBQeHLTDnSnVT2DALhakaB/D7jciFUVJo=;
        b=KPgKA18Fps/xKCOOoUd/r11APD14V+Cdyc0dqQcnUxCc314nal5CDZZBo3nac5QFnDlt/f
        TkzeY3qYiDlBUq1GKO/li/szeR6sxwqZyypO3cvyTCkPhzMtVyKXkGdILvuB1BssMT29j9
        yuLrCbLJjWmkFc4J3EFtnBh+3BPoE5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-b7tab7UHNzihncjbNRzdlA-1; Tue, 20 Jul 2021 15:40:34 -0400
X-MC-Unique: b7tab7UHNzihncjbNRzdlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF05B10C1ADC;
        Tue, 20 Jul 2021 19:40:32 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-228.rdu2.redhat.com [10.10.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3549D10016DB;
        Tue, 20 Jul 2021 19:40:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B308F223E70; Tue, 20 Jul 2021 15:40:28 -0400 (EDT)
Date:   Tue, 20 Jul 2021 15:40:28 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPcmrK/XdPiFIisJ@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXHWmiYXMNxxhf7@redhat.com>
 <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f346bf-e08d-3dad-d931-9d7aeb16ad08@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:19:50PM +0800, JeffleXu wrote:
> 
> 
> On 7/20/21 2:41 AM, Vivek Goyal wrote:
> > On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
> >> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> >> this file.
> >>
> >> When the per-file DAX flag changes for an *opened* file, the state of
> >> the file won't be updated until this file is closed and reopened later.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > 
> > [..]
> >> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> index 36ed092227fa..90c9df10d37a 100644
> >> --- a/include/uapi/linux/fuse.h
> >> +++ b/include/uapi/linux/fuse.h
> >> @@ -184,6 +184,9 @@
> >>   *
> >>   *  7.34
> >>   *  - add FUSE_SYNCFS
> >> + *
> >> + *  7.35
> >> + *  - add FUSE_ATTR_DAX
> >>   */
> >>  
> >>  #ifndef _LINUX_FUSE_H
> >> @@ -449,8 +452,10 @@ struct fuse_file_lock {
> >>   * fuse_attr flags
> >>   *
> >>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> >> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
> >>   */
> >>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> >> +#define FUSE_ATTR_DAX		(1 << 1)
> > 
> > Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
> > a separate patch. 
> 
> Got it.
> 
> > 
> > I am not clear on one thing. If we are planning to rely on persistent
> > inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
> > why fuse server needs to communicate the state of that attr using a 
> > flag? Can client directly query it?  I am not sure where at these
> > attrs stored and if fuse protocol currently supports it.
> 
> There are two issues.
> 
> 1. FUSE server side: Algorithm of deciding whether DAX is enabled for a
> file.
> 
> As I previously replied in [1], FUSE server must enable DAX if the
> backend file is flagged with FS_XFLAG_DAX, to make the FS_XFLAG_DAX
> previously set by FUSE client effective.
> 
> But I will argue that FUSE server also has the flexibility of the
> algorithm implementation. Even if guest queries FS_XFLAG_DAX by
> GETFLAGS/FSGETXATTR ioctl, FUSE server can still enable DAX when the
> backend file is not FS_XFLAG_DAX flagged.
> 
> 
> 2. The protocol between server and client.
> 
> extending LOOKUP vs. LOOKUP + GETFLAGS/FSGETXATTR ioctl
> 
> As I said in [1], client can directly query the FS_XFLAG_DAX flag, but
> there will be one more round trip.
> 
> 
> [1]
> https://lore.kernel.org/linux-fsdevel/031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com/T/#m3f3407158b2c028694c85d82d0d6bd0387f4e24e
> 
> > 
> > What about flag STATX_ATTR_DAX. We probably should report that too
> > in stat if we are using dax on the inode?
> > 
> 
> VFS will automatically report STATX_ATTR_DAX if inode is in DAX mode,
> e.g., in vfs_getattr_nosec().

Good to know. Given user will know which files are using dax and 
which ones are not, it is even more important to define semantics
properly. In what cases DAX will be driven by FS_XFLAGS_DAX attr
and in what cases DAX will completely be driven by server.

May be we should divide it in two patch series. First patch series
implements "-o dax=inode" and server follows FS_XFLAGS_DAX attr
and reports during lookup/getattr/..... 

And once that is merged this can be ehanced with "-o dax=server" where
server is free to choose what files dax should be used on. Only if
this is still needed.

Vivek

