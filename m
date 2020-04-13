Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C750C1A6855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgDMOuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 10:50:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbgDMOuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FEtIYVJIpib0M0PusMaXJ2aHzJiehmLRM7Ty7t9FWBg=;
        b=hSzfKAZyz28dYrOQN81B2kJNLLGX4d9ixHQ6JjsDJS8bMGI8Id5XvYlzEaUpUYpZSghU9U
        4cSDLEwtApwBYVn3e33KzzEKKg6Ukq7R2UZyklM8I3ZOXPdqbBN1YhDXoTTRTBx9vIn6xz
        gUfdeYTpcaB4dV2QWZ5Aa0JvpYOvXME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204--_H3N8V-Pwmh2DH0fsaWsA-1; Mon, 13 Apr 2020 10:50:19 -0400
X-MC-Unique: -_H3N8V-Pwmh2DH0fsaWsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9B5C1005509;
        Mon, 13 Apr 2020 14:50:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABEB1272A5;
        Mon, 13 Apr 2020 14:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2940558.1586789415.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 13 Apr 2020 15:50:15 +0100
Message-ID: <2940559.1586789415@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here are some fixes for the afs filesystem:

 (1) Fix the decoding of fetched file status records do that in advances
     the xdr pointer under all circumstances.

 (2) Fix the decoding of a fetched file status record that indicates an
     inline abort code (ie. an error) so that it sets the flag saying that
     it got an error.

 (3) Fix the decoding of the result of the rename operation so that it
     doesn't skip the decoding of the second fetched file status (ie. that
     of the dest dir) in the case that the source and dest dirs were the
     same as this causes the xdr pointer not to be advanced, leading to
     incorrect decoding of subsequent parts of the reply.

 (4) Fix the dump of a bad YFSFetchStatus record to dump the full length.

 (5) Fix a race between local editing of directory contents and accessing
     the dir for reading or d_revalidate by using the same lock in both.

 (6) Fix afs_d_revalidate() to not accidentally reverse the version on a
     dentry when it's meant to be bringing it forward.

David
---
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f313=
6:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20200413

for you to fetch changes up to 40fc81027f892284ce31f8b6de1e497f5b47e71f:

  afs: Fix afs_d_validate() to set the right directory version (2020-04-13=
 15:09:01 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (6):
      afs: Fix missing XDR advance in xdr_decode_{AFS,YFS}FSFetchStatus()
      afs: Fix decoding of inline abort codes from version 1 status record=
s
      afs: Fix rename operation status delivery
      afs: Fix length of dump of bad YFSFetchStatus record
      afs: Fix race between post-modification dir edit and readdir/d_reval=
idate
      afs: Fix afs_d_validate() to set the right directory version

 fs/afs/dir.c       | 108 +++++++++++++++++++++++++++++++++---------------=
-----
 fs/afs/dir_silly.c |  22 +++++++----
 fs/afs/fsclient.c  |  27 ++++++++------
 fs/afs/yfsclient.c |  26 +++++++------
 4 files changed, 112 insertions(+), 71 deletions(-)

