Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC58510CC4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfK1P7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbfK1P7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QBHEanAnhJnmZ8pttrzUKSxHgn6TIpT2MQ/5Lg7YF8=;
        b=cBWqJ+Vqa06b+ZfVeexGsS/kYoLmpMZ4Z2dR2mLq/KJ8aodF6MofJqbnTvNau7wfvUBW2x
        tEPnqyjpEbCVDZYtS53+q6ZuANmY8Y82yOMxV0/+V9+9uvWWb919q5fMi65MJGlQf2eZSK
        de8n5x0n2sHTQx2XIHjEensIF4QAVH0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-GLIw6fsbPuamBIJOqSTm3g-1; Thu, 28 Nov 2019 10:59:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so1316549wrm.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPUbXlh0ygv/oQuHSRuwxKMQNHDHgL0AUVPr6KUwCtg=;
        b=OxcM31rVgNMVy2EJcfNpGWeQS5pxVzEjMjrrr8kXUTZnm27IBxhJP+3dtRrkv/Mu1K
         KuYbn4wfrlIzHTQWvUJhmpEwrmuuIarVISULW6wthKZs4cGbkmL12reJYiqi0X1kQTzy
         imzX4qOt7ZVZap/7BX+bOMAKIeBP5vZOpsP8nVR9PyYuAC8dcaFl0k1rVHEmgdSUA4B4
         pFyeF1zEDLSeNThAjf2QCHzuoFSiYi2Tf+izO8yYNRwvm9PsZOtJv34wPwUpCHnKWy3D
         xJhs0PWgjtOTOq6Qq6Yp6Fpz3PwgwNayWHBEteBT/eISiPquvHLTImAbdmrRFBbqssy4
         MvEA==
X-Gm-Message-State: APjAAAVhouf0JYH71diylXwzyVU2atfZy+8rFxJYqwzc4KwcOU1HZpvU
        jbeqXJYh1Tgy1iQx25xrhEjvzkgLM/JkeBTMvuK4yTOoaSDfKyFyqIdrLmlQQHCvShZ+RibeeUF
        Sm9Q2I6naPtZVafhvCO1Kd30Arw==
X-Received: by 2002:adf:e886:: with SMTP id d6mr43622025wrm.112.1574956785559;
        Thu, 28 Nov 2019 07:59:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCKrJiKteJ6JBXNs8YdU7/3P20wLIqyfhgjHIPW/eJswuIAtIwMpeBzbvXZ0lHsWjx+IxpIg==
X-Received: by 2002:adf:e886:: with SMTP id d6mr43622013wrm.112.1574956785377;
        Thu, 28 Nov 2019 07:59:45 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:44 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Andrew Price <anprice@redhat.com>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 02/12] fs_parse: fix fs_param_v_optional handling
Date:   Thu, 28 Nov 2019 16:59:30 +0100
Message-Id: <20191128155940.17530-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: GLIw6fsbPuamBIJOqSTm3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

String options always have parameters, hence the check for optional
parameter will never trigger.

Check for param type being a flag first (flag is the only type that does
not have a parameter) and report "Missing value" if the parameter is
mandatory.

Tested with gfs2's "quota" option, which is currently the only user of
fs_param_v_optional.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Andrew Price <anprice@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
Cc: <stable@vger.kernel.org> # v5.4
---
 fs/fs_parser.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..5d8833d71b37 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -127,13 +127,15 @@ int fs_parse(struct fs_context *fc,
 =09case fs_param_is_u64:
 =09case fs_param_is_enum:
 =09case fs_param_is_string:
-=09=09if (param->type !=3D fs_value_is_string)
-=09=09=09goto bad_value;
-=09=09if (!result->has_value) {
+=09=09if (param->type =3D=3D fs_value_is_flag) {
 =09=09=09if (p->flags & fs_param_v_optional)
 =09=09=09=09goto okay;
-=09=09=09goto bad_value;
+
+=09=09=09return invalf(fc, "%s: Missing value for '%s'",
+=09=09=09=09      desc->name, param->key);
 =09=09}
+=09=09if (param->type !=3D fs_value_is_string)
+=09=09=09goto bad_value;
 =09=09/* Fall through */
 =09default:
 =09=09break;
--=20
2.21.0

