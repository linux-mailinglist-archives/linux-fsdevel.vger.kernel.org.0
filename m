Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD33F33C766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhCOUEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:04:10 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:36847 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhCOUDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:03:48 -0400
Received: by mail-ej1-f53.google.com with SMTP id e19so68488837ejt.3;
        Mon, 15 Mar 2021 13:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DV40QsbLmfrHazcRS7XkP3bcaAXUsBsn36zxNtb6dP8=;
        b=W/7sucFbvFG462CxXMsQbGlcfthxTZTvUHcC+eZbyKe8XG6M4RsEUPYA5pgtxTA+lx
         5LDaL6RRALZ5RglKs3qWWasrTOBK3XejloHhcalHbQtP7M8Lh0O4LwzONSvF+GPxDFBY
         iRxGXiYNr0Z1+qX+97wpYRp4cTqiFax1DNL2NRkZj04+M+mMGHYNIGfoXnWjuVaTVV+q
         wR11dQhpg3C/9vvirwHyjI2JNFgaD5BfSbouJBSGGf2TVe0z/wWedI45dVRv7XLTS5eX
         QgOitvNNkB0xoyYgGD2dfTVObiStCSWBtOnrfc9KE6Kh7q7VYRLUwAC3yWGQGGIs0Qqg
         MKGQ==
X-Gm-Message-State: AOAM5316eqv9aC4a17sQw27RzODO2MT3+4YvvemZlE1J6Jswzu6u7FUl
        5bgi5Ns1asyiStzh28INbYNff7T5rhSTfg==
X-Google-Smtp-Source: ABdhPJwGlvmSof040MXGMHe7UCZDixkNuAVv/Swr1OfG+JI694yceu9KyDg8F0XNHDSgvIxlf2OLUg==
X-Received: by 2002:a17:906:be9:: with SMTP id z9mr25347682ejg.35.1615838627191;
        Mon, 15 Mar 2021 13:03:47 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:03:46 -0700 (PDT)
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
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH -next 5/5] loop: increment sequence number
Date:   Mon, 15 Mar 2021 21:02:42 +0100
Message-Id: <20210315200242.67355-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315200242.67355-1-mcroce@linux.microsoft.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

On a very loaded system, if there are many events queued up from multiple
attach/detach cycles, it's impossible to match them up with the
LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
of our own association in the queue is[1].
Not even an empty uevent queue is a reliable indication that we already
received the uevent we were waiting for, since with multi-partition block
devices each partition's event is queued asynchronously and might be
delivered later.

Increment the disk sequence number when setting or changing the backing
file, so the userspace knows which backing file generated the event.

[1] https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a370cde3ddd4..1541ccff81f9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -734,6 +734,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
+	inc_diskseq(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1122,6 +1123,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
+	inc_diskseq(lo->lo_disk);
+
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
-- 
2.30.2

