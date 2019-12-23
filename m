Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3D129B93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLWW4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726833AbfLWW4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qGtQMo2+Ggjf6Vv8mYhur7z1U69z+rZqXUk93Xvkto=;
        b=TKfhoDptR0vMJIyDPJLlVpxCddeTmR8dS4hOBQgX2MpczfrmM9x7OTu1aXZOukoLzODmoK
        rVLc+Waj5Gn6jd070F2WVYpR2NoKIRWn1UQs5r1i0mfAH9tKEg3uo1x65fUPIvquine8mj
        nxYNIUMCtfQbTjDMSaC621zanCyqXwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-pffGjjZTM4-uEkKFB64OVQ-1; Mon, 23 Dec 2019 17:56:06 -0500
X-MC-Unique: pffGjjZTM4-uEkKFB64OVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAF5D184B44F;
        Mon, 23 Dec 2019 22:56:05 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2FDB60BE2;
        Mon, 23 Dec 2019 22:56:04 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 4/9] struct device_type: Add function callback durable_name
Date:   Mon, 23 Dec 2019 16:55:53 -0600
Message-Id: <20191223225558.19242-5-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function callback to be used in logging functions to write a persistent
durable name to the supplied character buffer.  This will be used to add
structured key-value data to log messages.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 297239a08bb7..dd4ac8db5f57 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -799,6 +799,8 @@ struct device_type {
 	void (*release)(struct device *dev);
=20
 	const struct dev_pm_ops *pm;
+
+	int (*durable_name)(const struct device *dev, char *buff, size_t len);
 };
=20
 /* interface for exporting device attributes */
--=20
2.21.0

