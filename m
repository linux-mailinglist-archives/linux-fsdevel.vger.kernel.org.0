Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D229243442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgHMG4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgHMG4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:56:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE0C061757;
        Wed, 12 Aug 2020 23:56:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so2314865pjx.5;
        Wed, 12 Aug 2020 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/ZXQiDU4LoOHXkIBxZCnA2u6rFmi9ElKGT6dxeDUOGg=;
        b=J3nhGCN9Er4diiB+NQx/QwgQQ8DiZa8+oNuDbBkzJpeZUKy9fExMpuyOK4x57VbA1G
         CqGccmUrvyrnoSLJl8j6jW9D+cdCju1+mHw4aiSc+dqiZ5U7EGDVmSAUX/ZzWxJm97VV
         z31CaibZpbeck1mc1y6MLGbRhRY70sFpojzGgWRkFOTW1+3lLV7N0oxDlPXAqvBZ4CJd
         VbDKv+F4OT/kD1tFKCU4KpREhuP9b11zDQhyUnBoRTC51B4m0gbxCnhc4Y9eccwvAn8R
         dZn28WWqV9kpfDeWrjtvQOn2dpSv1ugLIS6OkjBQBFYGuT+xWi/0YMSXfGS9UV7p+Gd4
         Iuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/ZXQiDU4LoOHXkIBxZCnA2u6rFmi9ElKGT6dxeDUOGg=;
        b=iVMy+9Uf0J/kiBYrPG2QdFqtn4QfTof9jEAKEUCXWOuutLtvyPtdBG2//pvRj5gUIo
         ZTcSMcm4Sxa+hGAwu0z3IiKut5OftvFgWmN/e7Ef5LNlQnG1SZU7BuTKzW1m7ARqTRqx
         chmTCBrSGw+J5qqskgmvsHaxyoL4jLOm+UwI8KEqa6OejLSc7PT+wTNfDGOo+n+isGnU
         z7Ry/7LyIopJfJEHOIu/XFgL5dyOqckZstWkg7KQp76s5f34KI1I9BiG99S1gydRtO/g
         waGvn2beBVAYYC1LMXm34AdkPRmKHWrYSQHpoO9pK90geGDgDvIs3xQngqw0CW+UfAAs
         LTpQ==
X-Gm-Message-State: AOAM533yyUBnhC8OtLDZXKax9bLV7YJG9cEWTEPCoXgjh+9gmdVT04pP
        By4rj2w5fgb0Sjk3CvOPXajSkt4iriU=
X-Google-Smtp-Source: ABdhPJzKG/UEMBN2JxxT4t5ii5/02WxmsNydw/51vWww31PExP8pCnRm6o8ECoDVDiXRlGMhAh1I2w==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr3574665pjb.157.1597301809728;
        Wed, 12 Aug 2020 23:56:49 -0700 (PDT)
Received: from localhost ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id a16sm4807925pfr.45.2020.08.12.23.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 23:56:49 -0700 (PDT)
Date:   Wed, 12 Aug 2020 23:56:44 -0700
From:   Liu Yong <pkfxxxing@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/io_uring.c: Fix uninitialized variable is referenced in
 io_submit_sqe
Message-ID: <20200813065644.GA91891@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

the commit <a4d61e66ee4a> ("<io_uring: prevent re-read of sqe->opcode>") 
caused another vulnerability. After io_get_req(), the sqe_submit struct 
in req is not initialized, but the following code defaults that 
req->submit.opcode is available.

Signed-off-by: Liu Yong <pkfxxxing@gmail.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index be3d595a607f..c1aaee061dae 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2559,6 +2559,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		goto err;
 	}
 
+	memcpy(&req->submit, s, sizeof(*s));
 	ret = io_req_set_file(ctx, s, state, req);
 	if (unlikely(ret)) {
 err_req:
-- 
2.17.1

