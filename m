Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B11345D64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCWLx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229670AbhCWLxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616500415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aA2iKoiePqQtpqGhhTijWBU3ANydJrmSdc9O2oPlqu4=;
        b=VeJfqUKPeKQbqxwEOFfmwSFvmDy8oxYgWmwlqzlLWQpCcPTSVREJE+vMtcLD1EhIlKznvX
        Fx4XS/yYN7co6B2cY7TIRjfChk+W3Sagp8bFZccpCSRPudg5jIfZZkhnKnVlsM4vSPMO/E
        NK1l3A/XFYJjUQHs0wEGFMYqhO3kjMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-4XzQj2goMvGi9a12EKrHHw-1; Tue, 23 Mar 2021 07:53:32 -0400
X-MC-Unique: 4XzQj2goMvGi9a12EKrHHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F1D101371D;
        Tue, 23 Mar 2021 11:53:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3D582C168;
        Tue, 23 Mar 2021 11:53:23 +0000 (UTC)
Subject: [PATCH 0/3] cachefiles, afs: mm wait fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 11:53:22 +0000
Message-ID: <161650040278.2445805.7652115256944270457.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some patches to fix page waiting-related issues in cachefiles and
afs[1]:

 (1) In cachefiles, remove the use of the wait_bit_key struct to access
     something that's actually in wait_page_key format.  The proper struct
     is now available in the header, so that should be used instead.

 (2) Add a proper wait function for waiting killably on the page writeback
     flag.  This includes a recent bugfix here (presumably commit
     c2407cf7d22d0c0d94cf20342b3b8f06f1d904e7).

 (3) In afs, use the function added in (2) rather than using
     wait_on_page_bit_killable() which doesn't have the aforementioned
     bugfix.

     Note that I modified this to work with the upstream code where the
     page pointer isn't cached in a local variable.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: https://lore.kernel.org/r/20210320054104.1300774-1-willy@infradead.org[1]

---
Matthew Wilcox (Oracle) (3):
      fs/cachefiles: Remove wait_bit_key layout dependency
      mm/writeback: Add wait_on_page_writeback_killable
      afs: Use wait_on_page_writeback_killable


 fs/afs/write.c          |  3 +--
 include/linux/pagemap.h |  1 +
 mm/page-writeback.c     | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)


