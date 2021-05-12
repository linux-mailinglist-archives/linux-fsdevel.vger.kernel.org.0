Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3B37BB6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELLF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 07:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhELLF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 07:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620817459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TOZHAEO+pT8rcr0WlOUE07svgCrHh7uPmgeF208tgU=;
        b=AF+RRRrG1clyVAr+k645F6KhwYRq+X6I5uzOFE46l8EKMIUYeRFi53Jxe/+vDVaX//n88L
        O077fo/eGhb0Lb++H5kJ8RiC4mWcy4RIv8DzjU8MBEf1UFGimDliM+ZxfgQzJRVDdoZeWj
        RuxRhfajuJVa27qfRd3yuox3M7vkUjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-pQdoI5l2MTmubJdgiyGqtw-1; Wed, 12 May 2021 07:04:17 -0400
X-MC-Unique: pQdoI5l2MTmubJdgiyGqtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FBA800D55;
        Wed, 12 May 2021 11:04:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3032B6CC;
        Wed, 12 May 2021 11:04:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87tun8z2nd.fsf@suse.de>
References: <87tun8z2nd.fsf@suse.de> <87czu45gcs.fsf@suse.de> <2507722.1620736734@warthog.procyon.org.uk>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2882180.1620817453.1@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 12:04:13 +0100
Message-ID: <2882181.1620817453@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> wrote:

> [ I wonder why the timestamps don't match between the traces and the
>   kernel log... ]

I've seen that.  I wonder if the timestamping of printk lines is delayed by
the serial driver outputting things.

> So, can we infer from this trace that an evict could actually be on-going
> but the old cookie wasn't relinquished yet and hence the collision?

It might be illuminating if you can make it print a traceline at the beginning
of v9fs_evict_inode() and in v9fs_drop_inode().  Print the cookie pointer in
both.

David

