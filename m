Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C20197C0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgC3Mhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgC3MhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so21399034wro.7;
        Mon, 30 Mar 2020 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUsSnudtXdVgGkOCyPuKO1wMS8K2vY7BbsC18XQpp2g=;
        b=aN8OnYUQaUjPiOUuMlAxIGuQ6G3wHwnuIjlY3p4OSIY1c2DN9n8SLU4fAqlo0E7IN8
         RI1EPry+Caixn7t7rv0ssg4EQv5zbdwoU2deXDjR2z0/uET5Y6rWC3fckZYvlOprVLl+
         0vTTBYx3WlPCPZbBmwKOGbzIzq9VN0V1NpQLuvpYPNeK9y9MQLJuTC+YGdCN1+mr7Fs0
         8GSIreW082aAxa//gqq9ri5laowIC+G9PgaexacIXU2IyIFEu9p4GHMUHwvS6j8vBBm9
         UA/Pj0v7PntuudvdI3pexhOKTrxoF1pSOe5kzudbh0QHQKPxVJU3RGYB6gf6mqS3KijS
         AD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUsSnudtXdVgGkOCyPuKO1wMS8K2vY7BbsC18XQpp2g=;
        b=rhC4BEKzRtx8/lGCmVoGY8XJtXaHn66iJ9ODg1WbQ4ZgZaOLTELK69LDOG0x9qph6X
         lHF5hwnoO1vmDOTDPwrf7VapzzuxFO9qmn/fnPQuqvkpS5L9nYKjabaKkWMMnNsMh6UZ
         Xs5OCQ2AMNAsDBYdGyZBfr2Ff833k+QOTI/5gpIxPI2+dk/IPotGfF2wVcKLHyIx43sJ
         OT+CtXVSrg+3XSOIyibmGYBVfCCypRT6J4iObT6i3cB6zfJZteRA8Y2nohS+Cs7Hy9fk
         OdhjF1lAxboV8wPVItpUUPZn/78jPi8FZ61rX7Vrj/rhaw7X9iOH0Wl5EBwD5buqydhQ
         F5rw==
X-Gm-Message-State: ANhLgQ2jWfuyEAkPj3sNT8To6fqsAcdGF8x3p2XaU4IZgawml4XjX67r
        2O9eJLiBhsLCsSCZYX3gvDS4u2rn
X-Google-Smtp-Source: ADFU+vsunku2VDvNNmS9tn9ToK7xiL/0rgKMQfjzVLsgNC6aM3tdFVaOg6Bqvgq3FFCAf7Le+PPUiw==
X-Received: by 2002:a05:6000:4d:: with SMTP id k13mr14908570wrx.356.1585571836590;
        Mon, 30 Mar 2020 05:37:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h5sm21671884wro.83.2020.03.30.05.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:16 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 7/9] XArray: the NULL xa_node condition is handled in xas_top
Date:   Mon, 30 Mar 2020 12:36:41 +0000
Message-Id: <20200330123643.17120-8-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From the last if/else check, it handles the NULL/non-NULL xa_node
mutually exclusively. While the NULL xa_node case is handled in the
first condition xas_top().

Just remove the redundant handling for NULL xa_node.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 0c5b44def3aa..82570bbbf2a5 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -650,16 +650,12 @@ static void *xas_create(struct xa_state *xas, bool allow_root)
 		slot = &xa->xa_head;
 	} else if (xas_error(xas)) {
 		return NULL;
-	} else if (node) {
+	} else {
 		unsigned int offset = xas->xa_offset;
 
 		shift = node->shift;
 		entry = xa_entry_locked(xa, node, offset);
 		slot = &node->slots[offset];
-	} else {
-		shift = 0;
-		entry = xa_head_locked(xa);
-		slot = &xa->xa_head;
 	}
 
 	while (shift > order) {
-- 
2.23.0

