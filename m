Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92663216F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGGOpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 10:45:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27769 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgGGOpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594133105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IJiqzQ/kLsjLqSZqOf6MLpDjuwJtn20YFnJVp0WHDBY=;
        b=Fwlkg7Hl/7S1mIeyuGDrAUd9ZzkZYdfeaj2AcB5B4CZ3khFQ1uvVzMXrJ9mdn5IZMjaE0w
        7AhtKznFtnu9BCpZNJ0gOSSWW3o+++htfRszBM5k8zT9uIkb1JwYWgl2SE8YQFLgnMWFiR
        De3yY4tp1txAM07Cme0Yl4X/9Ixucuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-WfeCbwyUO864-hMheGu1Bw-1; Tue, 07 Jul 2020 10:45:03 -0400
X-MC-Unique: WfeCbwyUO864-hMheGu1Bw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77838014D7;
        Tue,  7 Jul 2020 14:45:01 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB6F2797E4;
        Tue,  7 Jul 2020 14:44:59 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC v3 0/2] Fix gfs2 readahead deadlocks
Date:   Tue,  7 Jul 2020 16:44:55 +0200
Message-Id: <20200707144457.1603400-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the previous version, we could end up calling ->readpage without
checking IOCB_NOIO.

Andreas Gruenbacher (2):
  fs: Add IOCB_NOIO flag for generic_file_read_iter
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 45 +--------------------------------------
 fs/gfs2/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 23 ++++++++++++++++++--
 4 files changed, 73 insertions(+), 48 deletions(-)

-- 
2.26.2

