Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4582D2B87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgLHM6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbgLHM6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607432231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oYSrhl7On3ek4AmuwFnsO6QT9IbADxIiRQU6iafFmC8=;
        b=IkJbYe+fV1v2H5e3C06H1DyYhECAcLFNXyaoRBGbninvf11jvqgqM5cuLh63Hj2Dl+RtH2
        VkvgEE/dL6ReLjCkYVXv2MfOjQpVgrU1+9+wmeGWR+ipACP6NCO8wJpYQvxW67FNCcvbfH
        cM5SJs74P2w5QJfCjW9sGXQhmlX1Pxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-rrPQhd1BOtuur6_XxFWmXA-1; Tue, 08 Dec 2020 07:57:07 -0500
X-MC-Unique: rrPQhd1BOtuur6_XxFWmXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2C9C28A;
        Tue,  8 Dec 2020 12:57:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E77195C1BB;
        Tue,  8 Dec 2020 12:57:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201208003117.342047-4-krisman@collabora.com>
References: <20201208003117.342047-4-krisman@collabora.com> <20201208003117.342047-1-krisman@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 3/8] watch_queue: Support a text field at the end of the notification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <953178.1607432223.1@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 12:57:03 +0000
Message-ID: <953179.1607432223@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> This allow notifications to send text information to userspace without
> having to copy it to a temporary buffer to then copy to the ring.  One
> use case to pass text information in notifications is for error
> reporting, where more debug information might be needed, but we don't
> want to explode the number of subtypes of notifications.  For instance,
> ext4 can have a single inode error notification subtype, and pass more
> information on the cause of the error in this field.

I'm generally okay with this, but you really need to note that if you make use
of this for a subtype, you don't get to add more fields for that subtype
unless there's an offset to it.

Speaking of that, you need to update:

	Documentation/watch_queue.rst

since you're changing the API.

The "Watch Sources" section will also need altering to indicate that
superblock events are now a thing.

David

