Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E800E43B93C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbhJZSRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhJZSRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:17:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06440C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 11:15:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b188so433570iof.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NsCoSRUU4kSoqJKBkCULN+BKiJAeIiTrQ7Zf4BRmkLU=;
        b=D1RR9QJEaDD2zrBai/+61pncjmtnDAOJhYZoisg4LSpPLL0Y6w+UajRDewdGE5aJpu
         nOXQneSOZeV8B8tn+OaASBzeUKn81JrjRDrwoaveuduIm9UNMWT/xbf7+0WYmSctA9YB
         RoSrKR3dLnhrfQSHI4sPB7E6NCvEx8MBQMmwyq32g0IV6yACSGHpPIZLicC3ZrG0Lb9D
         uYs+0Gry8RLx6eUZqMODvh5l0odGju1SQnJEYC2uompo8rWmjOzi4bUkcNqimKIsI2nZ
         T2WXZx8wQ2dw442SGmyJj1ZkkYJ5g9Tc/hswiPJ0jxi9dy9WhBQg7dAD+B//mrhkTbDB
         CNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NsCoSRUU4kSoqJKBkCULN+BKiJAeIiTrQ7Zf4BRmkLU=;
        b=t2Es++U5D1gXk1qpbMoFeaSObhhSWeh0BpWzZFRt4SCijnTUIUzAqkjiLqXqeiU0gy
         Ovl15q1d/Pk430yrVRQ10cQqB6A+Z9bKISlw1Ai4+zanfTsWo9meyIl/yQ6Zki7+4k6F
         d4i1blYi2yvAC1rPcyuLMefEsC9VTI11CFlyx9LqNSMdoBGd8QC30XY/rpoVEKVidgx9
         lR5yI2G/n58nciOe9+/V7+EoosNjbtXiXBOju7MJvsSWly8AqLuI6+pp71mL53i2AZYK
         5mep5ggBIwidVaxq0ZVrZI5m8jci4BxDqvv514tB+VMY54pY5m0rMQauz4FNkzg9akmY
         SAUA==
X-Gm-Message-State: AOAM533816eDLTYyvBff9bUSpJg7Nkz3wIU7Cv8W+EqzsHfIofD8F3zF
        P3Pg6pwVzRcZVC14r/AUhBsu1w==
X-Google-Smtp-Source: ABdhPJxkgWbGaUfFjw5Lssk59vMnzkeEHdQbgnLlkkMVlyiIZSdtEWOH6BPbcrwtKnoFwXG0CdGX3Q==
X-Received: by 2002:a05:6638:c45:: with SMTP id g5mr12391809jal.16.1635272107353;
        Tue, 26 Oct 2021 11:15:07 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x13sm4632914ile.9.2021.10.26.11.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 11:15:07 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chris Mason <clm@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: mm: don't read i_size of inode unless we need it
Message-ID: <6b67981f-57d4-c80e-bc07-6020aa601381@kernel.dk>
Date:   Tue, 26 Oct 2021 12:15:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We always go through i_size_read(), and we rarely end up needing it. Push
the read to down where we need to check it, which avoids it for most
cases.

It looks like we can even remove this check entirely, which might be
worth pursuing. But at least this takes it out of the hot path.

Acked-by: Chris Mason <clm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

I came across this and wrote the patch the other day, then Pavel pointed
me at his original posting of a very similar patch back in August.
Discussed it with Chris, and it sure _seems_ like this would be fine.

In an attempt to move the original discussion forward, here's this
posting.

diff --git a/mm/filemap.c b/mm/filemap.c
index 44b4b551e430..850920276846 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2736,9 +2736,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		struct file *file = iocb->ki_filp;
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
-		loff_t size;
 
-		size = i_size_read(inode);
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
 						iocb->ki_pos + count - 1))
@@ -2770,8 +2768,9 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * the rest of the read.  Buffered reads will not work for
 		 * DAX files, so don't bother trying.
 		 */
-		if (retval < 0 || !count || iocb->ki_pos >= size ||
-		    IS_DAX(inode))
+		if (retval < 0 || !count || IS_DAX(inode))
+			return retval;
+		if (iocb->ki_pos >= i_size_read(inode))
 			return retval;
 	}
 
-- 
Jens Axboe

