Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED84D14BA1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbgA1Ofu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 09:35:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731717AbgA1Ofs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580222147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFTOPoCtpq01k+VzHiSyqPDi/82rQMnVsLvc9VmH8Xw=;
        b=gMtJPSq4qSnKIoqAki6gYY6hndZPLmBs/gmMNBme8x8fv3yJ8/NhcfOQ4hp+IT64nxTGA6
        GNdotVq0IjsG+JWCfa4mIvN3JAiJmTjR8mzmLdbUPGSVsJJIgf22Of7hQBc+qDpl54eloA
        EHgCIeUeEj8JCPayPYRLKKDTwAufLTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-G5eRXNstOnaC8zE6bPWVRg-1; Tue, 28 Jan 2020 09:35:43 -0500
X-MC-Unique: G5eRXNstOnaC8zE6bPWVRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63C9F1902EA8;
        Tue, 28 Jan 2020 14:35:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-70.rdu2.redhat.com [10.10.121.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 263D519C58;
        Tue, 28 Jan 2020 14:35:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200123071639.GA7216@dread.disaster.area>
References: <20200123071639.GA7216@dread.disaster.area> <20200117202219.GB295250@vader> <20200117222212.GP8904@ZenIV.linux.org.uk> <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader> <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com> <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 28 Jan 2020 14:35:38 +0000
Message-ID: <2173869.1580222138@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner <david@fromorbit.com> wrote:

> If we can forsee that users are going to complain that
> linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> leaves zero length files behind after a crash just like rename()
> does, then we haven't really improved anything at all...

For my purposes, I would like it to look like the end result of
unlink()+linkat().

I need to avoid losing the metadata in case of disconnected operation.  Now=
, I
can do it like Mikl=C3=B3s suggested and have a bunch of temporary dirs to =
iterate
round, then create new files there and rename over the target file.

I'm using direct I/O, so I'm assuming I don't need to fsync().

David

