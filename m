Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4B26C947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIPTGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727406AbgIPRpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600278340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QCINxFkWVxgedVzYoY8U6Uv9PQhmwRnO9P564IMtuQ=;
        b=dVfDEAIAnRiq7Sx9fmHyrhH9b2Pk2sn8tekoHlLQLBcYNr3flkXcwyHDeSizWsPy1zR15m
        u/zbAqp1h8GBXuUaCTEMpVomask8+br17dYqheOYuEIra55OVPDSyDTAKUVariuIji28Z/
        Jfqma02x46r5Pab1nVHE5dRzdrDBM9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-uwVgt0fYOxqv9rj6QBCJaw-1; Wed, 16 Sep 2020 12:38:45 -0400
X-MC-Unique: uwVgt0fYOxqv9rj6QBCJaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7744D64085;
        Wed, 16 Sep 2020 16:38:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5504375148;
        Wed, 16 Sep 2020 16:38:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EF3492209FD; Wed, 16 Sep 2020 12:38:40 -0400 (EDT)
Date:   Wed, 16 Sep 2020 12:38:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com
Subject: Re: [PATCH v2 0/6] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and
 enable SB_NOSEC
Message-ID: <20200916163840.GA6124@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916161737.38028-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:17:31PM -0400, Vivek Goyal wrote:
> Hi All,
> 
> Please find attached V2 of the patches to enable SB_NOSEC for fuse. I
> posted V1 here.

I have posted corresonding qemu/virtiofsd change patch here.

https://www.redhat.com/archives/virtio-fs/2020-September/msg00061.html

Thanks
Vivek

> 
> https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/
> 
> I have generated these patches on top of.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next
> 
> Previously I was not keen on implementing FUSE_HANDLE_KILLPRIV_V2 and
> implemented another idea to enable SB_NOSEC conditional on server
> declaring that filesystem is not shared. But that did not go too
> far when it came to requirements for virtiofs.
> 
> https://lore.kernel.org/linux-fsdevel/20200901204045.1250822-1-vgoyal@redhat.com/
> 
> So I went back to having another look at implementing FUSE_HANDLE_KILLPRIV_V2
> and I think it fits nicely and should work nicely with wide variety of
> use cases.
> 
> I have taken care of feedback from last round. For the case of random
> write peformance has jumped from 50MB/s to 250MB/s. So I am really
> looking forward to these changes so that fuse/virtiofs performance
> can be improved.
> 
> Thanks
> Vivek 
> 
> Vivek Goyal (6):
>   fuse: Introduce the notion of FUSE_HANDLE_KILLPRIV_V2
>   fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
>   fuse: setattr should set FATTR_KILL_PRIV upon size change
>   fuse: Kill suid/sgid using ATTR_MODE if it is not truncate
>   fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
>   virtiofs: Support SB_NOSEC flag to improve direct write performance
> 
>  fs/fuse/dir.c             | 19 ++++++++++++++++++-
>  fs/fuse/file.c            |  7 +++++++
>  fs/fuse/fuse_i.h          |  6 ++++++
>  fs/fuse/inode.c           | 17 ++++++++++++++++-
>  include/uapi/linux/fuse.h | 18 +++++++++++++++++-
>  5 files changed, 64 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.4
> 

