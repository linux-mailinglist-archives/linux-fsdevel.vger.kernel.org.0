Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070662A98F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgKFQAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 11:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgKFQAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604678439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnyte+HD5nVWcDfsLMpgif14Xkcr9VPpCQQrMIeJvJQ=;
        b=FYJ50LRSOiOsOg7yy4R6HzfnPKr6JbIQzC1aY7ip9gMeuLhQZoyLeiXKNFVELoD+2sC+5P
        rOrsSR1EtYyADg1JhFBF472BfhLWIFh9/Jgs6qB6LNVUBLmqeP9aRhA7xHQo2XwQq8z6ys
        hBatcIvet862awOYw0i0gIEVFf6/ABM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-c9JScbzoNBWOwNAN8b-KtQ-1; Fri, 06 Nov 2020 11:00:38 -0500
X-MC-Unique: c9JScbzoNBWOwNAN8b-KtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2976C6D580;
        Fri,  6 Nov 2020 16:00:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-167.rdu2.redhat.com [10.10.115.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D297917511;
        Fri,  6 Nov 2020 16:00:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C3F64225FCD; Fri,  6 Nov 2020 11:00:15 -0500 (EST)
Date:   Fri, 6 Nov 2020 11:00:15 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v3 5/6] fuse: Add a flag FUSE_OPEN_KILL_PRIV for open()
 request
Message-ID: <20201106160015.GD1436035@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
 <20201009181512.65496-6-vgoyal@redhat.com>
 <CAJfpegvhK+5-Zze7qZFrXkUkXbN_4M1CpEqyL9Rq9UNOtb2ckg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvhK+5-Zze7qZFrXkUkXbN_4M1CpEqyL9Rq9UNOtb2ckg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 02:55:11PM +0100, Miklos Szeredi wrote:
> On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > With FUSE_HANDLE_KILLPRIV_V2 support, server will need to kill
> > suid/sgid/security.capability on open(O_TRUNC), if server supports
> > FUSE_ATOMIC_O_TRUNC.
> >
> > But server needs to kill suid/sgid only if caller does not have
> > CAP_FSETID. Given server does not have this information, client
> > needs to send this info to server.
> >
> > So add a flag FUSE_OPEN_KILL_PRIV to fuse_open_in request which tells
> > server to kill suid/sgid(only if group execute is set).
> 
> This is needed for FUSE_CREATE as well (which may act as a normal open
> in case the file exists, and no O_EXCL was specified), right?

Hi Miklos,

IIUC, In current code we seem to use FUSE_CREATE only if file does not exist.
If file exists, then we probably will take FUSE_OPEN path.

Are you concerned about future proofing where somebody decides to use
FUSE_CREATE for create + open on a file which exists. If yes, I agree that
patching FUSE_CREATE makes sense.

> 
> I can edit the patch, if you agree.

Please do.

Thanks
Vivek

