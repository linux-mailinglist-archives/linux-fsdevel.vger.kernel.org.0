Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B657F2D2B77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgLHMwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:52:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLHMwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607431875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdxI1aFzATHmCTQ4qY4lTwkjlL93IzNY1JKWmh6317E=;
        b=hb0de9JYfTA/8tjfvjFNG8vBKDZ4z5gYpclLg0V/UYVhGHTBrxpaMj8Shz5+Jk2vPpKNBZ
        lPYA3yj9j7LCk5eOOFji2nw9E6vyW7g32CQWFOllOcmSECFuMvzVJq20GHVeSL60dStIPh
        w0bbv1nj59pGvfLWoeiECFSSnGSpSQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-USMaAIxCNxi7sLC_Omt8PQ-1; Tue, 08 Dec 2020 07:51:13 -0500
X-MC-Unique: USMaAIxCNxi7sLC_Omt8PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80D5D107ACE4;
        Tue,  8 Dec 2020 12:51:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6C65C1A3;
        Tue,  8 Dec 2020 12:51:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201208003117.342047-6-krisman@collabora.com>
References: <20201208003117.342047-6-krisman@collabora.com> <20201208003117.342047-1-krisman@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <952749.1607431868.1@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 12:51:08 +0000
Message-ID: <952750.1607431868@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> @@ -130,6 +131,8 @@ struct superblock_error_notification {
>  	__u32	error_cookie;
>  	__u64	inode;
>  	__u64	block;
> +	char	function[SB_NOTIFICATION_FNAME_LEN];
> +	__u16	line;
>  	char	desc[0];
>  };

As Darrick said, this is a UAPI breaker, so you shouldn't do this (you can,
however, merge this ahead a patch).  Also, I would put the __u16 before the
char[].

That said, I'm not sure whether it's useful to include the function name and
line.  Both fields are liable to change over kernel commits, so it's not
something userspace can actually interpret.  I think you're better off dumping
those into dmesg.

Further, this reduces the capacity of desc[] significantly - I don't know if
that's a problem.

And yet further, there's no room for addition of new fields with the desc[]
buffer on the end.  Now maybe you're planning on making use of desc[] for
text-encoding?

David

