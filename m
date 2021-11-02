Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AB442C03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhKBLDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 07:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhKBLDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635850858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=djlLnyWoaKPAw0wSkw5dEbcfALL5w0jKJlCdzBfCt+k=;
        b=VRvyTYX4I67ZBTa7VELQPwy5OIQXVu9Ciw3+d6SaEs74alFxi0B9FH0S8H8FXmVp+09ue4
        rU+I2O5JIhZmk4t4E+3cMS5EKMeIMyKYCWX0u8PThDQVP0F9cHPEJPR1tvjc8YyPmfKT9Z
        ToeLeGkcAOLREBKfwtLapCyxLtXjqx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-b9Ht4PA1Nf2bX63BCv6odg-1; Tue, 02 Nov 2021 07:00:55 -0400
X-MC-Unique: b9Ht4PA1Nf2bX63BCv6odg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6343F18358F2;
        Tue,  2 Nov 2021 11:00:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D01A1007625;
        Tue,  2 Nov 2021 11:00:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Split readpage and fix file creation mtime
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4096835.1635850852.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Nov 2021 11:00:52 +0000
Message-ID: <4096836.1635850852@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull these afs patches please?  There are two of them:

 (1) Split the readpage handler for symlinks from the one for files.  The
     symlink readpage isn't given a file pointer, so the handling has to b=
e
     special-cased.

     This has been posted as part of a patchset to foliate netfs, afs,
     etc.[1] but I've moved it to this one as it's not actually doing
     foliation but is more of a pre-cleanup.

 (2) Fix file creation to set the mtime from the client's clock to keep
     make happy if the server's clock isn't quite in sync.[2]

Thanks,
David

Link: https://lore.kernel.org/r/163005742570.2472992.7800423440314043178.s=
tgit@warthog.procyon.org.uk/ [1]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-October/004395.h=
tml [2]

---
The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a41738581=
3:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-next-20211102

for you to fetch changes up to 52af7105eceb311b96b3b7971a367f30a70de907:

  afs: Set mtime from the client for yfs create operations (2021-11-02 09:=
42:26 +0000)

----------------------------------------------------------------
AFS changes

----------------------------------------------------------------
David Howells (1):
      afs: Sort out symlink reading

Marc Dionne (1):
      afs: Set mtime from the client for yfs create operations

 fs/afs/file.c      | 14 +++++++++-----
 fs/afs/inode.c     |  6 +++---
 fs/afs/internal.h  |  3 ++-
 fs/afs/yfsclient.c | 32 +++++++++++++-------------------
 4 files changed, 27 insertions(+), 28 deletions(-)

