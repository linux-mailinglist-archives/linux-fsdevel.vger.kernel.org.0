Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648482B7D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgKRMBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 07:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbgKRMA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605700858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwJHgNKGQbZl2EwfB2TfXfGUisAomAHMeNWf/iz3SIo=;
        b=ezRtbaGswWnaiyKsQY13R2iA7CuCV0BIigNUnPMITlGcNL/smQMWBLt1Mbks2CEYmII7va
        q4RvqmMk+WCnBnPycbcq9+3YIc0gb5AMJq2Eb9m27tWGLvQHOMTCCuKMuUS5GBoxH/N1Z2
        H5cCjTWFyGv+NSgElcj8ZMXAB7mulUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-Vv7zJAryPLu1LbTzoZB3pA-1; Wed, 18 Nov 2020 07:00:54 -0500
X-MC-Unique: Vv7zJAryPLu1LbTzoZB3pA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D886D246;
        Wed, 18 Nov 2020 12:00:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9F02196FB;
        Wed, 18 Nov 2020 12:00:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1517306.1605699813@warthog.procyon.org.uk>
References: <1517306.1605699813@warthog.procyon.org.uk> <1514086.1605697347@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1553534.1605700847.1@warthog.procyon.org.uk>
Date:   Wed, 18 Nov 2020 12:00:47 +0000
Message-ID: <1553535.1605700847@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
>  {
> +	struct netfs_read_request *rreq = subreq->rreq;
> +	struct p9_fid *fid = rreq->netfs_priv;
>  	struct iov_iter to;
> +	loff_t pos = subreq->start + subreq->transferred;
> +	size_t len = subreq->len   - subreq->transferred;
>  	int retval, err;
>  
> +	iov_iter_xarray(&to, READ, &rreq->mapping->i_pages, pos, len);
>  
> +	retval = p9_client_read(fid, pos, &to, &err);
> +	if (retval)
> +		subreq->error = retval;

I forgot something: netfs_subreq_terminated() needs to be called when the read
is complete.  If p9_client_read() is synchronous, then that would be here,
probably something like:

	retval = p9_client_read(fid, pos, &to, &err);
	netfs_subreq_terminated(subreq, retval);

is what's required.  Manually setting subreq->error can then be removed.

David

