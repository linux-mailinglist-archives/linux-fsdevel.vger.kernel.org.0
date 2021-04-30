Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210CC36FA03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhD3MTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 08:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhD3MTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619785095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFoo+RFhSNZCaYS4vaZHmUV9XYlNWKNVH9g7dlU2Z6g=;
        b=fDQDQ9oXVqNIUBePKzhV/Kzvg/b8z5FgUmzlUFoYhKR6ecGx5S0yqnEN7M/2nRofXvIDWD
        9TnbzNIqOMfT9d9BjK87IbhUkrRbCIxUU/XA4tyW83pWH0KEF/sIR1OrYTyQsrfJ3++Xdk
        tpgZTtBeYm9s52p6T7CC6VpgrOosC6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-y_bAABREPW-S6Zzk2Wddsw-1; Fri, 30 Apr 2021 08:18:13 -0400
X-MC-Unique: y_bAABREPW-S6Zzk2Wddsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2016610CE781;
        Fri, 30 Apr 2021 12:18:12 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-26.rdu2.redhat.com [10.10.114.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFE6719C79;
        Fri, 30 Apr 2021 12:17:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8004322054F; Fri, 30 Apr 2021 08:17:57 -0400 (EDT)
Date:   Fri, 30 Apr 2021 08:17:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Robert Krawitz <rlk@redhat.com>
Subject: Re: [PATCH v2] virtiofs: propagate sync() to file server
Message-ID: <20210430121757.GA1936051@redhat.com>
References: <20210426151011.840459-1-groug@kaod.org>
 <20210427171206.GA1805363@redhat.com>
 <20210427210921.7b01c661@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427210921.7b01c661@bahia.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:09:21PM +0200, Greg Kurz wrote:
[..]
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 54442612c48b..1265ca17620c 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -179,6 +179,9 @@
> > >   *  7.33
> > >   *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
> > >   *  - add FUSE_OPEN_KILL_SUIDGID
> > > + *
> > > + *  7.34
> > > + *  - add FUSE_SYNCFS
> > >   */
> > >  
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -214,7 +217,7 @@
> > >  #define FUSE_KERNEL_VERSION 7
> > >  
> > >  /** Minor version number of this interface */
> > > -#define FUSE_KERNEL_MINOR_VERSION 33
> > > +#define FUSE_KERNEL_MINOR_VERSION 34
> > >  
> > >  /** The node ID of the root inode */
> > >  #define FUSE_ROOT_ID 1
> > > @@ -499,6 +502,7 @@ enum fuse_opcode {
> > >  	FUSE_COPY_FILE_RANGE	= 47,
> > >  	FUSE_SETUPMAPPING	= 48,
> > >  	FUSE_REMOVEMAPPING	= 49,
> > > +	FUSE_SYNCFS		= 50,
> > >  
> > >  	/* CUSE specific operations */
> > >  	CUSE_INIT		= 4096,
> > > @@ -957,4 +961,8 @@ struct fuse_removemapping_one {
> > >  #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
> > >  		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
> > >  
> > > +struct fuse_syncfs_in {
> > > +	uint64_t flags;
> > > +};
> > > +
> > 
> > Hi Greg,
> > 
> > Will it be better if 32bits are for flags and reset 32 are
> > padding and can be used in whatever manner.
> > 
> > struct fuse_syncfs_in {
> > 	uint32_t flags;
> > 	uint32_t padding;
> > };
> > 
> > This will increase the flexibility if we were to send more information
> > in future.
> > 
> > I already see bunch of structures where flags are 32 bit and reset
> > are padding bits. fuse_read_in, fuse_write_in, fuse_rename2_in etc.
> > 
> > Thanks
> > Vivek
> > 
> 
> Yes, it makes sense. I'll wait a few more days and roll out a v3.

Thinking more about it. We are not using any of the fields of this
structure right now. So may be all of it can be padding and no need
to add "flags".

struct fuse_syncfs_in {
	uint64_t padding;
};

Essentially what you have already done  :-). Just rename flags to
padding/unused to make it clear its unused for now.

Vivek

