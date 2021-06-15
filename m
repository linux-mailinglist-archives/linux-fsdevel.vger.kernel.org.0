Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7753A795F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFOIv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231191AbhFOIv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623746992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9bNiSS4LtRjfJeF4kAgGARfRNbXMQVYGkmUzqY0OnA=;
        b=aJID23wcUzFgfJMTmpXECmic8B/sZoTZ81a/ferBmGmbO4jU1Rrou9nT+nixpCa9TKHWnu
        n8m8ne+gccuaFFkIy+cj4RiPq3g2pGGahK3GKD7egeV5Agozb9d8pAiwR8CQMnTDiwPBPz
        yJapSoEMRo4azpGq+D3KCThawGNj7IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Fqy4fYCYMeOySnFASAaJog-1; Tue, 15 Jun 2021 04:49:50 -0400
X-MC-Unique: Fqy4fYCYMeOySnFASAaJog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7500380B72A;
        Tue, 15 Jun 2021 08:49:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7AF5C1B4;
        Tue, 15 Jun 2021 08:49:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <558445.1623745199@warthog.procyon.org.uk>
References: <558445.1623745199@warthog.procyon.org.uk> <YLAXfvZ+rObEOdc/@localhost.localdomain>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <600000.1623746987.1@warthog.procyon.org.uk>
Date:   Tue, 15 Jun 2021 09:49:47 +0100
Message-ID: <600001.1623746987@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > -	char afs_SRXCB##name##_name[] __tracepoint_string =	\
> > -		"CB." #name
> 
> I seem to remember that when I did this, it couldn't be a const string for
> some reason, though I don't remember exactly why now if that was indeed the
> case.
> 
> I wonder if it's better just to turn it into an enum-string table in
> linux/events/afs.h.

Hmmm...  It's not necessarily quite that simple - at least if I want to use
the operation ID as the key to the table - as there are at least three
separate services involved and they can have overlapping op IDs.

Is it possible to switch the table passed to __print_symbolic()?  For example,
in the afs_call tracepoint, could I do:

	    TP_printk("c=%08x %s u=%d o=%d sp=%pSR",
		      __entry->call,
		      __print_symbolic(__entry->op,
				       __entry->is_vl ? afs_vl_call_traces :
				       __entry->is_yfs ? afs_yfs_call_traces :
				       afs_fs_call_traces),
		      __entry->usage,
		      __entry->outstanding,
		      __entry->where)

David

