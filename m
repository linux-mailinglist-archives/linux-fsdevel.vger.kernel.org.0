Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78085EA15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCRIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 13:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCRIN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:08:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6EE2080C;
        Wed,  3 Jul 2019 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562173692;
        bh=0ouf0Y73C+G8kK8V/y9ZdKcbKz2QNfNH9xVkkqZP1JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJ0o71u9D8lYdXoiiMKqqplUcWvoc5CoTLCEvXJliqmrj/bLCD4U7ZquS4QjDfQ5S
         y6bAUovvtz1ELtv2hiWjY7X3gqzzZwKjN1wdiZhn6duk1o19EUlj0mUvmKXPY6BMpf
         chEbpSaJjWxWVemuFC7cZlw0f5molzIeYgqrlTLE=
Date:   Wed, 3 Jul 2019 19:08:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] uapi: General notification ring definitions [ver #5]
Message-ID: <20190703170810.GB24672@kroah.com>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173691411.15137.2073887155273175167.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156173691411.15137.2073887155273175167.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:48:34PM +0100, David Howells wrote:
> Add UAPI definitions for the general notification ring, including the
> following pieces:
> 
>  (1) struct watch_notification.
> 
>      This is the metadata header for each entry in the ring.  It includes a
>      type and subtype that indicate the source of the message
>      (eg. WATCH_TYPE_MOUNT_NOTIFY) and the kind of the message
>      (eg. NOTIFY_MOUNT_NEW_MOUNT).
> 
>      The header also contains an information field that conveys the
>      following information:
> 
> 	- WATCH_INFO_LENGTH.  The size of the entry (entries are variable
>           length).
> 
> 	- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
>           set.
> 
> 	- WATCH_INFO_TYPE_INFO.  (Sub)type-specific information.
> 
> 	- WATCH_INFO_FLAG_*.  Flag bits overlain on the type-specific
>           information.  For use by the type.
> 
>      All the information in the header can be used in filtering messages at
>      the point of writing into the buffer.
> 
>  (2) struct watch_queue_buffer.
> 
>      This describes the layout of the ring.  Note that the first slots in
>      the ring contain a special metadata entry that contains the ring
>      pointers.  The producer in the kernel knows to skip this and it has a
>      proper header (WATCH_TYPE_META, WATCH_META_SKIP_NOTIFICATION) that
>      indicates the size so that the ring consumer can handle it the same as
>      any other record and just skip it.
> 
>      Note that this means that ring entries can never be split over the end
>      of the ring, so if an entry would need to be split, a skip record is
>      inserted to wrap the ring first; this is also WATCH_TYPE_META,
>      WATCH_META_SKIP_NOTIFICATION.
> 
>  (3) WATCH_INFO_NOTIFICATIONS_LOST.
> 
>      This is a flag that can be set in the metadata header by the kernel to
>      indicate that at least one message was lost since it was last cleared
>      by userspace.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
