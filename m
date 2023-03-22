Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5C6C4D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCVOTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjCVOTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:19:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB164B09;
        Wed, 22 Mar 2023 07:19:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso11602499wmq.5;
        Wed, 22 Mar 2023 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD0MPlFrVhMWSH5JN60JlycyouFVYe+2olLzRC7osbE=;
        b=C6/LkRzwK9EU+t9L1+/8UNylNMvB2c11Yb4Mb4/XxHblz1eiSn5TaVze/YjByASzhj
         4q5rVNpp5g5+0rWeNPKS/AiMFsdsXNmKJqOiV1fBLNZZBb1oFCtPYlEdeiRN3sEyYDJL
         mV130lrgZ35byML8aQBjpE/69HUr2l9LsFMLsvH8ltEP4c5czi3mhkFyBKXLbPIPKejk
         UjUlooZPlYTs4SjUSwkl8tnavetMXC6VKmD/XN/oJ25+t2HJ7CKqy5+tTFvkmGsaUl37
         QS5GAJrec4Swa2SAQAyoXifPpEOnpCM4wqyho1uYN3W2qdFaBatBd4u9XHnO/2t3xVoQ
         s4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD0MPlFrVhMWSH5JN60JlycyouFVYe+2olLzRC7osbE=;
        b=VgNswDew3AyAoc5MFnI2ptOqecfqPMHDxRKQBKvQgwxSx06ABMhSLL8K/5ztU0HmnD
         tR2eDVSs5L9s9O7jy5SCMzqE+RXbHLaEDnzafUpFrfeXdMZP+MiiPGgd9awOrwQ4rmsl
         rWzHxxoxU5pXiyvZLtr4PL69ISlOOAgIxnTzNVpUiE4nio3nMj/2D5A3PiCBLBPQOXTC
         Mn/fERwj+kV74G+Cu91KR0tEuDt8amYAe+L6SCxP1WakZLh89YcuC2vDJ4aZfuHlNQwq
         Gzfx06UkMzFPNpJhdqsHrMb7QXd5jsqM/+nB2fVpKqOD6uWA0FvVmhwjUyi/8yBT0OU4
         rzbQ==
X-Gm-Message-State: AO0yUKWPaqY64dY3OHXIYMFRUg2fH5QHrhSNelXJWz9xTttHvTblt/kL
        VosW7kkTY1lWTq5fxpsRxjE=
X-Google-Smtp-Source: AK7set8Q+pMrAzLQnW2jTVv25XNsX4jcQlqyllVGurVLuiW4KBf84PEzNxxj/vpaa/czq4q2irivnw==
X-Received: by 2002:a1c:f217:0:b0:3eb:2de8:b739 with SMTP id s23-20020a1cf217000000b003eb2de8b739mr5461982wmc.37.1679494745991;
        Wed, 22 Mar 2023 07:19:05 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id f20-20020a7bcd14000000b003e203681b26sm16872855wmj.29.2023.03.22.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:19:05 -0700 (PDT)
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
Subject: [PATCH v5 3/4] iov_iter: add copy_page_to_iter_nofault()
Date:   Wed, 22 Mar 2023 14:18:50 +0000
Message-Id: <50d2f757ab570dbb84e44eb84e25bd9780842d5f.1679494218.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679494218.git.lstoakes@gmail.com>
References: <cover.1679494218.git.lstoakes@gmail.com>
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

Provide a means to copy a page to user space from an iterator, aborting if
a page fault would occur. This supports compound pages, but may be passed a
tail page with an offset extending further into the compound page, so we
cannot pass a folio.

This allows for this function to be called from atomic context and _try_ to
user pages if they are faulted in, aborting if not.

The function does not use _copy_to_iter() in order to not specify
might_fault(), this is similar to copy_page_from_iter_atomic().

This is being added in order that an iteratable form of vread() can be
implemented while holding spinlocks.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..29eb18bb6feb 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -173,6 +173,8 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 {
 	return copy_page_to_iter(&folio->page, offset, bytes, i);
 }
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
+				 size_t bytes, struct iov_iter *i);
 
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..b286cfea4bee 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -734,6 +734,42 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t bytes,
+				 struct iov_iter *i)
+{
+	size_t res = 0;
+
+	if (!page_copy_sane(page, offset, bytes))
+		return 0;
+	if (WARN_ON_ONCE(i->data_source))
+		return 0;
+	if (unlikely(iov_iter_is_pipe(i)))
+		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	page += offset / PAGE_SIZE; // first subpage
+	offset %= PAGE_SIZE;
+	while (1) {
+		void *kaddr = kmap_local_page(page);
+		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
+
+		iterate_and_advance(i, n, base, len, off,
+			copy_to_user_nofault(base, kaddr + offset + off, len),
+			memcpy(base, kaddr + offset + off, len)
+		)
+		kunmap_local(kaddr);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+	return res;
+}
+EXPORT_SYMBOL(copy_page_to_iter_nofault);
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-- 
2.39.2

