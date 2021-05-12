Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7798337BD85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhELM6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 08:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhELM61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 08:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620824239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ki09mF0tspJ6KFUpaOlyOAnAB4n3svOnlL/ruLe8uGQ=;
        b=cC8kmO8gHaN7jD+PgV9qnHVSWOPH8SxZkMv4SdY0lqNNy49EcR3j9affoIdBhy2ELDpbhL
        tS+q7TsQPC+tQeMp2/Q+XK5wK4RmhouMtzfd5uPrccEcsiNmpdpQXHhH+vT+dluqfwtM2j
        uHIq5XIaVSBhlFrrN33+Pd9xg+0C8KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-mK13o95yOqqRB0Pm0D2nuA-1; Wed, 12 May 2021 08:57:15 -0400
X-MC-Unique: mK13o95yOqqRB0Pm0D2nuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3863100945F;
        Wed, 12 May 2021 12:57:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499605D6A8;
        Wed, 12 May 2021 12:57:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YJvJWj/CEyEUWeIu@codewreck.org>
References: <YJvJWj/CEyEUWeIu@codewreck.org> <87tun8z2nd.fsf@suse.de> <87czu45gcs.fsf@suse.de> <2507722.1620736734@warthog.procyon.org.uk> <2882181.1620817453@warthog.procyon.org.uk> <87fsysyxh9.fsf@suse.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        Luis Henriques <lhenriques@suse.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: What sort of inode state does ->evict_inode() expect to see? [was Re: 9p: fscache duplicate cookie]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2891611.1620824231.1@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 13:57:11 +0100
Message-ID: <2891612.1620824231@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

We're seeing cases where fscache is reporting cookie collisions that appears
to be due to ->evict_inode() running parallel with a new inode for the same
filesystem object getting set up.

What's happening is that in all of 9p, afs, ceph, cifs and nfs, the fscache
cookie is being relinquished in ->evict_inode(), but that appears to be too
late because by that time, a new inode can be being allocated and a new cookie
get acquired.

evict_inode is a slow process, potentially, because it has to dismantle the
pagecache and wait for any outstanding DMA to the cache; then seal the cache
object - which involves a synchronous journalled op (setxattr), which means
that there's a lot of scope for a race.

Is there a better place to this?  drop_inode() maybe?  And is there a good
place to wait on all the DMAs that might be in progress to/from the cache?
(This might involve waiting for PG_locked or PG_fscache to be cleared on each
page).

David

