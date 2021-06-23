Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BE3B185A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFWLCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:22 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:43742 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFWLCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:16 -0400
Received: by mail-wm1-f44.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so1051229wma.2;
        Wed, 23 Jun 2021 03:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8WXhUdDCLyoaqLE/ASdptZOs5V4AdT2Ca24aztnZxs=;
        b=GQt4gDX+BzpqgdlH3SnalvvHlwe/tZdRwTXa8Pyan6VwJHqMoGCoye65vzOynHA0Ue
         cBzlaukInvBQe88WqQuXqksa6woQZ6H6uugo+L2VE7NgiV9A3nwV62YTuKNIA6stjAmM
         fZnPAj9+RySFxZPZ3mY9uEkAlGC+j2MaHry0a3vpgwmwUimEtRi5uqhK3BNB+cf6LTAG
         tIUmjDVo1rFkoSa8zxOThzTQEUYSqOLpSM7cO6j0Wiay+5+E5xPrHIfqyU3hpDpjiNjC
         PQQ9Q3KzI4LfST7lAv4adJAxJhIjH7OKO0XuaHBwln2BAvN+dW0tR+bUBX95IsOCyHQt
         +Yiw==
X-Gm-Message-State: AOAM531BE37U9ndYAR7iuPPj7sgi/b1NfeJuy2LQWb7R6ipHW/gbAaW+
        J0g/JBFzN1FTah3Z7Oeh5+O2OEpGCCfruw==
X-Google-Smtp-Source: ABdhPJxqlC8kPRYJureYms4UjWCazY4rKJs4g//PH6vLYW5YmB65+cNXHoGoHZAxDB1J709YJgfiEQ==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr9891587wml.74.1624445997681;
        Wed, 23 Jun 2021 03:59:57 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:57 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v3 5/6] block: increment sequence number
Date:   Wed, 23 Jun 2021 12:58:57 +0200
Message-Id: <20210623105858.6978-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Increment the disk sequence number when the media has changed,
i.e. on DISK_EVENT_MEDIA_CHANGE event.

    $ cat /sys/class/block/sr0/diskseq
    12
    $ eject
    $ cat /sys/class/block/sr0/diskseq
    22

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 768d8d5d1eca..9d58e0ea18ae 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1657,6 +1657,9 @@ static void disk_check_events(struct disk_events *ev,
 
 	spin_unlock_irq(&ev->lock);
 
+	if (events & DISK_EVENT_MEDIA_CHANGE)
+		inc_diskseq(disk);
+
 	/*
 	 * Tell userland about new events.  Only the events listed in
 	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
-- 
2.31.1

