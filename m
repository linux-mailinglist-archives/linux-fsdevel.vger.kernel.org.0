Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88C513C5C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAOOU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:20:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728931AbgAOOU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579098028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtSguD4DonoXKrAZPQ1DK5ewTREMerhNuGoZ0KSdPnQ=;
        b=VFbqD0PrToG09vUgR/3iqeQcBTMeI8eu6/AhiSGvVSZcLRN/93a1EddrNhFFJmVzgsRn+w
        P+ItHXWknOBej6kH1sQzL6gkjUUeqtLzeP3wbazGY3pz9TRhsDt+JSk8Dq/1TRPNbKA//P
        JZBU5Wbr+H/MKl4aq91iLTprlyO9h1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-Bu9W6yxqPZODu82iaD6qdw-1; Wed, 15 Jan 2020 09:20:24 -0500
X-MC-Unique: Bu9W6yxqPZODu82iaD6qdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2BB5107ACFA;
        Wed, 15 Jan 2020 14:20:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4B060E1C;
        Wed, 15 Jan 2020 14:20:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca>
References: <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     dhowells@redhat.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
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
Content-ID: <24869.1579098019.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Jan 2020 14:20:19 +0000
Message-ID: <24870.1579098019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> wrote:

> > Would you like to explain why you want to know such fs internal info?
> =

> I believe David wants it to store sparse files as an cache and use FIEMA=
P to
> determine if the blocks are cached locally, or if they need to be fetche=
d from
> the server.  If the filesystem doesn't store the written blocks accurate=
ly,
> there is no way for the local cache to know whether it is holding valid =
data
> or not.

More or less.  I have no particular attachment to bmap or FIEMAP as the
interface to use.  I'm just interested in finding out quickly if the data =
I
want is present.

If call_read_iter() will return a short read on hitting a hole, I can mana=
ge
if I can find out if just the first byte is present.

Finding out if the block is present allows me to avoid shaping read reques=
ts
from VM readahead into 256k blocks - which may require the allocation of e=
xtra
pages for bufferage.

David

