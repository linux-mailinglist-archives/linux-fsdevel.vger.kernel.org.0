Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0677C259070
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgIAOah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 10:30:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728413AbgIAO05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598970417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSXHW4rwxk+rln/8wtmfuMpbc6SR9rLqY65Wct12K5w=;
        b=Yuhm/KcHc1frSH1P7XvVD7T4SkCm7xx4QqV/EzVfOFam+u2Chln+TPIb3pOQgrltf0eM7x
        oebZADynEYHZsLJ3CG8Fz8stcrJ7kkvT6wYmNLyKzFQ9kKeluc+DXbTYgHntTapYOaNTs5
        hK9Hv32JI/HCI4fPwvqO+xlbdmaeQbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-RTHb7Z4GOaOT_jpJDmoRAQ-1; Tue, 01 Sep 2020 10:26:55 -0400
X-MC-Unique: RTHb7Z4GOaOT_jpJDmoRAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366AF801A9E;
        Tue,  1 Sep 2020 14:26:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C131002D5A;
        Tue,  1 Sep 2020 14:26:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 05A682255D9; Tue,  1 Sep 2020 10:26:46 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 2/2] fuse, dax: Save dax device in fuse_conn_dax
Date:   Tue,  1 Sep 2020 10:26:34 -0400
Message-Id: <20200901142634.1227109-3-vgoyal@redhat.com>
In-Reply-To: <20200901142634.1227109-1-vgoyal@redhat.com>
References: <20200901142634.1227109-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is needed later in fuse_iomap_begin to fill iomap->dax_dev. Otherwise
dax generic code (dax_iomap_rw()) returns -EOPNOTSUPP.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index c7099eec17b4..aa89173234c1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1296,6 +1296,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
 
 	fcd->nr_free_ranges = nr_ranges;
 	fcd->nr_ranges = nr_ranges;
+	fcd->dev = dax_dev;
 
 	fc->dax = fcd;
 	return 0;
-- 
2.25.4

