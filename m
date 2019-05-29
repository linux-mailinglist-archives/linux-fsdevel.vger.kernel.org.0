Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675262DBF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2Le2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 07:34:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2Le2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 07:34:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so1368003wmi.0;
        Wed, 29 May 2019 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lv+811UxRTiA1eeuITfBrlSYFc5i58j28rlvkjD03rM=;
        b=U3liTC6ZJCIAPgF5ohxRWUtSnwmEiVfVxH123hEmKBAPGu1Y5oKRc8WphyyDe/PIM7
         gGvxiCoFK+cdsXt9S2AV+ajjs3bFZeHbHZqG/y9gcDj/XxFQKm6bmDbmhjhcbqkBqyZW
         EjAPYDtVXjDf2B2lWTE2T/vmI53a4MF2JoxInqrV2Z0zkV6fRqDxpQQvEmPwneoYFGB0
         GzfZOG7hrw/pQQSMolG5O/ycikS1Vttz3N+wH0zjpJ+6dGd9kAFx+HZPlhoVFXovljBZ
         Eb8VLEwZ1pVb5/V+NOOh5UcdlFxRePuLcNDv6BEB1zAKFbPPUqAYUhxa0v3PYs9yx1TE
         xORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lv+811UxRTiA1eeuITfBrlSYFc5i58j28rlvkjD03rM=;
        b=PktOTs23TbjR8NCGwjVMt+F18vuWN1994TpJAoE0pVoPY9Cw/2oYEfauSs0l9jUCZF
         CZtdAC+M7dDpI8N5ksYisqbRGvI07+4gXS/d6S4010K9vHP6wZI4izeREY3WdInx9uGn
         SjawFBh9wM2270PNaf69lu/sE+dATszeS10xE0aP455tgP1kmj9vaQZ/cbKWyp7VdJZ9
         XNRphED9hAGeu6PWbT8x2HslJRXd+7AbG93pj9QIs2xNwRCcLMoXhxSSjqpvEj3V0Ikt
         269IYFZeI9rKkvfKdjwA+FYJqh5l8KPHkvTpLcaeFMaXUxzXSvXvUyyXXKGQkTjPJU0R
         lj4A==
X-Gm-Message-State: APjAAAW/dpglNOoXMUtBOvij6Yt7fmKRem54i1UHQv8MbVvc1/+JT3/2
        1F+jafLmYsa000k//jzRjpE=
X-Google-Smtp-Source: APXvYqxnCd912qjQWgtXe92WAl/vOIzwax4AWMMD54q443N3LcvMovQ4/4Lre+VsMfb/2oFNQMFFXA==
X-Received: by 2002:a1c:487:: with SMTP id 129mr5896823wme.143.1559129666196;
        Wed, 29 May 2019 04:34:26 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id d9sm15219388wro.26.2019.05.29.04.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 04:34:25 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 6A99211415A8; Wed, 29 May 2019 13:34:19 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: Replace strncpy with memcpy
Date:   Wed, 29 May 2019 13:33:41 +0200
Message-Id: <20190529113341.11972-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function strncpy was used to copy a fixed size buffer. Since
NUL-terminating string is not required here, prefer a memcpy function.
The generated code (ppc32) remains the same.

Silence the following warning triggered using W=1:

  fs/hfsplus/xattr.c:410:3: warning: 'strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/hfsplus/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index d5403b4004c9..bb0b27d88e50 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -407,7 +407,7 @@ static int copy_name(char *buffer, const char *xattr_name, int name_len)
 	int offset = 0;
 
 	if (!is_known_namespace(xattr_name)) {
-		strncpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
+		memcpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
 		offset += XATTR_MAC_OSX_PREFIX_LEN;
 		len += XATTR_MAC_OSX_PREFIX_LEN;
 	}
-- 
2.20.1

