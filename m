Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5B82120
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfHEQDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:03:39 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:32883 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHEQDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:03:39 -0400
Received: by mail-pf1-f170.google.com with SMTP id g2so39882199pfq.0;
        Mon, 05 Aug 2019 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/atQO8upnSIxjZFWbzwjewwcU7Pl/S5HrTw3sMMSaWk=;
        b=br2qjvk4qVQV+0wLGSAL40ExMnkokkHbHdnkt7eeD89dKuOBSjW/HmWeXIgFxr+xJH
         GNZnp38Fnbq0wQa+IUgeC2QFTAExUJYAxt8OYs3y+16fv5Yop8b+27sI5k6dm78JQcAM
         yfip/ukg1EiNusqYh7t4qtFqTMh0Sw93A249CIZ0vq2ox1TzeX+Vy2i43JlxI9905zMF
         AmYFMhhVfJTvYudH5rsHdBJ9WICusBYw8Kb3ggFef0VaSpHgryF0HImG/6GuPKU7YrtA
         M/ozz7qA9fJBBmx1ZpJBpslL8Lit3syIctcM+7FQSZeKZYuWOzJ30jJhQmz2DBMgmbrI
         yLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/atQO8upnSIxjZFWbzwjewwcU7Pl/S5HrTw3sMMSaWk=;
        b=Dde7lgspUEmddEPX+jyVJyAMC3Ykykve3ziCf5dLj713/g6LJCB1tFAn568hJ+L/v6
         zdvHHWJwz5z0S4tBCdO41ZD2Du6uOqyQ8H+F5FMfa/cWtnqmxlTeG1vdKMZ0sMZ+wmwy
         kVgiiNAQ0vq6ldKhV3/vlia6BKoUAcEPOckpANVaqf6GZkuThvd3D1pyAKUKeJfndg7U
         uqtN7i6WW7ICkQdqmNOI67ldGejtLLS4rep3UMbVycwTSp8If7gbDH4XnBNOnRoI8Ogb
         DFI/1w7fvfKlYrZl8fzFb79VIz59YYbuN/hYf5okNW780ox9krIkOZKmhwbH540ZKeca
         ikfg==
X-Gm-Message-State: APjAAAWvNLV/i7Q56P7ulBlHsOQAIZ0qB/Kmrqrr8b+URfMaW3zJrVqm
        +n5S67Oc/rHhphJfNwD0AWU=
X-Google-Smtp-Source: APXvYqwUMiDt9hI1FWfkjg6AfQy18Y9cjnzyUO0I8M+djjPTHDl4u6c97cQ4l/WmELIE44LZd4B54w==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr74674861pfo.146.1565021018143;
        Mon, 05 Aug 2019 09:03:38 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n98sm17061262pjc.26.2019.08.05.09.03.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:03:37 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 3/3] i915: do not leak module ref counter
Date:   Tue,  6 Aug 2019 01:03:07 +0900
Message-Id: <20190805160307.5418-4-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

put_filesystem() must follow get_fs_type().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index feedc9242072..93ac365ce9ce 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -24,6 +24,7 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		return -ENODEV;
 
 	gemfs = kern_mount(type);
+	put_filesystem(type);
 	if (IS_ERR(gemfs))
 		return PTR_ERR(gemfs);
 
-- 
2.22.0

