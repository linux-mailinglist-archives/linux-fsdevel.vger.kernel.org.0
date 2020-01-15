Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3513D08A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 00:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgAOXJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 18:09:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729661AbgAOXJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 18:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579129753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kh6FESOjeCOQkkcKQDJe6CbgaZZXbwDLWZRH4+4Tss=;
        b=jBPUrvCj6p74elJ9vq+GP0zxVTTcZ9leECjxcqqL2tX7OkTPoq4zzwG0r8kG6c4eZ3Rqv1
        fb4mYuEVgR321M9A7YHgh1VxHGYt8dkAd0XhRXq1Qbtn4A8fAqEAtP31ot/0jfriJXqhay
        YtEMBVg7J8h3Nqq8wA0oKPUuxSdGm2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-UC9E83_LNMupIBVLbIZ7aA-1; Wed, 15 Jan 2020 18:09:09 -0500
X-MC-Unique: UC9E83_LNMupIBVLbIZ7aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18964800D41;
        Wed, 15 Jan 2020 23:09:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFA35D9C9;
        Wed, 15 Jan 2020 23:09:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7233E240-8EE5-4CD1-B8A4-A90925F51A1B@dilger.ca>
References: <7233E240-8EE5-4CD1-B8A4-A90925F51A1B@dilger.ca> <C0F67EC5-7B5D-4179-9F28-95B84D9CC326@dilger.ca> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <20200115133101.GA28583@lst.de> <23762.1579121702@warthog.procyon.org.uk>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7025.1579129743.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Jan 2020 23:09:03 +0000
Message-ID: <7026.1579129743@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> wrote:

> > It would also have to say that blocks of zeros shouldn't be optimised =
away.
> =

> I don't necessarily see that as a requirement, so long as the filesystem
> stores a "block" at that offset, but it could dedupe all zero-filled blo=
cks
> to the same "zero block".  That still allows saving storage space, while
> keeping the semantics of "this block was written into the file" rather t=
han
> "there is a hole at this offset".

Yeah, that's more what I was thinking of.  Provided I can find out that
something is present, it should be fine.

David

