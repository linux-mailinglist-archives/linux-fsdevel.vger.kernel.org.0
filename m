Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318E0FC7FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKNNkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 08:40:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726912AbfKNNkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573738851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2J7Gf6SuzKWX47g7qh2y1AT+N7TUFXmW/HwIIlq/BU=;
        b=aXMZEQifHO/KlUv2Xj7nCo7CYLxtHzb0vEC+E2w5cnTAJA+FUW7A0KriGg7e8XIJgdA/S3
        qubLDvmR8tkumBlWQ/MmskQA3k1hVYFwMEWt8s9Fs7ygukXA/7qXMn0pluzBQ5bI4897ib
        dbWlgWILRNcj35c9vYaG//kXs2+fDCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-uy07ckELPtiy0UFAGms6Ow-1; Thu, 14 Nov 2019 08:40:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA83D800C77;
        Thu, 14 Nov 2019 13:40:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3751A60BD7;
        Thu, 14 Nov 2019 13:40:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <24942.1573667720@warthog.procyon.org.uk>
References: <24942.1573667720@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: How to avoid using bmap in cachefiles -- FS-Cache/CacheFiles rewrite
MIME-Version: 1.0
Content-ID: <30126.1573738838.1@warthog.procyon.org.uk>
Date:   Thu, 14 Nov 2019 13:40:38 +0000
Message-ID: <30127.1573738838@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uy07ckELPtiy0UFAGms6Ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

I've been rewriting cachefiles in the kernel and it now uses kiocbs to do
async direct I/O to/from the cache files - which seems to make a 40-48% spe=
ed
improvement.

However, I've replaced the use of bmap internally to detect whether data is
present or not - which is dodgy for a number of reasons, not least that
extent-based filesystems might insert or remove blocks of zeros to shape th=
e
extents better, thereby rendering the metadata information useless for
cachefiles.

But using a separate map has a couple of problems:

 (1) The map is metadata kept outside of the filesystem journal, so coheren=
cy
     management is necessary

 (2) The map gets hard to manage for very large files (I'm using 256KiB
     granules, so 1 bit per granule means a 512-byte map block can span 1Gi=
B)
     and xattrs can be of limited capacity.

I seem to remember you said something along the lines of it being possible =
to
tell the filesystem not to do discarding and insertion of blocks of zeros. =
 Is
there a generic way to do that?

Also, is it possible to make it so that I can tell an O_DIRECT read to fail
partially or, better, completely if there's no data to be had in part of th=
e
range?  I can see DIO_SKIP_HOLES, but that only seems to affect writes

Thanks,
David

