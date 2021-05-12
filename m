Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F937BB71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELLKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 07:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhELLKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 07:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620817781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2nAX+YI+rHmYRD6uHviI2eVH1B3T1K/tAfcgp+hzVc=;
        b=GBNp0Y21YHrxpbEpbxO9AVNyVVGNZL0zddW/aLqSWV110c3H+vHfDPIoSbPRFtEJBUy7q/
        Zfi+w879GmZOhSJxxkMz9HG1QurNNcCBSBl2u1q9Nq/bTWgvCVmVAa1OLNPwzg9LsIu017
        B+X38QaXeJtQZQf7HPGQ5LlVPkuSgQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-z6KQVHAeNniOF27qXhovXg-1; Wed, 12 May 2021 07:09:39 -0400
X-MC-Unique: z6KQVHAeNniOF27qXhovXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8781009446;
        Wed, 12 May 2021 11:09:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC45270139;
        Wed, 12 May 2021 11:09:36 +0000 (UTC)
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
Content-ID: <2882502.1620817775.1@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 12:09:35 +0100
Message-ID: <2882503.1620817775@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> wrote:

> > Note that my fscache-iter branch[1] improves the situation where the disk
> > I/O required to effect the destruction of a cache object delays the
> > completion of relinquishment by inserting waits, but that oughtn't to help
> > here.
> 
> Right, I haven't looked at it yet (I'll try to) but that could make things
> even worse, right?

It forces fscache_acquire_cookie() to wait for cookie relinquishment to
complete sufficiently; however, that doesn't seem to be the problem here since
the cookie hasn't been relinquished yet.

David

