Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D751B3692AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbhDWNI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242593AbhDWNI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZiEIV54Feydxm3In/brZNAh1w14oc1bLXe4KF6wMdTU=;
        b=VDf49I1b+TkKd1OZo2IxPrfagEITSaiyka0c7BuwGWIKmZZdgc5RpwsTcd5DGySsfaKMPW
        Z2o71DgguHYMkxXpJqiMhA05mNCOsj9+YhqmkGsMeNZYF3pxszfs7i10LrGJaxVxSufA0a
        HukZVeIm8w0Rb6GhYZbPQ8SJzqYy/10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-K22UzCxtO7iDmCD0Jo1zXg-1; Fri, 23 Apr 2021 09:07:46 -0400
X-MC-Unique: K22UzCxtO7iDmCD0Jo1zXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E6D343A5;
        Fri, 23 Apr 2021 13:07:44 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-86.rdu2.redhat.com [10.10.115.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123201B5F0;
        Fri, 23 Apr 2021 13:07:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 99F7E220BCF; Fri, 23 Apr 2021 09:07:37 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        willy@infradead.org, slp@redhat.com, groug@kaod.org
Subject: [PATCH v4 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date:   Fri, 23 Apr 2021 09:07:20 -0400
Message-Id: <20210423130723.1673919-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V4 of the patches. Posted V3 here.

https://lore.kernel.org/linux-fsdevel/20210419213636.1514816-1-vgoyal@redhat.com/

Changes since V3 are.

- Renamed "enum dax_entry_wake_mode" to "enum dax_wake_mode" (Matthew Wilcox)
- Changed description of WAKE_NEXT and WAKE_ALL (Jan Kara) 
- Got rid of a comment (Greg Kurz)

Thanks
Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.25.4

