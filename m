Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4266C3C49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCUUyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUUyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:54:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E5559E6;
        Tue, 21 Mar 2023 13:54:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so15025234wra.13;
        Tue, 21 Mar 2023 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679432082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4AaWDqV89kHBZGOLd4BouvpuEGkoHHTR7oX6vXaXkQ=;
        b=DtrM/GAKL+afDECOYccj2A5NhbOt6QK4UCjV13FFWN1N4jdaBAT7gMxRmDEF1VBl0P
         q3bv04VT2AAKYj3fgVyGX+Bgl1DxuKhi2zmCw43Wrs0lCpWjbH64Spf8AoWlaPVMN/v/
         oAhA+kOXLwYCnp/iFu8s+4yz1zzFzZ2ooIjv9OsNw2iC1z23zCT8m8r2AxgC6o1idz71
         eZD3+7KhlXMM3oNj2pL+K/eVyfuLeAoQLKL7AyCM9Qq+cSBR2dA4BjZdpGTHKfh2lRNz
         TLHUqXEDW+pMxZc41EOW+Mj0c3BRWjubPngA3fKrogTi6IMSk6P29qijajn8rQOmbvO0
         5weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679432082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4AaWDqV89kHBZGOLd4BouvpuEGkoHHTR7oX6vXaXkQ=;
        b=Sm4J/2pXBvf85YcHnE0x4WQ+aQG017NRXdAbbq3I2YnNRCpW+nbYzi9z0VQgy+m5Dj
         7+xazX2PsZbwbNt8gdHOFSx3jsBX7I1g1K6ljiEkKxlYUC6jqCxrIdb7SRlu2OTro9MB
         cR7lt+f7L9+ENEPb6PoHSqoEj+zo0qfma6q6uzo/xuH3THhzCQDd4jrunkEcMxcvXbrn
         qY7KDm+5rFlem/askF44FEUrzZPIGk0Ubp4cXEGsFxUscdlUlMNSBIUMHiNxj5JaZZdO
         Y1dOpAOUBA8Ti9wgx9ngRvcriulHbLZg19ja2e1nFwrNWy40AxZ05Ei+nH7ePMc7w3Iy
         u2jg==
X-Gm-Message-State: AO0yUKXuR5lMs878716lPhX3mNO/PmdTJH8/OHdpMv52RtqEDB4RihJU
        9RAGToPXn9qCRwPQMl3lob4=
X-Google-Smtp-Source: AK7set+oirJx1dsvQlN/Z2V/fsl/sXGk9/Y29eUdqktVmfmf2jbXPagkewMzFvuQJ63lAYAj1jwkaQ==
X-Received: by 2002:adf:e652:0:b0:2ce:a80c:3747 with SMTP id b18-20020adfe652000000b002cea80c3747mr3208960wrn.71.1679432082307;
        Tue, 21 Mar 2023 13:54:42 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm3744575wrx.25.2023.03.21.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:54:41 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 3/4] iov_iter: add copy_page_to_iter_atomic()
Date:   Tue, 21 Mar 2023 20:54:32 +0000
Message-Id: <31482908634cbb68adafedb65f0b21888c194a1b.1679431886.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431886.git.lstoakes@gmail.com>
References: <cover.1679431886.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an atomic context equivalent for copy_page_to_iter(). This eschews
the might_fault() check copies memory in the same way that
copy_page_from_iter_atomic() does.

This functions assumes a non-compound page, however this mimics the
existing behaviour of copy_page_from_iter_atomic(). I am keeping the
behaviour consistent between the two, deferring any such change to an
explicit folio-fication effort.

This is being added in order that an iteratable form of vread() can be
implemented with known prefaulted pages to avoid the need for mutex
locking.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..fab07103090f 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
+size_t copy_page_to_iter_atomic(struct page *page, unsigned offset,
+				size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..48ca1c5dfc04 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -821,6 +821,34 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
+size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_t bytes,
+				struct iov_iter *i)
+{
+	char *kaddr = kmap_local_page(page);
+	char *p = kaddr + offset;
+	size_t copied = 0;
+
+	if (!page_copy_sane(page, offset, bytes) ||
+	    WARN_ON_ONCE(i->data_source))
+		goto out;
+
+	if (unlikely(iov_iter_is_pipe(i))) {
+		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
+		goto out;
+	}
+
+	iterate_and_advance(i, bytes, base, len, off,
+		copyout(base, p + off, len),
+		memcpy(base, p + off, len)
+	)
+	copied = bytes;
+
+out:
+	kunmap_local(kaddr);
+	return copied;
+}
+EXPORT_SYMBOL(copy_page_to_iter_atomic);
+
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.39.2

