Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC65234738E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 09:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhCXIWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 04:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236326AbhCXIVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616574091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jAgNsK9devgKzZZEmPPhrqr8dUdGVfpvAFbi2fl9vfk=;
        b=NmboLgxF+F3wj/sQf4Htv0b+KS6ipMsBGWmX7HuDaMmXCFaAzbh1laZoENnWbcZAd9kQDS
        RTEamKQI8hbzhgISkALcaQqlvNGg8Ixd6hZcXQ1LXGy0iwVnhiwwOLlBx8j9e0+GpHCH3G
        Irhk2Qf1IOk5XC5VyzoadCLSgW9iVNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-QjT4gwMxNvWA814f-aWyuQ-1; Wed, 24 Mar 2021 04:21:27 -0400
X-MC-Unique: QjT4gwMxNvWA814f-aWyuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F77100746C;
        Wed, 24 Mar 2021 08:21:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7C6A6E6FD;
        Wed, 24 Mar 2021 08:21:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cachefiles, afs: mm wait fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2813136.1616574054.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 24 Mar 2021 08:21:21 +0000
Message-ID: <2813194.1616574081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these patches from Matthew Wilcox to fix page
waiting-related issues in cachefiles and afs as extracted from his folio
series[1]:

 (1) In cachefiles, remove the use of the wait_bit_key struct to access
     something that's actually in wait_page_key format.  The proper struct
     is now available in the header, so that should be used instead.

 (2) Add a proper wait function for waiting killably on the page writeback
     flag.  This includes a recent bugfix[2] that's not in the afs code.

 (3) In afs, use the function added in (2) rather than using
     wait_on_page_bit_killable() which doesn't provide the aforementioned
     bugfix.

Notes:

 - I've included these together since they are an excerpt from a patch
   series of Willy's, but I can send the first separately from the other
   two if you'd prefer since they touch different modules.

 - The cachefiles patch could be deferred to the next merge window as
   whichever compiler is used probably *should* generate the same code for
   both structs, even with struct randomisation turned on.

 - AuriStor (auristor.com) have added certain of my branches to their
   automated AFS testing, hence the Tested-by kafs-testing@auristor.com ta=
g
   on the patches in this set.  Is this the best way to represent this?

David

Link: https://lore.kernel.org/r/20210320054104.1300774-1-willy@infradead.o=
rg[1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dc2407cf7d22d0c0d94cf20342b3b8f06f1d904e7 [2]
Link: https://lore.kernel.org/r/20210323120829.GC1719932@casper.infradead.=
org/ # v1

---
The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49=
b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-cachefiles-fixes-20210323

for you to fetch changes up to 75b69799610c2b909a18e709c402923ea61aedc0:

  afs: Use wait_on_page_writeback_killable (2021-03-23 20:54:37 +0000)

----------------------------------------------------------------
cachefiles, afs: mm wait fixes

----------------------------------------------------------------
Matthew Wilcox (Oracle) (3):
      fs/cachefiles: Remove wait_bit_key layout dependency
      mm/writeback: Add wait_on_page_writeback_killable
      afs: Use wait_on_page_writeback_killable

 fs/afs/write.c          |  3 +--
 fs/cachefiles/rdwr.c    |  7 +++----
 include/linux/pagemap.h |  2 +-
 mm/page-writeback.c     | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

