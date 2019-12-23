Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6E1129B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfLWW4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726943AbfLWW4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ti74zgLwc9xdwukIMd+N9Ca9W+CO/0vNVJxfQlPd5OY=;
        b=W55TwLRVxXdSlIuqNsjAL4iDpU1YYUXLLAJtb2gWMsA5lOMrFSDuechr0dIzYWrZ8DMrBo
        bzVt2fYtrndu8286F11XzHaR+YcbJ0r/1qyKrb+pEQpINZLDKaCRl4k0PvwNFPBbaoRDWf
        xP4Xbdmh48x43VIpyQLJ/IycrwnansY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116--SyhMrKbN4Kn6hs4rcI6dA-1; Mon, 23 Dec 2019 17:56:03 -0500
X-MC-Unique: -SyhMrKbN4Kn6hs4rcI6dA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BBF510054E3;
        Mon, 23 Dec 2019 22:56:02 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E50160BE2;
        Mon, 23 Dec 2019 22:56:01 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 1/9] lib/string: Add function to trim duplicate WS
Date:   Mon, 23 Dec 2019 16:55:50 -0600
Message-Id: <20191223225558.19242-2-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds function strim_dupe which trims leading & trailing whitespace and
duplicate adjacent.  Initial use case is to shorten T10 storage IDs.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 include/linux/string.h |  2 ++
 lib/string.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index b6ccdc2c7f02..bcca6bfab6ab 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -72,6 +72,8 @@ extern char * __must_check skip_spaces(const char *);
=20
 extern char *strim(char *);
=20
+extern size_t strim_dupe(char *s);
+
 static inline __must_check char *strstrip(char *str)
 {
 	return strim(str);
diff --git a/lib/string.c b/lib/string.c
index 08ec58cc673b..1186cce1f66b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -515,6 +515,41 @@ char *strim(char *s)
 }
 EXPORT_SYMBOL(strim);
=20
+/**
+ * Removes leading and trailing whitespace and removes duplicate
+ * adjacent whitespace in a string, modifies string in place.
+ * @s The %NUL-terminated string to have spaces removed
+ * Returns the new length
+ */
+size_t strim_dupe(char *s)
+{
+	size_t ret =3D 0;
+	char *w =3D s;
+	char *p;
+
+	/*
+	 * This will remove all leading and duplicate adjacent, but leave
+	 * 1 space at the end if one or more are present.
+	 */
+	for (p =3D s; *p !=3D '\0'; ++p) {
+		if (!isspace(*p) || (p !=3D s && !isspace(*(p - 1)))) {
+			*w =3D *p;
+			++w;
+			ret +=3D 1;
+		}
+	}
+
+	*w =3D '\0';
+
+	/* Take off the last character if it's a space too */
+	if (ret && isspace(*(w - 1))) {
+		ret--;
+		*(w - 1) =3D '\0';
+	}
+	return ret;
+}
+EXPORT_SYMBOL(strim_dupe);
+
 #ifndef __HAVE_ARCH_STRLEN
 /**
  * strlen - Find the length of a string
--=20
2.21.0

