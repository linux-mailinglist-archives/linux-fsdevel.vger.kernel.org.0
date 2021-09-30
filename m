Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C056141DDDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbhI3Ppm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 11:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345133AbhI3Ppl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633016638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnX5DeDMbc0T/bp7M/AgnI3bvcIrL5pMjwuWcJiSyls=;
        b=Cfs42UaPl1oYwnSZBzJ/K/BOGpQ6z440morPOhOEj1uCghPMCQYEf3n7BIxJQ8/CZwvBod
        B2xVq93FrCFvtU6w/oxsTxGSDzGqqA+ZFRMBde/lzWlCyFb1xDVzaYVt+nbdfeZb5n7OYT
        amB3IQEzym5vAHWiS1wNyjLNx64TJkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-3LI2roQMM7KJA6yZ5mqOow-1; Thu, 30 Sep 2021 11:43:56 -0400
X-MC-Unique: 3LI2roQMM7KJA6yZ5mqOow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C38D0180830B;
        Thu, 30 Sep 2021 15:43:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 301CE60CC6;
        Thu, 30 Sep 2021 15:43:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B2A48220B02; Thu, 30 Sep 2021 11:43:29 -0400 (EDT)
Date:   Thu, 30 Sep 2021 11:43:29 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     iangelak@redhat.com, jaggel@bu.edu, dgilbert@redhat.com
Subject: Re: [PATCH 0/8] virtiofs: Notification queue and blocking posix locks
Message-ID: <YVXbITiMDbi531qi@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:38:42AM -0400, Vivek Goyal wrote:
> Hi,
> 
> As of now we do not support blocking remote posix locks with virtiofs.
> Well fuse client does not care but server returns -EOPNOTSUPP.

Posted corresponding qemu/virtiofsd changes here.

https://listman.redhat.com/archives/virtio-fs/2021-September/msg00153.html

Thanks
Vivek

> 
> There are couple of reasons to not support it yet.
> 
> - If virtiofsd is single threaded or does not have a thread pool just
>   to handle requests which can block for a long time, virtiofsd will
>   stop processing new requests and virtiofs will come to a halt.
>   To the extent that further unlock request will not make progress
>   and deadlock will result. This can be taken care of by creating
>   a custom thread pool in virtiofsd just to hanlde lock requests.
> 
> - If client sends a blocking lock request and blocks, then it will
>   consume descriptors in vring. If enough processes block, it is
>   possible that vring does not have capacity to send more requests
>   till some response comes back and descriptors are free. This can
>   also lead to deadlock where an unlock request can't be sent to
>   virtiofsd now. Also this will stop virtiofs operation as well as
>   new filesystem requests can't be sent.
> 
> To avoid this issue, idea was suggested thatn when a blocking
> lock request is sent by client, do not block it. Immediately
> send a reply saying client process should wait for a notification
> which will let it know once lock is available. This will make
> sure descriptors in virtqueue are not kept busy while we are
> waiting for lock and future unlock and other file system requests
> can continue to make progress.
> 
> This first requires a notion of notification queue and virtiosfd
> being able to send notifications to client. This patch series
> implements that as well.
> 
> As of now only one notification type has been implemented but now
> infrastructure is in place and other use cases should be easily
> add more type of notifications as need be.
> 
> We don't yet have the capability to interrupt the process which
> is waiting for the posix lock. And reason for that is that virtiofs
> does not support capability to interrupt yet. That's a TODO item
> for later.
> 
> Please have a look.
> 
> Thanks
> Vivek
> 
> Vivek Goyal (8):
>   virtiofs: Disable interrupt requests properly
>   virtiofs: Fix a comment about fuse_dev allocation
>   virtiofs: Add an index to keep track of first request queue
>   virtiofs: Decouple queue index and queue type
>   virtiofs: Add a virtqueue for notifications
>   virtiofs: Add a helper to end request and decrement inflight number
>   virtiofs: Add new notification type FUSE_NOTIFY_LOCK
>   virtiofs: Handle reordering of reply and notification event
> 
>  fs/fuse/virtio_fs.c            | 438 ++++++++++++++++++++++++++++++---
>  include/uapi/linux/fuse.h      |  11 +-
>  include/uapi/linux/virtio_fs.h |   5 +
>  3 files changed, 412 insertions(+), 42 deletions(-)
> 
> -- 
> 2.31.1
> 

