Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE57BAA5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJETmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjJETl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:41:58 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8491CF0;
        Thu,  5 Oct 2023 12:41:52 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so1030771a91.0;
        Thu, 05 Oct 2023 12:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534912; x=1697139712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnAe32dYKZLNlv2gocadcxlV/sPR0ItiYTGrPBtdmto=;
        b=fnUCrWOI3JzKYOI0ZGyafgMvpFHhHx6Uwof7dcB+DKwNyaKI9n5w0AIYtN3eZCZPjL
         zJEH1rzNVAXFCTT/7+0Ftst4L4a/YLA/ia14tmrqntgYiVzrZ6MA6VZml98STVnD42WU
         lA40gp2NleT4Kb3GEiLzUqd5PR1ODSZFFl5g0Itiq+NhavLWRyd5XOzHZQ3b15S78Ikz
         yOSHmJgdZjxDD6dMJXIrTQ49B2qD/Ujdrn02B4g7LmWujnAeb5TwF0gOYypg6jmfS2Y0
         +QhFErcDkrOtFIR/yNnpj6wyaGGWHj3GinMlRknkPzOrmPuWsx9EHuuEhE/iQGEgH1SK
         AXGg==
X-Gm-Message-State: AOJu0YziOGeLrr2SDNP4jd7elj71Nk3vVoh8P36lfnZtzQUAzbtYKVro
        PVjuQOLH2a1X7nVl2KeLkyJihMYc+PE=
X-Google-Smtp-Source: AGHT+IFKE1pVgjMbJaLnP0EVrkCOHRLrNhJtCUJDxDkl8j5QA/IRLCtN5uRtcDaBG1pjj9sVNPHaCw==
X-Received: by 2002:a17:90b:1489:b0:279:2e9a:c425 with SMTP id js9-20020a17090b148900b002792e9ac425mr6077244pjb.1.1696534911823;
        Thu, 05 Oct 2023 12:41:51 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001a9b29b6759sm2129596plf.183.2023.10.05.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:41:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 03/15] block: Support data lifetime in the I/O priority bitfield
Date:   Thu,  5 Oct 2023 12:40:49 -0700
Message-ID: <20231005194129.1882245-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231005194129.1882245-1-bvanassche@acm.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The NVMe and SCSI standards define 64 different data lifetimes. Support
storing this information in the I/O priority bitfield.

The current allocation of the 16 bits in the I/O priority bitfield is as
follows:
* 15..13: I/O priority class
* 12..6: unused
* 5..3: I/O hint (CDL)
* 2..0: I/O priority level

This patch changes this into the following:
* 15..13: I/O priority class
* 12: unused
* 11..6: data lifetime
* 5..3: I/O hint (CDL)
* 2..0: I/O priority level

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/uapi/linux/ioprio.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..efe9bc450872 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -71,7 +71,7 @@ enum {
  * class and level.
  */
 #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
-#define IOPRIO_HINT_NR_BITS		10
+#define IOPRIO_HINT_NR_BITS		3
 #define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
 #define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
 #define IOPRIO_PRIO_HINT(ioprio)	\
@@ -102,6 +102,12 @@ enum {
 	IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
 };
 
+#define IOPRIO_LIFETIME_SHIFT		(IOPRIO_HINT_SHIFT + IOPRIO_HINT_NR_BITS)
+#define IOPRIO_LIFETIME_NR_BITS		6
+#define IOPRIO_LIFETIME_MASK		((1u << IOPRIO_LIFETIME_NR_BITS) - 1)
+#define IOPRIO_PRIO_LIFETIME(ioprio)					\
+	((ioprio >> IOPRIO_LIFETIME_SHIFT) & IOPRIO_LIFETIME_MASK)
+
 #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >= (max))
 
 /*
