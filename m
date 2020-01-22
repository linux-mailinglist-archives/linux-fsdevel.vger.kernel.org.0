Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5CD145156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgAVJxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 04:53:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730135AbgAVJxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579686812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DNzYql10MRhGoEw8lSsU1VMTmUVLiv5bJngaz+sji8Y=;
        b=crD1Wv24zK2DlbkbeIaNaVLSEJFLVhgCJTAIkE5P96QVFFfGS0ryvdcdmAdobLbVdXVAL7
        qUvxFqhYy+1+v+z2VhTUImYSOzXKq1CPA1QVz1zmtVifD6Sol7jInT8a71TsMYDi8B5IPn
        YBPmlcxSnVZlFPDQLkG482evzZEhoeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-xR2SZy6fNgqCG5-ZqDO_Pw-1; Wed, 22 Jan 2020 04:53:29 -0500
X-MC-Unique: xR2SZy6fNgqCG5-ZqDO_Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 538B2100550E;
        Wed, 22 Jan 2020 09:53:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32F9886432;
        Wed, 22 Jan 2020 09:53:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200118022032.GR8904@ZenIV.linux.org.uk>
References: <20200118022032.GR8904@ZenIV.linux.org.uk> <20200117154657.GK8904@ZenIV.linux.org.uk> <20200117163616.GA282555@vader> <20200117165904.GN8904@ZenIV.linux.org.uk> <20200117172855.GA295250@vader> <20200117181730.GO8904@ZenIV.linux.org.uk> <20200117202219.GB295250@vader> <20200117222212.GP8904@ZenIV.linux.org.uk> <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3395817.1579686804.1@warthog.procyon.org.uk>
Date:   Wed, 22 Jan 2020 09:53:24 +0000
Message-ID: <3395818.1579686804@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> FWIW, that might be not so simple ;-/  Reason: NFS-like stuff.  Client
> sees a negative in cache; the problem is how to decide whether to
> tell the server "OK, I want normal link()" vs. "if it turns out that
> someone has created it by the time you see the request, give do
> a replacing link".  Sure, if could treat ->link() telling you -EEXIST
> as "OK, repeat it with ->link_replace(), then", but that's an extra
> roundtrip...

If someone asks for link_replace on a filesystem that doesn't support it or if
it's a network filesystem in which the client does, but the server being
accessed does not, then return an error (say EOPNOTSUPP) and let userspace (or
cachefiles or whatever) handle the fallback?

David

