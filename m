Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDA68161F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjA3QO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbjA3QOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:14:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADCA0;
        Mon, 30 Jan 2023 08:14:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so1033139pjd.2;
        Mon, 30 Jan 2023 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhCJkgKmno3Ehnuu2/UZ2Sk/flUz8J0C2jHe7kwnTK4=;
        b=GL0ynBl0gGdadbS5zkFARsHT+8kyPonuFb3c8tiGcfOUl3/+EQOlzVbIGwY8dSAaRB
         tJJEdCRBAoBM2JkqcOYd02wORea2jGZzZQKZ6TeMLaBvYga6hJ/qZ2UUq9XD0XX1hzvu
         ODuD2dK5LTak2ZUqfTNyq7FebBOABICxZ1tT8lTb/tFfkWxkL/phPga54fTzLASqXUrX
         /3Hg0VgwTK04jW6K2+nrftEoqn0XdTvC45Wnz/uFxtS8v0Sq7NP8tLy2UztKbMBxpoFW
         s1Q0OostBp3K9ddNJR6qDn5E3nGLSQiKKjc4px447VU1ezPI6XLvPQqnZyaIckBkIXTs
         LNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhCJkgKmno3Ehnuu2/UZ2Sk/flUz8J0C2jHe7kwnTK4=;
        b=KycJyD0iW3R8NArOHZun4tC8sEfHd+0lTAp7uo41Q7h9VqxlblJR+tqd71k0ufgMTm
         v6nFDeHKPkIdg+1vRYmi/0S8azsw1SZTqKVtRUToxul/SI99yuw0zPNazbSIYHM06O4Y
         xkdsLhmW6BwLuaqnFjJGEZ6KgkWIKuyjjwoZ0R/FERtAmut3Kj08lU/4JiINBrFoJL3w
         YYenuSHC93YvB1dbjfH3cRTTgQ66zQN8bZpEW8sO+Oagq8cx4EKA13Ib9NQyWfLP0VbZ
         oh31sikkVRuMjeNcRpgRDtmTyMOCjn2qGtyykfp+UlRKoCr1m5BtkPev69DylU0IVoIM
         yDeg==
X-Gm-Message-State: AO0yUKWju6xVcquxcLCCTVdrk54GDoSXBMKR6zs+VOwovJ33DkQW9Gqd
        swpStF8a/AS0vZxU/Jx7fUgrnBgOO14=
X-Google-Smtp-Source: AK7set+QChc6p40jqgU7RJABjPbrGQ3BFbvNxwrkfk4RjL1SioZBs3aXyorbCh5NlvfRkhopAlN3dw==
X-Received: by 2002:a17:902:c94e:b0:194:dda9:7b40 with SMTP id i14-20020a170902c94e00b00194dda97b40mr10767578pla.2.1675095293314;
        Mon, 30 Jan 2023 08:14:53 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001949ae8c275sm8002937plh.141.2023.01.30.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:14:52 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Aravinda Herle <araherle@in.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 1/3] iomap: Move creation of iomap_page early in __iomap_write_begin
Date:   Mon, 30 Jan 2023 21:44:11 +0530
Message-Id: <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675093524.git.ritesh.list@gmail.com>
References: <cover.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before this commit[1], we used to call iomap_page_create() before
checking folio_test_uptodate() in __iomap_write_begin().

The problem is that commit[1] moved iop creation later i.e. after checking for
whether the folio is uptodate. And if the folio is uptodate, it simply
returns and doesn't allocate a iop.
Now what can happen is that during __iomap_write_begin() for bs < ps,
there can be a folio which is marked uptodate but does not have a iomap_page
structure allocated.
(I think one of the reason it can happen is due to memory pressure, we
can end up freeing folio->private resource).

Thus the iop structure will only gets allocated at the time of writeback
in iomap_writepage_map(). This I think, was a not problem till now since
we anyway only track uptodate status in iop (no support of tracking
dirty bitmap status which later patches will add), and we also end up
setting all the bits in iomap_page_create(), if the page is uptodate.

[1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..e9c85fcf7a1f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -527,7 +527,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct iomap_page *iop;
+	struct iomap_page *iop = iomap_page_create(iter->inode, folio,
+						   iter->flags);
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -539,7 +540,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
-- 
2.39.1

