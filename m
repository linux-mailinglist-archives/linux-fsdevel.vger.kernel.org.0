Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02462B715D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 23:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgKQWRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 17:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgKQWRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:17:24 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8485BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 14:17:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h16so12896582pgb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 14:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AKTlH6BszfFIdFvRY+5BUmDZhqOvdYnZHRsPDQxl+fU=;
        b=EwIaQl0XyUgasMSGGeBRCsshCzyAm2YsiBB8iMl4jaigwlZuTOpgERcGy956zSUEUF
         u/VsgRStIIjhi94luz19OQe3PGtNkhklP5kARvwXg6HGybeAEiRDn6kL9Fy2wcgLkRtI
         8Wil4C45mXl5fRXT+O/znNBct4KekrBV+eZWbouaauEV9KSQMA43swxz6749WMXSJOyB
         pzLII7YHTMSTWCym49AlqvOduWmHUaDTLQG5f8GamEIzzqHxcl16cWuMsn1gb5xLUIZ1
         +tWFq4vipTPoZ+VTVtdokLkDp+SQLuavvc1BTzh9dmgIchTeuuxOkPbAoWv8l3RKZMt9
         /nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AKTlH6BszfFIdFvRY+5BUmDZhqOvdYnZHRsPDQxl+fU=;
        b=HkQKdIP/H0bSMikK0KCdVQJNQS64Nm6LnxYUvl0j7ISbqn9FcRQIWyq08ADawbdlfG
         LE+vF76Lw41eRXnepaMxDhF6B05txijzLfH5jrPalRY8s856YAnnfJM7qIWPWwBfprIa
         kdzj7A9uckCiq55YlbFcQIEvPySZIqELwLMNVU8Ma1dzOn47BskShdMZxBBkp8xXcqk/
         G/rLzLALsimL/0Uo/WFi72pwznkEYSW4QktsgNW428fzYrpfzVK57IWxJbaEw7bRQxYB
         PF+pViagxkfr6CD2368dN2u9O0Wy77yO6rvVZIWf2o7uZfU2TiQ341MEZhsRUYtoAk+h
         t39Q==
X-Gm-Message-State: AOAM532iR2+Geyj4FgUKbcfUqsO8RBXiSA9qfNXa34VLxnSzM6nj48Ft
        WgmZ+ov46Ff2mN0o4nHS6gY4bwqwW7l3sw==
X-Google-Smtp-Source: ABdhPJwq2hqX/Nb2KmPkKRSshpmmsebVnfHpt7csMm9KSIXlayWigtR1lk1u0rbxr6YlzoQqUGgnOQ==
X-Received: by 2002:a63:5963:: with SMTP id j35mr5120887pgm.55.1605651441680;
        Tue, 17 Nov 2020 14:17:21 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id in14sm59706pjb.57.2020.11.17.14.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:17:20 -0800 (PST)
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
Date:   Tue, 17 Nov 2020 15:17:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we've successfully transferred some data in __iomap_dio_rw(),
don't mark an error for a latter segment in the dio.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
IO. If we do parts of an IO, then once that completes, we still
return -EAGAIN if we ran into a problem later on. That seems wrong,
normal convention would be to return the short IO instead. For the
-EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
and complete it successfully.

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..1aa462bf9266 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -538,7 +538,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	} while ((count = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
-	if (ret < 0)
+	/*
+	 * Only flag an error if we're still at the start of the operation.
+	 * If we've already done some IO, return a short result instead.
+	 */
+	if (ret < 0 && iocb->ki_pos == pos)
 		iomap_dio_set_error(dio, ret);
 
 	/*

-- 
Jens Axboe

