Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA737A726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEKMzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 08:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhEKMzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 08:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620737643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ES3lo+LzI3IBSZTYaDNTFKRV/fpzrR23ONuVySbbDys=;
        b=GnoIreVOqcMWq3xKTch8Cl8vayuiz4MnlyjLEM42v1x4jCA+nwUGVFeIN2VoEdGqasAIZm
        cP23vF9q2J+G7GvmOm/MGb3HjzTH122Z5t9rzSmKlviJbpAm9XFRYB/hL1SHZZk/XTP2fk
        dGwwiZEiSOg2sOiihx0keqTpb0hamJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-zdAR-4qdMQu6CKaKf189Pg-1; Tue, 11 May 2021 08:53:59 -0400
X-MC-Unique: zdAR-4qdMQu6CKaKf189Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 589AF1854E21;
        Tue, 11 May 2021 12:53:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20F2C19C44;
        Tue, 11 May 2021 12:53:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <875yzq270z.fsf@suse.de>
References: <875yzq270z.fsf@suse.de> <87czu45gcs.fsf@suse.de> <YJPIyLZ9ofnPy3F6@codewreck.org> <87zgx83vj9.fsf@suse.de> <87r1ii4i2a.fsf@suse.de> <YJXfjDfw9KM50f4y@codewreck.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2508765.1620737636.1@warthog.procyon.org.uk>
Date:   Tue, 11 May 2021 13:53:56 +0100
Message-ID: <2508766.1620737636@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> wrote:

> I've just done a quick experiment: moving the call to function
> v9fs_cache_inode_put_cookie() in v9fs_evict_inode() to the beginning
> (before truncate_inode_pages_final()) and it seems to, at least, narrow
> the window -- I'm not able to reproduce the issue anymore.  But I'll need
> to look closer.

The cookie needs to be relinquished after the pagecache has been cleared such
that any outstanding writes have been dealt with as ->invalidatepage() may
refer to the cookie in order to ditch references to pages.

David

