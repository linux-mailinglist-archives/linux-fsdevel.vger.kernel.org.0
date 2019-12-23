Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBA129B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLWW4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38543 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726995AbfLWW4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYMogOorzB+CGid5/i1zzD3nNlcrIJfVcdr7IEB6sKc=;
        b=FH0O6pEP7CwBg7x4Kj1lLzoiwrTSp44Zi+xhSPtwi8m4SqdKEPz6N8Jc4OnxnY9vOPZisL
        QtYicxbl4lbvIDL+pQMGXGOqxuRD7n0Yd26AUEMIbrCFotm6nl4Mm7X18/BDmXLtvF/PQ+
        0Yw/ON7aa0l5qVaP8dcyRQdrtmQshsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-vGrG4TV6PNC4y9lmWKyn5Q-1; Mon, 23 Dec 2019 17:56:05 -0500
X-MC-Unique: vGrG4TV6PNC4y9lmWKyn5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 981E0800053;
        Mon, 23 Dec 2019 22:56:04 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B784C60BE2;
        Mon, 23 Dec 2019 22:56:03 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 3/9] printk: Add printk_emit_ratelimited macro
Date:   Mon, 23 Dec 2019 16:55:52 -0600
Message-Id: <20191223225558.19242-4-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Needed so we can add structured data to the block layer
logging.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 include/linux/printk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 06c3ba5b695e..dd41b79e6f06 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -172,6 +172,18 @@ int printk_emit(int facility, int level,
 		const char *dict, size_t dictlen,
 		const char *fmt, ...);
=20
+#define printk_emit_ratelimited(facility, level,			\
+		dict, dict_len, fmt, ...)				\
+({									\
+	static DEFINE_RATELIMIT_STATE(_ers,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+									\
+	if (__ratelimit(&_ers))						\
+		printk_emit(facility, level,				\
+				dict, dict_len, fmt, ##__VA_ARGS__);	\
+})
+
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
=20
--=20
2.21.0

