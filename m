Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4042262C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhJEMTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 08:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234722AbhJEMTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633436233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRKr51/8zMLS50oc29PqKZsNRavWkybmtHfcIniBEhA=;
        b=BMENpT9hORuvvBknrAemFC4ftDda7a0pNOPkSfg1VibETQ5k6Cz8/vVnGQJ8Dkd54hQ9WK
        mOAJ4xbxe98Kr+UDXjSwf77WuCIqaEOxXFhakffkUlPMxFL8Z1KrNj5QbpgdiqSlKVye87
        +ZyGYeqo6On92CYfjHxMQv7QHAJbNa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-_yuhuh9aMZqQMTjblstdTw-1; Tue, 05 Oct 2021 08:17:12 -0400
X-MC-Unique: _yuhuh9aMZqQMTjblstdTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BF101084685;
        Tue,  5 Oct 2021 12:17:10 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5201F443;
        Tue,  5 Oct 2021 12:16:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 4/9] proc/vmcore: let pfn_is_ram() return a bool
Date:   Tue,  5 Oct 2021 14:14:25 +0200
Message-Id: <20211005121430.30136-5-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callback should deal with errors internally, it doesn't make sense to
expose these via pfn_is_ram(). We'll rework the callbacks next. Right now
we consider errors as if "it's RAM"; no functional change.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..a9bd80ab670e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -84,11 +84,11 @@ void unregister_oldmem_pfn_is_ram(void)
 }
 EXPORT_SYMBOL_GPL(unregister_oldmem_pfn_is_ram);
 
-static int pfn_is_ram(unsigned long pfn)
+static bool pfn_is_ram(unsigned long pfn)
 {
 	int (*fn)(unsigned long pfn);
 	/* pfn is ram unless fn() checks pagetype */
-	int ret = 1;
+	bool ret = true;
 
 	/*
 	 * Ask hypervisor if the pfn is really ram.
@@ -97,7 +97,7 @@ static int pfn_is_ram(unsigned long pfn)
 	 */
 	fn = oldmem_pfn_is_ram;
 	if (fn)
-		ret = fn(pfn);
+		ret = !!fn(pfn);
 
 	return ret;
 }
@@ -124,7 +124,7 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (pfn_is_ram(pfn) == 0)
+		if (!pfn_is_ram(pfn))
 			memset(buf, 0, nr_bytes);
 		else {
 			if (encrypted)
-- 
2.31.1

