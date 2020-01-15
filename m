Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7254F13C6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 16:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAOO74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729061AbgAOO7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579100392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdF3CR86PjR3/icqlGPbxgEESDkiaecNDA80gTmcK8Q=;
        b=SA5VVeJtfthjY/Ol15ZJib82R0beCMUjLtW7DUI5wtamXkM4mA9BGhaJkORJh+nnFxEyRm
        mgrYvfspZ8bKu9knr/bVe2mwnmsT/oV1Acz73MmlzT/186Rbm1AFmdMIwyUwkPBWpJmGbC
        Bhxr+SVu6aumKujPEtSWSg84kianrhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-1uLPKIN8M2aufcEay_IGjQ-1; Wed, 15 Jan 2020 09:59:46 -0500
X-MC-Unique: 1uLPKIN8M2aufcEay_IGjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40F5F100E722;
        Wed, 15 Jan 2020 14:59:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86B68675AE;
        Wed, 15 Jan 2020 14:59:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200115144839.GA30301@lst.de>
References: <20200115144839.GA30301@lst.de> <20200115133101.GA28583@lst.de> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com> <26093.1579098922@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andreas Dilger <adilger@dilger.ca>,
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
Content-ID: <28754.1579100378.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Jan 2020 14:59:38 +0000
Message-ID: <28755.1579100378@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > Another thread could be writing to the file, and the raciness matters =
if I
> > want to cache the result of calling SEEK_HOLE - though it might be pos=
sible
> > just to mask it off.
> =

> Well, if you have other threads changing the file (writing, punching hol=
es,
> truncating, etc) you have lost with any interface that isn't an atomic
> give me that data or tell me its a hole.  And even if that if you allow
> threads that aren't part of your fscache implementation to do the
> modifications you have lost.  If on the other hand they are part of
> fscache you should be able to synchronize your threads somehow.

Another thread could be writing to the file at the same time, but not in t=
he
same block.  That's managed by netfs, most likely based on the pages and p=
age
flags attached to the netfs inode being cached in this particular file[*].

What I was more thinking of is that SEEK_HOLE might run past the block of
interest and into a block that's currently being written and see a partial=
ly
written block.

[*] For AFS, this is only true of regular files; dirs and symlinks are cac=
hed
    as monoliths and are there entirely or not at all.

> > However, SEEK_HOLE doesn't help with the issue of the filesystem 'alte=
ring'
> > the content of the file by adding or removing blocks of zeros.
> =

> As does any other method.  If you need that fine grained control you
> need to track the information yourself.

So, basically, I can't.  Okay.  I was hoping it might be possible to add a=
n
ioctl or something to tell filesystems not to do that with particular file=
s.

David

