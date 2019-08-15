Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0B8EE56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfHOOgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:36:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37272 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfHOOgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:36:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so2426377wrt.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 07:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YlmjJPeojzjGuL2iKbKBDyzRelOOlVV+qdVb0SrG38=;
        b=PcHnMMY6g1Zfs1DQ6XtnKUiiIIUaKe+2dcZQk4Gpq5J9vhuNTWXlbVFdwwcB34DsID
         Av2lvAQ2s9UuzeEoDHR3CfZgZ17iEMDipIavGc7M8dfL6uWcryM9pA4LnSPKu5aD82sR
         Qh/HucgxKdqmGNXf+YHydkYUOZLS0QKGVzaUtqQhyU4Wn80upvM2kUaBxOn9yTqUPVEA
         0JYiA1LIhb9AsspFuND2ATQcCV4/Ict5ziz5DW4qYGJiGAno1DCKYeqpxq52r34+jXqP
         t7IGclnPBlD1V8mgIuWjR7q6f0WWjng/xGCwJRy06WTmHnpcxuLebEImLrVP0lGS/LV7
         0yww==
X-Gm-Message-State: APjAAAUhnTVotDo3MQzALF+/p9sHiKIHK+IxVS5HUgQe5sICmZVxvv4A
        mowIwKtEny0cgJnXzC/7mULX1w==
X-Google-Smtp-Source: APXvYqwuDXbUGVL63z6asyFGv+G1v8IT0KvY9aerWRkjDh6nAUGeN643DxE+O1zkdw0zXQg11Jbu4w==
X-Received: by 2002:a5d:6383:: with SMTP id p3mr6144082wru.34.1565879767470;
        Thu, 15 Aug 2019 07:36:07 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a17sm1708199wmm.47.2019.08.15.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:36:06 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 1/1] shiftfs-5.2: use copy_from_user() correctly
Date:   Thu, 15 Aug 2019 16:36:03 +0200
Message-Id: <20190815143603.17127-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190815143603.17127-1-oleksandr@redhat.com>
References: <20190815143603.17127-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 fs/shiftfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/shiftfs.c b/fs/shiftfs.c
index 49f6714e9f95..14f3764577d8 100644
--- a/fs/shiftfs.c
+++ b/fs/shiftfs.c
@@ -1526,7 +1526,7 @@ static bool in_ioctl_whitelist(int flag, unsigned long arg)
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
 		return true;
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
-		if (copy_from_user(&flags, arg, sizeof(flags)))
+		if (copy_from_user(&flags, argp, sizeof(flags)))
 			return false;
 
 		if (flags & ~BTRFS_SUBVOL_RDONLY)
-- 
2.22.1

