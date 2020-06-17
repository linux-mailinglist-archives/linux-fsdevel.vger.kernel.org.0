Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9D1FCE14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFQNHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 09:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbgFQNHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592399240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=leSYs5eJlF2yRHZz2VWaeaIgreSYZPQY+//144okJEI=;
        b=NeJOrOiOYwMjxPqCWfHUqMxBNeOvBSn/VbiMQHmXuh5bJJnPVKtYyXJ4raQayHQ7l5M6AR
        BC2R9cnthV1jUddIDoZN0KgnHHW74XKfR2R3JqDRKqK8GB2+gAjKcmphvSlXOyyf2URs9x
        LdkLKw584r5ulCxezg1JSzWd/ESvBH4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-3cSbKZhPNP-_cI8d8B5M1w-1; Wed, 17 Jun 2020 09:07:18 -0400
X-MC-Unique: 3cSbKZhPNP-_cI8d8B5M1w-1
Received: by mail-qv1-f69.google.com with SMTP id h30so1533729qva.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=leSYs5eJlF2yRHZz2VWaeaIgreSYZPQY+//144okJEI=;
        b=UUwtCz4VchKk4GQSxzKCQ/ufjDOmwXlWIrlT9jACtJ2+n1CKOy0+goEZRSFcjYFoLh
         3wW3bx6AxPoCC6VyAtNviAGBIQqJ2jPXXrNVmyQesSuTwJnZ1Z6Dwrwog5EdHxav4Api
         xQPouqIgM2YCJQF9PK21JEn3cW9sceZTI7uSpFHpELVvT0yYj9Rup++YpYi1hE0/4E4X
         1ehgKXytOt4zeDxRi5V+woxsndWSeZDGb5mulVX+ETaWTliW2b9Lfde8s8DP/yadF+5R
         7JREwDSIquE2kudrZzJiZg5zHLCW5A+VevuFrBJVeq/1OnT0m9bVGnWiWcXczRXu0mUk
         rkQA==
X-Gm-Message-State: AOAM533X7R99C9sKmZ8Olq6wuQK+DQdja4ONC79npP/ATv6bico/q0TK
        TgkWcjiU77ejyH9FNDy0F8WBv3EtlR3xlr5z38+sVSNXp2fwkqqNMnZ1FUaxwmcH2+v+m8JOx7u
        nLDzv9md/lmYYfhyGcoG/TGStTQ==
X-Received: by 2002:a37:985:: with SMTP id 127mr26104714qkj.297.1592399238185;
        Wed, 17 Jun 2020 06:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypMQdahCFjHiWiaKUTucTI+GfdUfCkJlp/Zgqvo9GoRNi67NgD3Q/2ramjVSjXoLUG6gnrCw==
X-Received: by 2002:a37:985:: with SMTP id 127mr26104691qkj.297.1592399237920;
        Wed, 17 Jun 2020 06:07:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l56sm222123qtl.33.2020.06.17.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 06:07:17 -0700 (PDT)
From:   trix@redhat.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fs : initialize return for iter_file_splice_write
Date:   Wed, 17 Jun 2020 06:07:11 -0700
Message-Id: <20200617130711.23434-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this garbarge return
fs/splice.c:786:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~

ssize_t
iter_file_splice_write( ... size_t len, ..
	sd.total_len = len

	ssize_t ret;

	while (sd.total_len) {
	      ...
	      ret =
	}

If the input len is 0, the while loop will never run and ret will
not be set.

So handle similar to splice_direct_to_actor and initialize ret to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07..f65e072bcc2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -691,7 +691,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	int nbufs = pipe->max_usage;
 	struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
 					GFP_KERNEL);
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	if (unlikely(!array))
 		return -ENOMEM;
-- 
2.18.1

