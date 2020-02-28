Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFDA173D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1QgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:36:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38516 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgB1QgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582907778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zOQZKafxylozWi2DvF14UxTPNsm87fVtDrkiWSJi14=;
        b=cu0HyuyQmgOuEoZcP9R3tS9m4hE/7Z2nToRd2Pbmpb0TehlaOigdG5kFoxOwjEfkLGWsE6
        loLlp7BQK0brwiL9jVkEFz9yqsN82fTv2cIH+vqs3rU5VFVilpzq+GOItjq7NMmthZwFlb
        2DsZU7iqFMoIoo/DHWrZb8rlK9eWufU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Zp4_17ZxNFK2J0lzcG5oIw-1; Fri, 28 Feb 2020 11:36:11 -0500
X-MC-Unique: Zp4_17ZxNFK2J0lzcG5oIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC3A08017CC;
        Fri, 28 Feb 2020 16:36:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0DB690780;
        Fri, 28 Feb 2020 16:36:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
References: <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk> <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com> <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com> <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <107665.1582907766.1@warthog.procyon.org.uk>
Date:   Fri, 28 Feb 2020 16:36:06 +0000
Message-ID: <107666.1582907766@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sysfs also has some other disadvantages for this:

 (1) There's a potential chicken-and-egg problem in that you have to create a
     bunch of files and dirs in sysfs for every created mount and superblock
     (possibly excluding special ones like the socket mount) - but this
     includes sysfs itself.  This might work - provided you create sysfs
     first.

 (2) sysfs is memory intensive.  The directory structure has to be backed by
     dentries and inodes that linger as long as the referenced object does
     (procfs is more efficient in this regard for files that aren't being
     accessed).

 (3) It gives people extra, indirect ways to pin mount objects and
     superblocks.

For the moment, fsinfo() gives you three ways of referring to a filesystem
object:

 (a) Directly by path.

 (b) By path associated with an fd.

 (c) By mount ID (perm checked by working back up the tree).

but will need to add:

 (d) By fscontext fd (which is hard to find in sysfs).  Indeed, the superblock
     may not even exist yet.

David

