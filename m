Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3322CDDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGXSid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgGXSid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06ytkjVAvyBae2U5rl80yxLCbeymxFczMdXZruRQj+A=;
        b=gVRxUqjt8fJ1+UlKDMA3O375lW/h+QgkfKgNb4KwjYbx97SU7LeyWWnfcBmM8enYXnSzJz
        +dp3pHxlvNoqc4LG2CG8qNWcY4V4jdpWKfcPVqwmmU2xDk5bu0Enxid455crbvJ1wy7FWl
        XYmU9enNK+8VtrInYu5q247j+FCmf20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-mmUzY3Q2P6OCfngNe0uPog-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: mmUzY3Q2P6OCfngNe0uPog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4A1107BEF6;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A374010013D7;
        Fri, 24 Jul 2020 18:38:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3EA12223D06; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH 4/5] fuse: For sending setattr in case of open(O_TRUNC)
Date:   Fri, 24 Jul 2020 14:38:11 -0400
Message-Id: <20200724183812.19573-5-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

open(O_TRUNC) will not kill suid/sgid on server and fuse_open_in does not
have information if caller has CAP_FSETID or not.

So force sending setattr() which is called after open(O_TRUNC) so that
server clears setuid/setgid.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 82747ca4c5c8..0572779abbbe 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1516,7 +1516,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* This is coming from open(..., ... | O_TRUNC); */
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
-		if (fc->atomic_o_trunc) {
+		if (fc->atomic_o_trunc && !fc->handle_killpriv_v2) {
 			/*
 			 * No need to send request to userspace, since actual
 			 * truncation has already been done by OPEN.  But still
-- 
2.25.4

