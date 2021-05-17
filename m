Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6423834B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbhEQPLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 11:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242985AbhEQPI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 11:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621264031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=I5rAv94XxstBbe41BltHMXkjh+gEB3rfy3QPuNUieqo=;
        b=F1t8fETiFEM/n2WnF1zm3pU+khKpCFuBokIAg9b/FGlRXcxKhnEkiETGfo67Y+K7ZEPn60
        WPZ2l1+1YGZkSgoEPaHwmbn6EcETcyhHWkiCw31FYAvYqfUlouHCcHeB9RAkfXcTd7Vqb6
        7KMcQCN5dvtJrHC3qVKBCyZ6VxBo1nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-tj8WPEpmMVO6J5tMs2USrQ-1; Mon, 17 May 2021 11:07:08 -0400
X-MC-Unique: tj8WPEpmMVO6J5tMs2USrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DA96107ACCD;
        Mon, 17 May 2021 15:07:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-217.rdu2.redhat.com [10.10.112.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E90135D6D7;
        Mon, 17 May 2021 15:06:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>
cc:     dhowells@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: How capacious and well-indexed are ext4, xfs and btrfs directories?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <206077.1621264018.1@warthog.procyon.org.uk>
Date:   Mon, 17 May 2021 16:06:58 +0100
Message-ID: <206078.1621264018@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

With filesystems like ext4, xfs and btrfs, what are the limits on directory
capacity, and how well are they indexed?

The reason I ask is that inside of cachefiles, I insert fanout directories
inside index directories to divide up the space for ext2 to cope with the
limits on directory sizes and that it did linear searches (IIRC).

For some applications, I need to be able to cache over 1M entries (render
farm) and even a kernel tree has over 100k.

What I'd like to do is remove the fanout directories, so that for each logical
"volume"[*] I have a single directory with all the files in it.  But that
means sticking massive amounts of entries into a single directory and hoping
it (a) isn't too slow and (b) doesn't hit the capacity limit.

David

[*] What that means is netfs-dependent.  For AFS it would be a single volume
within a cell; for NFS, it would be a particular FSID on a server, for
example.  Kind of corresponds to a thing that gets its own superblock on the
client.

