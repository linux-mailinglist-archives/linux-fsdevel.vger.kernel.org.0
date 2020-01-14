Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B080F13AFED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgANQsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:48:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51947 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbgANQsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579020518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wa4DvoCfeEWwo/urASd6YVcN7NZPPV/NkQMLP8JZMPc=;
        b=a3/2qNtWS5NkfAPYCrG5beYpHo7nJ4Rt04O2/q8kHNOiZdBHTXTFPkuXyjnCfl2DytpqFQ
        iCLMOb5vjRn3HtaPkxGon0FLKq9/jpGVd6B3JuT/5/hc5UEzXvhmlSDSRB/2eXmOiOBtVC
        w5k25P/1KTBHhZVD2SaFQafi6fWIiuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-qff8BlnUO7GRh5at_9TLdg-1; Tue, 14 Jan 2020 11:48:34 -0500
X-MC-Unique: qff8BlnUO7GRh5at_9TLdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B70891FE18;
        Tue, 14 Jan 2020 16:48:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8C9C60BF1;
        Tue, 14 Jan 2020 16:48:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
cc:     dhowells@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4466.1579020509.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Jan 2020 16:48:29 +0000
Message-ID: <4467.1579020509@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Again with regard to my rewrite of fscache and cachefiles:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

I've got rid of my use of bmap()!  Hooray!

However, I'm informed that I can't trust the extent map of a backing file =
to
tell me accurately whether content exists in a file because:

 (a) Not-quite-contiguous extents may be joined by insertion of blocks of
     zeros by the filesystem optimising itself.  This would give me a fals=
e
     positive when trying to detect the presence of data.

 (b) Blocks of zeros that I write into the file may get punched out by
     filesystem optimisation since a read back would be expected to read z=
eros
     there anyway, provided it's below the EOF.  This would give me a fals=
e
     negative.

Is there some setting I can use to prevent these scenarios on a file - or =
can
one be added?

Without being able to trust the filesystem to tell me accurately what I've
written into it, I have to use some other mechanism.  Currently, I've swit=
ched
to storing a map in an xattr with 1 bit per 256k block, but that gets hard=
 to
use if the file grows particularly large and also has integrity consequenc=
es -
though those are hopefully limited as I'm now using DIO to store data into=
 the
cache.

If it helps, I'm downloading data in aligned 256k blocks and storing data =
in
those same aligned 256k blocks, so if that makes it easier...

David

