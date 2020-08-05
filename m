Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A039423CFDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgHET0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:26:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728684AbgHEROA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTnFp3FGNnUMIV+drG+EiP28NPY1kzNtc5gU15VKTgg=;
        b=EPFQ+szwIY5F62w8zr2I2fjpdpckbH7cE/mKO500e5Z2FY5u5l5us7dqhV/PNScv64ZY6+
        ryH4fDs8xkJtta7Mc3G0sHwUiK85UkV78lhlGTuOH/bcpT7ceLV5jMIUag0rRkkD0ihpXO
        vqY9RXcf5GpJyr7QAFBrplc0ttcqEHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-CVKT19CpOAaHFqv9tWctXA-1; Wed, 05 Aug 2020 13:13:57 -0400
X-MC-Unique: CVKT19CpOAaHFqv9tWctXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC2D80183C;
        Wed,  5 Aug 2020 17:13:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 089C25D9DC;
        Wed,  5 Aug 2020 17:13:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1596555579.10158.23.camel@HansenPartnership.com>
References: <1596555579.10158.23.camel@HansenPartnership.com> <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-ext4@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, kzak@redhat.com, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] VFS: Filesystem information [ver #21]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2329128.1596647628.1@warthog.procyon.org.uk>
Date:   Wed, 05 Aug 2020 18:13:48 +0100
Message-ID: <2329129.1596647628@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> It sort of petered out into a long winding thread about why not use
> sysfs instead, which really doesn't look like a good idea to me.

It seemed to turn into a set of procfs symlinks that pointed at a bunch of
sysfs stuff - or possibly some special filesystem.

> Could I make a suggestion about how this should be done in a way that
> doesn't actually require the fsinfo syscall at all: it could just be
> done with fsconfig.

I'd prefer to keep it separate.  The interface for fsconfig() is intended to
move stuff into the kernel, not out of it.  Better to add a parallel syscall
to go the other way (kind of like we have setxattr/getxattr, sendmsg/recvmsg).

Further, fsinfo() can refer directly to a file/fd/mount/whatever, but
fsconfig() doesn't do that.  You have to use fspick() to get a context before
you can use fsconfig().  Now, that's fine if you want to gather several pieces
of information from a particular object, but it's not so good if you want to
get one piece of information from each of several objects.

> ... make it table configured...

I did, kind of (though I didn't call it that).  Al rewrote the code to get rid
of it.

David

