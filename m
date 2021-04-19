Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21C364D2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhDSVjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 17:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240996AbhDSVjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618868344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HEv6wLVOqLEkA1FkObpOLdW0h1KNpD964gmCWJcGub4=;
        b=GuE7DuXDs//6C7RzTFS5evhFVv8+iBInuOA5qhH+Nptmt488eYvjff/uqtqDrF7LtlNhui
        O8FR3gF5tiIkG8JO16dMVyma+vpBhfOyjH0S+CfPuPSRvKOikS3F9BOq4QkJ459bE7yrtN
        PH0JBrwHYXbhwbnAHtyrtiiU+XbjHxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-HkjxGxMeNaeuxa9XXPlvZQ-1; Mon, 19 Apr 2021 17:39:00 -0400
X-MC-Unique: HkjxGxMeNaeuxa9XXPlvZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D091006C82;
        Mon, 19 Apr 2021 21:38:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-35.rdu2.redhat.com [10.10.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0513319C66;
        Mon, 19 Apr 2021 21:38:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8FDA722054F; Mon, 19 Apr 2021 17:38:52 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org
Cc:     virtio-fs@redhat.com, slp@redhat.com, miklos@szeredi.hu,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        vgoyal@redhat.com
Subject: [PATCH v3 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date:   Mon, 19 Apr 2021 17:36:33 -0400
Message-Id: <20210419213636.1514816-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V3 of patches. Posted V2 here.

https://lore.kernel.org/linux-fsdevel/20210419184516.GC1472665@redhat.com/

Changes since v2:

- Broke down patch in to a patch series (Dan)
- Added an enum to communicate wake mode (Dan)

Thanks
Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.25.4

