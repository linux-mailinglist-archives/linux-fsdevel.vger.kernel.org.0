Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C613C697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAOOue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:50:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729195AbgAOOue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579099832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Rf0cEa0njBpHKWLGMJpGbHzTU22PMR2115XgkwcWqQ=;
        b=jOc6OuBvmqst6B9qgzTwUPn2S+h+3RyPVaSGzXtHbgOvkg0k2yVPIQ453EY1suu/j9/6+0
        vlZ/y81HdNINz6DCGN+s50P+NbEQoHPQ1n/T/Rl7qYdBxAPvlE/gX2D4Wo4aFgSzS/s9T7
        FNEGgVSg6hGoZedfwb9wlYDd5lkKNZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-vzBayW3DM1KeNyA2oRU0Gg-1; Wed, 15 Jan 2020 09:50:29 -0500
X-MC-Unique: vzBayW3DM1KeNyA2oRU0Gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0948A243E;
        Wed, 15 Jan 2020 14:50:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FD2984332;
        Wed, 15 Jan 2020 14:50:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6330a53c-781b-83d7-8293-405787979736@gmx.com>
References: <6330a53c-781b-83d7-8293-405787979736@gmx.com> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <4467.1579020509@warthog.procyon.org.uk> <23358.1579097103@warthog.procyon.org.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hch@lst.de, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27262.1579099822.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Jan 2020 14:50:22 +0000
Message-ID: <27263.1579099822@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> "Unaligned" means "unaligned to fs sector size". In btrfs it's page
> size, thus it shouldn't be a problem for your 256K block size.

Cool.

> > Same answer as above.  Btw, since I'm using DIO reads and writes, woul=
d these
> > get compressed?
> =

> Yes. DIO will also be compressed unless you set the inode to nocompressi=
on.
> =

> And you may not like this btrfs internal design:
> Compressed extent can only be as large as 128K (uncompressed size).
> =

> So 256K block write will be split into 2 extents anyway.
> And since compressed extent will cause non-continuous physical offset,
> it will always be two extents to fiemap, even you're always writing in
> 256K block size.
> =

> Not sure if this matters though.

Not a problem, provided I can read them with a single DIO read.  I just ne=
ed
to know whether the data is present.  I don't need to know where it is or =
what
hoops the filesystem goes through to get it.

> > I'm not sure this isn't the same answer as above either, except if thi=
s
> > results in parts of the file being "filled in" with blocks of zeros th=
at I
> > haven't supplied.
> =

> The example would be, you have written 256K data, all filled with 0xaa.
> And it committed to disk.
> Then the next time you write another 256K data, all filled with 0xaa.
> Then instead of writing this data onto disk, the fs chooses to reuse
> your previous written data, doing a reflink to it.

That's fine as long as the filesystem says it's there when I ask for it.
Having it shared isn't a problem.

But that brings me back to the original issue and that's the potential pro=
blem
of the filesystem optimising storage by adding or removing blocks of zero
bytes.  If either of those can happen, I cannot rely on the filesystem
metadata.

> So fiemap would report your latter 256K has the same bytenr of your
> previous 256K write (since it's reflinked), and with SHARED flag.

It might be better for me to use SEEK_HOLE than fiemap - barring the sligh=
t
issues that SEEK_HOLE has no upper bound and that writes may be taking pla=
ce
at the same time.

David

