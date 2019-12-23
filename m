Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57E129B9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLWW4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727028AbfLWW4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eqUlR7O5ItJZvt5VamFpVvKNarH3yz0ic7VAKiE8+I=;
        b=JLnzsNjs0aWFdcso0z6uApF2lHCXlamjAoTTv/kdGS+czQImLAxGdqXDGFadV0ZuCmOD6i
        B1+owuYH6H/OJlVe11oZC5+jenHEPoi01uOtXhYf+mcWe41trELVi2k+BIFQdH0dHtJWTA
        Qpuxln0mZ5FBEOdTzfW5gap01ny6TKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-XZvnH7IvNFCASfr2LpmdQg-1; Mon, 23 Dec 2019 17:56:04 -0500
X-MC-Unique: XZvnH7IvNFCASfr2LpmdQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FD9DB60;
        Mon, 23 Dec 2019 22:56:03 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C87160BE2;
        Mon, 23 Dec 2019 22:56:02 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 2/9] printk: Bring back printk_emit
Date:   Mon, 23 Dec 2019 16:55:51 -0600
Message-Id: <20191223225558.19242-3-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Needed for adding structured logging in a number of different areas.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 include/linux/printk.h |  5 +++++
 kernel/printk/printk.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index c09d67edda3a..06c3ba5b695e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -167,6 +167,11 @@ int vprintk_emit(int facility, int level,
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
=20
+asmlinkage __printf(5, 6) __cold
+int printk_emit(int facility, int level,
+		const char *dict, size_t dictlen,
+		const char *fmt, ...);
+
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
=20
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca65327a6de8..8d7be8c9bb08 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2009,6 +2009,21 @@ asmlinkage int vprintk(const char *fmt, va_list ar=
gs)
 }
 EXPORT_SYMBOL(vprintk);
=20
+asmlinkage int printk_emit(int facility, int level,
+			   const char *dict, size_t dictlen,
+			   const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r =3D vprintk_emit(facility, level, dict, dictlen, fmt, args);
+	va_end(args);
+
+	return r;
+}
+EXPORT_SYMBOL(printk_emit);
+
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
--=20
2.21.0

