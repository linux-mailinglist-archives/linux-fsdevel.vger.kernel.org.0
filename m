Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47CC129BA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLWW4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38506 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727076AbfLWW4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXBplLcKGcpkDyS8yQgGXGNohbofkhElCmjtU2legM0=;
        b=AxipSpEWjGsg4Co0daYo62g8wTNVUa1+BrZB11S4KpD2MtpGbEOSvSbIbxcqIqBzfOXpyO
        LWVFNkCKyDoX97Oqggs9XTt6gV84jWIWCsjtq6fScLFqXqH1qRDyLeNcmDfjFLs1IWqdEp
        +jY40lRd5uJuYkPTmtAJHkqo7VHPMv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-cH2QAAxSOymhWEqg6-2E2A-1; Mon, 23 Dec 2019 17:56:10 -0500
X-MC-Unique: cH2QAAxSOymhWEqg6-2E2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8678E10054E3;
        Mon, 23 Dec 2019 22:56:09 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A373960BE2;
        Mon, 23 Dec 2019 22:56:08 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 7/9] print_req_error: Add persistent durable name
Date:   Mon, 23 Dec 2019 16:55:56 -0600
Message-Id: <20191223225558.19242-8-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add persistent durable name to errors that occur in block mid layer.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 block/blk-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..a0171a7c6535 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -211,11 +211,20 @@ static void print_req_error(struct request *req, bl=
k_status_t status,
 		const char *caller)
 {
 	int idx =3D (__force int)status;
+	char dict[128];
+	int dict_len =3D 0;
=20
 	if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(blk_errors)))
 		return;
=20
-	printk_ratelimited(KERN_ERR
+	if (req->rq_disk) {
+		dict_len =3D dev_durable_name(
+				disk_to_dev(req->rq_disk)->parent,
+				dict,
+				sizeof(dict));
+	}
+
+	printk_emit_ratelimited(0, LOGLEVEL_ERR, dict, dict_len,
 		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
 		caller, blk_errors[idx].name,
--=20
2.21.0

