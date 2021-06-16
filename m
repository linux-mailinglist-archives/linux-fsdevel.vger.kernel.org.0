Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19FF3AA18E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFPQmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFPQmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF26FC061767
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l184so2439401pgd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwtgVJkhTDK7FkC0vaUra0M374ERbF8RXthI68zkQrk=;
        b=PjKgFRjHSJToA5x31UIrlT2kQz8QWjvtUtYBHJLyMvk0e1Hb9GK88sJy3Wo1ywei+B
         z0DhACruELJPvs+3RZ33FJaX8HsHYVzcpOxltyO2La4fkO2wGBv6zH1UaGS7yZ5me6mJ
         vUp5deeq1o/Htj824MXRwhI+mkytJCSWrZDnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwtgVJkhTDK7FkC0vaUra0M374ERbF8RXthI68zkQrk=;
        b=cLdpMeLkY/7N0s+KoQ3KnXfFBOS4eExh6Rissf2CpghKQKrL4rLYp5IUnajAyx02nw
         lsfpDS+u7mw1ERrOksX8sqW1O/yDMMQmyAQZecyUnlEi66iSoszPRRXPR3nNJC1oUVF4
         XL1FkkEYuYcgTonAAjJxEVU4LOWjul1xfKGWOIpDHksIqXCLhe8UnqvnNSMdUh8B2WgQ
         2TfeVsbePyziCpAxoYxDIOLKoY+gdxn+Az2CPusEghmPH4OEC0rjguuAxr5n357uvWRP
         XUaqgsg9LMcBvA/QQwE6Olj7nnS7Ubf58AWbkGdh98BTEfPXDBmySSdx7MuYlzRy2k/M
         AJxQ==
X-Gm-Message-State: AOAM5330mSBLa0ZmZSmNOJYp2MbBwV3ZooPnqcz8oO8q1rLAIL06XIip
        /z4Jsjis9cNQWGOBgtnr3xKn5Q==
X-Google-Smtp-Source: ABdhPJyZY0hoVBBpbAB8LGirsSlZb/UXJaZdGclDdXDTOIGGnPZxvbdmt6gy8/o3bWoM59xye5Uu7g==
X-Received: by 2002:a05:6a00:844:b029:2f8:5436:dc39 with SMTP id q4-20020a056a000844b02902f85436dc39mr624754pfk.10.1623861646934;
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip7sm2663266pjb.39.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/5] pstore/blk: Improve failure reporting
Date:   Wed, 16 Jun 2021 09:40:39 -0700
Message-Id: <20210616164043.1221861-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616164043.1221861-1-keescook@chromium.org>
References: <20210616164043.1221861-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=95c1880167375f358445fa6b36d9d46efbebcc09; i=x+eth6WIY3ZV3RikljpGvsEDOkHC4+JR/D6VkOL4MwM=; m=KWKLltarrgCHVaChKkiXTTMXR+nWhEDb2yQ+7Fx0dy0=; p=hVqcquLAjJY5MNtchTMAytKSIfiafQn164H7tkcB2Bg=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKKYkACgkQiXL039xtwCZgHhAAode R8F21Ztaztm9OD+m51tZDz9H7Jmr3b179RR3mjQtLY5uCy9QlEpGuYAsz/ABz9YrgP0QBOkMztOPC oQPxj2VnCVVuMJRSzFTue9HH70ItKKMz/VIHIFeV7GPStnetLsLWB+ndgzT9ustwokFew+5O35X/l pOmZy7Ol4tvlE44IfAyL6U9z8p9P9r+3a9UyoxW9Hm+KrSC9fxCG0wayJe8PqBkEdSvJ7VolFsRPr bT2bKgOb1F1vZFcHVIK00XvErTh0b6lTlWZWU9m91uH0S47Z7T+rnsJyiRLAldZiTQW2TMWo4zkIs 0QXC77HT2aXShl9P8FZkqmxDS/bYJqYFmt8ags6dV7EPjaOdAt42WMXdYEYuwsZBUVjFVwqpxZPm6 v+z7VzEJQYXs4rrkOOdcUVk4p+BuoyTrmR6/YbOjHkmvW8ufWZxNlndmPcAXW2+CMqV+U8p3LiHnF Yt8bHShaW175vGPMGqhldiLQpQQvJUMtlfrf35EBWHfvA4lDbhJPkvYW/nytaYgyjrnSUmdNqcLTA sb5e0RWD0gXDZqBhYJX7byjf49AFfMoBn3f/Jke02up/jENft69J+Zz4+g+yXD8yERwRPUVy/A8fG Mty73UjHC9R3wIIIG2JsoPGhsP+8rLEgD7c7d6KYl/Pu9NcT44LdTcznpdHhVMi0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There was no feedback on bad registration attempts. Add details on the
failure cause.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/blk.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 4bb8a344957a..eca83820fb5d 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -114,8 +114,22 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (!dev) {
+		pr_err("NULL device info\n");
 		return -EINVAL;
+	}
+	if (!dev->total_size) {
+		pr_err("zero sized device\n");
+		return -EINVAL;
+	}
+	if (!dev->read) {
+		pr_err("no read handler for device\n");
+		return -EINVAL;
+	}
+	if (!dev->write) {
+		pr_err("no write handler for device\n");
+		return -EINVAL;
+	}
 
 	/* someone already registered before */
 	if (pstore_zone_info)
-- 
2.25.1

