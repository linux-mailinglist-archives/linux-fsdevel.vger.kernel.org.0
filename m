Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB97838B0CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbhETOBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:19 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40917 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbhETOAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:00:05 -0400
Received: by mail-ed1-f51.google.com with SMTP id t3so19501101edc.7;
        Thu, 20 May 2021 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtlDwB3yEpx8TeFOnWtic2oPG9XbfzOFhlQoKOiiSos=;
        b=L9+OgeYXZXOUAnxXmDaQ7TiacMKMfHybau048JM+ce6ZDq56WlmVRcAEH4C4UV2Scq
         ZMclq2iyogJs/0PIn105fN0XEeIj8tRDbPAmEN/7mvSoEgRdKboUtaE4BWix4Dtspb0O
         EJ45R+GBapfzT/J98XiCh1RVP698YHnjxamvqyesP8qFN8+yajWfxPiXIn8rJ434lVL1
         Khr4/OClW7FCt+KU2La1J4PkpDNYXT/i0wEQmobv3yr3ccVokd6bvnkwIXBXTPJ9WSkq
         q0X/wyWtJFTtQF/dMo9vOggs4wPLTqQaSeafhbSoqPN9bJEh1lA3QKdddrfsVq8bX/ii
         EATQ==
X-Gm-Message-State: AOAM5302Rh82lHi0KIjQGfLXMMBS2QYEvJZWpuc16kmLr53CyD4U6iKm
        X2UvDBSP6x156QDE9SRSXwyV4va0JVBna+sE
X-Google-Smtp-Source: ABdhPJzyZajk10SLdiMnhCpzUy1ZNox8Rmvv7xIIn3LrC0A4+H10JVykOD0mYkXIzmX/MxKAg6XTJw==
X-Received: by 2002:a05:6402:3511:: with SMTP id b17mr5084804edd.71.1621519122543;
        Thu, 20 May 2021 06:58:42 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:42 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH v2 5/6] block: increment sequence number
Date:   Thu, 20 May 2021 15:56:21 +0200
Message-Id: <20210520135622.44625-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
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
index 67519c034f9f..5bc6b6c248c4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1666,6 +1666,9 @@ static void disk_check_events(struct disk_events *ev,
 
 	spin_unlock_irq(&ev->lock);
 
+	if (events & DISK_EVENT_MEDIA_CHANGE)
+		inc_diskseq(disk);
+
 	/*
 	 * Tell userland about new events.  Only the events listed in
 	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
-- 
2.31.1

