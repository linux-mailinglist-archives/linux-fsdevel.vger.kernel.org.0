Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756F52B800F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 16:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKRPDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 10:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbgKRPDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605711788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8m9xlk+wKmmL3enreHjDmbAIg8ywAmVm1AGESujBoc=;
        b=MRsQvDhezE9cKvHe9DKFQbclvBtG319sBILlaggCfh2u8MO5VOmBhkZx18eSqG4dz9sSWG
        dTx499X6IEIkGJutehmpHVc2YHg2zQpw4JI5eTZ2RUW0dcSqWTlZLfJh3XhS5KsHmDJTVq
        2oNkvETS7udqyiCG0WZr6rGY8uBVSJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-ym6SNh0sMo-XNxsTHr83pg-1; Wed, 18 Nov 2020 10:03:04 -0500
X-MC-Unique: ym6SNh0sMo-XNxsTHr83pg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D809100C661;
        Wed, 18 Nov 2020 15:03:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACB510016DB;
        Wed, 18 Nov 2020 15:02:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201118141649.GA14211@nautica>
References: <20201118141649.GA14211@nautica> <20201118124826.GA17850@nautica> <1514086.1605697347@warthog.procyon.org.uk> <1561011.1605706707@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1787399.1605711778.1@warthog.procyon.org.uk>
Date:   Wed, 18 Nov 2020 15:02:58 +0000
Message-ID: <1787400.1605711778@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> I take it the read helper would just iterate as long as there's data
> still required to read, writing from THPs wouldn't do that?

Yep.  As long as you read some data, the helper will call you again if you
didn't read everything.  subreq->transferred keeps track of what has been read
so far.  You can also tell the helper just to clear the rest by setting
NETFS_SREQ_CLEAR_TAIL.

The helper tries to hide the pages from you as far as possible.  Using
ITER_XARRAY hides that even more.

David

