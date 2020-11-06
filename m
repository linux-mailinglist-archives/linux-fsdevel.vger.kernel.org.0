Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C82A9C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 19:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgKFSlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 13:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgKFSlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604688074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MS5xmnKi0rYuG1NsNuHDpkNNCt1GkSTPVcyLburW0Kg=;
        b=dux58rv6g7QH7kGFuteDWgHQdE+CTiiMpZ8WkPW7tbUPhPkxYX2+EkMYIu1UggPf3xK5ss
        Ui519qqW+Q9W5vAf8GbQq7L4MgpZZN9Zu7gTkzUBdR3cQf0Ys/akxjWbKNk8BDCksnfKX4
        Qp7nROZyXMWnhm0rcJZT1OaeIs1Vwm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-YZ46mYmWNjykQmXSU3V82A-1; Fri, 06 Nov 2020 13:41:12 -0500
X-MC-Unique: YZ46mYmWNjykQmXSU3V82A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA122CE67F;
        Fri,  6 Nov 2020 18:41:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-167.rdu2.redhat.com [10.10.115.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6B226CE52;
        Fri,  6 Nov 2020 18:41:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C6D5B225FCD; Fri,  6 Nov 2020 13:41:03 -0500 (EST)
Date:   Fri, 6 Nov 2020 13:41:03 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v3 5/6] fuse: Add a flag FUSE_OPEN_KILL_PRIV for open()
 request
Message-ID: <20201106184103.GE1436035@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
 <20201009181512.65496-6-vgoyal@redhat.com>
 <CAJfpegvhK+5-Zze7qZFrXkUkXbN_4M1CpEqyL9Rq9UNOtb2ckg@mail.gmail.com>
 <20201106160015.GD1436035@redhat.com>
 <CAJfpeguSoeD9UgEKAz-hxZQhVku93gsv8FUWArv_hMtQEun9Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguSoeD9UgEKAz-hxZQhVku93gsv8FUWArv_hMtQEun9Dw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:33:00PM +0100, Miklos Szeredi wrote:
> On Fri, Nov 6, 2020 at 5:00 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Fri, Nov 06, 2020 at 02:55:11PM +0100, Miklos Szeredi wrote:
> > > On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > With FUSE_HANDLE_KILLPRIV_V2 support, server will need to kill
> > > > suid/sgid/security.capability on open(O_TRUNC), if server supports
> > > > FUSE_ATOMIC_O_TRUNC.
> > > >
> > > > But server needs to kill suid/sgid only if caller does not have
> > > > CAP_FSETID. Given server does not have this information, client
> > > > needs to send this info to server.
> > > >
> > > > So add a flag FUSE_OPEN_KILL_PRIV to fuse_open_in request which tells
> > > > server to kill suid/sgid(only if group execute is set).
> > >
> > > This is needed for FUSE_CREATE as well (which may act as a normal open
> > > in case the file exists, and no O_EXCL was specified), right?
> >
> > Hi Miklos,
> >
> > IIUC, In current code we seem to use FUSE_CREATE only if file does not exist.
> > If file exists, then we probably will take FUSE_OPEN path.
> 
> That's true if the cache is up to date, one important point for
> FUSE_CREATE is that it works atomically even if the cache is stale.
> So if cache is negative and we send a FUSE_CREATE it may still open an
> *existing* file, and we want to do suid/caps clearing in that case
> also, no?

Yes, makes sense. This can happen in a race condition also where
fuse_lookup_name() gets a negative dentry and then another client
creates file (with setuid/setgid/caps) set. Now fuse_create_open()
is called without O_EXCL and in that case we should remove
setuid/setgid/caps as needed. 

So yes, please make modifications accordingly for FUSE_CREATE. If you
want me to do make those changes, please let me know.

Thanks
Vivek

