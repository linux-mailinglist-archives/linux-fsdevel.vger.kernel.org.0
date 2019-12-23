Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B28129B97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLWW4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726995AbfLWW4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gq1+GAMa0C3Il9jYW93UwC35MCssNnsKhwATazBP0NA=;
        b=GbT0KhZ7yQ322/DIfsUT0mmGit5d/ILuOJpZmVlntx0IIGX9E9KJOgld1+guFdxioIBE8q
        5H37cHfr0UfN/NX8rkBYQxrgHumntj7qyHttARbuLsmj3x6LqbN+UsExzXjBHrVnT3E8Jw
        +zksJvqDaPD/2M5kd1GLPWUSRKIZpuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-nuwm2qyyNIOwZBtnPLUHxA-1; Mon, 23 Dec 2019 17:56:09 -0500
X-MC-Unique: nuwm2qyyNIOwZBtnPLUHxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD6D800D41;
        Mon, 23 Dec 2019 22:56:08 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C12360BE2;
        Mon, 23 Dec 2019 22:56:07 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 6/9] create_syslog_header: Add durable name
Date:   Mon, 23 Dec 2019 16:55:55 -0600
Message-Id: <20191223225558.19242-7-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This gets us a persistent durable name for code that logs messages in the
block layer that have the appropriate callbacks setup for durable name.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/base/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 93cc1c45e9d3..57b5f5cd29fc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3318,6 +3318,15 @@ create_syslog_header(const struct device *dev, cha=
r *hdr, size_t hdrlen)
 				"DEVICE=3D+%s:%s", subsys, dev_name(dev));
 	}
=20
+	if (dev->type && dev->type->durable_name) {
+		int dlen;
+
+		dlen =3D dev_durable_name(dev, hdr + (pos + 1),
+					hdrlen - (pos + 1));
+		if (dlen)
+			pos +=3D dlen + 1;
+	}
+
 	if (pos >=3D hdrlen)
 		goto overflow;
=20
--=20
2.21.0

