Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C222B9E59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 00:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKSX2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 18:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSX15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:27:57 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E09C0613D4;
        Thu, 19 Nov 2020 15:27:57 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id y17so10300389ejh.11;
        Thu, 19 Nov 2020 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEG2CD9QwVdNv/i79I+tmKVH9JHsgkoJa/Bpyng44Pw=;
        b=pDS4YWZM0xDCSyd7nQ6UXWzJ6iVm+gjhGcLXJPGeQAuGW+RgzJJJwSUJeeJ28Scfa0
         OavWqmLPvWVxtQf5u+xeEUtJaJexbLO5SQV7wnuk4pce+xjeXBpbqUtMGUBnQB/L/823
         FDnHmUCBsGIyQUZeKFf2cT4ru7uBHB9X+yFY/Zoq7M6MiRfBRl8fTsCswNc6s3guI35k
         6XbEYg5j4bZMiAigGMBWoofx2q5iIfgFNKAemAVOF8RAEnIV8kcnCfkjjNPQ8k+1ztgO
         e7h+CeFWlam70lGYaehyBuqoZi0BC9m6pVrtOV8abLkOMq7iNFIyZ1oK12MZ9cXKGa1P
         sgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEG2CD9QwVdNv/i79I+tmKVH9JHsgkoJa/Bpyng44Pw=;
        b=S/dKgnG18JW0UolUcrXmnwWV9ggYHDu+WSW1JMcVGjgyB5sbDRX/mQ78G+vs9YITCq
         bnLwS1eepGcG8WxA4pdDVAoL6t1u90y1mv6b4P+fp6DFJH3NLEgEdydIrIvJ0uZNOnN5
         Oo3H4a1S7tOILbIOg+i/mKBK4koE67eC4jgmUcWobwjuTDK64DKrW25zeO7t0xsB+DWO
         D3jJowK7lfRpvuORNNk5IsH1uBf+DQLdAn3/HeCJqbk8cV8UnfW02QIyfzdW42cB+MYd
         5rcb1T35hxcoF5XeDCHZ9qL6SxgL7odnfcn+EBdclPMYaZ5eo8Tpm9IBXsrjQQMD8SdD
         WRiQ==
X-Gm-Message-State: AOAM532km5Dh6qadsIEget2Z7cptaNFwPuNKwamYgADo9MDF0LrPSzjV
        10o4wsQtXZFxmLMPq+wCObkgyH0ledWRiA==
X-Google-Smtp-Source: ABdhPJxrJaJb5bLlCj4U3qmJ2UGveo4KTfxI/RC3Z19irfRIvbrRMnlilouwTp2Y4RfowAF4ODg1FQ==
X-Received: by 2002:a17:906:b745:: with SMTP id fx5mr20185565ejb.103.1605828475893;
        Thu, 19 Nov 2020 15:27:55 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id n3sm458114ejl.33.2020.11.19.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:27:55 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iov_iter: optimise iter type checking
Date:   Thu, 19 Nov 2020 23:24:39 +0000
Message-Id: <70d65e06b22cfb11f70b92c12c4d176f36b0e646.1605827965.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605827965.git.asml.silence@gmail.com>
References: <cover.1605827965.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The problem here is that iov_iter_is_*() helpers check types for
equality, but all iterate_* helpers do bitwise ands. This confuses
compilers, so even if some cases were handled separately with
iov_iter_is_*(), corresponding ifs in iterate*() right after are not
eliminated.

E.g. iov_iter_npages() first handles bvecs and discards, but
iterate_all_kinds() still checks those iter types and generates actually
unreachable code including iter init, for(), etc.

size lib/iov_iter.o
before:
   text    data     bss     dec     hex filename
  24409     805       0   25214    627e lib/iov_iter.o

after:
   text    data     bss     dec     hex filename
  23785     793       0   24578    6002 lib/iov_iter.o

Most of it is ifs that are executed but never true.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..c5970b2d3307 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -57,27 +57,27 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_IOVEC;
+	return iov_iter_type(i) & ITER_IOVEC;
 }
 
 static inline bool iov_iter_is_kvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_KVEC;
+	return iov_iter_type(i) & ITER_KVEC;
 }
 
 static inline bool iov_iter_is_bvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_BVEC;
+	return iov_iter_type(i) & ITER_BVEC;
 }
 
 static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_PIPE;
+	return iov_iter_type(i) & ITER_PIPE;
 }
 
 static inline bool iov_iter_is_discard(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_DISCARD;
+	return iov_iter_type(i) & ITER_DISCARD;
 }
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
-- 
2.24.0

