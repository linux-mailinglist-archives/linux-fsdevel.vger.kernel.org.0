Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005C920EA0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgF3AMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 20:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgF3AMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:12:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D1C061755;
        Mon, 29 Jun 2020 17:12:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u17so14361889qtq.1;
        Mon, 29 Jun 2020 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a69CpnZLhKaGE1y0QOjVkguQ4McgCYqiRLiuKO0SAy8=;
        b=GFm7AzGEPZ4Jj7QmMtUX1wX/lPCFF3ui8xB2R2I+qzidRQDyha1w55qUaLedEfCFAn
         Gtxk5h8Nyi2PzXPXiAL57oPvlnPUpL1Uwka4+MMObk4LHbzbAd8tI5Dab5+LDttpOcMa
         nQ3xL3GZ5hr1ycGewInPXZ+V4JEc6k2su+yu8nOBkBEffSSNYYVY5d8RnI/81arZ5Sd1
         jD1vlzwMaH1tIT8cCPJAjzSKgVmNRFbSOBwX2OkNIUU2XLBc+1ugrkK+8HQxwvVIXSAz
         vBsFQYoeU/GjPdToYcr3HYxYxNTIkmGyvuP5f3YBKCAFUJ3mgnebOHzeQQjthjERpgeo
         BXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a69CpnZLhKaGE1y0QOjVkguQ4McgCYqiRLiuKO0SAy8=;
        b=ttnlN7HwchtLoBelQsxLk9ArVd2xOhhm3GkF5hkVhZetjKUbGzKjVGMrOTVXlt30il
         FZkwYSgJ4iNjAQpBIqD+uA2fKzeo4ZYt0Irk0NkWFLyhgcDSM6R6vhgq6uYwRiEnjV7p
         MMrCc8AnHLNxxdfqFhjSghaFuaSmNRtsM0EyR3IEyAP90p+FgchECmf5e85wkQz7nKpl
         mDS0K0kHWET/MR819bRvAO7YwNaQt06tNEHug72own1iDzbgkyrdYAn3dxi6fGR19zTU
         2xhfiC9LPfc5WFs6aBcVyMBYEwCbxFu2zogfLniyrQ2OcI8EJhHdPBJlzw+FUVEqzVb+
         J3+w==
X-Gm-Message-State: AOAM532SP52ZVEoqrT+lGRzrz4UNcE0z5bS3TdKpYVpcbkB0jp6SqOoX
        Fupp88Dr3G73ygGy0cIdqGFjnqJ8Cw==
X-Google-Smtp-Source: ABdhPJwMgJpDqP2Zu3aVARiPmklrqVzcOSGKmzF5cBLo/EZlvLhWjlgVkYZbkyLFh0CPrqSrUzDOKw==
X-Received: by 2002:ac8:3778:: with SMTP id p53mr18927663qtb.228.1593475957498;
        Mon, 29 Jun 2020 17:12:37 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id m26sm1579630qtm.73.2020.06.29.17.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:12:37 -0700 (PDT)
Date:   Mon, 29 Jun 2020 20:12:33 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Fixup patch for [PATCH 0/2] generic_file_buffered_read() refactoring
 & optimization
Message-ID: <20200630001233.GA39358@moria.home.lan>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610001036.3904844-1-kent.overstreet@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew - fixup patch because I got a bug report where we were trying to do an
order 7 allocation here:

-- >8 --
Subject: [PATCH] fixup! fs: generic_file_buffered_read() now uses
 find_get_pages_contig

We shouldn't try to pin too many pages at once, reads can be almost
arbitrarily big.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d8bd5e9647..b3a2aad1b7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2220,8 +2220,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	size_t orig_count = iov_iter_count(iter);
 	struct page *pages_onstack[8], **pages = NULL;
-	unsigned int nr_pages = ((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
-		(iocb->ki_pos >> PAGE_SHIFT);
+	unsigned int nr_pages = min_t(unsigned int, 512,
+			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
+			(iocb->ki_pos >> PAGE_SHIFT));
 	int i, pg_nr, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
-- 
2.27.0


