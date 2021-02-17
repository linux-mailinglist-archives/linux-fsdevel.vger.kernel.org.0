Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8F31E1AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 22:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhBQVzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 16:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhBQVzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:55:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FEAC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 13:54:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cl8so108841pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ApMAXAcsksn3actd3Y8DLu6EGOAUox/8XdPF11X2X+Q=;
        b=EiWZmHRjk7694wnJrYFakEzwQ0u+rbhfkvvTK1vbtkXNKPRr9TfK/swDmArF63fubC
         qkatq5lqY7oHenujIXJj1vXhnKpg8P61vB2U0/H4kS5F7aQpLF3vONeJZGZ150dGVpV+
         eibyYDP1QWxnvSVlLwJG/kNkxEM//lFgCf3RZjmhdTeJeczIf57Xd/tWuyR4XjoYhAVp
         jTGBe94ubcjdHDUhOTWlma3P/qPKazFRqbFbqks3Bg6YeBmcxIobauruYX7l7DG9vg4U
         dlzAKblBfoNuLNcrggpvBBOwq6RWT8GWgzuAa12MHf6A4holCgZBzsfnM8atsESsqPJB
         xmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ApMAXAcsksn3actd3Y8DLu6EGOAUox/8XdPF11X2X+Q=;
        b=p9YrU9KNbc+W8V0wTEgInbSReoge4vnEGoIgI1Dq4zJeoUAxeggpANKfseZIlS1vBF
         b7UY41ZeZIVdhsjU4fZJnm62pjTb3EsX/eiuwodzHaXeYVTTLCQBAViA6MA5Y+MxNSeL
         NDsUAT98eimNjWky4HCVc/8286YmTWnGM6yOxHEdHqbkTpNj953ZzL7Ht9qXGtjrSJbX
         CpX7yJHhBcxzKrWxePpAtUpiEGTM0DIx+vY1UQ3CF1SnbGop0Y9EzZf3Y9TE/DrqAZOI
         Pi2ssJWUMZTeZ+jFKNRvytLrIGByxY7WUMSoBZBqMJbjbVl3LotFxIAObej6UZfBJ5sr
         50LQ==
X-Gm-Message-State: AOAM531IJme4dNZtsnvpADtZL/qnWgSRX8zRXxn6TabDL8uvgAyJ3xqs
        oJd7cYcQgyWSKicNNjsPoviGlQvxWI4jDQ==
X-Google-Smtp-Source: ABdhPJzWgv9UOD3Gy2U1T6X3M4xheI0aF4J9+ImyGRltokmC5mO6BTDS5LgK54xeUHMZcO11ncOqdg==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr868738pjb.78.1613598874383;
        Wed, 17 Feb 2021 13:54:34 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::19db? ([2620:10d:c090:400::5:5c48])
        by smtp.gmail.com with ESMTPSA id e12sm2992964pjt.54.2021.02.17.13.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 13:54:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Suspected leak of 'name'
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <cd4caf07-69d1-d194-72f2-fddf55979d7b@kernel.dk>
Date:   Wed, 17 Feb 2021 14:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Same reproducer I sent you, was running testing and kmemleak complained
about 'name' from proc_self_get_link() never getting freed:

unreferenced object 0xffff8881086f0a30 (size 16):
  comm "al", pid 35226, jiffies 4295022637 (age 74.420s)
  hex dump (first 16 bytes):
    33 35 32 32 36 00 00 00 20 0a 6f 08 81 88 ff ff  35226... .o.....
  backtrace:
    [<00000000dbe89ca0>] proc_self_get_link+0x99/0xc0
    [<0000000090ccc390>] step_into+0x530/0x6b0
    [<00000000934729a9>] walk_component+0x70/0x1c0
    [<00000000fc19296d>] link_path_walk.part.0+0x234/0x370
    [<000000006f9abd8e>] path_openat+0xb3/0xe50
    [<00000000d07cfec9>] do_filp_open+0x88/0x130
    [<000000007de40bab>] do_sys_openat2+0x97/0x150
    [<00000000bf0f331a>] __x64_sys_openat2+0x66/0xc0
    [<000000007ec2351f>] do_syscall_64+0x2d/0x40
    [<00000000758089a7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Are we missing a drop_links() for the LOOKUP_CACHED case?

diff --git a/fs/namei.c b/fs/namei.c
index 58962569cc20..de74ad2bc6e2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -631,6 +631,7 @@ static bool legitimize_links(struct nameidata *nd)
 {
 	int i;
 	if (unlikely(nd->flags & LOOKUP_CACHED)) {
+		drop_links(nd);
 		nd->depth = 0;
 		return false;
 	}

-- 
Jens Axboe

